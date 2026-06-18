create database retail_Sales;
select * from clean_retail_sales;

-- Basic queries
-- 1.	Retrieve the first 10 transactions from the dataset, showing all columns.
select * from clean_retail_sales
limit 10;
-- 2.	Find the total number of transactions in the dataset.
SELECT count(*) as Total_Transaction FROM clean_retail_sales;
-- 3.	List all unique product categories available in the sales data.
SELECT distinct category FROM clean_retail_sales
order by category;
-- 4.	Find the total sales amount (total_sale) for all transactions.
SELECT sum(total_sale) as total_sales_amount FROM clean_retail_sales;
-- 5.	Find the average age of customers who made purchases.
SELECT round(avg(age),2) as avg_age FROM clean_retail_sales
where age is not null;

-- Filtering & Conditions

-- 6.	Find all sales made by Female customers in the Clothing category.
SELECT * FROM clean_retail_sales
where gender = "Female" and  category='clothing';

-- 7.	Find transactions where quantity is greater than 3 and category is Electronics.
SELECT * FROM clean_retail_sales
WHERE quantity>3 AND category ='electronics';

-- 8.	Find sales that happened in the year 2023.
SELECT * FROM clean_retail_sales
WHERE extract(year from sale_date)='2023';#or where sale_date like '2023%' or where year(sale_date)=2023

-- 9.	Find transactions where price_per_unit is greater than 400.
SELECT * FROM clean_retail_sales
WHERE price_per_unit >400;

-- 10.	Find customers who are older than 60 years and bought Beauty products.
SELECT * FROM clean_retail_sales
WHERE age > 60 AND category ='beauty';

-- Aggregation & Grouping

-- 11.	Find total sales (total_sale) by category (Clothing, Electronics, Beauty).
SELECT category,sum(total_sale) AS total_sales FROM clean_retail_sales
GROUP BY category
ORDER BY total_sales desc;

-- 12.	Find total sales by gender (Male vs Female).
SELECT gender,sum(total_Sale) AS total_sales FROM clean_retail_sales
GROUP BY gender;

-- 13.	Find the average price_per_unit for each category.
SELECT category,round(avg(price_per_unit),2) as avg_ppu FROM clean_retail_sales
GROUP BY category
order by avg_ppu desc;

-- 14.	Find the number of transactions per month (use sale_date).
SELECT extract(month from sale_date) AS per_month ,count(*) as number_of_transaction FROM clean_retail_sales
GROUP BY extract(month from sale_date) 
ORDER BY 1;# this give over all months for every year(2022,2023,2024)
#or
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    COUNT(*) AS transaction_count
FROM clean_retail_sales
GROUP BY month
ORDER BY month;

-- 15.	Find the top 5 highest total sale transactions.
SELECT transactions_id,sale_date,customer_id,category,total_sale as total FROM clean_retail_sales
order by 5 desc
limit 5;


-- Advanced Analysis
-- 16.	Find the total COGS (cogs) and total profit (total_sale - cogs) for the entire dataset.
SELECT round(sum(cogs),2)  AS total_cogs,sum(total_sale) as Total_Sale,
round(sum(total_sale - cogs),2) as total_profit
 FROM clean_retail_sales;
 
-- 17.	Find monthly total sales for the year 2023, sorted by month.
SELECT extract(year from sale_date)as Yr,extract(month FROM sale_date) as Total_sales_month,sum(total_sale) AS Total_Sale FROM clean_retail_sales
WHERE sale_date LIKE '2023%'
GROUP BY 1,2
ORDER BY  2;

-- 18.	Find the category with the highest average quantity sold.
SELECT category,round(avg(quantity),2) as avg_quantity FROM clean_retail_sales
GROUP BY category
ORDER BY avg_quantity DESC
LIMIT 1;

-- 19.	Find customers who made more than one purchase (group by customer_id).
SELECT customer_id,count(*) AS number_of_purchase ,sum(total_sale) AS total_amount_spend FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING count(*)>1
ORDER BY number_of_purchase DESC, total_amount_spend DESC;

-- 20.	Find the total sales for each gender in each category (use GROUP BY gender, category).
SELECT gender,category,sum(total_Sale) AS Total_Sale FROM clean_retail_sales
WHERE gender IS NOT NULL AND category IS NOT NULL
GROUP BY gender,category;


-- Date & Time Related
-- 21.	Find sales that happened between 10:00 AM and 2:00 PM.
SELECT *
FROM clean_retail_sales
WHERE sale_time BETWEEN '10:00:00' AND '14:00:00'
ORDER BY sale_time;
-- 22.	Find the number of sales per day of the week (use DAYNAME(sale_date) if supported).
SELECT 
    DAYNAME(sale_date) AS day_of_week,
    COUNT(*) AS number_of_sales
FROM clean_retail_sales
GROUP BY DAYNAME(sale_date)
ORDER BY 
    CASE day_of_week
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;
    
-- 23.	Find the best-selling day (day with highest total sales).
SELECT sum(total_sale) as total_sales,dayname(sale_date) as day_name FROM clean_retail_sales
GROUP BY 2
ORDER BY total_Sales desc
LIMIT 1;
-- 24.	Find year-wise total sales (2022 vs 2023).
SELECT sum(total_sale) as Total_Sales,year(sale_date) as sale_Dates FROM clean_retail_sales
group by 2;

-- Complex / Multi-step
-- 25.	Find the customer_id with the highest total spending (SUM(total_sale)).
SELECT customer_id,sum(total_sale) AS Total_Sale FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY Total_sale desc
limit 1;

-- 26.	Find the most profitable category (highest SUM(total_sale - cogs)).
SELECT category,round(sum(total_sale-cogs),0) as highest_value FROM clean_retail_sales
WHERE category IS NOT NULL
GROUP BY category
ORDER BY highest_value DESC
LIMIT 1;

-- 27.	Rank categories by total revenue using RANK() or ROW_NUMBER().
SELECT category,sum(total_sale) AS Total_revenue,
RANK() OVER (ORDER BY sum(total_sale) DESC ) 
	AS Revenue_ranks FROM clean_retail_sales
GROUP BY category
ORDER BY Revenue_ranks;


-- 28.	Find transactions where total_sale is higher than the average total sale.
SELECT * FROM clean_retail_sales where total_sale>(SELECT avg(total_sale ) FROM  clean_retail_sales) 
ORDER BY total_sale DESC;

-- 29.	Find the percentage of total sales contributed by each category.
SELECT category,sum(total_sale) as category_sale,
round((sum(total_sale) *100.0/(SELECT sum(total_Sale) FROM clean_retail_sales)),2) AS percentage
 FROM clean_retail_sales
 WHERE category IS NOT NULL
 GROUP BY category
 ORDER BY category_sale DESC;
 
 

-- 30.	Identify high-value customers: Customers who spent more than $2000 in total
SELECT count(*) AS total_high_transaction FROM(
SELECT customer_id,
sum(total_sale) AS total_Sales
FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING sum(total_sale)>2000
ORDER BY total_sales DESC) AS high_Value_customers;# this give the total number 

#this will give the people list SELECT 
 select 
 customer_id,
    COUNT(*) AS number_of_transactions,
    SUM(total_sale) AS total_spending
FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING SUM(total_sale) > 2000
ORDER BY total_spending DESC;


