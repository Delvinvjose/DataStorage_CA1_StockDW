--creating the data baese
CREATE DATABASE StockDW;
GO
USE StockDW;

--creating the dimension tables
--company dimension
CREATE TABLE DimCompany (
    CompanyKey INT PRIMARY KEY IDENTITY(1,1),
    CompanyName VARCHAR(50),
    Ticker VARCHAR(10),
    Sector VARCHAR(50),
    Country VARCHAR(50)
);

--date dimension
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY, -- Format: YYYYMMDD
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName VARCHAR(20),
    Day INT,
    DayOfWeek VARCHAR(20)
);

--market dimension
CREATE TABLE DimMarket (
    MarketKey INT PRIMARY KEY IDENTITY(1,1),
    MarketName VARCHAR(50),
    Region VARCHAR(50)
);

--price type dimension
CREATE TABLE DimPriceType (
    PriceTypeKey INT PRIMARY KEY IDENTITY(1,1),
    PriceType VARCHAR(50)
);

--currency dimenstion
CREATE TABLE DimCurrency (
    CurrencyKey INT PRIMARY KEY IDENTITY(1,1),
    CurrencyCode VARCHAR(10),
    CurrencyName VARCHAR(50)
);


--fact table
CREATE TABLE FactStockPrices (
    FactID INT PRIMARY KEY IDENTITY(1,1),
    DateKey INT FOREIGN KEY REFERENCES DimDate(DateKey),
    CompanyKey INT FOREIGN KEY REFERENCES DimCompany(CompanyKey),
    MarketKey INT FOREIGN KEY REFERENCES DimMarket(MarketKey),
    PriceTypeKey INT FOREIGN KEY REFERENCES DimPriceType(PriceTypeKey),
    CurrencyKey INT FOREIGN KEY REFERENCES DimCurrency(CurrencyKey),
    OpenPrice FLOAT,
    ClosePrice FLOAT,
    HighPrice FLOAT,
    LowPrice FLOAT,
    Volume BIGINT
);

--inserting data into company dimension
INSERT INTO DimCompany (CompanyName, Ticker, Sector, Country)
VALUES 
('Microsoft', 'MSFT', 'Technology', 'USA'),
('Meta', 'META', 'Technology', 'USA'),
('Tesla', 'TSLA', 'Automotive/Technology', 'USA');

--inserting data into market
INSERT INTO DimMarket (MarketName, Region)
VALUES 
('NASDAQ', 'USA');

--inserting data into currency
INSERT INTO DimCurrency (CurrencyCode, CurrencyName)
VALUES 
('USD', 'US Dollar');

--inserting data into price
INSERT INTO DimPriceType (PriceType)
VALUES 
    ('Open Price'),
    ('Close Price'),
    ('High Price'),
    ('Low Price');


--to populate date 
DECLARE @date DATE = '2010-01-01';
WHILE @date <= '2030-12-31'
BEGIN
    INSERT INTO DimDate (DateKey, FullDate, Year, Quarter, Month, MonthName, Day, DayOfWeek)
    VALUES (
        CONVERT(INT, FORMAT(@date, 'yyyyMMdd')),
        @date,
        YEAR(@date),
        DATEPART(QUARTER, @date),
        MONTH(@date),
        DATENAME(MONTH, @date),
        DAY(@date),
        DATENAME(WEEKDAY, @date)
    );
    SET @date = DATEADD(DAY, 1, @date);
END;

--linking fact and dim tables
ALTER TABLE FactStockPrices
ADD CONSTRAINT FK_Fact_Date FOREIGN KEY (DateKey)
REFERENCES DimDate(DateKey);

ALTER TABLE FactStockPrices
ADD CONSTRAINT FK_Fact_Company FOREIGN KEY (CompanyKey)
REFERENCES DimCompany(CompanyKey);

ALTER TABLE FactStockPrices
ADD CONSTRAINT FK_Fact_Market FOREIGN KEY (MarketKey)
REFERENCES DimMarket(MarketKey);

ALTER TABLE FactStockPrices
ADD CONSTRAINT FK_Fact_Currency FOREIGN KEY (CurrencyKey)
REFERENCES DimCurrency(CurrencyKey);


--to check the data is updated correctly
SELECT TOP 5 * FROM DimCompany;
SELECT TOP 5 * FROM DimMarket;
SELECT TOP 5 * FROM DimCurrency;
SELECT TOP 5 * FROM DimPriceType;
SELECT TOP 5 * FROM DimDate;

--to check data from connection
SELECT TOP 10 * FROM FactStockPrices;
SELECT * FROM DimCompany;
SELECT * FROM DimDate;
