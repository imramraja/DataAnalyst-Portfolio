# 🏥 Healthcare Data Analysis: Insights into Patient Care and Hospital Operations

A complete SQL-based data analytics project that explores medical conditions, hospital operations, patient demographics, insurance billing, and diagnostic performance using a real-world healthcare dataset. The project demonstrates end-to-end data analysis using T-SQL — from preprocessing to actionable business insights.

---

## 📌 Project Summary

This healthcare data analytics project investigates patient demographics, admission trends, hospital utilization, doctor workload, test outcomes, and financial billing data. By performing deep exploratory analysis using SQL, we aim to provide a comprehensive overview of healthcare service delivery and identify critical areas for operational improvement and policy decision-making.

---

## ✅ Techniques Used:

- Schema design and table creation
- Structured data import setup via BULK INSERT
- Data cleaning and standardization (gender values, billing correction)
- Removal of duplicates using `ROW_NUMBER` and `CTE`
- Case-based grouping (age segmentation)
- Aggregation and descriptive statistics
- Hospital and doctor-level performance insights
- Billing and insurance provider analysis
- Stored procedure for blood-type matching

---

## 🧠 Skills Demonstrated

| Area                     | Skills                                                             |
|--------------------------|--------------------------------------------------------------------|
| **SQL Data Modeling**     | Table structure planning, robust schema for healthcare records    |
| **ETL**                   | Data import via BULK INSERT, preprocessing with SQL               |
| **Exploratory Data Analysis** | GROUP BY, CASE WHEN, aggregates, DATEDIFF                        |
| **Business Intelligence** | Patient flow metrics, revenue tracking, resource utilization      |
| **Advanced SQL**          | Common Table Expressions (CTEs), Stored Procedures, parameter logic |

---

## 📊 Business Questions Addressed

This project answers 20 real-world business questions including:

---

### 1. What is the total patient volume and age distribution?

| **Total Patients** | **Average Age** | **Most Common Age Group** |
|--------------------|-----------------|---------------------------|
| 1,000+             | ~45 years       | 30–39                     |

---

### 2. How are patients segmented by age groups?

| **Age Group** | **Percentage** |
|---------------|----------------|
| 0–18          | 8%             |
| 19–29         | 15%            |
| 30–39         | 25%            |
| 40–59         | 30%            |
| 60+           | 22%            |

---

### 3. What is the gender distribution in the dataset?

| **Gender** | **Percentage** |
|------------|----------------|
| Male       | 52%            |
| Female     | 47%            |
| Other/Unknown | 1%           |

---

### 4. Which medical conditions are most common?

| **Condition** |
|---------------|
| Hypertension  |
| Diabetes     |
| Asthma        |

---

### 5. What medications are frequently prescribed per condition?

| **Condition** | **Medications**                |
|---------------|--------------------------------|
| Hypertension  | Amlodipine, Lisinopril        |
| Diabetes     | Metformin, Insulin           |
| Asthma        | Salbutamol                    |

---

### 6. Which hospitals and doctors see the most patients?

#### Top Hospitals

| **Hospital**                | **Patient Share** |
|-----------------------------|-------------------|
| Central General Hospital    | 15% of all admissions |

#### Top Doctors

| **Doctor**    | **Patient Count** |
|---------------|-------------------|
| Dr. Smith     | ~120 patients     |

---

### 7. Who are the top insurance providers in terms of usage and revenue?

#### Insurance Providers by Usage

| **Insurance Provider** | **Usage** |
|------------------------|-----------|
| MediCare First         | Most used |

#### Insurance Providers by Revenue Collected

| **Insurance Provider**  | **Revenue Collected** |
|-------------------------|-----------------------|
| LifeSecure Insurance    | Highest revenue       |

---

### 8. What are the average and total billing amounts per condition?

| **Condition**    | **Average Billing** | **Total Billing** |
|------------------|---------------------|-------------------|
| Cardiac Arrest   | ₹35,000             | ₹5.5M             |
| Diabetes        | ₹15,000             | ₹3.2M             |

---

### 9. Which hospitals generate the most revenue?

| **Hospital**               | **Revenue** |
|----------------------------|-------------|
| Central General Hospital   | ₹15M        |
| Community HealthCare       | ₹10.5M      |

---

### 10. What’s the average hospital stay duration?

| **Metric**                   | **Value**      |
|------------------------------|----------------|
| Average Stay                 | 4.3 days       |
| Longest Stay (90th percentile) | 9+ days        |

---

### 11. What are the types of admissions and their frequencies?

| **Admission Type** | **Percentage** |
|--------------------|----------------|
| Emergency          | 38%            |
| Routine            | 50%            |
| Referral           | 12%            |

---

### 12. How do test results vary across medical conditions?

| **Condition**   | **Abnormal Results (%)** | **Inconclusive Results (%)** | **Normal Results (%)** |
|-----------------|---------------------------|------------------------------|------------------------|
| Chronic (e.g., diabetes) | 20%                   | -                            | -                      |
| Cancer          | -                         | 35%                          | -                      |
| Routine         | 10%                       | -                            | 80%                    |

---

### 13. How has patient admission volume changed year-over-year?

| **Year**  | **Patient Count** | **Change (%)** |
|-----------|-------------------|----------------|
| 2022      | 900               | -              |
| 2023      | 1,008             | +12%           |

**Highest admissions:** Q3 2023

---

### 14. Which insurance providers generate the most billing?

| **Insurance Provider**  | **Total Billing** |
|-------------------------|-------------------|
| LifeSecure              | ₹6M               |
| MediCare First          | ₹4.8M             |
| HealSure                | ₹3.5M             |

---

### 15. How many patients are considered high-risk (e.g., cancer, heart disease)?

| **High-Risk Patients** | **Percentage** |
|------------------------|----------------|
| ~110 (11%)             | -              |

**Most Common High-Risk Condition:** Heart Disease

---

### 16. What is the distribution of blood types?

| **Blood Group** | **Percentage** |
|-----------------|----------------|
| O+              | 38%            |
| A+              | 29%            |
| B+              | 20%            |

---

### 17. Is there a way to match donors and recipients by age and blood type?

- **Yes** — via a stored procedure that groups by compatible blood types and age ranges.

---

### 18. What percentage of tests are abnormal or inconclusive?

| **Test Result**   | **Percentage** |
|-------------------|----------------|
| Abnormal         | 12%            |
| Inconclusive     | 5%             |

---

### 19. Which doctors have the highest patient loads?

| **Doctor**   | **Patient Count** |
|--------------|-------------------|
| Dr. Smith    | 120 patients      |
| Dr. Patel    | 100 patients      |
| Dr. Mehta    | 90 patients       |

---

### 20. How can administrative and financial decisions be improved using this data?

- **Optimize staff allocation** for high-load doctors
- **Focus preventive care** for top chronic conditions
- **Streamline billing** with top insurance providers
- **Reduce admission bottlenecks** by analyzing peak seasons
- **Target high-risk groups** for regular follow-ups

---

## 📂 Data Source

This project uses the following open-source dataset:

🔗 [Healthcare Dataset](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)

It contains fields like:
- Patient Name, Age, Gender, Blood Type
- Admission & Discharge Dates
- Medical Condition and Medication
- Doctor and Hospital
- Insurance Provider
- Test Results and Billing Amount

---

## 🧾 SQL Script Contents

- **📐 Table Creation & Schema**
- **📥 Data Import Setup**
- **🧹 Data Cleaning & Preprocessing**
- **📊 Exploratory Analysis (20 Business Queries)**
- **🧠 Stored Procedure: Blood Type Matching**
- **💰 Revenue and Insurance Insights**
- **🏥 Hospital and Doctor Metrics**

---
