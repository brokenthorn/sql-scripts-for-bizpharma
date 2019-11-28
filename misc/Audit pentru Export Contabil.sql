-- TODO: De adaugat si sume de numar de linii dar si antete.
-- TODO: Adauga total pe cota de TVA 5% pe achizitie si vanzare.

DECLARE
    @start DATETIME,
    @stop  DATETIME;

DECLARE
    @now DATETIME = getdate();

DECLARE
    @y INT = year(@now),
    @m INT = month(@now);

SET @start = datefromparts(@y, @m, 1);
SET @stop = datefromparts(@y, @m, day(eomonth(@now)));

DECLARE
    @idTipDocFacturaIn   INT,
    @idTipDocFacturaOut  INT,
    @idTipDocFactRet     INT,
    @idTipDocRetBonFisc  INT,
    @idTipLocatieFiliala INT;

SELECT @idTipLocatieFiliala = IdDictionar
FROM DictionarDetaliu
WHERE IdDictionar = 1
  AND Cod = 'F';

-- select * from Dictionar where Cod = 'TipDoc'; -- 2
-- select * from Dictionar where Cod = 'TipOper'; -- 10
-- select * from Dictionar where Cod = 'TipPV'; -- 58

SELECT @idTipDocFacturaOut = IdDictionarDetaliu
FROM DictionarDetaliu
WHERE IdDictionar = 2
  AND Cod = 'FacturaOut';

SELECT @idTipDocFacturaIn = IdDictionarDetaliu
FROM DictionarDetaliu
WHERE IdDictionar = 2
  AND Cod = 'FacturaIn';

SELECT @idTipDocFactRet = IdDictionarDetaliu
FROM DictionarDetaliu
WHERE IdDictionar = 2
  AND Cod = 'FactRet';

SELECT @idTipDocRetBonFisc = IdDictionarDetaliu
FROM DictionarDetaliu
WHERE IdDictionar = 2
  AND Cod = 'RetBonFisc';

--     DROP TABLE IF EXISTS #loc;
--
--     CREATE TABLE #loc
--     (
--         id   INT         NOT NULL PRIMARY KEY,
--         nume VARCHAR(50) NOT NULL
--     );
--
--     INSERT INTO #loc (id, nume)
--     SELECT IdLocatie, Nume
--     FROM Locatie
--     WHERE EsteActiv = 1
--       AND IdTipLocatie = @idTipLocatieFiliala;

DROP TABLE IF EXISTS #facturaOut;

CREATE TABLE #facturaOut
(
    idLocatie     INT         NOT NULL,
    numeLocatie   VARCHAR(50) NOT NULL,
    idDocument    INT         NOT NULL,
    serieNumarDoc VARCHAR(60),
    dataDoc       DATETIME    NOT NULL,
    totalAch0     MONEY       NOT NULL DEFAULT 0.00,
    totalAch9     MONEY       NOT NULL DEFAULT 0.00,
    totalAch19    MONEY       NOT NULL DEFAULT 0.00,
    totalAch24    MONEY       NOT NULL DEFAULT 0.00,
    totalVanz0    MONEY       NOT NULL DEFAULT 0.00,
    totalVanz9    MONEY       NOT NULL DEFAULT 0.00,
    totalVanz19   MONEY       NOT NULL DEFAULT 0.00,
    totalVanz24   MONEY       NOT NULL DEFAULT 0.00,
    PRIMARY KEY (idDocument, idLocatie)
);

-- inserez mai intai antetele documentelor:

INSERT INTO #facturaOut (idLocatie, numeLocatie, idDocument, serieNumarDoc, dataDoc)
SELECT D.IdLocatie,
       L.Nume,
       D.IdDocument,
       D.SerieDocument + '_' + D.NumarDocument,
       D.DataDocument
FROM Document D
         JOIN Locatie L ON D.IdLocatie = L.IdLocatie
WHERE D.DataDocument BETWEEN @start AND @stop
  AND D.IdTipDocument = @idTipDocFacturaOut
  AND D.EsteAnulat = 0;

--     SELECT *
--     FROM #facturaOutHO;

DECLARE
    @cursorFacturiIesire CURSOR,
    @idLocatie  INT,
    @idDocument INT;

SET @cursorFacturiIesire = CURSOR FAST_FORWARD FOR
    SELECT idLocatie, idDocument
    FROM #facturaOut;

OPEN @cursorFacturiIesire;
FETCH NEXT FROM @cursorFacturiIesire INTO @idLocatie, @idDocument;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE
        @totalAch0   MONEY = 0,
        @totalAch9   MONEY = 0,
        @totalAch19  MONEY = 0,
        @totalAch24  MONEY = 0,
        @totalVanz0  MONEY = 0,
        @totalVanz9  MONEY = 0,
        @totalVanz19 MONEY = 0,
        @totalVanz24 MONEY = 0;

    -- achizitie:

    SELECT @totalAch0 = SUM(DD.PretUnitar)
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 0;

    SELECT @totalAch9 = SUM(DD.PretUnitar)
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 9;

    SELECT @totalAch19 = SUM(DD.PretUnitar)
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 19;

    SELECT @totalAch24 = SUM(DD.PretUnitar)
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 24;

    -- vanzare:

    SELECT @totalVanz0 = SUM(DD.PretAmanunt * DD.CantI + (DD.PretAmanunt/DD.CantNrUT * DD.CantF))
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 0;

    SELECT @totalVanz9 = SUM(DD.PretAmanunt * DD.CantI + (DD.PretAmanunt/DD.CantNrUT * DD.CantF))
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 9;

    SELECT @totalVanz19 = SUM(DD.PretAmanunt * DD.CantI + (DD.PretAmanunt/DD.CantNrUT * DD.CantF))
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 19;

    SELECT @totalVanz24 = SUM(DD.PretAmanunt * DD.CantI + (DD.PretAmanunt/DD.CantNrUT * DD.CantF))
    FROM DocumentDetaliu DD
    WHERE DD.IdDocument = @idDocument
      AND DD.IdLocatie = @idLocatie
    and DD.ProcTVA = 24;

    FETCH NEXT FROM @cursorFacturiIesire INTO @idLocatie, @idDocument;
END

CLOSE @cursorFacturiIesire;
DEALLOCATE  @cursorFacturiIesire;