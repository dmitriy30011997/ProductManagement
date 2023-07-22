CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    -- Your trigger logic here
    -- For example:
    IF EXISTS (
        SELECT ID_SKU, COUNT(*) AS SKUCount
        FROM dbo.Basket
        GROUP BY ID_SKU
        HAVING COUNT(*) >= 2
    )
    BEGIN
        UPDATE dbo.Basket
        SET DiscountValue = Value * 0.05
        WHERE ID_SKU IN (
            SELECT ID_SKU
            FROM dbo.Basket
            GROUP BY ID_SKU
            HAVING COUNT(*) >= 2
        );
    END
    ELSE
    BEGIN
        UPDATE dbo.Basket
        SET DiscountValue = 0
        WHERE ID_SKU IN (
            SELECT ID_SKU
            FROM dbo.Basket
            GROUP BY ID_SKU
            HAVING COUNT(*) = 1
        );
    END
END;