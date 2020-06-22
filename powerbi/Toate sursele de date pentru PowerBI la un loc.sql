-- Locatie
SELECT IdLocatie, IdTipLocatie, IdPartener, IdAdresa, IdPunctLucru, EsteActiv, Nume AS NumeLocatie
FROM Locatie;

-- PunctLucru
SELECT IdPunctLucru, IdPartener, IdAdresa, IdAdresaFacturare, Denumire AS NumePunctLucru
FROM PunctLucru;

-- Partener
SELECT IdPartener, IdAdresa, Nume AS NumePartener, CodFiscal
FROM Partener;

-- Adresa
SELECT Adresa.IdAdresa,
       Oras.Nume     AS NumeOras,
       Adresa.Sector,
       Judet.Nume    AS NumeJudet,
       Tara.Nume     AS NumeTara,
       Adresa.Strada AS NumeStrada,
       Adresa.Numar  AS NumarCladire,
       Adresa.Bloc   AS Bloc,
       Adresa.Scara  AS Scara,
       Adresa.Ap     AS Apartament,
       Adresa.CodPostal,
       Adresa.Email,
       Adresa.Web
FROM Adresa
         JOIN Oras ON Adresa.IdOras = Oras.IdOras
         JOIN Judet ON Oras.IdJudet = Judet.IdJudet
         JOIN Tara ON Judet.IdTara = Tara.IdTara;

-- AntetPrecomanda
--
-- Antete pentru precomenzi ne-anulate si documente rezultate.
-- Filtrat sa excluda documente rezultate care au fost anulate.
BEGIN
    DECLARE
        @DeLaData DATE = '1 Feb 2020 00:00:00',
        @PanaLaData DATE = '29 Feb 2020 23:59:59';

    SELECT CHECKSUM(D.IdLocatie, D.IdDocument) AS DocumentKey,
           P.IdLocatie,
           -- P.IdPrecomanda,
           D.IdDocument,
           D.IdTipDocument,
           D.SerieDocument,
           D.NumarDocument,
           D.DataDocument,
           D.Descriere,
           P.IdSursaPrecomanda,
           P.IdTipPrecomanda,
           P.IdStarePrecomanda,
           P.Numar                             AS NumarPrecomanda,
           P.NumePersoana,
           P.PrenumePersoana,
           NULLIF(TRIM(P.CNP), '')             AS CNP_CIF,
           P.AdresaFacturare,
           P.AdresaLivrare,
           P.Telefon,
           P.AdresaEmail,
           P.ValoareAmanunt,
           P.ValoareCompensare,
           P.ValoareDiscount,
           P.NumarCard,
           P.ValoareDiscountCard,
           P.ValoareDiscountSpecial,
           P.ValoareDiscountSuplimentar,
           P.ValoareTaxaTransport,
           P.ValoarePlata
    FROM Precomanda P
             JOIN PrecomandaXDocument PXD
                  ON P.IdPrecomanda = PXD.IdPrecomanda AND P.IdLocatie = PXD.IdLocatie
             JOIN Document D ON PXD.IdDocument = D.IdDocument AND PXD.IdLocatie = D.IdLocatie
    WHERE D.EsteAnulat = 0
      AND D.DataDocument BETWEEN @DeLaData AND @PanaLaData;
END;

-- LiniePrecomanda
BEGIN
    DECLARE
        @DeLaData DATE = '1 Feb 2020 00:00:00',
        @PanaLaData DATE = '29 Feb 2020 23:59:59';

    SELECT CHECKSUM(DD.IdLocatie, DD.IdDocument) AS DocumentKey,
           DD.IdLocatie,
           DD.IdDocument,
           DD.IdDocumentDetaliu,
           DD.IdFurnizor,
           DD.IdArticol,
           DD.CantI,
           DD.CantF,
           DD.CantNrUT,
           DD.Lot,
           DD.PretUnitar,
           DD.ProcAdaos,
           DD.PretAmanunt,
           DD.ProcTVA
    FROM Precomanda P
             JOIN PrecomandaXDocument PXD
                  ON P.IdPrecomanda = PXD.IdPrecomanda AND P.IdLocatie = PXD.IdLocatie
             JOIN Document D ON PXD.IdDocument = D.IdDocument AND PXD.IdLocatie = D.IdLocatie
             JOIN DocumentDetaliu DD ON D.IdLocatie = DD.IdLocatie AND D.IdDocument = DD.IdDocument
    WHERE D.EsteAnulat = 0
      AND D.DataDocument BETWEEN @DeLaData AND @PanaLaData;
END

SELECT *
FROM DocumentDetaliu

-- -- Documente neanulate
-- SELECT IdLocatie,
--        IdDocument,
--        IdTipDocument,
--        SerieDocument,
--        NumarDocument,
--        DataDocument,
--        Descriere
-- FROM Document
-- WHERE EsteAnulat = 0;

-- SursaPrecomanda
SELECT IdDictionarDetaliu AS IdSursaPrecomanda,
       Nume               AS NumeSursaPrecomanda,
       Cod                AS CodSursaPrecomanda
FROM DictionarDetaliu
WHERE IdDictionar = 92

-- TipPrecomanda
SELECT IdDictionarDetaliu AS IdTipPrecomanda,
       Nume               AS NumeTipPrecomanda,
       Cod                AS CodTipPrecomanda
FROM DictionarDetaliu
WHERE IdDictionar = 93

-- StarePrecomanda
SELECT IdDictionarDetaliu AS IdStarePrecomanda,
       Nume               AS NumeStarePrecomanda,
       Cod                AS CodStarePrecomanda
FROM DictionarDetaliu
WHERE IdDictionar = 94


SELECT *
FROM DictionarDetaliu
WHERE IdDictionarDetaliu = 18958 -- tip
SELECT *
FROM DictionarDetaliu
WHERE IdDictionar = 93 -- tipuri

SELECT *
FROM DictionarDetaliu
WHERE IdDictionarDetaliu = 17217 -- stare
SELECT *
FROM DictionarDetaliu
WHERE IdDictionar = 94 -- stari
