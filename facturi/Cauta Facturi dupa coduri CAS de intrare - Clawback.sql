SELECT DISTINCT L.Nume                       AS Farmacie,
                P.Nume                       AS Partner,
                cast(D.DataDocument AS DATE) AS DataDocument,
                D.SerieDocument,
                D.NumarDocument,
                A.Nume,
                DD.CodCIMStoc,
                DD.CantI,
                DD.CantF,
                DD.CantNrUT
FROM DocumentDetaliu DD
         JOIN Document D ON DD.IdLocatie = D.IdLocatie AND DD.IdDocument = D.IdDocument
         JOIN Locatie L ON L.IdLocatie = D.IdLocatie
         JOIN Factura F ON D.IdLocatie = F.IdLocatie AND D.IdDocument = F.IdDocument
         JOIN Partener P ON P.IdPartener = F.IdPartener
         JOIN Articol A ON DD.IdArticol = A.IdArticol
WHERE DD.CodCIMStoc IN
      ('W57681001')
  AND F.DataDoc BETWEEN '2017-01-01' AND '2017-12-31 23:59:59.999'
  AND D.IdTipDocument = 88
  AND P.IdPartener <> 8676 -- NovoLine Pharm S.R.L.