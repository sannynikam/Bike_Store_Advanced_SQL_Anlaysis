use Bike_Store;

select * from customers;
select * from brands;
select * from categories;
select * from staffs;
select * from orders;
select * from products;
select * from order_items;
select * from stores;
select * from stocks;

-- Q.1 : total number of customers  ?
-- Query :

SELECT count(*) as total_customers
FROM customers;



-- Q.2 : Total number of orders ?
-- Query :

SELECT count(*) as total_orders
FROM Orders;



-- Q.3 : Total number of products ? 
-- Query :

SELECT count(*) as Total_Products
FROM Products;



-- Q.4 : Listing all stores along with theirs cities.
-- Query :

SELECT store_name, city 
FROM Stores;



-- Q.5 : Analyzing all active staff members. 
-- Query :

SELECT  Staff_id, last_name
from staffs 
WHERE active_rate = 1;



-- Q.6 : Analyzing total sales amount.
-- Query :

SELECT sum(quantity * list_price * ( 1 - discount )) as Total_Sales
FROM order_items;



-- Q.7 : Analyzing total orders per store. 

SELECT store_id, count(order_id) as Total_Orders
FROM Orders
GROUP BY store_id;



-- Q.8 : Total sales per store. 
-- Query : 

SELECT O.store_id, sum(oi.quantity * oi.list_price * ( 1 - oi.discount )) as Store_Sales
FROM orders O 
join order_items oi on o.order_id = oi.order_id
GROUP BY o.store_id;



-- Q.9 : Analyzing top 5 customers by total purchase value. 
-- Query :

SELECT c.cust_id,c.first_name, sum(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_money_spent
FROM customers c
join orders o on c.cust_id = c.cust_id
join order_items oi on o.order_id = oi.order_id
GROUP BY c.cust_id, c.first_name
ORDER BY total_money_spent DESC
LIMIT 5;




-- Q.10 : Anlyzing monthly sales trend. 
-- Query :

SELECT month(order_date) as month, 
sum(oi.quantity * oi.list_price * (1 - oi.discount)) as totat_sales
FROM orders o 
join order_items oi on o.order_id = oi.order_id
GROUP BY month(order_date)
ORDER BY month;




-- Q.11 : Finding best selling products by quanitity.
-- Query :

SELECT p.product_name, sum(oi.quantity) as total_quantity
FROM products p 
join order_items oi on p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;



-- Q.12 : Anlyzing Revenue by category. 
-- Query :

SELECT c.category_name, sum(oi.quantity * oi.list_price * ( 1 - oi.discount )) as Revenue
FROM categories c
join products p on c.category_id = p.category_id
join order_items oi on p.product_id = oi.product_id
GROUP BY c.category_name;



-- Q.13 : Analyzing revenue by brand. 
-- Query :

SELECT b.brand_name, sum(t.revenue) as total_revenue
FROM brands b 
join (
       SELECT p.brand_id, oi.quantity * oi.list_price * ( 1 - oi.discount ) as revenue
FROM products p 
join order_items oi on p.product_id = oi.product_id
)
t on b.brand_id = t.brand_id
GROUP BY b.brand_name;



-- Q.14 : Finding stores which have highest revenue. 
-- Query :

SELECT s.store_name, t.store_sales
FROM stores s join 
 (
select o.store_id, sum(oi.quantity * oi.list_price * (1 - oi.discount)) as store_sales
FROM orders o join order_items oi on o.order_id = oi.order_id
GROUP BY o.store_id
) 
t on s.store_id = t.store_id
ORDER BY t.store_sales desc
LIMIT 1;



-- Q.15 : Finding product with low stock. 
-- Query :

SELECT p.product_name, s.quantity
FROM stocks s
join products p on s.product_id = p.product_id
where s.quantity between 0 and 5;




-- Q.16 : Fiding avilable stcok per store. 
-- Query :

SELECT st.store_id, st.store_name,
(
SELECT sum(s.quantity)
FROM stocks s 
WHERE s.store_id = st.store_id
) as total_stock
FROM stores st;



-- Q.17 : Analyzing average orders. 
-- Query :

WITH order_totals as (
SELECT o.order_id, sum(oi.quantity * oi.list_price * (1 - oi.discount )) as order_value
FROM orders o 
join order_items oi on o.order_id = oi.order_id
GROUP BY o.order_id
)
SELECT Round(Avg(order_value), 2) as Avg_order_value
FROM order_totals;



-- Q.18 : Finding customers with more than 5 orders.
-- Query :

SELECT c.cust_id, c.first_name, count(DISTINCT o.order_id) as order_count
FROM customers c
join orders o on c.cust_id = o.customer_id
GROUP BY c.cust_id, c.first_name
HAVING count(DISTINCT o.order_id) > 5;



-- Q.19 : Finding running total sales by date
-- Query :

SELECT o.order_date, sum(oi.quantity * oi.list_price * ( 1 - discount )) as daily_sales,
sum(sum(oi.quantity * oi.list_price * ( 1 - discount )))
OVER ( ORDER BY o.order_date ) as running_total_sales
FROM orders o 
join order_items oi on o.order_id = oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date;



-- Q.20 : Finding highest price product within each category. 
-- Query :

SELECT product_name, category_id, list_price from (
SELECT p.product_name, p.category_id, p.list_price,
ROW_NUMBER() over ( PARTITION BY p.category_id ORDER BY p.list_price desc
) as rn from products p
) t
where rn = 1;



-- Q.21 : Anlyzing customers whose emails ends with "@gmail.com"
-- Query :

SELECT  cust_id, first_name, email
from customers
where email LIKE '%@gmail.com';



-- Q.22 : Finding stores whose street address contain "Road"
-- Query :

SELECT store_name, street
from stores
where street LIKE '%Road%';



-- Q.23 : Fining difference between current and previous order value. 
-- Query :

SELECT o.order_id, sum(oi.quantity * oi.list_price * (1 - oi.discount)) as order_value,
LAG(sum(oi.quantity * oi.list_price * (1 - oi.discount)))
OVER (ORDER BY o.order_id) as previous_order_value
FROM orders o
join order_items oi on o.order_id = oi.order_id
GROUP BY o.order_id;



-- Q.24 : Customers whose email does NOT end with @gmail.com.
-- Query : 

SELECT cust_id, first_name, last_name, email
from customers
where email NOT LIKE '%@gmail.com';



-- Q.25 : Finding differnt types of ending of customers emails.
-- Query :

SELECT DISTINCT SUBSTRING_INDEX(email, '@', -1) AS email_domain
from customers
where email IS NOT NULL;





 
















