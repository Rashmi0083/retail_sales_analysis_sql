--SQL Retail Sales Analysis
create database retail_db;
DROP TABLE IF EXISTS retail_sales ;

CREATE TABLE retail_sales
(
	transactions_id INT PRIMARY KEY,
	sale_date	DATE,
	sale_time	TIME,
	customer_id INT,	
	gender VARCHAR(15),	
	age INT,
	category VARCHAR(15) ,
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,	
	total_sale FLOAT
)

SELECT * from retail_sales;

Select count(*) from retail_sales ;

Select * from retail_sales
where 
	transactions_id	is null or
	sale_date is null or
	sale_time is null or
	customer_id	is null or
	gender	is null or
	age	is null or
	category is null or	
	quantity is null or	
	price_per_unit is null or
	cogs is null or
	total_sale is null ;

DELETE from retail_sales
where 
    transactions_id	is null 
	or
	sale_date is null 
	or
	sale_time is null 
	or
	customer_id	is null 
	or
	gender	is null 
	or
	age	is null 
	or
	category is null 
	or	
	quantity is null 
	or	
	price_per_unit is null 
	or
	cogs is null 
	or
	total_sale is null ;

SELECT COUNT(*) FROM retail_sales;

--Data Exploration

-- How many sales do we have
select count(*) from retail_sales;

-- How many customers we have
select count(distinct customer_id) from retail_sales

-- unique category
SELECT Distinct category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * from retail_sales
where sale_date = '2022-11-05' ;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * from retail_sales
	where category = 'Clothing'
	and 
	to_char(sale_date,'yyyy-mm') = '2022-11'
    and
	Quantity >= 4


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category , sum(total_sale) as Total_Sales from retail_sales
group by category
	;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select category ,Round( AVG(age), 2) as AVG_AGE from retail_sales 
	where category = 'Beauty'
group by category


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from retail_Sales
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select category ,count(*), gender from retail_sales
group by category , gender
order by category asc


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

with cte as
(	
    Select Extract (Year from sale_date) ,Extract(Month from sale_date) AS MONTH , avg(total_sale) as AVG_SALES ,
	rank() over (partition by Extract(Year from sale_date) order by avg(total_sale) desc ) as rn from retail_sales
	group by Extract (Year from sale_date) ,Extract(Month from sale_date)
)

select * from cte where rn = 1 ;	

	
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

, sum(total_sale) as total_sales 

select  customer_id, sum(total_sale) as total_sales from retail_sales
group by customer_id
order by total_sales desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) from retail_sales 
	group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, 
--Afternoon Between 12 & 17, Evening >17)

with cte as (
	Select *,
	case 
	when extract (hour from sale_time) <= 12 then 'Morning'
	when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end as shift 
	from retail_sales
)

select shift, count(*) from cte 
group by shift

--End of project
