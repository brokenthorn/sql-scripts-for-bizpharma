BEGIN
    SELECT L.Nume AS Farmacie, '1-10' AS GRUPA_PLATA, COUNT(*) AS CNT_Bonuri
    FROM Bon B
             JOIN Locatie L ON B.IdLocatie = L.IdLocatie
             JOIN Document D ON B.IdLocatie = D.IdLocatie AND B.IdDocument = D.IdDocument
    join CasRe
    WHERE D.DataOperare >= '15 Apr 2020'
      AND B.ValoareDePlata BETWEEN 1 AND 10
      AND D.EsteAnulat = 0
      AND B.EsteReturnat = 0
    GROUP BY L.Nume

    UNION ALL

    SELECT L.Nume AS Farmacie, '10.01-20' AS GRUPA_PLATA, COUNT(*) AS CNT_Bonuri
    FROM Bon B
             JOIN Locatie L ON B.IdLocatie = L.IdLocatie
             JOIN Document D ON B.IdLocatie = D.IdLocatie AND B.IdDocument = D.IdDocument
    WHERE D.DataOperare >= '15 Apr 2020'
      AND B.ValoareDePlata BETWEEN 10.01 AND 20
      AND D.EsteAnulat = 0
      AND B.EsteReturnat = 0
    GROUP BY L.Nume

    UNION ALL

    SELECT L.Nume AS Farmacie, '20.01-30' AS GRUPA_PLATA, COUNT(*) AS CNT_Bonuri
    FROM Bon B
             JOIN Locatie L ON B.IdLocatie = L.IdLocatie
             JOIN Document D ON B.IdLocatie = D.IdLocatie AND B.IdDocument = D.IdDocument
    WHERE D.DataOperare >= '15 Apr 2020'
      AND B.ValoareDePlata BETWEEN 20.01 AND 30
      AND D.EsteAnulat = 0
      AND B.EsteReturnat = 0
    GROUP BY L.Nume

    UNION ALL

    SELECT L.Nume AS Farmacie, '30.01-40' AS GRUPA_PLATA, COUNT(*) AS CNT_Bonuri
    FROM Bon B
             JOIN Locatie L ON B.IdLocatie = L.IdLocatie
             JOIN Document D ON B.IdLocatie = D.IdLocatie AND B.IdDocument = D.IdDocument
    WHERE D.DataOperare >= '15 Apr 2020'
      AND B.ValoareDePlata BETWEEN 30.01 AND 40
      AND D.EsteAnulat = 0
      AND B.EsteReturnat = 0
    GROUP BY L.Nume

    UNION ALL

    SELECT L.Nume AS Farmacie, '>40' AS GRUPA_PLATA, COUNT(*) AS CNT_Bonuri
    FROM Bon B
             JOIN Locatie L ON B.IdLocatie = L.IdLocatie
             JOIN Document D ON B.IdLocatie = D.IdLocatie AND B.IdDocument = D.IdDocument
    WHERE D.DataOperare >= '15 Apr 2020'
      AND B.ValoareDePlata > 40
      AND D.EsteAnulat = 0
      AND B.EsteReturnat = 0
    GROUP BY L.Nume;
END