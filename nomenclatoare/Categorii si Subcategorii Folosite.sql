SELECT DISTINCT IdCategorie, IdSubcategorie, Cat.Nume, SubCat.Nume
FROM Articol
         JOIN DictionarDetaliu Cat ON Articol.IdCategorie = Cat.IdDictionarDetaliu
         JOIN DictionarDetaliu SubCat ON Articol.IdSubcategorie = SubCat.IdDictionarDetaliu
WHERE AreStoc = 1
  AND Articol.EsteActiv = 1
ORDER BY Articol.IdCategorie, Articol.IdSubcategorie