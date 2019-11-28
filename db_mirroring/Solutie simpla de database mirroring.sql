-- === Joburi de RESTORE ===
-- =========================
-- De obicei aceste joburi sunt rulate la aceeasi ora, pentru a rula in paralel.
-- Aceste joburi ruleaza pe serverul mirror de HO.
-- Depdendente: Scripturi de mentenanta de la https://ola.hallengren.com/

-- === JOB: RESTORE BizPharmaHO ===
-- ================================
-- Restore the newest FULL backup and all LOG backups and then recover the database so that it can be used.
-- Restores with REPLACE, so any existing database will be overwritten!

USE master;
GO

ALTER DATABASE [BizPharmaHO] SET OFFLINE WITH ROLLBACK IMMEDIATE;
GO

EXEC dbo.sp_DatabaseRestore
     @Database = 'BizPharmaHO',
     @BackupPathFull = '\\ho.minifarm.local\sqlbackups\HO$SQL2008\BizPharmaHO\FULL\',
     @BackupPathLog = '\\ho.minifarm.local\sqlbackups\HO$SQL2008\BizPharmaHO\LOG\',
    -- We're not periodically applying logs to an already restored initial FULL backup
    -- so we need to set @ContinueLogs = 0, otherwise we get an error when trying to restore logs.
     @ContinueLogs = 0,
     @RunRecovery = 1,
     @Debug = 0,
     @Execute = 'Y';
GO

ALTER DATABASE [BizPharmaHO] SET ALLOW_SNAPSHOT_ISOLATION ON WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [BizPharmaHO] SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [BizPharmaHO] SET ONLINE;
GO

DELETE
FROM [BizPharmaHO].[dbo].[Repl_filiale];
GO

-- === JOB: RESTORE BizPharmaHO_RAPOARTE ===
-- =========================================
-- Restore the newest FULL backup and all LOG backups and then recover the database so that it can be used.
-- Restores with REPLACE, so any existing database will be overwritten!

USE master;
GO

ALTER DATABASE [BizPharmaHO_RAPOARTE] SET OFFLINE WITH ROLLBACK IMMEDIATE;
GO

EXEC dbo.sp_DatabaseRestore
     @Database = 'BizPharmaHO_RAPOARTE',
     @BackupPathFull = '\\ho.minifarm.local\sqlbackups\HO$SQL2008\BizPharmaHO_RAPOARTE\FULL\',
     @BackupPathLog = '\\ho.minifarm.local\sqlbackups\HO$SQL2008\BizPharmaHO_RAPOARTE\LOG\',
    -- We're not periodically applying logs to an already restored initial FULL backup
    -- so we need to set @ContinueLogs = 0, otherwise we get an error when trying to restore logs.
     @ContinueLogs = 0,
     @RunRecovery = 1,
     @Debug = 0,
     @Execute = 'Y';
GO

ALTER DATABASE [BizPharmaHO_RAPOARTE] SET ALLOW_SNAPSHOT_ISOLATION ON WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [BizPharmaHO_RAPOARTE] SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [BizPharmaHO_RAPOARTE] SET ONLINE;
GO

-- === JOB: RESTORE BizPharmaHO_REPLICARI ===
-- ==========================================
-- Restore the newest FULL backup and all LOG backups and then recover the database so that it can be used.
-- Restores with REPLACE, so any existing database will be overwritten!

USE master;
GO

ALTER DATABASE [BizPharmaHO_REPLICARI] SET OFFLINE WITH ROLLBACK IMMEDIATE;
GO

EXEC dbo.sp_DatabaseRestore
     @Database = 'BizPharmaHO_REPLICARI',
     @BackupPathFull = '\\ho.minifarm.local\sqlbackups\HO$SQL2008\BizPharmaHO_REPLICARI\FULL\',
     @BackupPathLog = '\\ho.minifarm.local\sqlbackups\HO$SQL2008\BizPharmaHO_REPLICARI\LOG\',
    -- We're not periodically applying logs to an already restored initial FULL backup
    -- so we need to set @ContinueLogs = 0, otherwise we get an error when trying to restore logs.
     @ContinueLogs = 0,
     @RunRecovery = 1,
     @Debug = 0,
     @Execute = 'Y';
GO

ALTER DATABASE [BizPharmaHO_REPLICARI] SET ALLOW_SNAPSHOT_ISOLATION ON WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [BizPharmaHO_REPLICARI] SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [BizPharmaHO_REPLICARI] SET ONLINE;
GO


-- === Joburi de BACKUP ===
-- ========================
-- De obicei aceste joburi sunt rulate la aceeasi ora, pentru a rula in paralel.
-- Aceste joburi ruleaza pe serverul principal de HO.
-- Depdendente: Scripturi de mentenanta de la https://ola.hallengren.com/

-- === JOB: BACKUP FULL SELECTIV ===
-- =================================

-- PAS 1
-- Dependenta terta. Datorita mutarii exportului contabil pe Mirror.
EXEC [ho-m1.minifarm.local\MSSQLSERVER,1433].[BizPharmaHO].[dbo].[wmr_SincronizareMapariMirrorHO] 1;
EXEC [ho-m1.minifarm.local\MSSQLSERVER,1433].[BizPharmaHO].[dbo].[wmr_SincronizareMapariMirrorHO] 8676;
GO

-- PAS 2
-- Backup-ul in sine.
EXECUTE [dbo].[DatabaseBackup]
        @Databases = 'BizPharmaHO,BizPharmaHO_RAPOARTE,BizPharmaHO_REPLICARI',
        @Directory = N'D:\sqlbackups',
        @BackupType = 'FULL',
        @CleanupTime = 24,
        @Compress = 'Y',
        @CheckSum = 'Y',
        @Verify = 'N',
        @MaxTransferSize = 4194304,
        @BufferCount = 75, -- Yielding around 300 MB buffer size
        @LogToTable = 'Y' -- dbo.CommandLog
;
GO

-- `CleanupTime`:
-- Specify the time, in hours, after which the backup files are deleted.
-- If no time is specified, then no backup files are deleted.
--
-- `DatabaseBackup` has a check to verify that transaction log backups that are
-- newer than the most recent full or differential backup are not deleted.

-- === JOB: BACKUP LOGS SELECTIV ===
-- =================================

EXECUTE [dbo].[DatabaseBackup]
        @Databases = 'BizPharmaHO,BizPharmaHO_RAPOARTE,BizPharmaHO_REPLICARI',
        @Directory = N'D:\sqlbackups',
        @CleanupTime = 24,
        @BackupType = 'LOG',
        @ChangeBackupType = 'Y', -- Changes to FULL if LOG can't be taken
        @Compress = 'Y',
        @CheckSum = 'Y',
        @Verify = 'N',
        @MaxTransferSize = 4194304,
        @BufferCount = 75, -- Yielding around 300 MB buffer size
        @LogToTable = 'Y' -- dbo.CommandLog
;
GO