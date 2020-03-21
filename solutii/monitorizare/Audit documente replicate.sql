-- DROP TABLE AuditReplicari;

IF NOT EXISTS(SELECT *
              FROM sys.sysobjects
              WHERE name = 'AuditReplicari'
                AND xtype = 'U')
CREATE TABLE AuditReplicari
(
    DataSetId                 DATETIME    NOT NULL,
    TipBazaDeDate             VARCHAR(50) NOT NULL,
    NumeLocatie               VARCHAR(50) NOT NULL,
    IdLocatie                 INT         NOT NULL,
    IdDocument                INT         NOT NULL,
    DataOperare               DATE        NOT NULL,
    DataUltimaModificare      DATE          DEFAULT NULL,
    EsteAnulat                BIT         NOT NULL,
    DataAnulareDocument       DATE          DEFAULT NULL,
    DataDocument              DATE          DEFAULT NULL,
    SerieDocument             VARCHAR(50)   DEFAULT NULL,
    NumarDocument             VARCHAR(50)   DEFAULT NULL,
    Numar                     VARCHAR(50)   DEFAULT NULL,
    NumeTipDocument           VARCHAR(50) NOT NULL,
    NumarLiniiDocument        INT           DEFAULT NULL,
    ValoareDocument           MONEY         DEFAULT NULL,
    CotaTVA                   NUMERIC(6, 3) DEFAULT NULL,
    ValoareDocumentPerCotaTVA MONEY         DEFAULT NULL,
    CONSTRAINT PK_AuditReplicari PRIMARY KEY NONCLUSTERED (DataSetId, TipBazaDeDate, IdLocatie, IdDocument, CotaTVA)
);


DECLARE @DataSetId_Date DATE = GETDATE();
DECLARE @DataSetId VARCHAR(50);
DECLARE @StartDate VARCHAR(50);
DECLARE @EndDate VARCHAR(50);

SET @DataSetId = CAST(@DataSetId_Date AS VARCHAR(50));
SET @StartDate = CAST(DATEADD(DAY, -2, @DataSetId_Date) AS VARCHAR(50))
SET @EndDate = CAST(DATEADD(DAY, -1, @DataSetId_Date) AS VARCHAR(50))

-- select @StartDate, @EndDate

DECLARE @SQL VARCHAR(MAX);
DECLARE @LS VARCHAR(MAX);

-- Creez un cursor pentru construirea referintei Linked Server,
-- care include tot mai putin numele tabelei.
DECLARE LSCursor CURSOR FAST_FORWARD
    FOR
    SELECT '[' + LD.NumeLinkedServer + '].' + LD.NumeBazaDeDate + '.dbo.' AS LS
    FROM LocatieDetaliu LD
             JOIN Locatie L ON LD.IdLocatie = L.IdLocatie
    WHERE L.EsteActiv = 1
      AND LEN(LD.NumeBazaDeDate) > 3
	  AND L.IdLocatie not in (77, 48); -- VIVO, mamaia

OPEN LSCursor;
FETCH NEXT FROM LSCursor INTO @LS;
WHILE @@fetch_status = 0
    BEGIN
        BEGIN TRY
            SET @SQL =
                        'INSERT INTO BizPharmaHO.dbo.AuditReplicari (DataSetId, TipBazaDeDate, NumeLocatie, IdLocatie, IdDocument, DataOperare, DataUltimaModificare, EsteAnulat, DataAnulareDocument, DataDocument, SerieDocument, NumarDocument, Numar, NumeTipDocument, NumarLiniiDocument, ValoareDocument, CotaTVA, ValoareDocumentPerCotaTVA) ' +
                        'SELECT ''' + @DataSetId + ''' AS DataSetId,
               IIF(LEFT(''' + @LS + ''', 11) = ''[10.0.0.130'', ''HeadOffice'', ''Filiala'') AS TipBazaDeDate,
               L.Nume                               AS NumeLocatie,
               D.IdLocatie,
               D.IdDocument,
               CAST(D.DataOperare AS DATE)          AS DataOperare,
               CAST(D.DataUltimaModificare AS DATE) AS DataUltimaModificare,
               D.EsteAnulat,
               CAST(D.DataAnulareDocument AS DATE)  AS DataAnulareDocument,
               CAST(D.DataDocument AS DATE)         AS DataDocument,
               D.SerieDocument,
               D.NumarDocument,
               D.Numar,
               DicD.Nume                            AS NumeTipDocument,
               -- NumarLiniiDocument:
               (
                   SELECT COUNT(*)
                   FROM DocumentDetaliu DD
                   WHERE DD.IdLocatie = D.IdLocatie
                     AND DD.IdDocument = D.IdDocument
               )                                    AS NumarLiniiDocument,
               -- ValoareDocument
               (
                   SELECT SUM(DD.PretAmanunt * DD.CantI + DD.PretAmanunt / DD.CantNrUT * DD.CantF)
                   FROM DocumentDetaliu DD
                   WHERE DD.IdLocatie = D.IdLocatie
                     AND DD.IdDocument = D.IdDocument
               )                                    AS ValoareDocument,
               -- ValoareDocumentPerCotaTVA
               DD.ProcTVA                           AS CotaTVA,
               SUM(DD.PretAmanunt * DD.CantI + DD.PretAmanunt / DD.CantNrUT * DD.CantF)
                                                    AS ValoareDocumentPerCotaTVA
        FROM ' + @LS + 'Document D
                 JOIN ' + @LS + 'Locatie L
                      ON D.IdLocatie = L.IdLocatie
                 JOIN ' + @LS + 'DocumentDetaliu DD
                      ON DD.IdLocatie = D.IdLocatie AND
                         DD.IdDocument = D.IdDocument
                 JOIN ' + @LS + 'DictionarDetaliu DicD
                      ON D.IdTipDocument = DicD.IdDictionarDetaliu
        WHERE D.IdTipDocument NOT IN (17897, 16454) -- Borderou incasari, OrdinCulegere
          AND D.DataOperare BETWEEN ''' + @StartDate + ''' AND ''' + @EndDate + '''' + '
        GROUP BY L.Nume,
                 IIF(D.IdLocatie = 1, ''HeadOffice'', ''Filiala''),
                 D.IdLocatie,
                 D.IdDocument,
                 D.DataOperare,
                 D.DataUltimaModificare,
                 D.EsteAnulat,
                 D.DataAnulareDocument,
                 D.DataDocument,
                 D.SerieDocument,
                 D.NumarDocument,
                 D.Numar,
                 DicD.Nume,
                 DD.ProcTVA
        ORDER BY D.IdLocatie, D.DataOperare, D.IdDocument;';

            EXEC (@SQL);
        END TRY
        BEGIN CATCH
            PRINT 'FAILED QUERYING LS: ' + @LS;
            PRINT ''; -- an empty line as a delimiter
        END CATCH

        FETCH NEXT FROM LSCursor INTO @LS;
    END

CLOSE LSCursor;
DEALLOCATE LSCursor;