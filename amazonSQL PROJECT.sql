-- Kaggle dataset this information was pulled from https://www.kaggle.com/datasets/rohiteng/amazon-sales-dataset/data

-- Checking import status: the original dataset had 100,000 rows but only 50,722 rows were imported. 
SELECT *
FROM amazon_sales_data_project;

-- Checking for duplicates - none found

SELECT OrderID, COUNT(1)
FROM amazon_sales_data_project
GROUP BY OrderID
HAVING COUNT(1) >1;

-- What is the total revenute generated across all orders? 

SELECT SUM(totalamount)
FROM amazon_sales_data_project;

-- How many total orders are in the dataset?

SELECT COUNT(OrderID)
FROM amazon_sales_data_project;

-- What is the average order value? 
-- To many decimal places so I used the ROUND function to bring it to 2 decimals

SELECT ROUND(AVG(totalamount),2)
FROM amazon_sales_data_project;

-- Which product categories generate the most revenue? 
-- Solutions are showing more the 2 decimal places due to the data type for the column being double. 

SELECT DISTINCT(category) AS category, 
		SUM(totalamount) AS total_revenue
FROM amazon_sales_data_project
GROUP BY category;

-- Altering table to solve the double data type. I found that 65 digits was the max that the total could be adjusted to. 

ALTER TABLE amazon_sales_data_project 
	MODIFY TotalAmount DECIMAL (65, 2),
    MODIFY Quantity DECIMAL (65 , 2),
    MODIFY UnitPrice DECIMAL (65, 2);
    
-- Which products have the highest sales volume?

SELECT DISTINCT productid, ProductName, SUM(quantity) AS total_units_sold
FROM amazon_sales_data_project
GROUP BY ProductID, ProductName
ORDER BY SUM(quantity) DESC
LIMIT 10;

-- What are the top 10 best-selling products by revenue?

SELECT productid, productname, SUM(UnitPrice) as total_revenue
FROM amazon_sales_data_project
GROUP BY  productid, productname
ORDER BY total_revenue DESC
LIMIT 10;

-- How many unique customers placed orders?
-- original answer didnt look right,
-- double checked the csv where i received the data from and found that customers made multiple purchases but were given multiple customer id's. Good learning experience to not take data as accurate even with a 10.0 usability. 

SELECT  COUNT(DISTINCT customerid), COUNT(DISTINCT CustomerName)
FROM amazon_sales_data_project;

-- What is the distribution of order statuses (Delivered, Shipped, Pending, Shipped, Cancelled )?

SELECT OrderStatus, COUNT(OrderStatus) AS total_orders
FROM amazon_sales_data_project
GROUP BY orderstatus
ORDER BY total_orders DESC;

-- What percentage of orders were returned?

SELECT 
;
