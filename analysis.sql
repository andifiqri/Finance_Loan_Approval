-- 1. Loan application distribution by marital status and gender
SELECT
    Gender,
    Married,
    COUNT(*) AS total_applicants
FROM loan_approval
GROUP BY Gender, Married
ORDER BY total_applicants DESC;

-- 2. Distribution by number of dependents
SELECT
    Dependents,
    COUNT(*) AS total_applicants
FROM loan_approval
GROUP BY Dependents
ORDER BY total_applicants DESC;

-- 3. Distribution by property area with percentage
SELECT
    Property_Area,
    COUNT(*) AS total_applicants,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loan_approval), 2) AS percentage
FROM loan_approval
GROUP BY Property_Area
ORDER BY total_applicants DESC;

-- 4. Average income of applicants and co-applicants by credit history
SELECT
    Credit_History,
    ROUND(AVG(ApplicantIncome), 2) AS avg_applicant_income,
    ROUND(AVG(CoapplicantIncome), 2) AS avg_coapplicant_income
FROM loan_approval
GROUP BY Credit_History;

-- 5. Average loan amount by credit history
SELECT
    Credit_History,
    ROUND(AVG(LoanAmount), 2) AS avg_loan_amount
FROM loan_approval
GROUP BY Credit_History;

-- 6. Average loan amount by employment status
SELECT
    Self_Employed,
    ROUND(AVG(LoanAmount), 2) AS avg_loan_amount
FROM loan_approval
GROUP BY Self_Employed;

-- 7. Loan trends by loan term duration
SELECT
    Loan_Amount_Term,
    COUNT(*) AS total_loans,
    ROUND(AVG(LoanAmount), 2) AS avg_loan_amount
FROM loan_approval
GROUP BY Loan_Amount_Term
ORDER BY Loan_Amount_Term;

-- 8. Influence of credit history on loan approval
SELECT
    Credit_History,
    COUNT(*) AS total_applicants,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS approved_loans,
    ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS approval_rate
FROM loan_approval
GROUP BY Credit_History;

-- 9. Loan approval rate by property area
SELECT
    Property_Area,
    COUNT(*) AS total_applicants,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS approved_loans,
    ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS approval_rate
FROM loan_approval
GROUP BY Property_Area;

-- 10. Loan approval rate by self-employed status
SELECT
    Self_Employed,
    COUNT(*) AS total_applicants,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS approved_loans,
    ROUND(SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS approval_rate
FROM loan_approval
GROUP BY Self_Employed;

-- 11. Loan ranking by applicant income and education level
SELECT
    Education,
    ApplicantIncome,
    LoanAmount,
    RANK() OVER (PARTITION BY Education ORDER BY LoanAmount DESC) AS loan_rank
FROM loan_approval;

-- 12. Comparison of loan amounts with the average by credit history
WITH avg_loans AS (
    SELECT
        Credit_History,
        ROUND(AVG(LoanAmount), 2) AS avg_loan_amount
    FROM loan_approval
    GROUP BY Credit_History
)
SELECT
    l.Loan_ID,
    l.Credit_History,
    l.LoanAmount,
    a.avg_loan_amount
FROM loan_approval AS l
JOIN avg_loans AS a ON l.Credit_History = a.Credit_History;

-- 13. Next loan amount trend by applicant income
SELECT
    Loan_ID,
    ApplicantIncome,
    LoanAmount,
    LEAD(LoanAmount) OVER (ORDER BY ApplicantIncome) AS next_loan_amount
FROM loan_approval;

-- 14. Comparison of loan amounts with previous loan by applicant income
SELECT
    Loan_ID,
    ApplicantIncome,
    LoanAmount,
    LAG(LoanAmount) OVER (ORDER BY ApplicantIncome) AS previous_loan_amount
FROM loan_approval;

-- 15. Approved vs. rejected loan percentage based on multiple factors
SELECT
    Self_Employed,
    Education,
    Property_Area,
    Loan_Status,
    COUNT(*) AS total_applicants,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Self_Employed, Education, Property_Area), 2) AS percentage
FROM loan_approval
GROUP BY Self_Employed, Education, Property_Area, Loan_Status
ORDER BY Self_Employed, Education, Property_Area, Loan_Status;