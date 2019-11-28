SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT DISTINCT L.Nume AS Farmacie, A.Nume AS Medicament, F.Numar, F.NumarDoc, F.Serie, F.DataDoc
FROM Factura F
       JOIN Document D ON F.IdLocatie = D.IdLocatie AND F.IdDocument = D.IdDocument
       JOIN Locatie L ON D.IdLocatie = L.IdLocatie
       JOIN DocumentDetaliu DD ON D.IdLocatie = DD.IdLocatie AND D.IdDocument = DD.IdDocument
       JOIN Articol A ON DD.IdArticol = A.IdArticol
       JOIN DictionarDetaliu DictDet ON D.IdTipDocument = DictDet.IdDictionarDetaliu
       JOIN Dictionar Dict ON DictDet.IdDictionar = Dict.IdDictionar
WHERE Dict.IdDictionar = 2                      -- Tip document
  AND DictDet.IdDictionarDetaliu IN (1, 88, 91) -- Facturi de toate tipurile, toate de intrare
  AND A.Nume LIKE '%irbe%';
