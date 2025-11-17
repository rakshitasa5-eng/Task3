CREATE DATABASE ecommerce; 
USE ecommerce;

SHOW tables;
RENAME TABLE `ecommerce dataset` TO ecommerce_dataset;
SELECT * FROM ecommerce_dataset;

SELECT 
    customer_id,
    first_name,
    last_name,
    email,
    product_id,
    product_name,
    category,
    price,
    order_id,
    order_date,
    total_amount,
    quantity
FROM ecommerce_dataset;

-- All orders with customer info (including unmatched)
SELECT 
    e.customer_id,
    e.first_name,
    e.last_name,
    e.email,
    e.order_id,
    e.product_name,
    e.category,
    e.price,
    e.order_date,
    e.total_amount,
    e.quantity
FROM ecommerce_dataset e
ORDER BY e.customer_id;

-- Total revenue per product
SELECT 
    product_name,
    SUM(total_amount) AS total_revenue
FROM ecommerce_dataset
GROUP BY product_name;	

-- Average quantity per category
WITH customer_totals AS (
    SELECT 
        customer_id,
        first_name,
        last_name,
        SUM(total_amount) AS total_spent
    FROM ecommerce_dataset
    GROUP BY customer_id, first_name, last_name
),
avg_spending AS (
    SELECT AVG(total_spent) AS avg_spent
    FROM customer_totals)
SELECT *
FROM customer_totals
WHERE total_spent > (SELECT avg_spent FROM avg_spending);

-- Total Revenue Per category
SELECT 
    category, SUM(total_amount) AS total_revenue
FROM
    ecommerce_dataset
GROUP BY category; 

-- Highest Spending Coustomer 
SELECT 
    customer_id,
    first_name,
    last_name,
    SUM(total_amount) AS total_spent
FROM
    ecommerce_dataset
GROUP BY customer_id , first_name , last_name
ORDER BY total_spent DESC
LIMIT 3;

-- Average Quantity Per prodect
SELECT 
    product_name, AVG(quantity) AS avg_qty
FROM
    ecommerce_dataset
GROUP BY product_name;

-- Customers Who Bought More Than 2 Item
SELECT 
    customer_id, first_name, last_name, quantity
FROM
    ecommerce_dataset
WHERE
    quantity > 2;
    
-- Top-Selling Product (Highest Quantity)
SELECT 
    product_name, SUM(quantity) AS total_qty
FROM
    ecommerce_dataset
GROUP BY product_name
ORDER BY total_qty DESC
LIMIT 1;





