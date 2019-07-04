SELECT P.IdArticolXPretImpus,
       P.IdArticol,
       A.Nume                               AS NumeArticol,
       P.IdLocatie,
       L.Nume                               AS NumeLocatie,
       cast(P.PretRidicataImpus AS MONEY)   AS PretRidicataImpus,
       cast(P.PretAmanuntImpus AS MONEY)    AS PretAmanuntImpus,
       (SELECT SUM(PretAchizitieNediscFTVA * (CantF + (CantI * CantNrBuc))) / SUM(CantF + (CantI * CantNrBuc))
        FROM Stoc
        WHERE Stoc.IdArticol = P.IdArticol) AS PretAchMediuPonderatNediscFTVA,
       (SELECT SUM(PretAchizitieDiscFTVA * (CantF + (CantI * CantNrBuc))) / SUM(CantF + (CantI * CantNrBuc))
        FROM Stoc
        WHERE Stoc.IdArticol = P.IdArticol) AS PretAchMediuPonderatDiscFTVA,
       P.DataInceput,
       P.DataSfarsit,
       P.EsteActiv,
       P.IdImport,
       P.IdGrupaLocatieXGrilaPreturiXDiscount,
       P.IdGrupaLocatie,
       G.Nume                               AS NumeGrupaLocatie,
       P.Descriere
FROM ArticolXPretImpus P
         JOIN Articol A ON P.IdArticol = A.IdArticol
         LEFT JOIN Locatie L ON L.IdLocatie = P.IdLocatie
         LEFT JOIN GrupaLocatie G ON P.IdGrupaLocatie = G.IdGrupaLocatie