/*
==============================================================================
👥 CUSTOMER SEGMENTATION
------------------------------------------------------------------------------
Purpose:
- Group customers based on spending and loyalty (lifespan).
==============================================================================
*/

WITH CUSTOMER_SPENDING AS (
    SELECT
        C.CUSTOMER_KEY,
        SUM(F.SALES_AMOUNT) AS TOTAL_SPENDING,
        MIN(F.ORDER_DATE) AS FIRST_ORDER,
        MAX(F.ORDER_DATE) AS LAST_ORDER,
        (EXTRACT(YEAR FROM AGE(MAX(F.ORDER_DATE), MIN(F.ORDER_DATE))) * 12 +
         EXTRACT(MONTH FROM AGE(MAX(F.ORDER_DATE), MIN(F.ORDER_DATE)))) AS LIFE_SPAN
    FROM GOLD.FACT_SALES F
    LEFT JOIN GOLD.DIM_CUSTOMERS C ON F.CUSTOMER_KEY = C.CUSTOMER_KEY
    GROUP BY C.CUSTOMER_KEY
)
SELECT
    CUSTOMER_SEGMENT,
    COUNT(CUSTOMER_KEY) AS TOTAL_CUSTOMERS
FROM (
    SELECT
        CUSTOMER_KEY,
        CASE
            WHEN LIFE_SPAN > 12 AND TOTAL_SPENDING > 5000 THEN 'VIP'
            WHEN LIFE_SPAN > 12 AND TOTAL_SPENDING <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS CUSTOMER_SEGMENT
    FROM CUSTOMER_SPENDING
) sub
GROUP BY CUSTOMER_SEGMENT
ORDER BY TOTAL_CUSTOMERS DESC;
