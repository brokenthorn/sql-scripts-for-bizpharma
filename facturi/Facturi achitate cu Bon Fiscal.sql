SELECT ROW_NUMBER() OVER (ORDER BY F.IdDocument) AS NrCrt,
       CONCAT(F.Idlocatie, ': ' + L.Nume)        AS Locatie,
       F.IdDocument,
       F.Numar,
       F.Serie,
       F.NumarDoc,
       F.DataDoc,
       F.ValoareDoc,
       F.ValoareDePlata,
       FI.EsteFacturaOnline,
       FI.Tiparita,
       B.Numar                                   AS NumarInternBon,
       B.NumarBonFiscal,
       B.ValoareDePlata                          AS ValoarePlataBon,
       B.EsteReturnat,
       B.EsteTiparit
FROM Factura F
         JOIN Locatie L ON F.IdLocatie = L.IdLocatie
         JOIN FacturaIesire FI ON F.IdLocatie = FI.IdLocatie AND F.IdDocument = FI.IdDocument
         JOIN FacturaIesireXBon FIXB ON F.IdLocatie = FIXB.IdLocatie AND F.IdDocument = FIXB.IdFactura
         JOIN Bon B ON FIXB.IdLocatie = B.IdLocatie AND FIXB.IdBon = B.IdDocument
WHERE F.DataDoc BETWEEN '2020-01-01' AND '2020-01-31 23:59:59.999'
ORDER BY F.IdDocument