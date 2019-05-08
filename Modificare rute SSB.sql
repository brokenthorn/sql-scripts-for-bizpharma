-- Creare Linked Server catre HO, in FL.
-- INFO: se poate face replace la IP, la sintagma SQL2008 (instanta) si/sau la port
-- si se poate rula apoi si pe HO pentru adaugare si acolo LS catre FL.
-- Deci, creare LS in FL, pentru HO:

USE [master]
GO
EXEC master.dbo.sp_addlinkedserver @server = N'10.0.0.130\SQL2008,1443', @srvproduct=N'SQL Server'

GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'collation compatible', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'data access', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'dist', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'pub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'rpc', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'rpc out', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'sub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'connect timeout', @optvalue=N'10'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'collation name', @optvalue=NULL
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'lazy schema validation', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'query timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'use remote collation', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'10.0.0.130\SQL2008,1443', @optname=N'remote proc transaction promotion',
     @optvalue=N'true'
GO
USE [master]
GO
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'10.0.0.130\SQL2008,1443', @locallogin = NULL, @useself = N'False',
     @rmtuser = N'sa', @rmtpassword = N'Minifarm53tr10'
GO

-- Setare parametru server comunicare cu HO:

USE BizPharma; -- sau care e numele bazei de FL...
GO

UPDATE Parametru
SET
    -- Valoare=''[185.18.226.214\SQL2008,1443].[BizPharmaHO].[dbo].'' -- Prin Internet
    Valoare='[10.0.0.130\SQL2008,1443].[BizPharmaHO].[dbo].' -- Prin VPN
WHERE idparametru = 338
  AND Nume = 'SERVER de comunicare cu HeadOffice';

-- Update rute:

-- cauta ruta actuala, ia de aici numele rutelor si service name-urilor
-- pentru mai jos cand re-creezi rutele:

SELECT *
FROM sys.routes
-- WHERE name like '%veche%' -- deoarece cand esti pe HO, se vad prea multe.
;

-- recreaza rutele doar dupa ce ai folosit aceleasi nume ca inainte, luate de mai sus!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

DROP ROUTE RouteWebPharma_RI_Filiala_To_HO
CREATE ROUTE RouteWebPharma_RI_Filiala_To_HO
    AUTHORIZATION dbo
    WITH SERVICE_NAME = 'tcp://CENTRU:4022/WebPharma/DataReceiver_BizPharmaHO',
    ADDRESS = 'TCP://10.0.0.130:4022';

DROP ROUTE RouteWebPharma_RD_Filiala_PiataVeche_To_HO
CREATE ROUTE RouteWebPharma_RD_Filiala_PiataVeche_To_HO
    AUTHORIZATION dbo
    WITH SERVICE_NAME = 'tcp://CENTRU:4022/WebPharma/DataSenderRD_PiataVeche',
    ADDRESS = 'TCP://10.0.0.130:4022';

