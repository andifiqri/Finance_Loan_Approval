--- Checking Null Values ---
SELECT 
    SUM(CASE WHEN Gender IS NULL OR Gender = '' THEN 1 ELSE 0 END) AS Gender_Null,
    SUM(CASE WHEN Married IS NULL OR Married = '' THEN 1 ELSE 0 END) AS Married_Null,
    SUM(CASE WHEN Dependents IS NULL OR Dependents = '' THEN 1 ELSE 0 END) AS Dependents_Null,
    SUM(CASE WHEN Education IS NULL OR Education = '' THEN 1 ELSE 0 END) AS Education_Null,
    SUM(CASE WHEN Self_Employed IS NULL OR Self_Employed = '' THEN 1 ELSE 0 END) AS Self_Employed_Null,
    SUM(CASE WHEN ApplicantIncome IS NULL OR ApplicantIncome = '' THEN 1 ELSE 0 END) AS ApplicantIncome_Null,
    SUM(CASE WHEN CoapplicantIncome IS NULL OR CoapplicantIncome = '' THEN 1 ELSE 0 END) AS CoapplicantIncome_Null,
    SUM(CASE WHEN LoanAmount IS NULL OR LoanAmount = '' THEN 1 ELSE 0 END) AS LoanAmount_Null,
    SUM(CASE WHEN Loan_Amount_Term IS NULL OR Loan_Amount_Term = '' THEN 1 ELSE 0 END) AS Loan_Amount_Term_Null,
    SUM(CASE WHEN Credit_History IS NULL OR Credit_History = '' THEN 1 ELSE 0 END) AS Credit_History_Null,
    SUM(CASE WHEN Property_Area IS NULL OR Property_Area = '' THEN 1 ELSE 0 END) AS Property_Area_Null,
    SUM(CASE WHEN Loan_Status IS NULL OR Loan_Status = '' THEN 1 ELSE 0 END) AS Loan_Status_Null
FROM loan_approval;

--- Handling Missing Categorical Values With Mode Imputation --- 
-- Fill missing gender values
START TRANSACTION;

SET @mode_value = (
    SELECT gender
    FROM loan_approval
    WHERE gender <> ''
    GROUP BY gender
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

UPDATE loan_approval
SET gender = @mode_value
WHERE gender = '';

COMMIT;

-- Fill missing married values
START TRANSACTION;

SET @mode_value = (
    SELECT married
    FROM loan_approval
    WHERE married <> ''
    GROUP BY married
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

UPDATE loan_approval
SET married = @mode_value
WHERE married = '';

COMMIT;

-- Fill missing Self_Employed values
START TRANSACTION;

SET @mode_value = (
    SELECT self_employed
    FROM loan_approval
    WHERE self_employed <> ''
    GROUP BY self_employed
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

UPDATE loan_approval
SET self_employed = @mode_value
WHERE self_employed = '';

COMMIT;

--- Handling Missing Numerical Values with Mean Imputation ---
-- Fill missing loan_amount values
START TRANSACTION;

SET @mean_value = (
    SELECT ROUND(AVG(loanamount))
    FROM loan_approval
    WHERE loanamount <> ''
);

UPDATE loan_approval
SET loanamount = @mean_value
WHERE loanamount = '';

COMMIT;