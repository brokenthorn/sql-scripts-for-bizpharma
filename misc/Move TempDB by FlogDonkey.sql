/*
Scriptul este un simplu create/move al bazei de date temporare pe un drive
separat.

Dupa ce rulezi acest script, SQL Server trebuie repornit pentru a avea
efect.
*/

-- 1. declara marimea disk-ului in GB deoarece tempdb trebuie setat sa creasca
-- pana la acea dimensiune in total, altfel apar erori de supra-alocare
-- sau poate nu doresti sa umpli disk-ul 100%.

-- 2. declara file count mai mic sau egal cu numarul de procesoare/thread-uri
-- ale procesorului serverului
-- de exemplu quad core -> 4,
-- quad core cu SMT/HyperThreading -> 8.

-- 3. declara litera disk-ului in loc de T, in litera corecta/dorita.
-- 4. este nevoie sa creezi si sub-folder-ul cu numele dat de SELECT @@SERVICENAME
-- deci ruleaza separat SELECT @@SERVICENAME si creeaza acel folder in root-ul
-- drive-ului selectat, spre exemplu T:\BIZPHARMA2008
-- Alternativ poti folosi orice cale dorita, spre exemplu:
-- @DrivePath VARCHAR(100) = 'T:\Backup_SQL\'
DECLARE @DriveSizeGB INT = 40
    ,@FileCount INT = 9
    ,@RowID INT
    ,@FileSize VARCHAR(10)
    ,@DrivePath VARCHAR(100) = 'T:\' + @@SERVICENAME + '\';

/* Converts GB to MB */
SELECT @DriveSizeGB = @DriveSizeGB * 1000;

/* Splits size by the file count */
SELECT @FileSize = @DriveSizeGB / @FileCount;

/* Table to house requisite SQL statements that will modify the files to the standardized name, and size */
DECLARE @Command TABLE
                 (
                     RowID   INT IDENTITY (1, 1),
                     Command NVARCHAR(MAX)
                 );
INSERT INTO @Command (Command)
SELECT 'ALTER DATABASE tempdb MODIFY FILE (NAME = [' + f.name + '],' + ' FILENAME = ''' + @DrivePath + f.name
           + IIF(f.type = 1, '.ldf', '.mdf') + ''', SIZE = ' + @FileSize + ');'
FROM sys.master_files AS f
WHERE f.database_id = DB_ID(N'tempdb');
SET @RowID = @@ROWCOUNT

/* If there are less files than indicated in @FileCount, add missing lines as ADD FILE commands */
WHILE @RowID < @FileCount
    BEGIN
        INSERT INTO @Command (Command)
        SELECT 'ALTER DATABASE tempdb ADD FILE (NAME = [temp' + CAST(@RowID AS VARCHAR) + '],' + ' FILENAME = ''' +
               @DrivePath + 'temp' + CAST(@RowID AS VARCHAR) + '.mdf''' + ', SIZE=' + @FileSize + ');'
        SET @RowID = @RowID + 1
    END

/* Execute each line to process */
WHILE @RowID > 0
    BEGIN
        DECLARE @WorkingSQL NVARCHAR(MAX)

        SELECT @WorkingSQL = Command
        FROM @Command
        WHERE RowID = @RowID

        EXEC (@WorkingSQL)
        SET @RowID = @RowID - 1
    END