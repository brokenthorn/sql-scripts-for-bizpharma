SELECT B.NumarBonFiscal,
       B.Numar         AS NumarBon,
       B.ValoareDoc,
       B.EsteReturnat,
       B.EsteTiparit,
       BFXP.Nume       AS Articol,
       BFXP.CantI,
       BFXP.CantF,
       BFXP.CantitateUT,
       BFXP.Pozitie,
       BPXIT.NumarReteta,
       BPXIT.SerieReteta,
       BPXIT.NumarCard AS NumarCardInfotreat,
       BPXIT.ValDisc,
       BPXIT.ValDiscUT,
       BPXIT.MesajRaspuns,
       BPXIT.CodRaspuns
FROM Bon B
         JOIN BonFiscalXProdus BFXP ON B.IdDocument = BFXP.IdDocument AND B.IdLocatie = BFXP.IdLocatie
         JOIN BonProdusXInfoTreat BPXIT ON BPXIT.IdDocument = BFXP.IdDocument AND BPXIT.IdLocatie = BFXP.IdLocatie
         JOIN CasReteta_ENC CRE ON B.IdLocatie = CRE.IdLocatie AND B.IdDocument = CRE.IdBon
WHERE CRE.SerieReteta = 'ntliai'
  AND CRE.NumarReteta = '4243'