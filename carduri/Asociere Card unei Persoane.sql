-- Completeaza doar urmatoarele 2 variabile:
DECLARE @nrCard VARCHAR(100) = '1100000000082';
DECLARE @codUnicPersoanaSauCnp VARCHAR(13) = '';

-- Urmatoarele doua variabile sunt optionale,
-- dar implicit cardul este valid incepand de acum pana la infinit (teoretic):
DECLARE @dataInceputAsociere DATE = GETDATE(); -- fiind DATE, se face trunchiere la time.
DECLARE @dataSfarsitAsociere DATE = '9999-12-31';
DECLARE @cardulEsteDejaAsociat BIT;

SELECT @cardulEsteDejaAsociat =
       (SELECT TOP 1 1
        FROM CarduriXPersoana CXP
        WHERE CXP.NumarCard = @nrCard);

IF @cardulEsteDejaAsociat = 1
    BEGIN
        SELECT 'Cardul ' + @nrCard + ' este deja asociat unei persoane.';
    END
ELSE
    BEGIN
        DECLARE @idPersoanaPosesor INT;

        SELECT @idPersoanaPosesor = IdPersoana
        FROM Persoana
        WHERE CNP = @codUnicPersoanaSauCnp;

        IF @idPersoanaPosesor IS NOT NULL
            BEGIN
                DECLARE @idNouCarduriXPersoana INT;

                EXEC spNewTableId @TableName = 'CarduriXPersoana',
                     @NextId = @idNouCarduriXPersoana OUTPUT;

                IF @idNouCarduriXPersoana IS NOT NULL
                    BEGIN
                        INSERT INTO CarduriXPersoana (IdCarduriXPersoana,
                                                      NumarCard,
                                                      IdPersoana,
                                                      DataInceput, DataSfarsit)
                        VALUES (@idNouCarduriXPersoana,
                                @nrCard,
                                @idPersoanaPosesor,
                                @dataInceputAsociere, @dataSfarsitAsociere);

                        SELECT 'Asociere incheiata intre cardul ' + @nrCard +
                               ' si persoana cu cod/CNP ' +
                               @codUnicPersoanaSauCnp;
                    END
                ELSE
                    BEGIN
                        SELECT 'Nu s-a putut genera ID cheie primara pentru insert in tabela CarduriXPersoana.';
                    END
            END
        ELSE
            BEGIN
                SELECT 'Nu s-a gasit persoana cu cod unic sau CNP ' +
                       @codUnicPersoanaSauCnp;
            END
    END