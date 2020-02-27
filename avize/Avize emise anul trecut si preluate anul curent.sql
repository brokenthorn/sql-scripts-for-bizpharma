SELECT dest.nume AS [desinatie], sursa.Nume AS [sursa], aviz_intrare.Valoare, doc_intrare.*
FROM document doc_intrare
         JOIN locatie dest ON dest.IdLocatie = doc_intrare.IdLocatie
         JOIN aviz aviz_intrare
              ON doc_intrare.IdLocatie = aviz_intrare.IdLocatie AND doc_intrare.IdDocument = aviz_intrare.IdDocument
         JOIN locatie sursa ON sursa.IdLocatie = aviz_intrare.IdLocatiePartener
WHERE IdTipDocument = 80
  AND year(DataDocument) = 2019
  AND year(DataReceptie) = 2020
ORDER BY doc_intrare.Numar