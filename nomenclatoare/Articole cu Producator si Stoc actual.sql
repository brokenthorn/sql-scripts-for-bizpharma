SELECT A.IdArticol,
       A.Cod,
       A.Nume                                          AS Nume,
       Prod.Nume                                       AS Producator,
       Stoc.CantNrBuc                                  AS ImpStoc,
       SUM(Stoc.CantI) +
       FLOOR(
               sum(Stoc.CantF) / CAST(Stoc.CantNrBuc AS MONEY)
           )                                           AS T_CantI,
       SUM(Stoc.CantF) % CAST(Stoc.CantNrBuc AS MONEY) AS T_CantF
FROM Articol A
         LEFT JOIN Produs Prds ON A.IdArticol = Prds.IdArticol
         LEFT JOIN Partener Prod ON Prod.IdPartener = Prds.IdProducator
         LEFT OUTER JOIN Stoc ON A.IdArticol = Stoc.IdArticol
WHERE A.AreStoc = 1
GROUP BY A.IdArticol,
         A.Cod,
         A.Nume,
         Prod.Nume,
         Stoc.CantNrBuc;
GO