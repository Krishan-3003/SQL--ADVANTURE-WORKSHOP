# Adventure Works SQL Data Analysis Project

## 📌 Project Overview

This project demonstrates SQL-based data analysis using the **Adventure Works** dataset. The objective was to transform raw sales data into an analysis-ready dataset and generate meaningful business insights related to sales, products, customers, costs, profit, and time-based performance.

The project covers data preparation, table integration, data enrichment, calculated fields, financial analysis, and business KPI generation using SQL.

## 🛠️ Tools & Technologies

* **MySQL**
* SQL
* Adventure Works Dataset
* Data Cleaning & Transformation
* Business Intelligence / Data Analysis

## 📂 Project Workflow

### 1. Sales Data Integration

Combined sales data from two internet sales tables using `UNION ALL` to create a consolidated `Sales` table.

### 2. Data Enrichment

Added important information to the sales table using joins with dimension tables:

* Product Name
* Customer Full Name
* Unit Price

The project uses `DimProduct` and `DimCustomer` to enrich the sales data.

### 3. Sales Amount Calculation

Calculated sales amount using:

**Sales Amount = Unit Price × Order Quantity × (1 − Discount %)**

This helped create a consistent sales metric for further analysis.

### 4. Date & Time Analysis

Created several date-related columns from `OrderDateKey`:

* Year
* Month Number
* Month Name
* Quarter
* Year-Month
* Weekday Number
* Weekday Name
* Financial Month
* Financial Quarter

These fields support monthly, quarterly, yearly, and financial-period analysis.

### 5. Cost & Profit Analysis

Calculated:

* Unit Cost
* Production Cost
* Profit

Profit was calculated by subtracting production cost from sales amount.

### 6. Business Analysis Queries

Created SQL queries for:

* Monthly sales analysis
* Year-wise sales
* Month-wise sales
* Quarter-wise sales
* Sales vs. production cost
* Total profit
* Total products sold
* Total customers
* Profit margin
* Total sales

These queries can be used as the SQL foundation for dashboards and business reports.

## 📊 Key Analysis Areas

| Analysis                 | Purpose                                  |
| ------------------------ | ---------------------------------------- |
| Year-wise Sales          | Understand annual sales performance      |
| Month-wise Sales         | Identify monthly sales trends            |
| Quarter-wise Sales       | Compare quarterly performance            |
| Sales vs Production Cost | Analyze revenue and cost together        |
| Product Analysis         | Understand product-level performance     |
| Customer Analysis        | Analyze customer contribution            |
| Profit Analysis          | Measure business profitability           |
| Profit Margin            | Evaluate profitability relative to sales |

## 🎯 Project Objectives

* Combine sales data from multiple sources.
* Enrich transactional data using dimension tables.
* Perform data transformation using SQL.
* Create business-ready calculated fields.
* Analyze sales, costs, and profitability.
* Generate KPIs for business performance analysis.
* Prepare SQL outputs that can be connected to visualization tools.

## 💡 Skills Demonstrated

* SQL Joins
* UNION ALL
* ALTER TABLE
* UPDATE statements
* CASE statements
* Aggregate Functions
* GROUP BY
* ORDER BY
* Date Functions
* String Functions
* Data Transformation
* KPI Development
* Business Data Analysis

## 📁 Project Structure

```text
Adventure-Works-SQL-Project/
│
├── SQL Adventure Works Project.sql
└── README.md
```

## 🚀 Conclusion

This project demonstrates how SQL can be used to transform raw transactional data into structured information for business analysis. The final queries provide a foundation for analyzing sales, customers, products, costs, profitability, and performance trends.

The project also demonstrates practical SQL skills that are relevant to **Data Analyst and Business Intelligence roles**.
