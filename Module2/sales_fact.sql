-- create fact table for sales
CREATE TABLE "sales_fact"
( "s_id" 		int not null,
 "row_id"       int NOT NULL,
 "order_id"     varchar(14) NOT NULL,
 "sales" 		numeric NOT NULL,
 "quantity" 	int not null,
 "discount" 	numeric,
 "profit"       numeric NOT NULL,
 "date"         int NOT NULL,
 "ship_id"      integer NOT NULL,
 "geo_id"       integer NOT NULL,
 "p_id"         int NOT NULL,
 "c_id"         int NOT NULL,
 CONSTRAINT "PK_sales_fact" PRIMARY KEY ( "s_id" ),
 CONSTRAINT "FK_17" FOREIGN KEY ( "date" ) REFERENCES "calendar_dim" ( "date" ),
 CONSTRAINT "FK_25" FOREIGN KEY ( "geo_id" ) REFERENCES "geography_dim" ( "geo_id" ),
 CONSTRAINT "FK_34" FOREIGN KEY ( "ship_id" ) REFERENCES "shipping_dim" ( "ship_id" ),
 CONSTRAINT "FK_59" FOREIGN KEY ( "p_id" ) REFERENCES "products_dim" ( "p_id" ),
 CONSTRAINT "FK_65" FOREIGN KEY ( "c_id" ) REFERENCES "customers_dim" ( "c_id" )
);


CREATE INDEX "fkIdx_17" ON "sales_fact"
(
 "date"
);

CREATE INDEX "fkIdx_25" ON "sales_fact"
(
 "geo_id"
);

CREATE INDEX "fkIdx_34" ON "sales_fact"
(
 "ship_id"
);

CREATE INDEX "fkIdx_59" ON "sales_fact"
(
 "p_id"
);

CREATE INDEX "fkIdx_65" ON "sales_fact"
(
 "c_id"
);

--clean table
TRUNCATE TABLE sales_fact;

INSERT INTO sales_fact
SELECT 100+row_number() OVER(), row_id, order_id, sales, quantity, discount, profit, c.date, s.ship_id, g.geo_id, p.p_id, cu.c_id FROM 
orders o
INNER JOIN calendar_dim c on o.order_date=c.order_date and o.ship_date =c.ship_date 
INNER JOIN shipping_dim s on o.ship_mode=s.ship_mode 
INNER JOIN geography_dim g on o.country =g.country and o.city =g.city and o.postal_code =g.postal_code  and o.region =g.region and o.state =g.state 
INNER JOIN products_dim p on o.product_id =p.product_id and o.category =p.category  and o.subcategory =p.subcategory and o.segment=p.segment and o.product_name =p.product_name 
INNER JOIN customers_dim cu on o.customer_id =cu.customer_id ;

--check data
SELECT * FROM sales_fact;
