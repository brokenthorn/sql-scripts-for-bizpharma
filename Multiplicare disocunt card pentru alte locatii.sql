DECLARE
    @idLocatie INT = 72;
DECLARE
    @nextId INT;

-- select L.Nume, L.IdLocatie from Locatie L join Adresa A ON L.IdAdresa = A.IdAdresa
-- join Oras O on A.IdOras = O.IdOras
-- where O.Nume like '%tulcea%'

-- select * from Locatie where Nume like '%juri%';

-- select * from CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar

EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 2, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 3, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 4, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 5, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 6, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 7, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 8, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 9, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 10, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 11, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 12, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 13, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 14, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 19, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 20, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 21, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 22, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 27, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 28, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 29, 14995, 19129, NULL, @idLocatie,
        NULL, 5.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 2, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 3, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 4, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 5, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 6, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 7, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 8, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 9, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 10, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 11, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 11, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 12, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 13, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 14, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 19, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 20, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 21, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 22, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 27, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 28, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);
EXEC spNewTableId
     @TableName = 'CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar',
     @NextId = @nextId OUT
INSERT INTO CarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar(IdCarduriXBonDefinitieXCategorieArticolXTipArticolXLocatieXOrar,
                                                                          NumeSerie,
                                                                          IdBonDefinitie,
                                                                          IdCategorie,
                                                                          IdTipArticol,
                                                                          IdGrupaLocatie,
                                                                          IdLocatie,
                                                                          IdOrar,
                                                                          ProcDiscount,
                                                                          SeExcludBonurileDecontateUM)
VALUES (@nextId, 'Mini-Farm Fidelizare', 29, 14995, 19130, NULL, @idLocatie,
        NULL, 12.00, 1);