SELECT CED.CodCAS,
       L.Nume,
       CB.Nume,
       CB.DataBorderou,
       CB.DataInceput,
       CB.DataSfarsit,
       CB.SerieFactura,
       CB.NumarFactura,
       CB.DataFactura,
       CB.SerieFacturaG21,
       CB.NumarFacturaG21,
       CB.DataFacturaG21,
       CB.SerieFacturaCroniceLicitate,
       CB.NumarFacturaCroniceLicitate,
       CB.DataFacturaCroniceLicitate,
       CB.SerieFacturaInsuline,
       CB.NumarFacturaInsuline,
       CB.DataFacturaInsuline,
       CB.SerieFacturaOncologice,
       CB.NumarFacturaOncologice,
       CB.DataFacturaOncologice,
       CB.SerieFacturaTransplant,
       CB.NumarFacturaTransplant,
       CB.DataFacturaTransplant,
       CB.SerieFacturaPens600,
       CB.NumarFacturaPens600,
       CB.DataFacturaPens600,
       CB.SerieFacturaPens600MS,
       CB.NumarFacturaPens600MS,
       CB.DataFacturaPens600MS,
       CB.SerieFacturaPens600CAS,
       CB.NumarFacturaPens600CAS,
       CB.DataFacturaPens600CAS,
       CB.SerieFacturaCardEuropean,
       CB.NumarFacturaCardEuropean,
       CB.DataFacturaCardEuropean,
       CB.NrFacturaDiferitCARD_ACORD_FE_PNS
FROM CasBorderou CB
         JOIN CasReteta CR
              ON CB.IdCasBorderou = CR.IdCasBorderou AND
                 CB.IdLocatie = CR.IdLocatie
         JOIN CasEliberare CE
              ON CE.IdCasReteta = CR.IdCasReteta AND
                 CE.IdLocatie = CR.IdLocatie
         JOIN CasPrescriere CP
              ON CP.IdCasPrescriere = CE.IdCasPrescriere AND
                 CP.IdLocatie = CE.IdLocatie
    --JOIN CasPrescriereDetaliu CPD
    --     ON CPD.IdCasPrescriere = CP.IdCasPrescriere AND
    --        CPD.IdLocatie = CP.IdLocatie
         JOIN CasEliberareDetaliu CED
              ON CED.IdLocatie = CE.IdLocatie AND
                 CED.IdCasEliberare = CE.IdCasEliberare
         JOIN Locatie L ON CB.IdLocatie = L.IdLocatie
         JOIN CasTipBorderou CTB ON CB.IdCasTipBorderou = CTB.IdCasTipBorderou
WHERE CTB.IdCas = 1
  AND CED.CodCAS IN
      ('W56001006',
       'W57668001',
       'W57669001',
       'W58031002',
       'W59688005',
       'W60122002',
       'W60645004')
  AND CE.DataEliberare BETWEEN '2017-10-01' AND '2018-02-28 23:59:59.999'
GROUP BY CED.CodCAS, L.Nume, CB.Nume, CB.DataBorderou, CB.DataInceput,
         CB.DataSfarsit, CB.SerieFactura, CB.NumarFactura, CB.DataFactura,
         CB.SerieFacturaG21, CB.NumarFacturaG21, CB.DataFacturaG21,
         CB.SerieFacturaCroniceLicitate, CB.NumarFacturaCroniceLicitate,
         CB.DataFacturaCroniceLicitate, CB.SerieFacturaInsuline,
         CB.NumarFacturaInsuline, CB.DataFacturaInsuline,
         CB.SerieFacturaOncologice, CB.NumarFacturaOncologice,
         CB.DataFacturaOncologice, CB.SerieFacturaTransplant,
         CB.NumarFacturaTransplant, CB.DataFacturaTransplant,
         CB.SerieFacturaPens600, CB.NumarFacturaPens600, CB.DataFacturaPens600,
         CB.SerieFacturaPens600MS, CB.NumarFacturaPens600MS,
         CB.DataFacturaPens600MS, CB.SerieFacturaPens600CAS,
         CB.NumarFacturaPens600CAS, CB.DataFacturaPens600CAS,
         CB.SerieFacturaCardEuropean, CB.NumarFacturaCardEuropean,
         CB.DataFacturaCardEuropean, CB.NrFacturaDiferitCARD_ACORD_FE_PNS;