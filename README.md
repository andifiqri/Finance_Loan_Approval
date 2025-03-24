# Loan Approval Analysis with SQL

This project involves data cleansing and analysis of a loan approval dataset using SQL. The goal is to extract meaningful insights related to loan approval trends, applicant demographics, and key influencing factors such as credit history and employment status.

## Dataset Overview
The dataset includes the following key features:
- Gender, Marital Status, Dependents
- Education, Self-Employment Status
- Applicant & Coapplicant Income
- Loan Amount, Loan Term
- Credit History, Property Area
- Loan Approval Status

## Key Objectives
- Handle missing data with appropriate imputation techniques (mode/mean).
- Analyze loan approval distribution across demographic and financial variables.
- Determine key drivers behind loan approval decisions.
- Use advanced SQL techniques including window functions (RANK, LEAD, LAG) and CTEs.

## SQL Techniques Used
- **Data Cleansing**: Mode & Mean Imputation
- **Aggregations**: GROUP BY, COUNT, AVG, ROUND
- **Window Functions**: RANK, LEAD, LAG
- **CTEs (Common Table Expressions)**: For comparison analysis
- **Conditional Logic**: CASE statements for approval rate calculation

## Sample Insights
- Applicants with a positive credit history have an approval rate of ≈ 80%.
- Self-employed individuals have submitted significantly fewer loan applications compared to those who are not self-employed. However, the approval rates between the two groups are not substantially different — 65.75% for self-employed applicants and 68.97% for non-self-employed applicants.
- Semiurban property areas account for the highest number of loan applications.

## How to Use
1. Import the SQL scripts into your MySQL environment.
2. Run each section in sequence: Data Cleansing → Analysis.
3. Modify queries to suit your specific analysis needs.

## Tools Used
- SQL Workbench
