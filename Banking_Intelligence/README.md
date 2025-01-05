# Customer Analysis for Bank Intelligence 

## Project Description
Banking Intelligence aims to develop a supervised machine learning model to predict customer behaviors based on transactional data and product ownership characteristics. The project involves creating a denormalized table with indicators (features) derived from the database to represent customer behaviors and financial activities.

## Objectives
- Create a feature table for machine learning model training.
- Enrich customer data with calculated indicators based on their transactions and accounts.

## Added Value
The project provides several benefits for the company:
1. **Customer Behavior Prediction:** Predict future actions like purchasing products or account closures.
2. **Churn Reduction:** Identify at-risk customers and enable timely marketing interventions.
3. **Risk Management Improvement:** Segment customers to optimize credit and risk strategies.
4. **Personalized Offers:** Tailor products and services based on individual habits.
5. **Fraud Prevention:** Detect transactional anomalies to improve security.

## Database Structure
The database consists of the following tables:
- **Customer:** Personal information (e.g., age).
- **Account:** Details about accounts owned by customers.
- **Account Type:** Types of accounts available.
- **Transaction Type:** Types of transactions that can occur on accounts.
- **Transactions:** Details of transactions performed by customers.

## Behavioral Indicators
Indicators are calculated for each customer and include:

### Basic Indicators
- Customer's age.

### Transaction Indicators
- Number of outgoing and incoming transactions.
- Total outgoing and incoming transaction amounts.

### Account Indicators
- Total number of accounts owned.
- Number of accounts owned by type.

### Transaction Indicators by Account Type
- Number of outgoing and incoming transactions by account type.
- Total outgoing and incoming amounts by account type.

## Deliverables
- The final output should be delivered as an SQL file containing the denormalized table.

## N.B.
For obvious reasons the database is not provided.

