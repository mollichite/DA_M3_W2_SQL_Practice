USE coffeeshop_db;

-- =========================================================
-- BASICS PRACTICE
-- Instructions: Answer each prompt by writing a SELECT query
-- directly below it. Keep your work; you'll submit this file.
-- =========================================================

-- Q1) List all products (show product name and price), sorted by price descending.
SELECT name, price from products
order by price desc;
-- Q2) Show all customers who live in the city of 'Lihue'.
select customer_id, city = 'Lihue' from customers;
-- Q3) Return the first 5 orders by earliest order_datetime (order_id, order_datetime).
SELECT order_id, order_datetime from orders
order by order_datetime asc;
-- Q4) Find all products with the word 'Latte' in the name.
SELECT * from products 
where name = 'Latte';
-- Q5) Show distinct payment methods used in the dataset.
select payment_method from orders;
-- Q6) For each store, list its name and city/state (one row per store).
select name, city, state from stores;
-- Q7) From orders, show order_id, status, and a computed column total_items
--     that counts how many items are in each order.
select 
	o.order_id, 
    o.status, 
    COUNT(*) AS total_items 
from 
	orders o
	join order_items oi
	on o.order_id = oi.order_id
group by o.order_id, o.status;

	
-- Q8) Show orders placed on '2025-09-04' (any time that day).
select * FROM orders where DATE(order_datetime) = '2025-09-04';

-- Q9) Return the top 3 most expensive products (price, name).
select price, name from products 
order by price desc
limit 3;
-- Q10) Show customer full names as a single column 'customer_name'
--      in the format "Last, First".
select concat(last_name,' ', first_name) as customer_name
from customers;
