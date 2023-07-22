CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        THROW 50000, 'Family does not exist.', 1;
        RETURN;
    END

    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName))
    WHERE SurName = @FamilySurName;
END;