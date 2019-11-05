
DECLARE
    @startDate DATETIME = '2019-11-01 00:00:00';

SELECT L.Nume                               AS Locatie,
       Utlz.Nume                            AS Utilizator,
       BonDefinitie.Nume                    AS TipBon,
       Bon.NumarCard                        AS NumarCard,
       -- CXO.NumarCard AS NumarCardInregistratInOperatie,
       IIF(PersoanaCardPrincipal.IdPersoana IS NULL, 'Secundar',
           'Principal')                     AS TipCard,
       ISNULL(PersoanaCardPrincipal.Nume + ' ' +
              PersoanaCardPrincipal.Prenume,
              PersoanaCardSecundar.Nume + ' ' +
              PersoanaCardSecundar.Prenume) AS PosesorCard,

       CXO.IdOperatie                       AS IdOperatie,
       CXO.SensOperatie                     AS SensOperatie
FROM CardXOperatie CXO
         JOIN Operatie O ON O.IdOperatie = CXO.IdOperatie AND
                            O.IdLocatie = CXO.IdLocatie
         JOIN Document D
              ON O.IdElement = D.IdDocument AND O.IdLocatie = D.IdLocatie
         JOIN Bon ON Bon.IdDocument = D.IdDocument AND
                     Bon.IdLocatie = D.IdLocatie
         JOIN Utilizator Utlz ON O.IdUtilizator = Utlz.IdUtilizator
         JOIN BonDefinitie
              ON BonDefinitie.IdBonDefinitie = Bon.IdBonDefinitie
         JOIN Carduri C ON CXO.NumarCard = C.NumarCard
         JOIN Locatie L ON D.IdLocatie = L.IdLocatie
         LEFT JOIN Persoana PersoanaCardPrincipal
                   ON PersoanaCardPrincipal.NumarCard = C.NumarCard
         LEFT JOIN CarduriXPersoana CXP ON C.NumarCard = CXP.NumarCard
         LEFT JOIN Persoana PersoanaCardSecundar
                   ON CXP.IdPersoana = PersoanaCardSecundar.IdPersoana
WHERE C.NumeSerie LIKE 'Regina Maria'
  AND O.MomentOperatie >= @startDate
--   AND Bon.NumarCard = '1000000211634'
--              GROUP BY L.Nume, Utlz.Nume, BonDefinitie.Nume, Bon.NumarCard,
--                       PersoanaCardPrincipal.IdPersoana, PersoanaCardPrincipal.Nume, PersoanaCardPrincipal.Prenume,
--                       PersoanaCardSecundar.IdPersoana, PersoanaCardSecundar.Nume, PersoanaCardSecundar.Prenume,
--                       CXO.SensOperatie
