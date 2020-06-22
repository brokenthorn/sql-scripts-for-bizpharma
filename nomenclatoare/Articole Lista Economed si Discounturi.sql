SELECT DISTINCT ea.Nume,
                ed.ValDisc,
                ed.ProcCas,
                ed.DataInceput
FROM EconomedDiscount ed
         JOIN EconomedArticol ea
              ON ed.IdLocatie = ea.IdLocatie AND ed.IdEconomedArticol = ea.IdEconomedArticol
WHERE ea.DataSfarsit >= GETDATE()
  AND ed.DataSfarsit >= GETDATE()
ORDER BY ea.Nume;