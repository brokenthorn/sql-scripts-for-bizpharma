SELECT NumeSerie,
       min(NumarCard)     AS Minim,
       max(NumarCard)     AS Maxim,
       COUNT(*)              CountCarduri,
       LEFT(NumarCard, 1) AS PrimaCifra
FROM Carduri
WHERE ISNUMERIC(NumarCard) = 1
GROUP BY NumeSerie, LEFT(NumarCard, 1)
ORDER BY min(NumarCard) ASC


-- 100000083101
SELECT NumeSerie, NumarCard
FROM Carduri
WHERE NumarCard >= '100000083101' and NumarCard <= '2000000000000'
  AND ISNUMERIC(NumarCard) = 1
  AND NumeSerie = 'Mini-Farm Fidelizare'