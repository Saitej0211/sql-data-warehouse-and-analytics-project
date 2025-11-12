# 🧩 Exploratory Data Analysis (EDA) — Gold Layer

## 📘 Overview
This folder contains SQL scripts used for **Exploratory Data Analysis (EDA)** on the **Gold Layer** of the data warehouse.  
It focuses on analyzing the cleaned and transformed data (post-ETL), stored in the `gold` schema, to validate data integrity and extract business insights.

The SQL scripts are written for **PostgreSQL** and executed in **pgAdmin** or **DBeaver**.

---

## 🧱 Schema Overview
The **Gold Layer** is the presentation layer in the data warehouse, designed following the **Star Schema** model.  
It consists of:

- **Fact Table:** `gold.fact_sales`  
  Stores transactional sales data (orders, dates, amounts, quantities).

- **Dimension Tables:**  
  - `gold.dim_customers` — Customer attributes (name, gender, country, birth date).  
  - `gold.dim_products` — Product attributes (name, category, subcategory, cost).

---

## 📂 Contents

| Script Section | Description |
|----------------|-------------|
| **1. Database Exploration** | Metadata queries to inspect schemas, tables, and columns. |
| **2. Dimensions Exploration** | Analyze customer demographics and product hierarchies. |
| **3. Date Exploration** | Explore time-based attributes like sales coverage and customer age. |
| **4. Measures Exploration** | Compute total sales, items sold, average price, and order volume. |
| **5. Magnitude Analysis** | Identify business distributions — sales by category, region, or gender. |
| **6. Ranking Analysis** | Rank top/bottom customers and products by revenue or orders. |

---

## 🚀 Usage

1. Ensure your PostgreSQL instance contains the `gold` schema.
2. Open `gold_layer_analysis.sql` in **pgAdmin** or **DBeaver**.
3. Run queries section by section to:
   - Validate data transformations.
   - Explore business KPIs.
   - Derive key insights for reporting and visualization.

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

## ⚙️ Tech Stack

- **Database:** PostgreSQL 18  
- **Query Tool:** pgAdmin / DBeaver  
- **Model:** Star Schema (Fact & Dimension Tables)  
- **Functions Used:** `AGE()`, `EXTRACT()`, `DATE_TRUNC()`, `ROW_NUMBER()`, `CONCAT()`, `LIMIT`

---
