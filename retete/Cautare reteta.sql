USE BizPharmaHO;
GO

-- Cauta reteta:
SELECT L.Nume,
       R.*
FROM CasReteta R
         JOIN Locatie L ON R.IdLocatie = L.IdLocatie
WHERE
--       NumarReteta = '6070'
--   AND SerieReteta LIKE 'NTLIAL'
R.CID = '40110884864662357058';
GO

-- Cauta eliberarea:
DECLARE
    @IdCasReteta INT,
    @IdLocatie INT;

SELECT TOP 1 @IdLocatie = R.IdLocatie,
             @IdCasReteta = R.IdCasReteta
FROM CasReteta R
WHERE NumarReteta = '2741'
  AND SerieReteta = 'NTLGCF';

SELECT L.Nume, E.*
FROM CasEliberare E
         JOIN Locatie L ON E.IdLocatie = L.IdLocatie
WHERE E.IdCasReteta = @IdCasReteta
  AND E.IdLocatie = @IdLocatie;
GO