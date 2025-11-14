/*
==============================================================================
💰 PRODUCT SEGMENTATION
------------------------------------------------------------------------------
Purpose:
- Group products into cost-based ranges for analysis.
==============================================================================
*/

WITH PRODUCT_SEGMENTS AS (
    SELECT
        PRODUCT_KEY,
        PRODUCT_NAME,
        COST,
        CASE
            WHEN COST < 100 THEN 'Below 100'
            WHEN COST BETWEEN 100 AND 500 THEN '100-500'
            WHEN COST BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS COST_RANGE
    FROM GOLD.DIM_PRODUCTS
)
SELECT
    COST_RANGE,
    COUNT(PRODUCT_KEY) AS TOTAL_PRODUCTS
FROM PRODUCT_SEGMENTS
GROUP BY COST_RANGE
ORDER BY TOTAL_PRODUCTS DESC;
