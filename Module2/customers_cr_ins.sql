-- create dimensional table for customers
CREATE TABLE "customers_dim"
( c_id int not null,
 "customer_id"    varchar(8) NOT NULL,
 "customer_name" varchar(22) NOT NULL,
 CONSTRAINT "PK_customers_dim" PRIMARY KEY ( "c_id" )
);
--clean table
drop TABLE customers_dim;
-- insert unique values and generate id
INSERT INTO customers_dim
SELECT 100+row_number() OVER(), customer_id, customer_name FROM (SELECT DISTINCT customer_id, customer_name FROM orders) c;
--check data
SELECT * FROM customers_dim;