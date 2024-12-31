-- CREATE SCHEMA dannys_diner01;
-- USE dannys_diner01;

-- CREATE TABLE sales (
--   `customer_id` VARCHAR(1),
--   `order_date` DATE,
--   `product_id` INT
-- );

-- INSERT INTO sales (`customer_id`, `order_date`, `product_id`)
-- VALUES
--   ('A', '2021-01-01', 1),
--   ('A', '2021-01-01', 2),
--   ('A', '2021-01-07', 2),
--   ('A', '2021-01-10', 3),
--   ('A', '2021-01-11', 3),
--   ('A', '2021-01-11', 3),
--   ('B', '2021-01-01', 2),
--   ('B', '2021-01-02', 2),
--   ('B', '2021-01-04', 1),
--   ('B', '2021-01-11', 1),
--   ('B', '2021-01-16', 3),
--   ('B', '2021-02-01', 3),
--   ('C', '2021-01-01', 3),
--   ('C', '2021-01-01', 3),
--   ('C', '2021-01-07', 3);

-- CREATE TABLE menu (
--   `product_id` INT,
--   `product_name` VARCHAR(5),
--   `price` INT
-- );

-- INSERT INTO menu (`product_id`, `product_name`, `price`)
-- VALUES
--   (1, 'sushi', 10),
--   (2, 'curry', 15),
--   (3, 'ramen', 12);

-- CREATE TABLE members (
--   `customer_id` VARCHAR(1),
--   `join_date` DATE
-- );

-- INSERT INTO members (`customer_id`, `join_date`)
-- VALUES
--   ('A', '2021-01-07'),
--   ('B', '2021-01-09');

-- Data ingestion 
use dannys_diner;
Show tables;

-- Question: What is the total amount each customer spent at the restaurant?
-- Ans
SELECT customer_id,sum(price) FROM menu as m
Left join sales as s on m.product_id =s.product_id
Group by customer_id Order by 1;


-- Question: How many days has each customer visited the restaurant?
-- Ans

SELECT Customer_id, count(distinct Order_date) as visit 
From sales
group by 1 order by 1;


-- Question: 3. What was the first item from the menu purchased by each customer ?
-- Ans 

With First_product as (
SELECT customer_id, order_date, product_id , 
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS rank_01
From sales
)

SELECT  customer_id, b.product_name FROM First_product as a 
left Join menu as b on a.product_id=b.product_id
where rank_01=1;

-- Question: What is the most purchased item on the menu and
-- how many times was it purchased by all customers?
-- ans 
SELECT  product_name , count(*) as time_purchase
From sales as a left join 
menu as b on a.product_id=b.product_id
group by 1;

-- Question :Which item was the most popular for each customer?
-- ans 


SELECT * FROM (
SELECT customer_id,product_name	, Count(sales.product_id) as most_order, dense_rank () over (
partition by customer_id order by  Count(sales.product_id)  desc) as rankk
From sales
Left join menu on sales.product_id=menu.product_id
Group by 1,2) as sub_query
where rankk=1;

-- Question:Which item was purchased first by the customer after they became a member?
-- ans 
With cte as (
SELECT customer_id, product_id,min(diff), dense_rank() 
over(  partition by customer_id order by min(diff) asc) as rankk
 FRom (
SELECT m.customer_id,s.product_id,order_date-join_date as diff  FROM members as m left JOin Sales as s 
on m.customer_id=s.customer_id 
where order_date-join_date>=0 ) as sub_query
Group by 1,2)

SELECT customer_id,product_name FROM cte as a left join menu as b  on a.product_id=b.product_id
where rankk=1
 ;

-- Question: What is the total items and
-- amount spent for each member before they became a member?
-- Ans 

select a.customer_id, Count(c.product_id) as No_of_purchase_product ,sum(c.price) as total_spend From members as a 
left Join sales as b  on a.customer_id=b.customer_id 
left Join menu as c on b.product_id=c.product_id
where  a.join_date>b.order_date
Group by 1;



-- Question: If each $1 spent equates to 10 points and sushi 
-- has a 2x points multiplier - how many points would each customer have?
-- ans 

SELECT 
     customer_id,
     SUM(CASE
         WHEN s.product_id = 1 THEN price * 20
         ELSE price * 10
         END) AS total_points
  FROM
     sales s,
     menu m
  WHERE
     m.product_id = s.product_id
  GROUP BY customer_id;
  

  
-- Question: In the first week after a customer joins the program (including their join date)
--  they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?  

-- ans 


SELECT 
    a.customer_id,
    SUM(
        CASE 
            WHEN DATEDIFF(b.order_date, a.join_date) BETWEEN 0 AND 6 THEN c.price * 2
            ELSE c.price
        END
    ) AS total_points
FROM members AS a
LEFT JOIN sales AS b 
    ON a.customer_id = b.customer_id
LEFT JOIN menu AS c 
    ON b.product_id = c.product_id
WHERE b.order_date <= '2021-01-31'  
GROUP BY a.customer_id;
