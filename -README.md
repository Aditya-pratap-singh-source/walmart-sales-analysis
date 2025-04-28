# 🛒 Walmart Sales Analysis Using SQL

## 📂 Project Overview
This project involves a complete sales analysis of a Walmart store's transactional data using MySQL. The goal was to derive business insights through data cleaning, feature engineering, exploratory analysis, and business KPI calculations.

---

## 📋 Objectives
- Analyze sales trends across different times of the day, days of the week, and months.
- Identify the top-performing product lines, cities, and branches.
- Understand customer behaviors based on type, gender, and payment methods.
- Calculate key business metrics: revenue, COGS, VAT, gross income, and gross margin.

---

## 🛠️ Tools and Technologies
- **Database**: MySQL
- **Language**: SQL
- **Dataset**: Walmart Sales Data (10,000+ records)

---

## 📈 Key Activities
- **Database and Table Creation**: Structured the Walmart sales dataset into a MySQL table.
- **Data Cleaning**: Fixed date formats and handled time issues using `STR_TO_DATE()` and `CAST()`.
- **Feature Engineering**:
  - Created `time_of_day` based on transaction times (Morning, Afternoon, Evening).
  - Extracted `day_name` and `month_name` from the Date column.
- **Business Analysis**:
  - Analyzed sales by product line, city, branch, customer type, and gender.
  - Identified top-selling product lines and branches.
  - Calculated VAT (5%), COGS, total sales, gross income, and gross margin percentages.
- **Advanced SQL Usage**:
  - Used subqueries and CTEs for cleaner, modular queries.
  - Applied aggregation (`AVG()`, `SUM()`), conditional statements (`CASE WHEN THEN`), and grouping (`GROUP BY`).

---

## 📊 Business Questions Answered
- How many unique cities and branches are in the data?
- What are the most popular product lines and payment methods?
- Which city generates the highest revenue?
- Which product lines perform above the average sales quantity?
- What are the customer types and gender distribution?
- When do customers make the most purchases and give the highest ratings?

---

## 📚 Key Learnings
- Real-world data preparation and cleaning using SQL.
- Business thinking applied to retail sales datasets.
- Feature engineering to enhance dataset insights.
- Hands-on experience with KPIs, gross margin, revenue, and profit calculations.
- Clear, modular SQL coding practices with CTEs.

---

## 🚀 Future Enhancements
- Build an interactive Power BI Dashboard based on this data analysis.
- Create predictive models for sales forecasting using machine learning.

---

## 📑 Sample SQL Queries Used

```sql
-- Add time of day based on transaction time
UPDATE walmart_sales
SET time_of_day = 
  CASE 
    WHEN HOUR(Time) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN HOUR(Time) BETWEEN 12 AND 15 THEN 'Afternoon'
    ELSE 'Evening'
  END;

