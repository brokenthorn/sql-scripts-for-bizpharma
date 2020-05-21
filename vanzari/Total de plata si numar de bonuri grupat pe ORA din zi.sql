BEGIN
    SELECT ORA            = DATEPART(HOUR, D.MomentOperareDocument),
           ValoareDePlata = SUM(B.ValoareDePlata),
           Nr             = COUNT(B.IdDocument)
    FROM Bon B
             JOIN Locatie L ON B.IdLocatie = L.IdLocatie
             JOIN Document D ON B.IdLocatie = D.IdLocatie AND B.IdDocument = D.IdDocument
    WHERE D.MomentOperareDocument BETWEEN '1 May 2020' AND '30 May 2020'
    GROUP BY DATEPART(HOUR, D.MomentOperareDocument)
    ORDER BY 2 DESC
END