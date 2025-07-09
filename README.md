 # 🏥 Hospital Readmission Risk Analysis

Analysed 100,000+ patient records from the UCI Hospital Readmission dataset using **MySQL** to uncover risk patterns in early hospital readmissions. The project aims to identify high-risk groups, optimize treatment plans, and reduce hospital inefficiencies: through SQL queries.

---

## Objectives

- Identify departments and diagnoses with high readmission rates
- Analyze age groups and medication counts linked to readmission risk
- Provide data-driven insights to improve patient care and reduce costs
- Showcase advanced SQL querying with real healthcare data

---

## Tech Stack

| Tool              | Purpose                          |
|-------------------|----------------------------------|
| MySQL             | SQL querying and analysis        |
| MySQL Workbench   | IDE for running and testing SQL  |
| CSV Dataset       | `diabetic_data.csv`, `IDs_mapping.csv` from UCI/Kaggle |

---

## Business Questions Answered

- Which hospital departments have the highest readmission rates?
- Which age groups are most vulnerable to early readmission?
- What diagnoses are linked with long hospital stays?
- How does insulin treatment impact readmission?
- Do patients on more medications face higher readmission risks?

---

## Queries


```sql


 Top 10 Departments by 30-Day Readmission Rate


SELECT 
  medical_specialty,
  COUNT(*) AS total_cases,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_cases,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate_pct
FROM patients
WHERE medical_specialty IS NOT NULL
GROUP BY medical_specialty
ORDER BY readmission_rate_pct DESC
LIMIT 10;


 Age Group vs Readmission Risk


SELECT 
  age,
  COUNT(*) AS total_patients,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS risk_pct
FROM patients
GROUP BY age
ORDER BY risk_pct DESC;


 Longest Average Stay by Diagnosis


SELECT 
  diag_1 AS diagnosis_code,
  ROUND(AVG(time_in_hospital), 2) AS avg_days,
  COUNT(*) AS patient_count
FROM patients
GROUP BY diag_1
HAVING patient_count > 50
ORDER BY avg_days DESC
LIMIT 10;


  Insulin Usage vs Readmission Risk


SELECT 
  insulin,
  COUNT(*) AS total_patients,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate
FROM patients
GROUP BY insulin
ORDER BY readmission_rate DESC;


 Number of Medications vs Readmission Risk


SELECT 
  num_medications,
  COUNT(*) AS total_cases,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmit_rate
FROM patients
GROUP BY num_medications
HAVING total_cases > 50
ORDER BY readmit_rate DESC
LIMIT 10;


 Patients with Frequent Readmissions


 SELECT 
  patient_nbr,
  COUNT(*) AS visit_count,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS short_term_readmits
FROM patients
GROUP BY patient_nbr
HAVING short_term_readmits >= 2
ORDER BY short_term_readmits DESC
LIMIT 10;


 Lab Procedure Count vs Readmission Risk


SELECT 
  num_lab_procedures,
  COUNT(*) AS patient_count,
  ROUND(AVG(time_in_hospital), 2) AS avg_stay,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmit_rate
FROM patients
GROUP BY num_lab_procedures
HAVING patient_count > 50
ORDER BY readmit_rate DESC
LIMIT 10;


 Discharge Disposition Impact


SELECT 
  discharge_disposition_id,
  COUNT(*) AS total,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmits,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmit_rate
FROM patients
GROUP BY discharge_disposition_id
ORDER BY readmit_rate DESC
LIMIT 10;


 Diabetes Type vs Readmission


SELECT 
  diag_1,
  COUNT(*) AS total_cases,
  ROUND(AVG(time_in_hospital), 2) AS avg_stay,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate
FROM patients
WHERE diag_1 LIKE '250%'
GROUP BY diag_1
ORDER BY readmission_rate DESC
LIMIT 5;


