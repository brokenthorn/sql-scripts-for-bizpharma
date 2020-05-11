-- Carduri neasociate
SELECT C.NumeSerie,
       C.NumarCard,
       NULLIF(CONCAT(P.Nume, ' ', P.Prenume), ' ')       AS PersoanaPrincipala,
       NULLIF(CONCAT(PCXP.Nume, ' ', PCXP.Prenume), ' ') AS Persoana
FROM Carduri C
         LEFT JOIN Persoana P ON C.NumarCard = P.NumarCard
         LEFT JOIN CarduriXPersoana CXP ON C.NumarCard = CXP.NumarCard
         LEFT JOIN Persoana PCXP ON PCXP.IdPersoana = CXP.IdPersoana
WHERE C.NumeSerie LIKE 'Mini-Farm%'
  AND P.IdPersoana IS NULL
  AND PCXP.IdPersoana IS NULL
ORDER BY C.NumarCard