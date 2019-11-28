SELECT cxo.NumarCard,
       p1.Nume,
       p1.Prenume,
       p1.cnp,
       p2.Nume,
       p2.Prenume,
       p2.CNP,
       cxo.NrPuncte AS NrPuncteExpirate,
       cxo.Observatie,
       cxo.DataOperatie
FROM CardXOperatie CXO
         LEFT JOIN Persoana P1 ON P1.NumarCard = CXO.NumarCard
         LEFT JOIN CarduriXPersoana cxp ON cxp.NumarCard = cxo.NumarCard
         LEFT JOIN Persoana P2 ON P2.NumarCard = cxp.NumarCard
WHERE IdLocatie = 1
  AND Observatie LIKE 'Proces verbal de diminuare (creat automat) - puncte expirate in luna%'
  AND (cxp.DataInceput IS NULL OR cxp.DataInceput <= GETDATE())
  AND (cxp.DataSfarsit IS NULL OR cxp.DataSfarsit >= GETDATE())
  AND YEAR(DataOperatie) = 2019
  AND MONTH(DataOperatie) = 6 -- se pot decomenta aceste conditii daca se doreste extragerea informatiilor aferente unei anumite luni
ORDER BY cxo.DataOperatie, cxo.NumarCard