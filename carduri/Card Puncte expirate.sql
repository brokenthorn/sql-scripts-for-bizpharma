DECLARE @luniValabilitate INT = 6;

SELECT cxo.NumarCard,
       p1.Nume,
       p1.Prenume,
       p1.cnp,
       p2.Nume,
       p2.Prenume,
       p2.CNP,
       cxo.NrPuncte                AS NrPuncteExpirate,
       cxo.Observatie,
       cxo.DataOperatie            AS DataProcesuluiDeExpirare,
       IIF((month(cxo.DataOperatie) - @luniValabilitate) < 0,
           month(cxo.DataOperatie) - @luniValabilitate + 12,
           month(cxo.DataOperatie) - @luniValabilitate) %
       12                          AS LunaAcumulariiPunctelorExpirate,
       IIF((month(cxo.DataOperatie) - @luniValabilitate) < 0, year(cxo.DataOperatie) - 1,
           year(cxo.DataOperatie)) AS AnulAcumulariiPunctelorExpirate
FROM CardXOperatie CXO
         LEFT JOIN Persoana P1 ON P1.NumarCard = CXO.NumarCard
         LEFT JOIN CarduriXPersoana cxp ON cxp.NumarCard = cxo.NumarCard
         LEFT JOIN Persoana P2 ON P2.NumarCard = cxp.NumarCard
WHERE IdLocatie = 1
  AND Observatie LIKE 'Proces verbal de diminuare (creat automat) - puncte expirate in luna%'
  AND YEAR(DataOperatie) = 2019
ORDER BY cxo.DataOperatie, cxo.NumarCard
