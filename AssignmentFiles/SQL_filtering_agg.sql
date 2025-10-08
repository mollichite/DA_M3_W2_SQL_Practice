-- ==================================
-- FILTERS & AGGREGATION
-- ==================================

USE coffeeshop_db;


-- Q1) Compute total items per order.
--     Return (order_id, total_items) from order_items.
SELECT order_id, COUNT(*) AS total_items
FROM order_items
Group by order_id;

-- Q2) Compute total items per order for PAID orders only.
--     Return (order_id, total_items). Hint: order_id IN (SELECT ... FROM orders WHERE status='paid').
SELECT order_id, COUNT(*) AS total_items
FROM order_items
WHERE 
	order_id IN (
    SELECT order_id 
    FROM orders 
    WHERE status = 'paid'
    ) 
group by order_id; 

-- Q3) How many orders were placed per day (all statuses)?
--     Return (order_date, orders_count) from orders.
select Date(order_datetime) AS order_date, COUNT(*) AS orders_count
From orders
group by DATE(order_datetime)
order by order_date;

-- Q4) What is the average number of items per PAID order?
--     Use a subquery or CTE over order_items filtered by order_id IN (...).
SELECT 
  AVG(total_items) AS avg_items_per_paid_order
FROM 
  (SELECT 
    oi.order_id,
    COUNT(*) AS total_items
  FROM 
    order_items oi
  JOIN 
    orders o ON oi.order_id = o.order_id
  WHERE 
    o.status = 'paid'
  GROUP BY 
    oi.order_id)
AS paid_order_counts;
-- Q5) Which products (by product_id) have sold the most units overall across all stores?
--     Return (product_id, total_units), sorted desc.
SELECT product_id, SUM(quantity) AS total_units
FROM order_items
Group by product_id
order by total_units desc;
-- Q6) Among PAID orders only, which product_ids have the most units sold?
--     Return (product_id, total_units_paid), sorted desc.
--     Hint: order_id IN (SELECT order_id FROM orders WHERE status='paid').
SELECT product_id, SUM(quantity) AS total_units
FROM order_items
WHERE
	order_id IN(
    SELECT order_id 
    FROM orders 
    WHERE status='paid')
Group by product_id
Order by total_units DESC; 
-- Q7) For each store, how many UNIQUE customers have placed a PAID order?
--     Return (store_id, unique_customers) using only the orders table.
select store_id, count(distinct customer_id) as unique_customers
From orders
where status = 'PAID'
Group by store_id;
-- Q8) Which day of week has the highest number of PAID orders?
--     Return (day_name, orders_count). Hint: DAYNAME(order_datetime). Return ties if any.
select 
	dayname(order_datetime) as day_name, 
	count(status) as orders_count
From orders
where status = 'PAID'
Group by day_name, orders_count; 

-- Q9) Show the calendar days whose total orders (any status) exceed 3.
--     Use HAVING. Return (order_date, orders_count).
SELECT 
	DATE(order_datetime) as order_date, 
    COUNT(order_id) as orders_count
FROM orders
group by DATE(order_datetime)
HAVING COUNT(*) > 3;
-- Q10) Per store, list payment_method and the number of PAID orders.
--      Return (store_id, payment_method, paid_orders_count).
SELECT 
	store_id, payment_method, COUNT(*) as paid_orders_count
FROM orders
Where status = 'PAID'
group by store_id, payment_method;

-- Q11) Among PAID orders, what percent used 'app' as the payment_method?
--      Return a single row with pct_app_paid_orders (0–100).
SELECT
	Round( 100* SUM(CASE WHEN payment_method = 'app' THEN 1 ELSE 0 END)
    / COUNT(*), 2) AS pct_app_paid_orders 
FROM orders
Where status = 'PAID';

	
-- Q12) Busiest hour: for PAID orders, show (hour_of_day, orders_count) sorted desc.


-- ================
