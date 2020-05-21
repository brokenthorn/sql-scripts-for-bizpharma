SELECT NumeSerie,
       min(NumarCard)     AS Minim,
       max(NumarCard)     AS Maxim,
       COUNT(*)              CountCarduri,
       LEFT(NumarCard, 1) AS PrimaCifra
FROM Carduri
WHERE ISNUMERIC(NumarCard) = 1
GROUP BY NumeSerie, LEFT(NumarCard, 1)
ORDER BY min(NumarCard) ASC