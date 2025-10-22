SELECT * FROM commodity_db.price_details;
---- filter sales for  6 months

With avai_6_month_sales as (
SELECT *
FROM commodity_db.price_details
WHERE date BETWEEN DATE_ADD((SELECT MAX(date) FROM commodity_db.price_details), INTERVAL -6 MONTH)
              AND (SELECT MAX(date) FROM commodity_db.price_details))
,region_partition as (              
SELECT *, dense_rank() over(partition by Region_Id order by retail_price desc) as region_partition  FROM avai_6_month_sales )
SELECT * FROM region_partition 
where region_partition=3
 ;
 
 
 
SELECT DATE_FORMAT("2025-09-24", "%W");

 
 
 -- date_add 
 --  date_sub
-- SELECT  
--   DATE_add(CURDATE(),INTERVAL 30 DAY)
  
 --  SELECT DAYNAME(CURDATE());
--   SELECT  
--   DATE_add(CURDATE(),INTERVAL 30 DAY)
--   
--   SELECT CURDATE()
-- SELECT DAYOFMONTH(CURDATE()), MONTH(CURDATE()),Year(CURDATE());








-- getting date range without business days




SELECT *,
DATEDIFF(end_date,start_date) as actual_day, 
(DATE_FORMAT(end_date, '%v')- DATE_FORMAT(start_date, '%v')) as number_of_week_dff,
    DATEDIFF(end_date, start_date) + 1 AS total_days,  -- inclusive day count

  TIMESTAMPDIFF(WEEK, start_date, end_date) AS full_weeks,
  (DATEDIFF(end_date, start_date) + 1)-(TIMESTAMPDIFF(WEEK, start_date, end_date)*2)  - (CASE WHEN DAYOFWEEK(start_date) = 1 THEN 1 ELSE 0 END)  -- start on Sunday
      - (CASE WHEN DAYOFWEEK(end_date) = 7 THEN 1 ELSE 0 END)    -- end on Saturday

 FROM date_ranges;
 
 
 
 SELECT
    id,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) + 1 AS total_days,  -- inclusive day count
    TIMESTAMPDIFF(WEEK, start_date, end_date) AS full_weeks,
    -- Business days = total_days - 2*full_weeks - adjustments
    (DATEDIFF(end_date, start_date) + 1)
      - (TIMESTAMPDIFF(WEEK, start_date, end_date) * 2)
      - (CASE WHEN DAYOFWEEK(start_date) = 1 THEN 1 ELSE 0 END)  -- start on Sunday
      - (CASE WHEN DAYOFWEEK(end_date) = 7 THEN 1 ELSE 0 END)    -- end on Saturday
      
      AS business_days,(TIMESTAMPDIFF(WEEK, start_date, end_date) * 2),CASE WHEN DAYOFWEEK(start_date) = 1 THEN 1 ELSE 0 END,CASE WHEN DAYOFWEEK(end_date) = 7 THEN 1 ELSE 0 END
FROM date_ranges;


-- SELECT *, datediff(ShippedDate,orderDate)+1 as totalDays,timestampdiff(Week,orderDate,ShippedDate), (case when Dayofweek(orderDate)=1 then 1 else 0 end ),(case when Dayofweek(ShippedDate)=7 then 1 else 0 end ),
--  (datediff(ShippedDate,orderDate)+1) - (2*timestampdiff(Week,orderDate,ShippedDate)) -
--  (case when Dayofweek(orderDate)=1 then 1 else 0 end )
--  -(case when Dayofweek(ShippedDate)=7 then 1 else 0 end ) as business_days 
--  FROM classicmodels.orders;
 
--  
--  CREATE TABLE sales (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     sale_date DATE,
--     amount DECIMAL(10,2)
-- );

-- INSERT INTO sales (sale_date, amount) VALUES
-- ('2025-09-01', 100),
-- ('2025-09-02', 200),
-- ('2025-09-03', 150),
-- ('2025-09-04', 250),
-- ('2025-09-05', 300);

--  
use commodity_db;
with month_year_sum as (
SELECT 
    DATE_FORMAT(date, "%Y-%m") as year_months ,
    MAKEDATE(YEAR(`date`), 1) + INTERVAL (MONTH(`date`) - 1) MONTH AS month_start,
    SUM(Retail_Price) AS total_price
FROM commodity_db.price_details
GROUP BY DATE_FORMAT(date, "%Y-%m"),month_start
ORDER BY DATE_FORMAT(date, "%Y-%m"))


SELECT *, sum(total_price) over( order by year_months Range between interval 2 month preceding and current row) as test  FROM month_year_sum;




\