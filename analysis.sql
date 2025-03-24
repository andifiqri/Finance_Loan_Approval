-- 1. Loan application distribution by marital status and gender
SELECT
    Gender,
    Married,
    COUNT(*) AS total_applicants
FROM loan_approval
GROUP BY Married, Gender
ORDER BY total_applicants DESC;

-- 2. Average income of applicants and co-applicants by credit history
SELECT
    credit_history,
    AVG(ApplicantIncome) AS avg_applicant_income,
    AVG(CoapplicantIncome) AS avg_coapplicant_income
FROM loan_approval
GROUP BY Credit_History;

-- 3. Percentage of loan applications by property area
SELECT
    Property_Area,
    COUNT(*) AS total_applicants,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM loan_approval), 2) AS percentage
FROM loan_approval
GROUP BY Property_Area
ORDER BY total_applicants DESC;

-- 4. Loan application distribution by number of dependents
SELECT
    Dependents,
    COUNT(*) AS total_applicants
FROM loan_approval
GROUP BY Dependents
ORDER BY total_applicants DESC;

-- 5. Average loan amount by credit history
SELECT
    Credit_History,
    AVG(LoanAmount) AS avg_loan_amount
FROM loan_approval
GROUP BY Credit_History;

-- 6. Average loan amount by employment status
SELECT
    Self_Employed,
    AVG(LoanAmount) AS avg_loan_amount
FROM loan_approval
GROUP BY Self_Employed;

-- 7. Loan trends by loan term duration
SELECT
    Loan_Amount_Term,
    COUNT(*) AS total_loans,
    AVG(LoanAmount) AS avg_loan_amount
FROM loan_approval
GROUP BY Loan_Amount_Term
ORDER BY Loan_Amount_Term;

-- 8. Loan ranking by applicant income and education level
SELECT
    Education,
    ApplicantIncome,
    LoanAmount,
    RANK() OVER (PARTITION BY Education ORDER BY LoanAmount DESC) AS loan_rank
FROM loan_approval;

-- 9. Comparison of loan amounts with the average by credit history
WITH avg_loans AS (
    SELECT
        Credit_History,
        AVG(LoanAmount) AS avg_loan_amount
    FROM loan_approval
    GROUP BY Credit_History
)

SELECT
    l.Loan_ID,
    l.Credit_History,
    l.LoanAmount,
    a.avg_loan_amount
FROM loan_approval AS l
JOIN avg_loans AS a ON l.credit_history = a.credit_history;

-- 10. Next loan amount trend by applicant income
SELECT
    Loan_ID,
    ApplicantIncome,
    LoanAmount,
    LEAD(LoanAmount) OVER (ORDER BY ApplicantIncome) AS next_loan_amount
FROM loan_approval;

-- 11. Comparison of loan amounts with previous loan by applicant income
SELECT 
    Loan_ID, 
    ApplicantIncome, 
    LoanAmount,
    LAG(LoanAmount) OVER (ORDER BY ApplicantIncome) AS previous_loan_amount
FROM loan_approval;

-- 12. Approved vs. rejected loan percentage based on multiple factors
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