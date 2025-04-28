create database walmart;
use walmart ;
create table walmart_sales(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT
);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------Feature Engineering---------------------------------------------------------------------------------------
-- ---------------time_of_day---
alter table walmart_sales
add column time_of_day varchar(20);
update walmart_sales
set time_of_day = (case 
when time between 	"00:00:00" and "12:00:00" then "Morning"
when time between 	"12:01:00" and "16:00:00" then "Afternoon"
else "Evening "
end 
);
-- ------------------------- day_name_column

alter table walmart_sales
add column day_name_column varchar(20);
update walmart_sales
set day_name_column = dayname(date);
-- -----------------------------------------month_name_column

alter table walmart_sales
add column month_name_column varchar(20);
update walmart_sales
set month_name_column = monthname(date);
-- ------ -----------------------------------------------------------------------------------------------------------------------------------------------
--------- --------------------------------------------------Generic--------------------------------------------------------------------------------------
-- ------- How many unique cities does the data have?

select distinct city
from walmart_sales;
-- -------- In which city is each branch?

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
select distinct product_line
from walmart_sales;

-- What is the most selling product line
select sum(quantity) As qty,
product_line
from walmart_sales
group by product_line
order by qty desc;
-- What is the total revenue by month
select month_name_column,
sum(total) as total_revenue
from walmart_sales
group by month_name_column
order by total_revenue desc;

-- What month had the largest COGS?
select month_name_column, sum(cogs) as cogs
from walmart_sales
group by month_name_column 
order by cogs desc;

-- What is the city with the largest revenue?
select city, sum(total) as total_revenue
from walmart_sales
group by city
order by total_revenue desc;

-- What product line had the largest VAT?
select product_line, sum(tax_pct) As VAT
from walmart_sales
group by product_line
order by VAT desc;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales
select product_line,avg(quantity) as avg_qty,
case
when avg(quantity)>(select avg(quantity) from walmart_sales) then "Good"
Else "Bad"
End As Remark
From walmart_sales
Group by product_line;

-- Which branch sold more products than average product sold?
Select branch, sum(quantity) As Total_qnty 
from walmart_sales
group by branch
having sum(quantity)>(select avg (Total_qnty)
from (Select branch, sum(quantity) As Total_qnty 
from walmart_sales
group by branch)
As Branch_total
);

-- What is the most common product line by gender
Select gender, product_line,
count(gender) as total_count
from walmart_sales
group by gender, product_line
order by total_count  desc;

-- What is the average rating of each product line
select product_line, round(avg(rating),2) as avg_rating
from walmart_sales
group by product_line
order by avg_rating desc;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------
-- How many unique customer types does the data have?
select distinct customer_type
from walmart_sales;

-- How many unique payment methods does the data have?
select distinct payment
from walmart_sales;

-- What is the most common customer type?
select customer_type, count(*) As total_count 
from walmart_sales
group by customer_type
order by total_count desc;

-- Which customer type buys the most?
select customer_type, sum(quantity) as total_qnty
from walmart_sales
group by customer_type
order by total_qnty desc
limit 1;

-- What is the gender of most of the customers?
Select  gender,count(*) as gender_count
from walmart_sales
group by gender
order by gender_count desc
limit 1;

-- What is the gender distribution per branch?
select branch, gender, count(*) as total_count 
from walmart_sales
group by  branch, gender
order by branch;

-- Which time of the day do customers shop most?
select time_of_day,count(*) As total_count
from walmart_sales
group by time_of_day
order by total_count desc
limit 1
;

-- Which day fo the week has the best avg ratings?
select day_name_column, round(avg(rating),2) as avg_rating
from walmart_sales
group by day_name_column
order by avg_rating desc
limit 1;

-- Which day of the week has the best average ratings per branch?
SELECT branch, day_name_column, avg_rating
FROM (
    SELECT 
        branch,
        day_name_column,
        ROUND(AVG(rating), 2) AS avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank_per_branch
    FROM walmart_sales
    GROUP BY branch, day_name_column
) AS ranked_days
WHERE rank_per_branch = 1
ORDER BY branch, avg_rating DESC;

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------
-- Number of sales made in each time of the day per weekday 
    SELECT
    day_name_column,
    COUNT(CASE WHEN time_of_day = 'Morning' THEN 1 END) AS Morning_Sales,
    COUNT(CASE WHEN time_of_day = 'Afternoon' THEN 1 END) AS Afternoon_Sales,
    COUNT(CASE WHEN time_of_day = 'Evening' THEN 1 END) AS Evening_Sales
FROM walmart_sales
GROUP BY day_name_column
ORDER BY FIELD(day_name_column, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, max(tax_pct)As max_tax
from walmart_sales
group by city
order by max_tax
limit 1;

-- Which customer type pays the most in VAT?
select customer_type, round(sum(tax_pct),2) as total_tax
from walmart_sales
group by customer_type
order by total_tax desc
limit 1;


