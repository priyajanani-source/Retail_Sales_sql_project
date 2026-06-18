# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner to Advanced  
**Database**: `retail_Sales`  
**Tool**: MySQL Workbench  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are building a solid foundation in SQL and want to work on a real-world retail dataset.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
3. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
4. **Advanced SQL**: Apply Window Functions, Subqueries, and complex aggregations to solve multi-step problems.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_Sales`.
- **Table Creation**: A table named `clean_retail_sales` is used to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.


### 2. Data Exploration

- **Record Count**: Determine the total number of transactions in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.

```sql
SELECT COUNT(*) AS Total_Transaction FROM clean_retail_sales;

SELECT DISTINCT category FROM clean_retail_sales ORDER BY category;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

**Q1. Retrieve the first 10 transactions from the dataset, showing all columns.**
```sql
SELECT * FROM clean_retail_sales
LIMIT 10;
```

**Q2. Find the total number of transactions in the dataset.**
```sql
SELECT COUNT(*) AS Total_Transaction FROM clean_retail_sales;
```

**Q3. List all unique product categories available in the sales data.**
```sql
SELECT DISTINCT category FROM clean_retail_sales
ORDER BY category;
```

**Q4. Find the total sales amount (total_sale) for all transactions.**
```sql
SELECT SUM(total_sale) AS total_sales_amount FROM clean_retail_sales;
```

**Q5. Find the average age of customers who made purchases.**
```sql
SELECT ROUND(AVG(age), 2) AS avg_age FROM clean_retail_sales
WHERE age IS NOT NULL;
```

**Q6. Find all sales made by Female customers in the Clothing category.**
```sql
SELECT * FROM clean_retail_sales
WHERE gender = 'Female' AND category = 'Clothing';
```

**Q7. Find transactions where quantity is greater than 3 and category is Electronics.**
```sql
SELECT * FROM clean_retail_sales
WHERE quantity > 3 AND category = 'Electronics';
```

**Q8. Find sales that happened in the year 2023.**
```sql
SELECT * FROM clean_retail_sales
WHERE EXTRACT(YEAR FROM sale_date) = '2023';
```

**Q9. Find transactions where price_per_unit is greater than 400.**
```sql
SELECT * FROM clean_retail_sales
WHERE price_per_unit > 400;
```

**Q10. Find customers who are older than 60 years and bought Beauty products.**
```sql
SELECT * FROM clean_retail_sales
WHERE age > 60 AND category = 'Beauty';
```

**Q11. Find total sales (total_sale) by category (Clothing, Electronics, Beauty).**
```sql
SELECT category, SUM(total_sale) AS total_sales FROM clean_retail_sales
GROUP BY category
ORDER BY total_sales DESC;
```

**Q12. Find total sales by gender (Male vs Female).**
```sql
SELECT gender, SUM(total_sale) AS total_sales FROM clean_retail_sales
GROUP BY gender;
```

**Q13. Find the average price_per_unit for each category.**
```sql
SELECT category, ROUND(AVG(price_per_unit), 2) AS avg_ppu FROM clean_retail_sales
GROUP BY category
ORDER BY avg_ppu DESC;
```

**Q14. Find the number of transactions per month (use sale_date).**
```sql
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    COUNT(*) AS transaction_count
FROM clean_retail_sales
GROUP BY month
ORDER BY month;
```

**Q15. Find the top 5 highest total sale transactions.**
```sql
SELECT transactions_id, sale_date, customer_id, category, total_sale AS total 
FROM clean_retail_sales
ORDER BY total DESC
LIMIT 5;
```

**Q16. Find the total COGS and total profit (total_sale - cogs) for the entire dataset.**
```sql
SELECT 
    ROUND(SUM(cogs), 2) AS total_cogs,
    SUM(total_sale) AS Total_Sale,
    ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM clean_retail_sales;
```

**Q17. Find monthly total sales for the year 2023, sorted by month.**
```sql
SELECT 
    EXTRACT(YEAR FROM sale_date) AS Yr,
    EXTRACT(MONTH FROM sale_date) AS Total_sales_month,
    SUM(total_sale) AS Total_Sale 
FROM clean_retail_sales
WHERE sale_date LIKE '2023%'
GROUP BY 1, 2
ORDER BY 2;
```

**Q18. Find the category with the highest average quantity sold.**
```sql
SELECT category, ROUND(AVG(quantity), 2) AS avg_quantity FROM clean_retail_sales
GROUP BY category
ORDER BY avg_quantity DESC
LIMIT 1;
```

**Q19. Find customers who made more than one purchase (group by customer_id).**
```sql
SELECT 
    customer_id,
    COUNT(*) AS number_of_purchase,
    SUM(total_sale) AS total_amount_spend 
FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY number_of_purchase DESC, total_amount_spend DESC;
```

**Q20. Find the total sales for each gender in each category.**
```sql
SELECT gender, category, SUM(total_sale) AS Total_Sale 
FROM clean_retail_sales
WHERE gender IS NOT NULL AND category IS NOT NULL
GROUP BY gender, category;
```

**Q21. Find sales that happened between 10:00 AM and 2:00 PM.**
```sql
SELECT *
FROM clean_retail_sales
WHERE sale_time BETWEEN '10:00:00' AND '14:00:00'
ORDER BY sale_time;
```

**Q22. Find the number of sales per day of the week.**
```sql
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
```

**Q23. Find the best-selling day (day with highest total sales).**
```sql
SELECT SUM(total_sale) AS total_sales, DAYNAME(sale_date) AS day_name 
FROM clean_retail_sales
GROUP BY 2
ORDER BY total_sales DESC
LIMIT 1;
```

**Q24. Find year-wise total sales (2022 vs 2023).**
```sql
SELECT SUM(total_sale) AS Total_Sales, YEAR(sale_date) AS sale_Dates 
FROM clean_retail_sales
GROUP BY 2;
```

**Q25. Find the customer_id with the highest total spending.**
```sql
SELECT customer_id, SUM(total_sale) AS Total_Sale 
FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY Total_Sale DESC
LIMIT 1;
```

**Q26. Find the most profitable category (highest SUM(total_sale - cogs)).**
```sql
SELECT category, ROUND(SUM(total_sale - cogs), 0) AS highest_value 
FROM clean_retail_sales
WHERE category IS NOT NULL
GROUP BY category
ORDER BY highest_value DESC
LIMIT 1;
```

**Q27. Rank categories by total revenue using RANK().**
```sql
SELECT 
    category,
    SUM(total_sale) AS Total_revenue,
    RANK() OVER (ORDER BY SUM(total_sale) DESC) AS Revenue_ranks 
FROM clean_retail_sales
GROUP BY category
ORDER BY Revenue_ranks;
```

**Q28. Find transactions where total_sale is higher than the average total sale.**
```sql
SELECT * FROM clean_retail_sales 
WHERE total_sale > (SELECT AVG(total_sale) FROM clean_retail_sales)
ORDER BY total_sale DESC;
```

**Q29. Find the percentage of total sales contributed by each category.**
```sql
SELECT 
    category,
    SUM(total_sale) AS category_sale,
    ROUND((SUM(total_sale) * 100.0 / (SELECT SUM(total_sale) FROM clean_retail_sales)), 2) AS percentage
FROM clean_retail_sales
WHERE category IS NOT NULL
GROUP BY category
ORDER BY category_sale DESC;
```

**Q30. Identify high-value customers: Customers who spent more than $2000 in total.**
```sql
SELECT 
    customer_id,
    COUNT(*) AS number_of_transactions,
    SUM(total_sale) AS total_spending
FROM clean_retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING SUM(total_sale) > 2000
ORDER BY total_spending DESC;
```

## Findings

- **Total Transactions**: 2,000 transactions recorded between January 2022 and December 2023.
- **Top Category by Revenue**: Electronics leads with $313,810 in total sales, followed by Clothing ($311,070) and Beauty ($286,840).
- **Gender Sales**: Female customers contributed slightly more ($465,400) compared to Male customers ($446,320).
- **Most Profitable Category**: Clothing has the highest total profit at $246,679.
- **Customer Insights**: 155 unique customers were identified, with several high-value customers spending more than $2,000 in total.
- **Age Range**: Customers range from 18 to 64 years old with an average age of 41.

## Reports

- **Sales Summary**: Total sales, COGS, and profit breakdown across all categories.
- **Trend Analysis**: Monthly and yearly sales trends for 2022 and 2023.
- **Customer Insights**: Top spending customers and high-value customer identification.
- **Time Analysis**: Sales patterns by day of week and time of day.

## Conclusion

This project serves as a comprehensive SQL analysis of retail sales data, covering database setup, exploratory data analysis, and business-driven SQL queries progressing from Basic to Advanced. The findings from this project can help retail businesses make better decisions by understanding sales patterns, customer behaviour, and product performance across categories and time periods.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the setup section in `sql_project_1.sql` to create the database.
3. **Import the Dataset**: Use MySQL Workbench Table Data Import Wizard to load `clean_retail_sales.csv`.
4. **Run the Queries**: Use the SQL queries provided in `sql_project_1.sql` to perform your analysis.
5. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Priya Janani

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/priya-janani-krishnamoorthy-saravanapriya-40795535a)


Thank you for your support, and I look forward to connecting with you!
