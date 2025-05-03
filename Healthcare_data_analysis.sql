
-- ========================================
-- Comprehensive Healthcare Data Analysis Project
-- Dataset Source: Kaggle
-- https://www.kaggle.com/datasets/prasad22/healthcare-dataset
-- ========================================

-- ========================================
-- Step 1: Table Creation
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
-- Step 2: Data Import
-- ========================================
-- Import the data using SQL Server Import Wizard or BULK INSERT if data is available as CSV.
-- Example (update file path accordingly):
-- BULK INSERT healthcare_data
-- FROM 'C:\path\to\healthcare-dataset.csv'
-- WITH (
--     FIRSTROW = 2,
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n',
--     TEXTQUALIFIER = '"',
--     TABLOCK,
--     CODEPAGE = '65001'
-- );

-- ========================================
-- Step 3: Preprocessing
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

-- ========================================
-- Step 4: Exploratory & Business Analysis (20 Problems)
-- ========================================


-- ========================================
-- Comprehensive Healthcare Data Analysis Project
-- Dataset Source: Kaggle
-- https://www.kaggle.com/datasets/prasad22/healthcare-dataset
-- ========================================

-- 1. Total number of patients
SELECT COUNT(*) AS total_patients
FROM healthcare_data;

-- 2. Age statistics
SELECT 
    AVG(CAST(Age AS FLOAT)) AS avg_age,
    MAX(Age) AS max_age,
    MIN(Age) AS min_age
FROM healthcare_data;

-- 3. Age group distribution
SELECT 
    CASE 
        WHEN Age < 18 THEN 'Child'
        WHEN Age BETWEEN 18 AND 45 THEN 'Adult'
        WHEN Age BETWEEN 46 AND 65 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS Age_Group,
    COUNT(*) AS Group_Count
FROM healthcare_data
GROUP BY 
    CASE 
        WHEN Age < 18 THEN 'Child'
        WHEN Age BETWEEN 18 AND 45 THEN 'Adult'
        WHEN Age BETWEEN 46 AND 65 THEN 'Middle Aged'
        ELSE 'Senior'
    END;

-- 4. Gender distribution
SELECT Gender, COUNT(*) AS patient_count
FROM healthcare_data
GROUP BY Gender;

-- 5. Most common medical conditions
SELECT [Medical Condition], COUNT(*) AS frequency
FROM healthcare_data
GROUP BY [Medical Condition]
ORDER BY frequency DESC;

-- 6. Medication usage for top conditions
SELECT [Medical Condition], Medication, COUNT(*) AS count
FROM healthcare_data
GROUP BY [Medical Condition], Medication
ORDER BY count DESC;

-- 7. Most visited hospitals
SELECT Hospital, COUNT(*) AS visit_count
FROM healthcare_data
GROUP BY Hospital
ORDER BY visit_count DESC;

-- 8. Doctors with most patients
SELECT Doctor, COUNT(*) AS patient_count
FROM healthcare_data
GROUP BY Doctor
ORDER BY patient_count DESC;

-- 9. Most used insurance providers
SELECT [Insurance Provider], COUNT(*) AS patient_count
FROM healthcare_data
GROUP BY [Insurance Provider]
ORDER BY patient_count DESC;

-- 10. Total and average billing by condition
SELECT [Medical Condition], 
       COUNT(*) AS num_cases,
       SUM([Billing Amount]) AS total_billing,
       AVG([Billing Amount]) AS avg_billing
FROM healthcare_data
GROUP BY [Medical Condition]
ORDER BY total_billing DESC;

-- 11. Revenue generated per hospital
SELECT Hospital,
       SUM([Billing Amount]) AS revenue
FROM healthcare_data
GROUP BY Hospital
ORDER BY revenue DESC;

-- 12. Average length of hospital stay
SELECT 
    AVG(DATEDIFF(DAY, [Date of Admission], [Discharge Date])) AS avg_stay_days
FROM healthcare_data
WHERE [Discharge Date] IS NOT NULL;

-- 13. Admission type distribution
SELECT [Admission Type], COUNT(*) AS count
FROM healthcare_data
GROUP BY [Admission Type];

-- 14. Test result analysis by condition
SELECT [Medical Condition], [Test Results], COUNT(*) AS count
FROM healthcare_data
GROUP BY [Medical Condition], [Test Results]
ORDER BY count DESC;

-- 15. Year-over-year patient admissions
SELECT YEAR([Date of Admission]) AS Year, COUNT(*) AS admissions
FROM healthcare_data
GROUP BY YEAR([Date of Admission])
ORDER BY Year;

-- 16. Highest billing insurance providers
SELECT [Insurance Provider],
       SUM([Billing Amount]) AS total_billed
FROM healthcare_data
GROUP BY [Insurance Provider]
ORDER BY total_billed DESC;

-- 17. Count of high-risk patients (example criteria)
SELECT COUNT(*) AS high_risk_patients
FROM healthcare_data
WHERE [Medical Condition] IN ('Cancer', 'Heart Disease')
  AND [Test Results] = 'Abnormal';

-- 18. Blood type distribution
SELECT [Blood Type], COUNT(*) AS count
FROM healthcare_data
GROUP BY [Blood Type]
ORDER BY count DESC;

-- 19. Blood donation matcher procedure
-- Donor and recipient matching logic
CREATE OR ALTER PROCEDURE Blood_Matcher
    @DonorAge INT,
    @DonorBloodType VARCHAR(10),
    @Hospital NVARCHAR(100)
AS
BEGIN
    SELECT Name, Age, [Blood Type], Hospital
    FROM healthcare_data
    WHERE [Blood Type] = @DonorBloodType
      AND Age BETWEEN @DonorAge - 10 AND @DonorAge + 10
      AND Hospital = @Hospital;
END;

-- 20. Abnormal or inconclusive test result percentages
SELECT [Test Results], COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM healthcare_data
GROUP BY [Test Results];
