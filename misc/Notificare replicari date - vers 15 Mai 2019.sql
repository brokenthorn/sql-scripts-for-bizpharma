DECLARE
    -- prag pachete in coada de transmisie:
    @transmissionQueueTreshold INT = 500,
    -- prag pachete in coada de primire:
    @queuedMessageTreshold     INT = 50;

DROP TABLE IF EXISTS #receiveQueueStats;
CREATE TABLE #receiveQueueStats
(
    name NVARCHAR(128) PRIMARY KEY NOT NULL,
    c    INT                       NOT NULL
);

DECLARE sqCursor CURSOR FOR
    SELECT name
    FROM sys.service_queues WITH (NOLOCK)
    WHERE is_ms_shipped = 0;

DECLARE
    @buildReceiveQueueStatsSQL NVARCHAR(MAX) = '',
    @queueName                 NVARCHAR(128) = '';

OPEN sqCursor;
FETCH NEXT FROM sqCursor INTO @queueName;

WHILE @@fetch_status = 0
BEGIN
    SET @buildReceiveQueueStatsSQL = @buildReceiveQueueStatsSQL +
                                     'insert into #receiveQueueStats ' +
                                     '(name, c) VALUES ' +
                                     '(''' + @queueName + ''', (select count(*) from ' + @queueName + '));';
    FETCH NEXT FROM sqCursor INTO @queueName;
END

CLOSE sqCursor;
DEALLOCATE sqCursor;

EXECUTE sp_executesql @statement = @buildReceiveQueueStatsSQL;

DECLARE c CURSOR FOR
    SELECT r.Tran_Message_Count,
           r.Queued_Message_Count,
           r.last_activated_time,
           r.last_empty_rowset_time,
           r.Queue_Name,
           r.is_enqueue_enabled,
           r.is_receive_enabled,
           r.is_activation_enabled,
           r.Schema_Name,
           r.Service_Name
    FROM (
             SELECT svcs.name   AS [Service_Name],
                    sch.name    AS [Schema_Name],
                    serv_q.name AS [Queue_Name],
                    CASE
                        WHEN t4.last_activated_time IS NULL THEN '--'
                        ELSE CONVERT(VARCHAR, t4.last_activated_time)
                        END     AS last_activated_time,
                    CASE
                        WHEN t4.last_empty_rowset_time IS NULL THEN '--'
                        ELSE CONVERT(VARCHAR, t4.last_empty_rowset_time)
                        END     AS last_empty_rowset_time,
                    serv_q.is_enqueue_enabled,
                    serv_q.is_receive_enabled,
                    serv_q.is_activation_enabled,
                    (
                        SELECT COUNT(*) AS c
                        FROM sys.transmission_queue t6
                        WHERE (t6.from_service_name = svcs.name)
                    )           AS [Tran_Message_Count],
                    (
                        SELECT rqs.c
                        FROM #receiveQueueStats rqs
                        WHERE rqs.name = serv_q.name
                    )           AS [Queued_Message_Count]
             FROM sys.services svcs WITH (NOLOCK)
                      INNER JOIN sys.service_queues serv_q WITH (NOLOCK)
                                 ON (svcs.service_queue_id = serv_q.object_id)
                      INNER JOIN sys.schemas sch WITH (NOLOCK) ON (serv_q.schema_id = sch.schema_id)
                      LEFT OUTER JOIN sys.dm_broker_queue_monitors t4 WITH (NOLOCK)
                                      ON (serv_q.object_id = t4.queue_id AND t4.database_id = DB_ID())
                      INNER JOIN sys.databases t5 WITH (NOLOCK) ON (t5.database_id = DB_ID())
             WHERE serv_q.is_ms_shipped = 0
         ) r
    WHERE r.Tran_Message_Count > @transmissionQueueTreshold
       OR r.Queued_Message_Count > @queuedMessageTreshold;

OPEN c;

DECLARE
    @Tran_Message_Count     INT,
    @Queued_Message_Count   INT,
    @last_activated_time    VARCHAR(30),
    @last_empty_rowset_time VARCHAR(30),
    @Queue_Name             NVARCHAR(128),
    @is_enqueue_enabled     BIT,
    @is_receive_enabled     BIT,
    @is_activation_enabled  BIT,
    @Schema_Name            NVARCHAR(128),
    @Service_Name           NVARCHAR(128),
    @table                  NVARCHAR(MAX);

SET @table = '<h3>Mini-Farm HO: Status cozi de replicare</h3><br/>' +
             '<table style="word-break:break-all;" border="1px" cellspacing="0" cellpadding="3">' +
             '<thead>' +
             '<tr>' +
             '<td>Tran msg count</td>' +
             '<td>Queued msg count</td>' +
             '<td>Last active time</td>' +
             '<td>Last empty rowset time</td>' +
             '<td>Queue name</td>' +
             '<td>is_enqueue_enabled</td>' +
             '<td>is_receive_enabled</td>' +
             '<td>is_activation_enabled</td>' +
             '<td>Schema name</td>' +
             '<td>Service name</td>' +
             '</tr>' +
             '</thead>' +
             '<tbody>';

FETCH NEXT FROM c INTO
    @Tran_Message_Count,
    @Queued_Message_Count,
    @last_activated_time,
    @last_empty_rowset_time,
    @Queue_Name,
    @is_enqueue_enabled,
    @is_receive_enabled,
    @is_activation_enabled,
    @Schema_Name,
    @Service_Name;

WHILE @@fetch_status = 0
BEGIN
    SET @table = @table +
                 '<tr>' +
                 '<td>' + CAST(@Tran_Message_Count AS NVARCHAR(16)) + '</td>' +
                 '<td>' + CAST(@Queued_Message_Count AS NVARCHAR(16)) + '</td>' +
                 '<td>' + @last_activated_time + '</td>' +
                 '<td>' + @last_empty_rowset_time + '</td>' +
                 '<td>' + @Queue_Name + '</td>' +
                 '<td>' + CAST(@is_enqueue_enabled AS NVARCHAR(5)) + '</td>' +
                 '<td>' + CAST(@is_receive_enabled AS NVARCHAR(5)) + '</td>' +
                 '<td>' + CAST(@is_activation_enabled AS NVARCHAR(5)) + '</td>' +
                 '<td>' + @Schema_Name + '</td>' +
                 '<td>' + @Service_Name + '</td>' +
                 '</tr>';

    FETCH NEXT FROM c INTO
        @Tran_Message_Count,
        @Queued_Message_Count,
        @last_activated_time,
        @last_empty_rowset_time,
        @Queue_Name,
        @is_enqueue_enabled,
        @is_receive_enabled,
        @is_activation_enabled,
        @Schema_Name,
        @Service_Name;
END

CLOSE c;
DEALLOCATE c;

SET @table = @table + '</tbody></table>';

EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Verificare replicari',
     @recipients='sebastian@minifarm.ro',
     @subject='Alerta replicari BizPharmaHO - Mini-Farm S.R.L.',
     @body=@table,
     @body_format='HTML';