SELECT A.IdArticol,
       A.Cod,
       A.Nume                                          AS Nume,
       Prod.Nume                                       AS Producator,
       Prds.CantNrBuc                                  AS Imp,
       SUM(Stoc.CantI) +
       FLOOR(
               sum(stoc.CantF) / CAST(Prds.CantNrBuc AS MONEY)
           )                                           AS T_CantI,
       SUM(stoc.CantF) % CAST(Prds.CantNrBuc AS MONEY) AS T_CantF
FROM Articol A
         LEFT JOIN Produs Prds ON A.IdArticol = Prds.IdArticol
         LEFT JOIN Partener Prod ON Prod.IdPartener = Prds.IdProducator
         LEFT OUTER JOIN Stoc ON A.IdArticol = Stoc.IdArticol
WHERE A.AreStoc = 1
GROUP BY A.IdArticol,
         A.Cod,
         A.Nume,
         Prod.Nume,
         Prds.CantNrBuc