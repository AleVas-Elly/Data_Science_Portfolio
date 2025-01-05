-- CREATE TABLE denormalized_features AS
SELECT
c.client_id,

-- BASE FEATURES:
-- Client's Age
YEAR(current_date()) - YEAR(c.birth_date) AS Age,

-- TRANSACTIONS FEATURES:
COUNT(CASE WHEN sign = "-" THEN 1 END) AS Number_of_OUT_Transactions,
COUNT(CASE WHEN sign = "+" THEN 1 END) AS Number_of_IN_Transactions,
sum(CASE WHEN sign = "-" THEN amount ELSE 0 END) AS Total_OUT_Amount,
sum(CASE WHEN sign = "+" THEN amount ELSE 0 END) AS Total_IN_Amount,

-- ACCOUNT FEATURES
-- Number of Accounts per client
COUNT(distinct acc.account_id) AS Number_of_Accounts,

-- Number of Accounts by Account Type
COUNT(distinct CASE WHEN acct.account_type_id = 0 THEN acc.account_id END) AS Total_Base_Accounts,
COUNT(distinct CASE WHEN acct.account_type_id = 1 THEN acc.account_id END) AS Total_Business_Accounts,
COUNT(distinct CASE WHEN acct.account_type_id = 2 THEN acc.account_id END) AS Total_Private_Accounts,
COUNT(distinct CASE WHEN acct.account_type_id = 3 THEN acc.account_id END) AS Total_Family_Accounts,
-- Number of IN/OUT Transactions by Account Type:
-- OUT
COUNT(CASE WHEN acct.account_type_id = 0 AND sign = "-" THEN 1 END) AS Total_NUMBER_Base_Account_OUT_Transactions,
COUNT(CASE WHEN acct.account_type_id = 1 AND sign = "-" THEN 1 END) AS Total_NUMBER_Business_Accounts_OUT_Transactions,
COUNT(CASE WHEN acct.account_type_id = 2 AND sign = "-" THEN 1 END) AS Total_NUMBER_Private_Accounts_OUT_Transactions,
COUNT(CASE WHEN acct.account_type_id = 3 AND sign = "-" THEN 1 END) AS Total_NUMBER_Family_Accounts_OUT_Transactions,

-- IN
COUNT(CASE WHEN acct.account_type_id = 0 AND sign = "+" THEN 1 END) AS Total_NUMBER_Base_Account_IN_Transactions,
COUNT(CASE WHEN acct.account_type_id = 1 AND sign = "+" THEN 1 END) AS Total_NUMBER_Business_Accounts_IN_Transactions,
COUNT(CASE WHEN acct.account_type_id = 2 AND sign = "+" THEN 1 END) AS Total_NUMBER_Private_Accounts_IN_Transactions,
COUNT(CASE WHEN acct.account_type_id = 3 AND sign = "+" THEN 1 END) AS Total_NUMBER_Family_Accounts_IN_Transactions,

-- IN/OUT Amount by Account Type
-- OUT
sum(CASE WHEN acct.account_type_id = 0 AND sign = "-" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Base_Account_OUT_Transactions,
sum(CASE WHEN acct.account_type_id = 1 AND sign = "-" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Business_Accounts_OUT_Transactions,
sum(CASE WHEN acct.account_type_id = 2 AND sign = "-" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Private_Accounts_OUT_Transactions,
sum(CASE WHEN acct.account_type_id = 3 AND sign = "-" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Family_Accounts_OUT_Transactions,

-- IN
sum(CASE WHEN acct.account_type_id = 0 AND sign = "+" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Base_Account_IN_Transactions,
sum(CASE WHEN acct.account_type_id = 1 AND sign = "+" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Business_Accounts_IN_Transactions,
sum(CASE WHEN acct.account_type_id = 2 AND sign = "+" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Private_Accounts_IN_Transactions,
sum(CASE WHEN acct.account_type_id = 3 AND sign = "+" THEN tra.amount ELSE 0 END) AS Total_AMOUNT_Family_Accounts_IN_Transactions
FROM client c
LEFT JOIN 
	account acc ON c.clint_id = acc.client_id
LEFT JOIN 
	account_type acct ON acc.account_type_id = acct.account_type_id
LEFT JOIN
	transactions tra ON acc.account_id = tra.account_id
LEFT JOIN 
	transaction_type trat ON trat.transaction_type_id = tra.transaction_type_id
GROUP BY 1,2
