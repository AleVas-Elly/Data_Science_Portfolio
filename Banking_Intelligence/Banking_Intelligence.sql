-- CREATE TABLE denormalized_features AS
SELECT
c.id_cliente,

-- BASE FEATURES:
-- Client's Age
YEAR(current_date()) - YEAR(c.data_nascita) AS Age,

-- TRANSACTIONS FEATURES:
COUNT(CASE WHEN segno = "-" THEN 1 END) AS Number_of_OUT_Transactions,
COUNT(CASE WHEN segno = "+" THEN 1 END) AS Number_of_IN_Transactions,
sum(CASE WHEN segno = "-" THEN importo ELSE 0 END) AS Total_OUT_Amount,
sum(CASE WHEN segno = "+" THEN importo ELSE 0 END) AS Total_IN_Amount,

-- ACCOUNT FEATURES
-- Number of Accounts per client
COUNT(distinct acc.id_conto) AS Number_of_Accounts,

-- Number of Accounts by Account Type
COUNT(distinct CASE WHEN acct.id_tipo_conto = 0 THEN acc.id_conto END) AS Total_Base_Accounts,
COUNT(distinct CASE WHEN acct.id_tipo_conto = 1 THEN acc.id_conto END) AS Total_Business_Accounts,
COUNT(distinct CASE WHEN acct.id_tipo_conto = 2 THEN acc.id_conto END) AS Total_Private_Accounts,
COUNT(distinct CASE WHEN acct.id_tipo_conto = 3 THEN acc.id_conto END) AS Total_Family_Accounts,
-- Number of IN/OUT Transactions by Account Type:
-- OUT
COUNT(CASE WHEN acct.id_tipo_conto = 0 AND segno = "-" THEN 1 END) AS Total_NUMBER_Base_Account_OUT_Transactions,
COUNT(CASE WHEN acct.id_tipo_conto = 1 AND segno = "-" THEN 1 END) AS Total_NUMBER_Business_Accounts_OUT_Transactions,
COUNT(CASE WHEN acct.id_tipo_conto = 2 AND segno = "-" THEN 1 END) AS Total_NUMBER_Private_Accounts_OUT_Transactions,
COUNT(CASE WHEN acct.id_tipo_conto = 3 AND segno = "-" THEN 1 END) AS Total_NUMBER_Family_Accounts_OUT_Transactions,

-- IN
COUNT(CASE WHEN acct.id_tipo_conto = 0 AND segno = "+" THEN 1 END) AS Total_NUMBER_Base_Account_IN_Transactions,
COUNT(CASE WHEN acct.id_tipo_conto = 1 AND segno = "+" THEN 1 END) AS Total_NUMBER_Business_Accounts_IN_Transactions,
COUNT(CASE WHEN acct.id_tipo_conto = 2 AND segno = "+" THEN 1 END) AS Total_NUMBER_Private_Accounts_IN_Transactions,
COUNT(CASE WHEN acct.id_tipo_conto = 3 AND segno = "+" THEN 1 END) AS Total_NUMBER_Family_Accounts_IN_Transactions,

-- IN/OUT Amount by Account Type
-- OUT
sum(CASE WHEN acct.id_tipo_conto = 0 AND segno = "-" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Base_Account_OUT_Transactions,
sum(CASE WHEN acct.id_tipo_conto = 1 AND segno = "-" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Business_Accounts_OUT_Transactions,
sum(CASE WHEN acct.id_tipo_conto = 2 AND segno = "-" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Private_Accounts_OUT_Transactions,
sum(CASE WHEN acct.id_tipo_conto = 3 AND segno = "-" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Family_Accounts_OUT_Transactions,

-- IN
sum(CASE WHEN acct.id_tipo_conto = 0 AND segno = "+" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Base_Account_IN_Transactions,
sum(CASE WHEN acct.id_tipo_conto = 1 AND segno = "+" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Business_Accounts_IN_Transactions,
sum(CASE WHEN acct.id_tipo_conto = 2 AND segno = "+" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Private_Accounts_IN_Transactions,
sum(CASE WHEN acct.id_tipo_conto = 3 AND segno = "+" THEN tra.importo ELSE 0 END) AS Total_AMOUNT_Family_Accounts_IN_Transactions
FROM cliente c
LEFT JOIN 
	conto acc ON c.id_cliente = acc.id_cliente
LEFT JOIN 
	tipo_conto acct ON acc.id_tipo_conto = acct.id_tipo_conto
LEFT JOIN
	transazioni tra ON acc.id_conto = tra.id_conto
LEFT JOIN 
	tipo_transazione trat ON trat.id_tipo_transazione = tra.id_tipo_trans
GROUP BY 1,2
