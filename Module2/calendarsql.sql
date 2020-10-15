-- create dimensional table for calendar
CREATE TABLE "calendar_dim"
(
 "date"     int NOT NULL,
 order_date date not null,
 ship_date date not null,
 "year"     int NOT NULL,
 "quater"   varchar(5) NOT NULL,
 "month"    int NOT NULL,
 "week"     int NOT NULL,
 "week_day" int NOT NULL,
 CONSTRAINT "PK_calendar_dim" PRIMARY KEY ( "date" )
);
--clean table
TRUNCATE TABLE calendar_dim;
-- insert unique values and generate id
INSERT INTO calendar_dim 
SELECT 100+row_number () OVER(), order_date, ship_date, "year", "quarter", "month", "week", "week_day"
FROM (SELECT DISTINCT 
             order_date, 
             ship_date,
             EXTRACT (YEAR FROM order_date) AS "year",
             EXTRACT (quarter FROM order_date) AS "quarter",
             EXTRACT (month FROM order_date) AS "month",
             EXTRACT (week FROM order_date) AS "week",
             EXTRACT (dow FROM order_date) AS "week_day"
             FROM orders 
            ) x;
--check data
SELECT * FROM calendar_dim;