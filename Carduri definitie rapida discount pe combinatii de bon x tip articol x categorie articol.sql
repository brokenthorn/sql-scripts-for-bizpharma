-- Script de setare automata configuratii Card pe varianta CarduriXBonDefinitieXCategorieArticolXTipArticol

-- Previzualizare definitie la nivel de bon definitie x categorie articol x tip articol:
-- SELECT *
-- FROM CarduriXBonDefinitieXCategorieArticolXTipArticol
-- WHERE NumeSerie = 'Regina Maria';

DECLARE @numeSerie VARCHAR(50) = 'Regina Maria';
DECLARE @procDisc DECIMAL(6, 3) = 18.0;
DECLARE @seExcludBonurileDecontateUM BIT = 1;

-- restul filtrelor sunt de tip tabel si se compun dupa cum urmeaza:

-- filtru: bon definitie (sau tip bon):
DECLARE @bonDefinitii TABLE
                      (
                          IdBonDefinitie INT NOT NULL PRIMARY KEY,
                          procesat       BIT NOT NULL DEFAULT 0
                      );

INSERT INTO @bonDefinitii (IdBonDefinitie)
SELECT IdBonDefinitie
FROM BonDefinitie
WHERE Nume NOT LIKE 'Normal';

-- filtru: categoria de articol:
DECLARE @categorii TABLE
                   (
                       IdCategorie INT NOT NULL PRIMARY KEY,
                       procesat    BIT NOT NULL DEFAULT 0
                   );

INSERT INTO @categorii (IdCategorie)
SELECT IdDictionarDetaliu
FROM DictionarDetaliu
WHERE IdDictionar = 7
  AND EsteActiv = 1
  AND Nume LIKE 'Rx';

-- filtru: tipuri de articol:
DECLARE @tipuriArticol TABLE
                       (
                           IdTipArticol INT NOT NULL PRIMARY KEY,
                           procesat     BIT NOT NULL DEFAULT 0
                       );

-- setam la toate tipurile de articol utilizate actualmente
-- pentru categoriile de articol introduse mai sus in @categorii:
INSERT INTO @tipuriArticol (IdTipArticol)
SELECT DISTINCT IdTipArticol
FROM Articol
WHERE IdCategorie IN (SELECT IdCategorie FROM @categorii)
  AND AreStoc = 1;

-- running variables:
DECLARE @idCat INT;
DECLARE @idTip INT;
DECLARE @idBonDef INT;

-- loop categorii
WHILE (SELECT COUNT(*)
       FROM @categorii
       WHERE procesat = 0) > 0
    BEGIN
        SELECT TOP 1 @idCat = IdCategorie FROM @categorii WHERE procesat = 0;

        -- loop tipuri articol:
        WHILE (SELECT COUNT(*)
               FROM @tipuriArticol
               WHERE procesat = 0) > 0
            BEGIN
                SELECT TOP 1 @idTip = IdTipArticol FROM @tipuriArticol WHERE procesat = 0;

                -- loop bon definitii:
                WHILE (SELECT COUNT(*)
                       FROM @bonDefinitii
                       WHERE procesat = 0) > 0
                    BEGIN
                        SELECT TOP 1 @idBonDef = IdBonDefinitie FROM @bonDefinitii WHERE procesat = 0;

                        INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticol (NumeSerie, IdBonDefinitie,
                                                                                      IdCategorie, IdTipArticol,
                                                                                      ProcDiscount,
                                                                                      SeExcludBonurileDecontateUM)
                        VALUES (@numeSerie, @idBonDef, @idCat, @idTip, @procDisc, @seExcludBonurileDecontateUM);

                        UPDATE @bonDefinitii SET procesat = 1 WHERE IdBonDefinitie = @idBonDef;
                    END

                -- s-au procesat toate definitiile de bon pentru aceasta runda din loop-ul tip articol,
                -- deci resetam bitul:
                UPDATE @bonDefinitii SET procesat = 0 WHERE procesat = 1;

                UPDATE @tipuriArticol SET procesat = 1 WHERE IdTipArticol = @idTip;
            END

        -- s-au procesat toate tipurile de articol pentru aceasta runda din loop-ul categorii articol,
        -- deci resetam bitul:
        UPDATE @tipuriArticol SET procesat = 0 WHERE procesat = 1;

        UPDATE @categorii SET procesat = 1 WHERE IdCategorie = @idCat;
    END