-- ankit bandsal interview questions

-- Quetion 1
-- Complex SQL 2 | find new and repeat customers  

Use test_nilesh_learning;


-- with first_intraction as (
-- select customer_id, min(order_date) as first_intraction from customer_orders
-- Group by customer_id)


-- SELECT co.order_date,
-- sum(Case when co.order_date=fi.first_intraction then 1 else 0 end) as  New_customer,
-- sum( case when co.order_date!=fi.first_intraction then 1 else 0 end) as Repetative_customer
--  FROM customer_orders as co
-- Left Join first_intraction as fi on co.customer_id=fi.customer_id
-- Group by co.order_date;



-- Question 2 
-- Derive Points table for ICC tournament
