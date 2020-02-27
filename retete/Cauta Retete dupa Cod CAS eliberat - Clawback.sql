SELECT L.Nume                      AS Farmacie,
       Cas.Nume                    AS Casa,
       A.Nume                      AS Medicament,
       CRD.CodCas,
       CR.SerieReteta,
       CR.NumarReteta,
       cast(CR.DataReteta AS DATE) AS DataReteta,
       CRD.CantitateUT,
       CRD.CantNrBuc
FROM CasRetetaDetaliu CRD
         JOIN CasReteta CR
              ON CRD.IdLocatie = CR.IdLocatie
                  AND CRD.IdCasReteta = CR.IdCasReteta
         JOIN Articol A ON CRD.IdArticol = A.IdArticol
         JOIN Cas ON CR.IdCas = Cas.IdCas
         JOIN Locatie L ON L.IdLocatie = CR.IdLocatie
WHERE CR.DataReteta BETWEEN '2017-10-01' AND '2017-12-31 23:59:59.999'
  AND CRD.CodCas IN ('W57681001')