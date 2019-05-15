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
    SELECT r.Queue_State,
           r.Tran_Message_Count,
           r.Queued_Message_Count,
           r.last_activated_time,
           r.last_empty_rowset_time,
           r.Queue_Name,
           r.Schema_Name,
           r.Service_Name,
           r.tasks_waiting
    FROM (
             SELECT t1.name AS [Service_Name],
                    t3.name AS [Schema_Name],
                    t2.name AS [Queue_Name],
                    CASE
                        WHEN t4.state IS NULL THEN 'Not available'
                        ELSE t4.state
                        END AS [Queue_State],
                    CASE
                        WHEN t4.tasks_waiting IS NULL THEN '--'
                        ELSE CONVERT(VARCHAR, t4.tasks_waiting)
                        END AS tasks_waiting,
                    CASE
                        WHEN t4.last_activated_time IS NULL THEN '--'
                        ELSE CONVERT(VARCHAR, t4.last_activated_time)
                        END AS last_activated_time,
                    CASE
                        WHEN t4.last_empty_rowset_time IS NULL THEN '--'
                        ELSE CONVERT(VARCHAR, t4.last_empty_rowset_time)
                        END AS last_empty_rowset_time,
                    (
                        SELECT COUNT(*) AS c
                        FROM sys.transmission_queue t6
                        WHERE (t6.from_service_name = t1.name)
                    )       AS [Tran_Message_Count],
                    (
                        SELECT rqs.c
                        FROM #receiveQueueStats rqs
                        WHERE rqs.name = t2.name
                    )       AS [Queued_Message_Count]
             FROM sys.services t1 WITH (NOLOCK)
                      INNER JOIN sys.service_queues t2 WITH (NOLOCK)
                                 ON (t1.service_queue_id = t2.object_id)
                      INNER JOIN sys.schemas t3 WITH (NOLOCK) ON (t2.schema_id = t3.schema_id)
                      LEFT OUTER JOIN sys.dm_broker_queue_monitors t4 WITH (NOLOCK)
                                      ON (t2.object_id = t4.queue_id AND t4.database_id = DB_ID())
                      INNER JOIN sys.databases t5 WITH (NOLOCK) ON (t5.database_id = DB_ID())
             WHERE t2.is_ms_shipped = 0
         ) r
    WHERE r.Tran_Message_Count > @transmissionQueueTreshold
       OR r.Queued_Message_Count > @queuedMessageTreshold;

OPEN c;

DECLARE
    @Queue_State            NVARCHAR(32),
    @Tran_Message_Count     INT,
    @Queued_Message_Count   INT,
    @last_activated_time    VARCHAR(30),
    @last_empty_rowset_time VARCHAR(30),
    @Queue_Name             NVARCHAR(128),
    @Schema_Name            NVARCHAR(128),
    @Service_Name           NVARCHAR(128),
    @tasks_waiting          VARCHAR(30),
    @table                  NVARCHAR(MAX);

SET @table = '<table border="1px" cellspacing="0" cellpadding="3">' +
             '<thead>' +
             '<tr>' +
             '<td>Queue state</td>' +
             '<td>Tran message count</td>' +
             '<td>Queued message count</td>' +
             '<td>Last active time</td>' +
             '<td>Last empty rowset time</td>' +
             '<td>Queue name</td>' +
             '<td>Schema name</td>' +
             '<td>Service name</td>' +
             '<td>Tasks waiting</td>' +
             '</tr>' +
             '</thead>' +
             '<tbody>';

FETCH NEXT FROM c INTO @Queue_State,
    @Tran_Message_Count,
    @Queued_Message_Count,
    @last_activated_time,
    @last_empty_rowset_time,
    @Queue_Name,
    @Schema_Name,
    @Service_Name,
    @tasks_waiting;

WHILE @@fetch_status = 0
BEGIN
    SET @table = @table +
                 '<tr>' +
                 '<td>' + @Queue_State + '</td>' +
                 '<td>' + CAST(@Tran_Message_Count AS NVARCHAR(16)) + '</td>' +
                 '<td>' + CAST(@Queued_Message_Count AS NVARCHAR(16)) + '</td>' +
                 '<td>' + @last_activated_time + '</td>' +
                 '<td>' + @last_empty_rowset_time + '</td>' +
                 '<td>' + @Queue_Name + '</td>' +
                 '<td>' + @Schema_Name + '</td>' +
                 '<td>' + @Service_Name + '</td>' +
                 '<td>' + @tasks_waiting + '</td>' +
                 '</tr>';

    FETCH NEXT FROM c INTO @Queue_State,
        @Tran_Message_Count,
        @Queued_Message_Count,
        @last_activated_time,
        @last_empty_rowset_time,
        @Queue_Name,
        @Schema_Name,
        @Service_Name,
        @tasks_waiting;
END

CLOSE c;
DEALLOCATE c;

SET @table = @table + '</tbody></table>';

EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Verificare replicari',
     @recipients='x@y.com;a@b.net',
     @subject='Alerta replicari BizPharmaHO - Mini-Farm S.R.L.',
     @body=@table,
     @body_format='HTML';