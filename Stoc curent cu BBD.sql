-- Stoc curent cu BBD
-- ------------------

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO

SELECT DISTINCT L.Nume              AS Farmacie,
                A.IdArticol         AS IdArticol,
                A.Nume              AS Produs,
                cast(S.BBD AS DATE) AS BBD,
                SUM(S.CantI)        AS StocI
FROM Stoc S
         JOIN Locatie L ON S.IdLocatie = L.IdLocatie
         JOIN Articol A ON S.IdArticol = A.IdArticol
WHERE S.IdArticol IN (1385)
GROUP BY L.Nume, A.IdArticol, A.Nume, cast(S.BBD AS DATE);
GO