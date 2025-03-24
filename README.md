# Finance_Loan_Approval
This project showcases data cleansing and analytical SQL queries derived from a Finance Loan Approval dataset. The analysis focuses on key metrics related to loan applications, including income, credit history, property details, loan amounts, and approval status. The goal is to ensure data integrity and generate actionable insights for informed decision-making.

# Dataset Overview
The dataset contains detailed information about loan applicants and loan status, comprising the following columns:

loan_ID: Unique identifier for each loan applications

Gender: Applicant's gender

Married: Marital status of the applicant

Dependents: Number of dependents

Education: Education level of applicant

Self_Employed: Employment status

ApplicantIncome: Income of the primary applicant

CoapplicantIncome: Income of co-applicant

Loan_Amount: Amount of loan requested

Loan_Amount_Term: Duration of loan term

Credit_History: Record of credit payment

Property_Area: Type of property area (urban/rural/semiurban)

Loan_Status: Loan approval status

# Data Cleansing Process
To ensure accurate analysis, data cleansing was performed, including:

•	Detecting missing or empty values.

•	Handling null values via mode imputation for categorical data.

•	Filling numerical gaps with mean imputation (rounded values).

•	Ensuring data integrity using TRANSACTION blocks.

# Cleansing Highlights:

•	Efficient null detection using CASE WHEN logic.

•	Dynamic SQL variables for mode calculation.

•	Mean imputation using AVG() with rounding for consistency.

•	Safe updates and rollback capability using START TRANSACTION and COMMIT.

# SQL Features Utilized
The project applies various SQL techniques to clean and analyze data effectively:

•	Aggregations: COUNT, AVG, ROUND for summarizing data.

•	Window Functions: RANK, LEAD, LAG for ranking and time-based analysis.

•	CTE: WITH clause for clean and reusable subquery.

•	Join: INNER JOIN for combining related datasets.

• Subqueries: Nested queries for calculating percentage and metrics.

