
-- ========================================
-- Healthcare Data Analysis Project
-- Dataset Source: Kaggle
-- https://www.kaggle.com/datasets/prasad22/healthcare-dataset
-- ========================================

-- ========================================
--  Table Creation
-- ========================================
CREATE TABLE healthcare_data (
    [Name] NVARCHAR(100),
    [Age] INT,
    [Gender] NVARCHAR(10),
    [Blood Type] NVARCHAR(5),
    [Medical Condition] NVARCHAR(100),
    [Date of Admission] DATE,
    [Doctor] NVARCHAR(100),
    [Hospital] NVARCHAR(100),
    [Insurance Provider] NVARCHAR(100),
    [Billing Amount] FLOAT,
    [Room Number] NVARCHAR(10),
    [Admission Type] NVARCHAR(50),
    [Discharge Date] DATE,
    [Medication] NVARCHAR(100),
    [Test Results] NVARCHAR(50)
);

-- ========================================
--  Data Import
-- ========================================
 Import the data using SQL Server Import Wizard or BULK INSERT if data is available as CSV.
 Example (update file path accordingly):
 BULK INSERT healthcare_data
 FROM 'C:\projects\healthcare\healthcare-dataset.csv'
 WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
     TEXTQUALIFIER = '"',
     TABLOCK,
     CODEPAGE = '65001'
 );

-- ========================================
--  Preprocessing
-- ========================================

-- Remove duplicate records
WITH CTE_Duplicates AS (
    SELECT *, ROW_NUMBER() OVER (
        PARTITION BY [Name], [Date of Admission], [Doctor]
        ORDER BY [Name]
    ) AS rn
    FROM healthcare_data
)
DELETE FROM CTE_Duplicates WHERE rn > 1;

-- Handle missing billing amounts (if applicable)
UPDATE healthcare_data
SET [Billing Amount] = 0
WHERE [Billing Amount] IS NULL;

-- Standardize gender values
UPDATE healthcare_data
SET Gender = CASE 
                WHEN Gender IN ('M', 'Male') THEN 'Male'
                WHEN Gender IN ('F', 'Female') THEN 'Female'
                ELSE 'Unknown'
            END;
