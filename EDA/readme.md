# 🧩 Exploratory Data Analysis (EDA) — Gold Layer

## 📘 Overview
This folder contains SQL scripts used for **Exploratory Data Analysis (EDA)** on the **Gold Layer** of the data warehouse.  
It focuses on analyzing the cleaned and transformed data (post-ETL), stored in the `gold` schema, to validate data integrity and extract business insights.

The SQL scripts are written for **PostgreSQL** and executed in **pgAdmin** or **DBeaver**.

---

## 🏗️ Schema Context
The **Gold Layer** represents the final, business-ready data layer derived from the **Silver Layer**.  
It contains:

- **Dimension Tables**
  - `gold.dim_customers`
  - `gold.dim_products`
- **Fact Table**
  - `gold.fact_sales`

These tables follow a **Star Schema** model, where the `fact_sales` table references the dimensions via surrogate keys.

---

## 📁 Script Structure

| Section | Description |
|----------|--------------|
| **1. Database Exploration** | Lists schemas, tables, and columns using `information_schema` to explore database metadata. |
| **2. Dimensions Exploration** | Explores categorical attributes like countries, product categories, and subcategories. |
| **3. Date Exploration** | Analyzes sales date ranges and customer age spans using date functions (`AGE()`, `EXTRACT()`). |
| **4. Measures Exploration** | Computes key performance metrics such as total sales, average prices, and order counts. |
| **5. Magnitude Analysis** | Aggregates business metrics like customers by region, revenue by category, and product counts. |
| **6. Ranking Analysis** | Ranks top and bottom performers — products and customers — using `ROW_NUMBER()` and `LIMIT`. |

---

## ⚙️ Prerequisites

- **PostgreSQL 14+**
- **pgAdmin 4** or **DBeaver** for query execution
- A database schema named `gold` with the following tables:

| Table | Description |
|--------|-------------|
| `dim_customers` | Customer dimension with fields like `customer_key`, `first_name`, `last_name`, `country`, `gender`, `birth_date`. |
| `dim_products` | Product dimension with fields like `product_key`, `product_name`, `category`, `sub_category`, `cost`. |
| `fact_sales` | Fact table with fields like `order_number`, `order_date`, `product_key`, `customer_key`, `sales_amount`, `quantity`, `price`. |

---

## 🚀 How to Use

1. **Open pgAdmin or DBeaver.**
2. Connect to your PostgreSQL database that contains the `gold` schema.
3. Copy the full SQL script (`gold_layer_analysis.sql`) into a query editor window.
4. Execute section by section, or run the entire script for a complete analysis.
5. Review outputs to understand data quality, business insights, and performance metrics.

---

## 📈 Key Insights Generated

- **Data Coverage**
  - Sales date range in years, months, and days.
  - Number of customers, products, and orders available.

- **Customer Insights**
  - Distribution by gender and country.
  - Youngest and oldest customer demographics.
  - Top and bottom customers by revenue and order count.

- **Product Insights**
  - Average cost by category.
  - Top 5 and bottom 5 products by revenue.
  - Product performance by category and line.

- **Sales Insights**
  - Total and average sales metrics.
  - Revenue contribution by category and customer.
  - Quantity sold per country.

---

## 📊 Some Insights

| Insight | Example Output |
|----------|----------------|
| Total Sales | `$29M` |
| Active Customers | `18,484` |
| Top Product | `Bikes` |
| Highest Revenue Country | `United States` |
| Sales Range | `3 years, 30 days` |

---

## 🛠️ Highlights & Features

- Clean **PostgreSQL-compatible** syntax (`LIMIT`, `CONCAT()`, `AGE()`, `DATE_TRUNC()`).
- Modular structure with readable comments.
- Works across any **star-schema warehouse** following dimensional modeling principles.
- Includes **ranking**, **aggregation**, and **exploratory analysis** sections.
- Ready to integrate into BI dashboards or analytics notebooks.
---
