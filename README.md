# 🛒 Walmart Sales Analysis (SQL + Power BI)

This project is a comprehensive sales analysis of Walmart data using **MySQL for data processing** and **Power BI for dashboard visualization**. It answers key business questions around revenue, profit, customer behavior, and product performance.

## 📁 Files in This Repository

| File | Description |
|------|-------------|
| `WalmartSalesData.csv` | Raw sales transaction data |
| `walmart_sales_analysis.sql` | SQL scripts for feature engineering and analysis |
| `Walmart_Sales_Analysis.pbix` | Power BI report file with interactive dashboards |

---

 🧰 Tools Used

- **MySQL** – For data cleaning, transformation, and analysis
- **Power BI** – For dashboard building and visual analytics
- **GitHub** – For version control and portfolio showcasing

---

## 🧠 Key Business Questions Answered

### 📍 General
- How many unique cities are in the data?
- Which branch is located in which city?

### 🛍️ Products
- Which product line is most popular?
- What is the most used payment method?
- Which product lines generate the most revenue and VAT?

### 📈 Sales Analysis
- Revenue trends by month
- Sales volume by time of day and day of week
- Average rating by product line

### 👥 Customer Insights
- Which customer type brings the most revenue?
- Gender distribution per branch
- Which customer type pays the most VAT?

---

## 📐 Feature Engineering

New columns created using SQL:
- `time_of_day` → Morning / Afternoon / Evening
- `day_name` → Day of the week (Mon–Sun)
- `month_name` → Month name (Jan–Dec)
- `gross income`, `VAT`, `total sales`, and `gross margin %`

---

## 📌 How to Run This Project

1. Import `WalmartSalesData.csv` into your MySQL database
2. Run SQL queries from `walmart_sales_analysis.sql`
3. Open `Walmart_Sales_Analysis.pbix` in Power BI Desktop
4. Refresh the dataset and explore the dashboard

---

## 📚 Conclusion

This project demonstrates how SQL and Power BI can be combined to uncover deep business insights from transactional data. It simulates the type of analysis a Data Analyst would perform in a real-world retail setting.

---

