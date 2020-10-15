-- create dimensional table for shipping
CREATE TABLE "shipping_dim"
(
 "ship_id"   serial NOT NULL,
 "ship_mode" varchar(14) NOT NULL,
 CONSTRAINT "PK_shipping_dim" PRIMARY KEY ( "ship_id" )
);
--clean table
TRUNCATE TABLE shipping_dim;
-- insert unique values and generate id
INSERT INTO shipping_dim
SELECT 100+row_number() OVER(), ship_mode FROM (SELECT DISTINCT ship_mode FROM orders) a;
--check data
SELECT * FROM shipping_dim;
