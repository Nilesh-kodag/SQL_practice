-- Create database test_nilesh_learning;
-- use test_nilesh_learning; 


-- CREATE  TABLE orders (
--     order_id     INT PRIMARY KEY,
--     customer_id  INT,
--     order_date   DATE
-- );
-- INSERT INTO orders (order_id, customer_id, order_date) VALUES
-- (1, 101, '2025-01-05'), -- Jan
-- (2, 102, '2025-01-10'),
-- (3, 103, '2025-01-15'),
-- (4, 101, '2025-02-03'), -- repeat Feb
-- (5, 104, '2025-02-12'),
-- (6, 105, '2025-02-18'),
-- (7, 102, '2025-03-02'), -- repeat Mar
-- (8, 106, '2025-03-10'),
-- (9, 101, '2025-03-15'),
-- (10, 104, '2025-03-20');



select * FROM orders;
with Customer_months as (
SELECT customer_id,date_format(order_date,'%y-%m-01') as order_month
from orders
group by customer_id,date_format(order_date,'%y-%m-01'))

-- select * FROM Customer_months;
,first_month_order as (
SELECT customer_id,min(date_format(order_date,'%y-%m-01')) as first_month_order_month
from orders
group by customer_id)



-- select 
-- *
-- -- cm.order_month,
-- -- count(distinct cm.customer_id) as Unique_customer,
-- -- count(distinct case when cm.order_month=fmo.first_month_order_month then cm.customer_id end ) as New_customer,
-- -- count(distinct case when cm.order_month>fmo.first_month_order_month then cm.customer_id end ) as repetative_customer
-- FROM Customer_months as cm 
-- inner Join first_month_order as fmo on cm.customer_id=fmo.customer_id
-- -- Group by cm.order_month
-- where cm.order_month='25-03-01' ;
-- 101	25-03-01	101	25-01-01
-- 102	25-03-01	102	25-01-01
-- 104	25-03-01	104	25-02-01
-- 106	25-03-01	106	25-03-01


select 
cm.order_month,
count(distinct cm.customer_id) as Unique_customer,
count(distinct case when cm.order_month=fmo.first_month_order_month then cm.customer_id end ) as New_customer,
count(distinct case when cm.order_month>fmo.first_month_order_month then cm.customer_id end ) as repetative_customer
FROM Customer_months as cm 
inner Join first_month_order as fmo on cm.customer_id=fmo.customer_id
Group by cm.order_month;

