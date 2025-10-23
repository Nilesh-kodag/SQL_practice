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



-- select * FROM orders;
-- with Customer_months as (
-- SELECT customer_id,date_format(order_date,'%y-%m-01') as order_month
-- from orders
-- group by customer_id,date_format(order_date,'%y-%m-01'))

-- select * FROM Customer_months;
-- ,first_month_order as (
-- SELECT customer_id,min(date_format(order_date,'%y-%m-01')) as first_month_order_month
-- from orders
-- group by customer_id)



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


-- select 
-- cm.order_month,
-- count(distinct cm.customer_id) as Unique_customer,
-- count(distinct case when cm.order_month=fmo.first_month_order_month then cm.customer_id end ) as New_customer,
-- count(distinct case when cm.order_month>fmo.first_month_order_month then cm.customer_id end ) as repetative_customer
-- FROM Customer_months as cm 
-- inner Join first_month_order as fmo on cm.customer_id=fmo.customer_id
-- Group by cm.order_month;



-- --- find second highest retail price base on region id 
-- SELECT * FROM (
-- SELECT *,row_number() over(partition by region_id order by Retail_Price desc) as retail_price_rank FROM commodity_db.price_details) as table1
-- where retail_price_rank=2;

-- Questions2 -- Derive Points table for ICC tournament

-- create table icc_world_cup
-- (
-- Team_1 Varchar(20),
-- Team_2 Varchar(20),
-- Winner Varchar(20)
-- );
-- INSERT INTO icc_world_cup values('India','SL','India');
-- INSERT INTO icc_world_cup values('SL','Aus','Aus');
-- INSERT INTO icc_world_cup values('SA','Eng','Eng');
-- INSERT INTO icc_world_cup values('Eng','NZ','NZ');
-- INSERT INTO icc_world_cup values('Aus','India','India');



-- With distinct_team as (
-- select  Team_1 as team_name, count(*) as matches_played from icc_world_cup
-- Group by Team_1
-- union all 
-- select distinct Team_2 as team_name, count(*) as matches_played  from icc_world_cup
-- Group by Team_2 )
-- ,
-- No_of_matches as (
-- select  team_name, sum(matches_played) as no_matches_played from distinct_team
-- Group by team_name)

-- ,No_of_wins as (
-- SELECT Team_Name,no_matches_played, count(Winner) as no_of_wins FROM No_of_matches as a
-- left join icc_world_cup as b on a.team_name=b.Winner
-- Group by Team_Name,no_matches_played)

-- SELECT *,no_matches_played-no_of_wins as No_of_losses FROM No_of_wins;

-- Questions3 -- Scenario based Interviews Question for Product companies
-- create table entries ( 
-- name varchar(20),
-- address varchar(20),
-- email varchar(20),
-- floor int,
-- resources varchar(10));

-- insert into entries 
-- values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
-- ,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')




-- With most_visited_floor as (
-- SELECT Name,floor as most_visited, count(*)   ,row_number() over(partition by name order by count(*) desc) as row_num
--  FROM entries
--  Group by Name,floor)
--  

-- SELECT a.Name,b.total_visit,a.most_visited,b.sting_agg_all FROM most_visited_floor as a
-- Left JOIN (
-- SELECT Name,count(*) as total_visit,  GROUP_CONCAT(resources ORDER BY resources ASC SEPARATOR ', ')as sting_agg_all
--  FROM entries
--  Group by Name
-- )  as b on a.Name=b.Name
-- where row_num=1
--  
--  ;


-- the pareto principle state 80% of work done by 20% of employee



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



-- select * FROM orders;
-- with Customer_months as (
-- SELECT customer_id,date_format(order_date,'%y-%m-01') as order_month
-- from orders
-- group by customer_id,date_format(order_date,'%y-%m-01'))

-- select * FROM Customer_months;
-- ,first_month_order as (
-- SELECT customer_id,min(date_format(order_date,'%y-%m-01')) as first_month_order_month
-- from orders
-- group by customer_id)



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


-- select 
-- cm.order_month,
-- count(distinct cm.customer_id) as Unique_customer,
-- count(distinct case when cm.order_month=fmo.first_month_order_month then cm.customer_id end ) as New_customer,
-- count(distinct case when cm.order_month>fmo.first_month_order_month then cm.customer_id end ) as repetative_customer
-- FROM Customer_months as cm 
-- inner Join first_month_order as fmo on cm.customer_id=fmo.customer_id
-- Group by cm.order_month;



-- --- find second highest retail price base on region id 
-- SELECT * FROM (
-- SELECT *,row_number() over(partition by region_id order by Retail_Price desc) as retail_price_rank FROM commodity_db.price_details) as table1
-- where retail_price_rank=2;

-- Questions2 -- Derive Points table for ICC tournament

-- create table icc_world_cup
-- (
-- Team_1 Varchar(20),
-- Team_2 Varchar(20),
-- Winner Varchar(20)
-- );
-- INSERT INTO icc_world_cup values('India','SL','India');
-- INSERT INTO icc_world_cup values('SL','Aus','Aus');
-- INSERT INTO icc_world_cup values('SA','Eng','Eng');
-- INSERT INTO icc_world_cup values('Eng','NZ','NZ');
-- INSERT INTO icc_world_cup values('Aus','India','India');



-- With distinct_team as (
-- select  Team_1 as team_name, count(*) as matches_played from icc_world_cup
-- Group by Team_1
-- union all 
-- select distinct Team_2 as team_name, count(*) as matches_played  from icc_world_cup
-- Group by Team_2 )
-- ,
-- No_of_matches as (
-- select  team_name, sum(matches_played) as no_matches_played from distinct_team
-- Group by team_name)

-- ,No_of_wins as (
-- SELECT Team_Name,no_matches_played, count(Winner) as no_of_wins FROM No_of_matches as a
-- left join icc_world_cup as b on a.team_name=b.Winner
-- Group by Team_Name,no_matches_played)

-- SELECT *,no_matches_played-no_of_wins as No_of_losses FROM No_of_wins;

-- Questions3 -- Scenario based Interviews Question for Product companies
-- create table entries ( 
-- name varchar(20),
-- address varchar(20),
-- email varchar(20),
-- floor int,
-- resources varchar(10));

-- insert into entries 
-- values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
-- ,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')




-- With most_visited_floor as (
-- SELECT Name,floor as most_visited, count(*)   ,row_number() over(partition by name order by count(*) desc) as row_num
--  FROM entries
--  Group by Name,floor)
--  

-- SELECT a.Name,b.total_visit,a.most_visited,b.sting_agg_all FROM most_visited_floor as a
-- Left JOIN (
-- SELECT Name,count(*) as total_visit,  GROUP_CONCAT(resources ORDER BY resources ASC SEPARATOR ', ')as sting_agg_all
--  FROM entries
--  Group by Name
-- )  as b on a.Name=b.Name
-- where row_num=1
--  
--  ;


-- the pareto principle state 80% of work done by 20% of employee

SHOW VARIABLES LIKE 'local_infile';




LOAD DATA LOCAL INFILE 'C:/Users/lenovo/Desktop/orders.csv'
INTO TABLE orders2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

