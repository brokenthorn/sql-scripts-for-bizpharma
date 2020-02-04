DECLARE @serie_sursa VARCHAR(255) = 'Black 50 temporare';
DECLARE @serie_destinatie VARCHAR(255) = 'Mini-Farm Fidelizare';

CREATE TABLE #card_de_mutat
(
    nume_serie VARCHAR(255) NOT NULL,
    numar_card VARCHAR(100) NOT NULL,
    PRIMARY KEY (nume_serie, numar_card)
);


INSERT #card_de_mutat (nume_serie, numar_card)
SELECT NumeSerie, NumarCard
FROM Carduri
WHERE NumeSerie = @serie_sursa;

DECLARE c CURSOR FOR SELECT nume_serie, numar_card
                     FROM #card_de_mutat;

DECLARE @serie VARCHAR(255);
DECLARE @card VARCHAR(100);
DECLARE @cod_rezultat INT;
DECLARE @msg_rezultat VARCHAR(255);

OPEN c;
FETCH NEXT FROM c INTO @serie, @card;

WHILE @@fetch_status = 0
    BEGIN
        EXEC spSchimbaSerieCard @serie, @serie_destinatie,
             @card, 1, @cod_rezultat OUT, @msg_rezultat OUT;

        DECLARE @msg VARCHAR(MAX) = CAST(@cod_rezultat AS VARCHAR(50)) + ': ' + @msg_rezultat;

        RAISERROR (@msg, 0, 1) WITH NOWAIT;

        FETCH NEXT FROM c INTO @serie, @card;
    END

CLOSE c;
DEALLOCATE c;
