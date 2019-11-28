DECLARE
    @startDate DATETIME = '2019-07-01 00:00:00',
    @endDate   DATETIME = '2019-07-31 23:59:59';

SELECT L.Nume              AS Locatie,
       CXO.NumarCard       AS NumarCard,
       IIF(
               EXISTS(
                       SELECT P.IdPersoana
                       FROM Persoana P
                       WHERE P.NumarCard = CXO.NumarCard
                   ),
               (
                   SELECT TOP 1 P.Nume + ' ' + P.Prenume
                   FROM Persoana P
                   WHERE P.NumarCard = CXO.NumarCard
               ),
               (
                   SELECT TOP 1 P.Nume + ' ' + P.Prenume
                   FROM CarduriXPersoana CXP
                            JOIN Persoana P ON P.IdPersoana = CXP.IdPersoana
                   WHERE CXP.NumarCard = CXO.NumarCard
               )
           )               AS PosesorCard,
       @startDate          AS StartDate,
       @endDate            AS EndDate,
       SUM(CXO.NrPuncte)   AS TotalPuncteAcumulate,
       COUNT(CXO.NrPuncte) AS NumarDeAcumulari,
       0                   AS TotalPuncteAchitari,
       0                   AS NumarDeAchitari
FROM CardXOperatie CXO
         JOIN Locatie L ON CXO.IdLocatie = L.IdLocatie
WHERE CXO.SensOperatie > 0 -- Acumulare
  AND CXO.NrPuncte <> 0
  AND (CXO.DataOperatie BETWEEN @startDate AND @endDate)
GROUP BY L.Nume,
         CXO.NumarCard

UNION ALL

SELECT L.Nume              AS Locatie,
       CXO.NumarCard       AS NumarCard,
       IIF(
               EXISTS(
                       SELECT P.IdPersoana
                       FROM Persoana P
                       WHERE P.NumarCard = CXO.NumarCard
                   ),
               (
                   SELECT TOP 1 P.Nume + ' ' + P.Prenume
                   FROM Persoana P
                   WHERE P.NumarCard = CXO.NumarCard
               ),
               (
                   SELECT TOP 1 P.Nume + ' ' + P.Prenume
                   FROM CarduriXPersoana CXP
                            JOIN Persoana P ON P.IdPersoana = CXP.IdPersoana
                   WHERE CXP.NumarCard = CXO.NumarCard
               )
           )               AS PosesorCard,
       @startDate          AS StartDate,
       @endDate            AS EndDate,
       0                   AS TotalPuncteAcumulate,
       0                   AS NumarDeAcumulari,
       SUM(CXO.NrPuncte)   AS TotalPuncteAchitari,
       COUNT(CXO.NrPuncte) AS NumarDeAchitari
FROM CardXOperatie CXO
         JOIN Locatie L ON CXO.IdLocatie = L.IdLocatie
WHERE CXO.SensOperatie < 0 -- Achitare
  AND CXO.NrPuncte <> 0
  AND (CXO.DataOperatie BETWEEN @startDate AND @endDate)
GROUP BY L.Nume,
         CXO.NumarCard

ORDER BY PosesorCard