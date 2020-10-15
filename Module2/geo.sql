-- create dimensional table for geography
CREATE TABLE "geography_dim"
(
 "geo_id"      serial NOT NULL,
 "country"     varchar(13) NOT NULL,
 "city"        varchar(17) NOT NULL,
 "state"       varchar(20) NOT NULL,
 "postal_code" int,
 "region"      varchar(7) NOT NULL,
 CONSTRAINT "PK_geography_dim" PRIMARY KEY ( "geo_id" )
);
--clean table
truncate table geography_dim;
-- insert unique values and generate id
INSERT INTO geography_dim
SELECT 100+row_number() OVER(), country, city, state, postal_code, region FROM 
(SELECT DISTINCT country, city, state, postal_code, region FROM orders) c;
--check data
SELECT * FROM geography_dim;