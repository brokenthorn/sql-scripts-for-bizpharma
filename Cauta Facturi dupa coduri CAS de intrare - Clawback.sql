SELECT DISTINCT L.Nume                       AS Farmacie,
                P.Nume                       AS Partner,
                cast(D.DataDocument AS DATE) AS DataDocument,
                D.SerieDocument,
                D.NumarDocument,
                A.Nume,
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
      ('W03703002',
       'W07268001',
       'W08254001',
       'W08932002',
       'W08973001',
       'W41731002',
       'W41732002',
       'W53034001',
       'W54046001')
  AND F.DataDoc BETWEEN '2017-06-01' AND '2018-03-31 23:59:59.999'
  AND D.IdTipDocument = 88