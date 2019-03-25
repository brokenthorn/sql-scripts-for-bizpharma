BEGIN TRAN
  -- modifica setarea despre linked serverul folosit de BizPharma pentru conectarea la HO.
  -- acesta trebuie sa fi fost create deja, ca BizPharma sa il poata folosi.
  -- nu este de ajuns sa fie doar configurat aici.
  UPDATE Parametru
  SET
    -- Valoare=''[185.18.226.214\SQL2008,1443].[BizPharmaHO].[dbo].''
    Valoare='[10.0.0.130\SQL2008,1443].[BizPharmaHO].[dbo].'
  WHERE idparametru = 338
    AND Nume = 'SERVER de comunicare cu HeadOffice'

  -- cauta ruta actuala
  SELECT * FROM sys.routes WHERE name LIKE '%bigcta%'

  -- recreaza rutele
  DROP ROUTE RouteWebPharma_RD_HO_To_Filiala_BigCTA
  DROP ROUTE RouteWebPharma_RI_HO_To_Filiala_BigCTA

  CREATE ROUTE RouteWebPharma_RD_HO_To_Filiala_BigCTA
    AUTHORIZATION dbo
    WITH SERVICE_NAME = 'tcp://86.122.48.75:4022/WebPharma/DataReceiverRD_BigCTA', ADDRESS = 'TCP://10.0.22.131:4022'


  CREATE ROUTE RouteWebPharma_RI_HO_To_Filiala_BigCTA
    AUTHORIZATION dbo
    WITH SERVICE_NAME = 'tcp://86.122.48.75:4022/WebPharma/DataSender_BigCTA', ADDRESS = 'TCP://10.0.22.131:4022'
ROLLBACK