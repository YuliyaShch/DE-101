-- 1. Overview
SELECT round(sum(sales),0) total_sales 
, round(sum(profit),0) total_profit
, round(((sum(profit)/SUM(sales))*100),2) AS profit_ratio
, round((sum(profit)/COUNT(DISTINCT order_id)),2) AS profit_per_order
, round((sum(sales)/COUNT(DISTINCT customer_id )),2) AS sales_per_customer
, round(avg(discount),2) AS avg_discount
FROM orders;

SELECT segment
, round(sum(sales),0) total_sales
, date_trunc('month', order_date) AS month
FROM orders
GROUP BY segment, date_trunc('month', order_date)
ORDER BY segment, date_trunc('month', order_date) ASC ;

SELECT category 
, round(sum(sales),0) total_sales
, date_trunc('month', order_date) AS month
FROM orders
GROUP BY category, date_trunc('month', order_date)
ORDER BY category, date_trunc('month', order_date) ASC;

-- 2. Product Metrics
-- Sales by Product Category over time
SELECT category
, round(sum(sales),0) total_sales
, round(sum(profit),0) total_profit
, order_date 
FROM orders
GROUP BY category, order_date
ORDER BY category, order_date ;

-- 3. Customer Analysis
-- 3.1 Sales by Category/SubCategory
SELECT category
, subcategory
, round(sum(sales),0) total_sales
FROM orders o2 
GROUP BY category, subcategory
ORDER BY category, subcategory;

-- 3.2 Sales by Segment
SELECT category
, segment 
, round(sum(sales),0) total_sales
FROM orders o2 
GROUP BY category, segment 
ORDER BY category, segment ;

-- 3.3 Percentage of Sales by Region
SELECT region
, round(sum(sales)*100.0/sum(sum(sales)) over(),1) AS percentage
FROM orders 
GROUP BY  region;

-- 3.4 Percentage of Returns
SELECT 
coalesce (r.returned, 'No') as returned 
, round(COUNT(DISTINCT o.order_id)*100.0/sum(COUNT(DISTINCT o.order_id)) over(),1) AS percentage
FROM orders o left JOIN returns r 
ON o.order_id=r.order_id 
GROUP BY returned; 


-- 3.5 Salesmen
SELECT p.person
, o.region
, round(sum(o.sales),0) total_sales
, round(sum(o.profit),0) total_profit
FROM orders o left JOIN people p 
ON o.region=p.region 
GROUP BY p.person, o.region
ORDER BY total_sales DESC , total_profit DESC 

show datestyle;
SET datestyle = "ISO, MDY";





