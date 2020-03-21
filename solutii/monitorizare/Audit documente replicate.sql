-- Solutie de audit al documentelor replicate.
--
-- Se construieste acest raport in HO si in FL si se compara rezultatele.
-- Se pot astfel detecta linii/documente nereplicate, sau nereplicate complet,
-- precum si diferente de valoari la nivel de linie de document.

DECLARE @DataSetId DATETIME;
SET @DataSetId = GETDATE();
DECLARE @TipBazaDeDate VARCHAR(50);
SET @TipBazaDeDate = dbo.fnTipBazaDeDate();

DECLARE @StartDate DATE, @EndDate DATE;
SET @StartDate = DATEADD(DAY, -8, CAST(@DataSetId AS DATE))
SET @EndDate = DATEADD(DAY, -1, CAST(@DataSetId AS DATE))

-- select @StartDate, @EndDate

SELECT @DataSetId                           AS DataSetId,
       @TipBazaDeDate                       AS TipBazaDeDate,
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
FROM DOCUMENT D
         JOIN Locatie L
              ON D.IdLocatie = L.IdLocatie
         JOIN DocumentDetaliu DD
              ON DD.IdLocatie = D.IdLocatie AND
                 DD.IdDocument = D.IdDocument
         JOIN DictionarDetaliu DicD
              ON D.IdTipDocument = DicD.IdDictionarDetaliu
WHERE D.IdTipDocument NOT IN (17897, 16454) -- Borderou incasari, OrdinCulegere
  AND D.DataOperare BETWEEN @StartDate AND @EndDate
  AND L.Nume LIKE 'CEC'
GROUP BY L.Nume,
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
ORDER BY D.IdLocatie, D.DataOperare, D.IdDocument;