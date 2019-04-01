USE BizPharmaHO
GO

DECLARE serversCursor CURSOR FOR
  SELECT [data_source]
  FROM sys.servers
  WHERE is_linked = 1
    AND name LIKE '10.%'            -- doar big net-ul de VPN
    AND name NOT LIKE '10.0.0.130%' -- fara HO
    AND name NOT LIKE '10.0.0.131%' -- fara BI
    AND name NOT LIKE '10.0.0.132%' -- fara subnet cloud, urmatorul IP...
    AND name NOT LIKE '10.0.0.133%' -- fara subnet cloud, urmatorul IP...
    AND name NOT LIKE '10.0.0.134%' -- fara subnet cloud, urmatorul IP...
    AND name NOT LIKE '10.0.0.135%'; -- fara subnet cloud, urmatorul IP... e de ajuns, nu mai sunt hosturi active.

DECLARE
  @tabelRezultat
    TABLE
    (
      datasource VARCHAR(250) UNIQUE NOT NULL,
      db         VARCHAR(50)         NOT NULL,
      idLocatie  INT UNIQUE          NOT NULL
    );

DECLARE
  @dataSource VARCHAR(250);

OPEN serversCursor;

FETCH NEXT FROM serversCursor INTO @dataSource;

WHILE @@FETCH_STATUS = 0
BEGIN
  DECLARE
    @db VARCHAR(50);
  DECLARE
    @idLocatie INT;

  DECLARE
    @scriptAflareBaza NVARCHAR(MAX)
      = N'select top 1 @dbOUT = [name] from [' + @dataSource + N'].master.sys.databases '
      + N'where state=0 AND [name] like ''BizPharma%'' and [name] not like ''%AUX'' and [name] not like ''%TEST%'' '
      + N'and [name] not like ''%RAPOARTE'' and [name] not like ''%FOST_TEST_BIG'' and [name] not like ''%Parametru'' '
      + N'order by [name] asc';

  EXEC sp_executesql @scriptAflareBaza, N'@dbOUT varchar(50) output', @dbOUT=@db OUTPUT;

  DECLARE
    @ScriptAflareIdLocatie NVARCHAR(MAX)
      = N'select top 1 @idLocatieOUT = [Value] from [' + @dataSource + N'].' + @db + N'.dbo.InitInfo '
      + N'where [Object] like ''HostIdLocatie''';

  EXEC sp_executesql @ScriptAflareIdLocatie, N'@idLocatieOUT int output', @idLocatieOUT=@idLocatie OUTPUT;

  INSERT INTO @tabelRezultat (datasource, db, idLocatie)
  VALUES (@dataSource, @db, @idLocatie);

  FETCH NEXT FROM serversCursor INTO @dataSource;
END;

CLOSE serversCursor;
DEALLOCATE serversCursor;

SELECT *
FROM @tabelRezultat;

GO