IF OBJECT_ID('tempdb..#ConfiguratieCarduri') IS NOT NULL DROP TABLE #ConfiguratieCarduri;

CREATE TABLE #ConfiguratieCarduri
(
    NumeSerie             VARCHAR(100) NOT NULL,
    ProcentDiscount       INT            DEFAULT NULL,
    TipBon                VARCHAR(100)   DEFAULT NULL,
    TipReteta             VARCHAR(100)   DEFAULT NULL,
    TipArticol            VARCHAR(100)   DEFAULT NULL,
    CategorieArticol      VARCHAR(100)   DEFAULT NULL,
    Locatie               VARCHAR(100)   DEFAULT NULL,
    GrupaLocatie          VARCHAR(100)   DEFAULT NULL,
    Orar                  VARCHAR(100)   DEFAULT NULL,
    PuncteValoareVanzare  MONEY          DEFAULT NULL,
    PuncteValoareAchitare MONEY          DEFAULT NULL,
    PuncteProcentVanzare  DECIMAL(20, 6) DEFAULT NULL,
    CONSTRAINT UQ_ROWS_ConfiguratieCarduri UNIQUE NONCLUSTERED (
                                                                NumeSerie,
                                                                ProcentDiscount,
                                                                TipBon,
                                                                TipReteta,
                                                                TipArticol,
                                                                CategorieArticol,
                                                                Locatie,
                                                                GrupaLocatie,
                                                                Orar,
                                                                PuncteValoareVanzare,
                                                                PuncteValoareAchitare,
                                                                PuncteProcentVanzare
        )
);


INSERT INTO #ConfiguratieCarduri (NumeSerie,
                                  ProcentDiscount,
                                  TipBon,
                                  TipReteta,
                                  TipArticol,
                                  CategorieArticol,
                                  Locatie,
                                  GrupaLocatie,
                                  Orar,
                                  PuncteValoareVanzare,
                                  PuncteValoareAchitare,
                                  PuncteProcentVanzare)
SELECT DISTINCT Conf.NumeSerie,
                Conf.ProcDiscount,
                IIF(TipBon.Nume LIKE 'Normal', 'Bon la liber', 'Reteta'),
                IIF(TipBon.Nume NOT LIKE 'Normal', TipBon.Nume, NULL),
                TipArticol.Nume,
                Categorie.Nume,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
FROM CarduriXBonDefinitieXCategorieArticolXTipArticol Conf
         LEFT JOIN BonDefinitie TipBon ON Conf.IdBonDefinitie = TipBon.IdBonDefinitie
         LEFT JOIN DictionarDetaliu Categorie ON Conf.IdCategorie = Categorie.IdDictionarDetaliu
         LEFT JOIN DictionarDetaliu TipArticol ON Conf.IdTipArticol = TipArticol.IdDictionarDetaliu;


INSERT INTO #ConfiguratieCarduri (NumeSerie,
                                  ProcentDiscount,
                                  TipBon,
                                  TipReteta,
                                  TipArticol,
                                  CategorieArticol,
                                  Locatie,
                                  GrupaLocatie,
                                  Orar,
                                  PuncteValoareVanzare,
                                  PuncteValoareAchitare,
                                  PuncteProcentVanzare)
SELECT DISTINCT Conf.NumeSerie,
                Conf.ProcDiscount,
                IIF(TipBon.Nume LIKE 'Normal', 'Bon la liber', 'Reteta'),
                IIF(TipBon.Nume NOT LIKE 'Normal', TipBon.Nume, NULL),
                TipArticol.Nume,
                Categorie.Nume,
                L.Nume,
                GL.Nume,
                O.Nume + ' (IdOrar=' + CAST(O.IdOrar AS VARCHAR(10)) + ')',
                NULL,
                NULL,
                NULL
FROM CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar Conf
         LEFT JOIN BonDefinitie TipBon ON Conf.IdBonDefinitie = TipBon.IdBonDefinitie
         LEFT JOIN DictionarDetaliu Categorie ON Conf.IdCategorie = Categorie.IdDictionarDetaliu
         LEFT JOIN DictionarDetaliu TipArticol ON Conf.IdTipArticol = TipArticol.IdDictionarDetaliu
         LEFT JOIN Locatie L ON Conf.IdLocatie = L.IdLocatie
         LEFT JOIN GrupaLocatie GL ON Conf.IdGrupaLocatie = GL.IdGrupaLocatie
         LEFT JOIN Orar O ON Conf.IdOrar = O.IdOrar;


INSERT INTO #ConfiguratieCarduri (NumeSerie,
                                  ProcentDiscount,
                                  TipBon,
                                  TipReteta,
                                  TipArticol,
                                  CategorieArticol,
                                  Locatie,
                                  GrupaLocatie,
                                  Orar,
                                  PuncteValoareVanzare,
                                  PuncteValoareAchitare,
                                  PuncteProcentVanzare)
SELECT DISTINCT Conf.NumeSerie,
                NULL,
                IIF(TipBon.Nume LIKE 'Normal', 'Bon la liber', 'Reteta'),
                IIF(TipBon.Nume NOT LIKE 'Normal', TipBon.Nume, NULL),
                TipArticol.Nume,
                Categorie.Nume,
                NULL,
                NULL,
                NULL,
                Conf.ValoareVanzare,
                Conf.ValoareAchitare,
                Conf.ProcentVanzare
FROM CarduriXValoarePuncteXBonDefinitieXCategorieArticolXTipArticol Conf
         LEFT JOIN BonDefinitie TipBon ON Conf.IdBonDefinitie = TipBon.IdBonDefinitie
         LEFT JOIN DictionarDetaliu Categorie ON Conf.IdCategorie = Categorie.IdDictionarDetaliu
         LEFT JOIN DictionarDetaliu TipArticol ON Conf.IdTipArticol = TipArticol.IdDictionarDetaliu;


INSERT INTO #ConfiguratieCarduri (NumeSerie,
                                  ProcentDiscount,
                                  TipBon,
                                  TipReteta,
                                  TipArticol,
                                  CategorieArticol,
                                  Locatie,
                                  GrupaLocatie,
                                  Orar,
                                  PuncteValoareVanzare,
                                  PuncteValoareAchitare,
                                  PuncteProcentVanzare)
SELECT DISTINCT Conf.NumeSerie,
                NULL,
                IIF(TipBon.Nume LIKE 'Normal', 'Bon la liber', 'Reteta'),
                IIF(TipBon.Nume NOT LIKE 'Normal', TipBon.Nume, NULL),
                TipArticol.Nume,
                Categorie.Nume,
                L.Nume,
                GL.Nume,
                O.Nume + ' (IdOrar=' + CAST(O.IdOrar AS VARCHAR(10)) + ')',
                Conf.ValoareVanzare,
                Conf.ValoareAchitare,
                Conf.ProcentVanzare
FROM CarduriXValoarePuncteXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar Conf
         LEFT JOIN BonDefinitie TipBon ON Conf.IdBonDefinitie = TipBon.IdBonDefinitie
         LEFT JOIN DictionarDetaliu Categorie ON Conf.IdCategorie = Categorie.IdDictionarDetaliu
         LEFT JOIN DictionarDetaliu TipArticol ON Conf.IdTipArticol = TipArticol.IdDictionarDetaliu
         LEFT JOIN Locatie L ON Conf.IdLocatie = L.IdLocatie
         LEFT JOIN GrupaLocatie GL ON Conf.IdGrupaLocatie = GL.IdGrupaLocatie
         LEFT JOIN Orar O ON Conf.IdOrar = O.IdOrar;

SELECT *
FROM #ConfiguratieCarduri
ORDER BY NumeSerie,
         ProcentDiscount,
         TipBon,
         TipReteta,
         TipArticol,
         CategorieArticol,
         Locatie,
         GrupaLocatie,
         Orar,
         PuncteValoareVanzare,
         PuncteValoareAchitare,
         PuncteProcentVanzare;