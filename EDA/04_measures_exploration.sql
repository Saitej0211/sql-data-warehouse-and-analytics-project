/* =====================================================================
 💰 MEASURES EXPLORATION
===================================================================== */

-- Find total sales
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Find total quantity of items sold
SELECT SUM(quantity) AS total_items_sold
FROM gold.fact_sales;

-- Find average selling price
SELECT ROUND(AVG(price), 2) AS avg_selling_price
FROM gold.fact_sales;

-- Find total number of orders (including duplicates)
SELECT COUNT(order_number) AS total_no_orders
FROM gold.fact_sales;

-- Find total number of unique orders
SELECT COUNT(DISTINCT order_number) AS total_no_orders
FROM gold.fact_sales;

-- Find total number of products
SELECT COUNT(DISTINCT product_key) AS total_no_products
FROM gold.dim_products;

-- Find total number of customers
SELECT COUNT(DISTINCT customer_key) AS total_no_customers
FROM gold.dim_customers;

-- Find number of customers who have placed at least one order
SELECT COUNT(DISTINCT customer_key) AS active_customers
FROM gold.fact_sales;

-- Generate a report showing all key business metrics
SELECT 'Total Sales' AS metric, SUM(sales_amount) AS value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity)
FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', ROUND(AVG(price), 2)
FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number)
FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name)
FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(DISTINCT customer_key)
FROM gold.dim_customers;
