/*
==============================================================================
📄 CREATE VIEW: GOLD.REPORT_CUSTOMERS
------------------------------------------------------------------------------
Purpose:
- This report consolidates key customer metrics and behaviors
Highlights:
1. Gathers essential fields such as names, ages, and transaction details.
2. Segments customers into categories (VIP, Regular, New) and age groups.
3. Aggregates customer-level metrics:
- total orders
- total sales
- total quantity purchased
- total products
- lifespan (in months)
4. Calculates valuable KPIs:
- recency (months since last order)
- average order value
- average monthly spend
==============================================================================
*/

CREATE VIEW gold.report_customers AS
WITH BASE_QUERY AS (
    SELECT
        C.CUSTOMER_KEY,
        C.CUSTOMER_NUMBER,
        CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS CUSTOMER_NAME,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, C.BIRTH_DATE)) AS AGE,
        F.ORDER_NUMBER,
        F.ORDER_DATE,
        F.PRODUCT_KEY,
        F.SALES_AMOUNT,
        F.QUANTITY
    FROM GOLD.FACT_SALES F
    LEFT JOIN GOLD.DIM_CUSTOMERS C ON C.CUSTOMER_KEY = F.CUSTOMER_KEY
    WHERE F.ORDER_DATE IS NOT NULL
),
CUSTOMER_AGGREGATIONS AS (
    SELECT
        CUSTOMER_KEY,
        CUSTOMER_NUMBER,
        CUSTOMER_NAME,
        AGE,
        COUNT(DISTINCT ORDER_NUMBER) AS TOTAL_ORDERS,
        SUM(SALES_AMOUNT) AS TOTAL_SALES,
        COUNT(DISTINCT PRODUCT_KEY) AS TOTAL_PRODUCTS,
        SUM(QUANTITY) AS TOTAL_QUANTITY,
        MAX(ORDER_DATE) AS LAST_ORDER_DATE,
        (EXTRACT(YEAR FROM AGE(MAX(ORDER_DATE), MIN(ORDER_DATE))) * 12 +
         EXTRACT(MONTH FROM AGE(MAX(ORDER_DATE), MIN(ORDER_DATE)))) AS LIFE_SPAN
    FROM BASE_QUERY
    GROUP BY CUSTOMER_KEY, CUSTOMER_NUMBER, CUSTOMER_NAME, AGE
)
SELECT
    CUSTOMER_KEY,
    CUSTOMER_NUMBER,
    CUSTOMER_NAME,
    AGE,
    CASE
        WHEN AGE < 20 THEN 'Under 20'
        WHEN AGE BETWEEN 20 AND 29 THEN '20-29'
        WHEN AGE BETWEEN 30 AND 39 THEN '30-39'
        WHEN AGE BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS AGE_GROUP,
    CASE
        WHEN LIFE_SPAN > 12 AND TOTAL_SALES > 5000 THEN 'VIP'
        WHEN LIFE_SPAN > 12 AND TOTAL_SALES <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS CUSTOMER_SEGMENT,
    LAST_ORDER_DATE,
    (EXTRACT(YEAR FROM AGE(CURRENT_DATE, LAST_ORDER_DATE)) * 12 +
     EXTRACT(MONTH FROM AGE(CURRENT_DATE, LAST_ORDER_DATE))) AS RECENCY,
    TOTAL_ORDERS,
    TOTAL_SALES,
    TOTAL_PRODUCTS,
    TOTAL_QUANTITY,
    LIFE_SPAN,
    -- KPI: Average Order Value (AOV)
    CASE WHEN TOTAL_ORDERS = 0 THEN 0 ELSE ROUND(TOTAL_SALES / TOTAL_ORDERS, 2) END AS AVG_ORDER_VALUE,
    -- KPI: Average Monthly Spend
    CASE WHEN LIFE_SPAN = 0 THEN ROUND(TOTAL_SALES, 2) ELSE ROUND(TOTAL_SALES / LIFE_SPAN, 2) END AS AVG_MONTHLY_SPEND
FROM CUSTOMER_AGGREGATIONS;
