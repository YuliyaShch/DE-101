-- create dimensional table for products_dim
CREATE TABLE "products_dim"
( "p_id"       int NOT NULL,
 "product_id"  varchar(15) NOT NULL,
 "product_name"varchar(127) NOT NULL,
 "category"    varchar(15) NOT NULL,
 "subcategory" varchar(11) NOT NULL,
 "segment"     varchar(11) NOT NULL,
 CONSTRAINT "PK_products_dim" PRIMARY KEY ( "p_id" )
);
--clean table
drop table products_dim;
-- insert unique values and generate id
INSERT INTO products_dim
SELECT 100+row_number() OVER() as p_id, product_id, product_name, category, subcategory, segment FROM 
(SELECT DISTINCT product_id, product_name, category, subcategory, segment FROM orders) d;
--check data
SELECT * FROM products_dim;
