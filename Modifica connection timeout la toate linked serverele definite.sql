USE [master]
GO

-- verificare timeout inainte si dupa
SELECT [name], connect_timeout
FROM sys.servers

DECLARE c CURSOR FOR SELECT [name]
                     FROM master.sys.servers

OPEN c;
DECLARE
  @s NVARCHAR(300);
FETCH NEXT FROM c INTO @s;

-- set connection timeout to 10 seconds:
WHILE @@FETCH_STATUS = 0
BEGIN
  DECLARE
    @e VARCHAR(MAX) = 'EXEC master.dbo.sp_serveroption @server=' + 'N''' + @s + ''', ' +
                      '@optname=N''connect timeout'', @optvalue=N''10'';';
  EXEC (@e);
  FETCH NEXT FROM c INTO @s;
END

CLOSE c;
DEALLOCATE c;