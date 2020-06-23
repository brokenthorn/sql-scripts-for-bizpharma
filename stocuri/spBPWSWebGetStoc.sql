ALTER PROCEDURE spBPWSWebGetStoc @DataUltimaActualizare VARCHAR(50),
    @DataCurenta VARCHAR(50),
    @MesajEroare VARCHAR(255) OUTPUT
    AS
    BEGIN
        DECLARE @DataSiOraCurenta DATETIME;
        SET @MesajEroare = '';

        IF 1 = 0 SET FMTONLY OFF;

        SET @DataSiOraCurenta = CAST(@DataCurenta AS DATETIME);

        DECLARE @IdLocatieMagazinOnline INT = 79;

        DECLARE @LocatiiExceptate TABLE
                                  (
                                      IdLocatie INT NOT NULL PRIMARY KEY NONCLUSTERED
                                  );

        INSERT INTO @LocatiiExceptate (IdLocatie)
        SELECT IdLocatie
        FROM Locatie
        WHERE Nume LIKE '%baia%'
           OR Nume LIKE '%jurilovca%'
           OR nume LIKE '%mamaia%';


        SELECT 'A'                                         AS Zona,
               S.IdArticol,
               S.CantNrBuc,

               (
                   SELECT COALESCE(MAX(derived1.PretAmOnline),
                                   MAX(derived1.PretAmFarmacii),
                                   MAX(derived1.PretAmStoc))
                   FROM (
                            SELECT MAX(AXPI1.PretAmanuntImpus) AS PretAmOnline,
                                   NULL                        AS PretAmFarmacii,
                                   NULL                        AS PretAmStoc
                            FROM ArticolXPretImpus AXPI1
                            WHERE AXPI1.IdArticol = S.IdArticol
                              AND @DataSiOraCurenta BETWEEN AXPI1.DataInceput AND ISNULL(AXPI1.DataSfarsit, '99991231')
                              AND AXPI1.EsteActiv = 1
                              AND AXPI1.IdLocatie = @IdLocatieMagazinOnline
                            UNION
                            SELECT NULL                        AS PretAmOnline,
                                   MAX(AXPI2.PretAmanuntImpus) AS PretAmFarmacii,
                                   NULL                        AS PretAmStoc
                            FROM ArticolXPretImpus AXPI2
                            WHERE AXPI2.IdArticol = S.IdArticol
                              AND @DataSiOraCurenta BETWEEN AXPI2.DataInceput AND ISNULL(AXPI2.DataSfarsit, '99991231')
                              AND AXPI2.EsteActiv = 1
                              AND AXPI2.IdLocatie <> @IdLocatieMagazinOnline
                              AND AXPI2.IdLocatie NOT IN
                                  (SELECT IdLocatie FROM @LocatiiExceptate)
                            UNION
                            SELECT NULL                AS PretAmOnline,
                                   NULL                AS PretAmFarmacii,
                                   MAX(S2.PretAmanunt) AS PretAmStoc
                            FROM Stoc S2
                            WHERE S2.IdArticol = S.IdArticol
                              AND S2.IdLocatie NOT IN
                                  (SELECT IdLocatie FROM @LocatiiExceptate)
                        ) derived1
               )                                           AS PretAmanunt,

               (
                   SELECT MAX(SPA.PretAchizitie)
                   FROM Stoc SPA
                   WHERE SPA.IdArticol = S.IdArticol
               )                                           AS PretAchizitie,
               S.IdLocatie,
               (SUM(S.CantI) * S.CantNrBuc) + SUM(S.CantF) AS CantitateUT,
               ISNULL(S.Lot, '')                           AS Lot,
               ISNULL(S.BBD, '20500101')                   AS BBD
        FROM Stoc S
                 JOIN Locatie L
                      ON S.IdLocatie = L.IdLocatie
                 JOIN LocatieDetaliu LD ON LD.IdLocatie = L.IdLocatie
        WHERE LD.TipUnitate = 1 -- fara depozite
          AND S.IdLocatie NOT IN (SELECT IdLocatie FROM @LocatiiExceptate)
        GROUP BY S.IdArticol, S.CantNrBuc, S.IdLocatie, S.Lot, S.BBD
        ORDER BY /* Z.Nume,*/ S.IdArticol, S.IdLocatie -- NU MODIFICA ORDINEA DEOARECE NU SE MAI GENEREAZA REZULTATUL CORECT DIN C#
        ;
    END
GO

