Use BizPharma;

SELECT *
FROM CasaMarcatXPrintServer;

SELECT *
FROM CasaMarcatStatieXPrintServer;

SELECT *
FROM ImprimantaXPrintServer;

SELECT *
FROM ImprimantaStatieXPrintServer;

-- 1. Check previous values with above SELECTs
-- 2. Run below transaction but don't COMMIT
-- 3. Check new values with above SELECTSs.
--    Make sure only the rows that should have changed, changed.
-- 4. COMMIT or ROLLBACK depending on results.

BEGIN TRANSACTION
    DECLARE
        @DenumireVechePrintServer VARCHAR(50) = 'DESKTOP-C702QEG',
        @DenumireNouaPrintServer  VARCHAR(50) = 'ISACCEI-4';

    UPDATE CasaMarcatXPrintServer
    SET PrintServer = @DenumireNouaPrintServer
    WHERE PrintServer = @DenumireVechePrintServer;

    UPDATE CasaMarcatStatieXPrintServer
    SET Statie = @DenumireNouaPrintServer
    WHERE Statie = @DenumireVechePrintServer;

    UPDATE ImprimantaXPrintServer
    SET PrintServer = @DenumireNouaPrintServer
    WHERE PrintServer = @DenumireVechePrintServer;

    UPDATE ImprimantaStatieXPrintServer
    SET Statie = @DenumireNouaPrintServer
    WHERE Statie = @DenumireVechePrintServer;

-- ROLLBACK

-- COMMIT