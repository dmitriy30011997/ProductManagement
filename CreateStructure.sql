-- 2.1 dbo.SKU
CREATE TABLE dbo.SKU (
    ID INT IDENTITY PRIMARY KEY,
    Code VARCHAR(50) UNIQUE,
    Name VARCHAR(100)
);

-- 2.2 dbo.Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY PRIMARY KEY,
    SurName VARCHAR(100),
    BudgetValue DECIMAL(18, 2)
);

-- 2.3 dbo.Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY PRIMARY KEY,
    ID_SKU INT,
    ID_Family INT,
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(18, 2) CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue DECIMAL(18, 2),
    FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU (ID),
    FOREIGN KEY (ID_Family) REFERENCES dbo.Family (ID)
);