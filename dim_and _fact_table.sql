-- summary  of understanding of fact and dimention table
-- in star schema we use fact and dimention table a lot
	-- fact table: Fact table contain all measurable and numerical data sach as sales, amount,
    -- revenue or number of transaction each row represent individual record
			-- we can indentify fact table easily because these table have all important business measures like revenues, Sales and unit sold
            
    -- Dimention table: This type of table hold descriptive information that provide context to the fact like product detail and 
    -- customer information or time period dimention table are typically demrmalized and include text and field such as name and location
    -- dimention table have information about attributes like time the product sold, product and geography

use learning ;

-- Create basic time dimention table 
create table dim_time(
time_id int primary key,
Date Date,
day_of_week varchar(10),
month int,
quater int,
year int
);

-- create customer table 
Create table dim_customer(
customer_id int primary key,
first_name varchar (50),
last_name varchar (50),
gender varchar (50),
email varchar(50),
contry varchar (50)
);


-- product dimention table 
Create table dim_product (
Product_id  int Primary key,
Product_name varchar (100),
Category varchar (50),
price decimal (10,2)
);

