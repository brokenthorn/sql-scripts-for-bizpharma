SELECT d.MomentOperareDocument,
       tip.Cod AS TipTranzactie,
       tip.Nume,
       od.IdLocatie,
       od.IdDocument,
       od.Ordine,
       od.ProdusOSMRCod2D,
       od.ProdusOSMRCod,
       od.ProdusOSMRNrSerial,
       od.ProdusOSMRLot,
       od.ProdusOSMRBBD,
       ott.CodEroareRaspuns,
       ott.MesajEroareRaspuns
FROM Document d
         INNER JOIN OSMRXDocument od ON d.IdLocatie = od.IdLocatie AND
                                        d.IdDocument = od.IdDocument
         INNER JOIN OSMRXDocumentXTipTranzactie ott
                    ON od.IdLocatie = ott.IdLocatie AND
                       od.IdOSMRXDocument = ott.IdOSMRXDocument
         INNER JOIN OSMRTipTranzactie tip
                    ON ott.IdTipTranzactie = tip.IdOSMRTipTranzactie
WHERE d.MomentOperareDocument BETWEEN '20200608' AND '20200614 23:59:59.997'
  AND ott.CodEroareRaspuns IN
      ('NMVS_FE_LOT_13', 'NMVS_NC_PC_02', 'NMVS_FE_LOT_03', 'NMVS_NC_PCK_22')
  AND tip.Cod <> 'G110'