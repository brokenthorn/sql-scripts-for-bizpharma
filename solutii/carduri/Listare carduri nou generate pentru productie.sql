-- Cautare dupa diverse criterii:

SELECT NumarCard,
       NumeSerie,
       Valabil
-- SELECT COUNT(*)
FROM Carduri
WHERE NumeSerie LIKE 'Mini-Farm Fidelizare'
  AND ISNUMERIC(NumarCard) = 1
  AND NumarCard >= '200000096036'
  AND NumarCard NOT LIKE '9%'
ORDER BY NumarCard ASC


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT NumarCard,
       NumeSerie,
       Valabil
-- SELECT COUNT(*)
FROM Carduri
WHERE NumeSerie LIKE 'Sustinem o copilarie sanatoasa'
  AND ISNUMERIC(NumarCard) = 1
  AND NumarCard >= '200000106036'
--   AND NumarCard NOT LIKE '9%'
ORDER BY NumarCard ASC

-- Cautare dupa data de valabilitate distincta pentru seria generata:

SELECT count(*)
FROM Carduri
WHERE Valabil = '9998-12-31 00:00:00.000'

-- Cautare numar maxim intr-o serie

SELECT LEFT(NumarCard, 1) AS Inceput,
       MIN(NumarCard)                                                  AS Minim,
       MAX(NumarCard)                                                  AS Maxim,
       COUNT(*)                                                        AS Randuri,
       CAST(MAX(NumarCard) AS BIGINT) - cast(MIN(NumarCard) AS BIGINT) AS MaxMinusMin,
       NumeSerie
FROM Carduri
WHERE ISNUMERIC(NumarCard) = 1
--       NumarCard NOT LIKE '9%'
--   AND NumarCard NOT LIKE '8%'
--   AND NumarCard NOT LIKE '5%'
--   AND NumeSerie = 'Sustinem o copilarie sanatoasa'
--   AND NumarCard LIKE '2%'
GROUP BY LEFT(NumarCard, 1), NumeSerie
ORDER BY LEFT(NumarCard, 1), MIN(NumarCard)
