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

SELECT
  age,
  COUNT(*) AS total_patients,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS risk_pct
FROM patients
GROUP BY age
ORDER BY risk_pct DESC;

SELECT
  diag_1 AS diagnosis_code,
  ROUND(AVG(time_in_hospital), 2) AS avg_days,
  COUNT(*) AS patient_count
FROM patients
GROUP BY diag_1
HAVING patient_count > 50
ORDER BY avg_days DESC
LIMIT 10;

SELECT
  insulin,
  COUNT(*) AS total_patients,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate
FROM patients
GROUP BY insulin
ORDER BY readmission_rate DESC;

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


SELECT
  patient_nbr,
  COUNT(*) AS visit_count,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS short_term_readmits
FROM patients
GROUP BY patient_nbr
HAVING short_term_readmits >= 2
ORDER BY short_term_readmits DESC
LIMIT 10;

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

SELECT
  discharge_disposition_id,
  COUNT(*) AS total,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmits,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmit_rate
FROM patients
GROUP BY discharge_disposition_id
ORDER BY readmit_rate DESC
LIMIT 10;

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
