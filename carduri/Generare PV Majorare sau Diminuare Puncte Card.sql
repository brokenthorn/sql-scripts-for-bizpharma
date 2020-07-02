-- Completati cu atentie valorile variabilelor de mai jos inainte de a rula!

DECLARE @idTipOperatie INT = 15363; -- 15363 majorare, -- 14902 diminuare
DECLARE @sensOperatie INT = 1; -- 1 majorare, -1 diminuare
DECLARE @nrCard VARCHAR(100) = 1100000000389;
DECLARE @nrPuncte DECIMAL(7, 2) = 0; -- cate puncte in plus au in minus, fara semn aici
DECLARE @valPunct DECIMAL(7, 2) = 1;
DECLARE @descriere VARCHAR(255) = 'Majorare card numarul: ''' + @nrCard +
                                  ''' cu ' + cast(@nrPuncte AS VARCHAR(20)) +
                                  ' puncte.';

BEGIN TRAN
    DECLARE @idOperatieNoua INT;
    DECLARE @rezultatLogareOperatie INT;
    DECLARE @rezultatSalvarePv INT;

    EXEC spNewTableId 'Operatie', @idOperatieNoua OUTPUT;

    IF @idOperatieNoua = 0
        BEGIN
            GOTO DoRollback
        END;

    EXEC spLogOperatie @IdLocatie = 1,
         @IdOperatie = @idOperatieNoua,
         @IdUtilizator = 1,
         @NumeUtilizator = 'Administrator aplicatie',
         @Host = 'HO',
         @IdTipOperatie = @idTipOperatie,
         @IdElement = 0,
         @Descriere = @descriere,
         @Rezultat = @rezultatLogareOperatie OUTPUT;

    IF @rezultatLogareOperatie <> 0
        BEGIN
            GOTO DoRollback
        END

    EXEC spCardSalveazaPVDimPuncte @IdLocatie = 1,
         @IdOperatie = @idOperatieNoua,
         @NumarCard = @nrCard,
         @SensOperatie = @sensOperatie,
         @Observatie = @descriere,
         @NrPuncte = @nrPuncte,
         @ValoarePunct = @valPunct,
         @Activ = 1,
         @Rezultat = @rezultatSalvarePv OUTPUT;

    IF @rezultatSalvarePv <> 0
        BEGIN
            GOTO DoRollback
        END
COMMIT TRAN

DoRollback:
PRINT 'Unexpected error occurred!'
ROLLBACK