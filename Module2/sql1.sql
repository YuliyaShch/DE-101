-- 1. Overview
select round(sum(sales),0) total_sales 
, round(sum(profit),0) total_profit
, round(((sum(profit)/sum(sales))*100),2) as profit_ratio
, round((sum(profit)/count(distinct order_id)),2) as profit_per_order
, round((sum(sales)/count(distinct customer_id )),2) as sales_per_customer
, round(avg(discount),2) as avg_discount
from orders;

select 
segment
, round(sum(sales),0) total_sales
, date_trunc('month', order_date)
from orders
group by segment, date_trunc('month', order_date)
order by segment, date_trunc('month', order_date) asc ;

select 
category 
, round(sum(sales),0) total_sales
, date_trunc('month', order_date)
from orders
group by category, date_trunc('month', order_date)
order by category, date_trunc('month', order_date) asc;

-- 2. Product Metrics
-- Sales by Product Category over time
select category
, round(sum(sales),0) total_sales
, round(sum(profit),0) total_profit
, order_date 
from orders
group by category, order_date
order by category, order_date ;

-- 3. Customer Analysis
-- 3.1 Sales by Category/SubCategory
select category
, subcategory
, round(sum(sales),0) total_sales
from orders o2 
group by category, subcategory
order by category, subcategory;

-- 3.2 Sales by Segment
select category
, segment 
, round(sum(sales),0) total_sales
from orders o2 
group by category, segment 
order by category, segment ;

-- 3.3 Percentage of Sales by Region
select region
, round(sum(sales)*100.0/sum(sum(sales)) over(),1) as percentage
from orders 
group by region;

-- 3.4 Percentage of Returns
-- !!! 
select r.returned
, round(count(o.order_id)*100.0/sum(count(o.order_id)) over(),1) as percentage
from orders o left join returns r 
on o.order_id=r.order_id 
group by returned;  -- поменять нулл на НЕТ


-- 3.5 Salesmen
select p.person
, o.region
, round(sum(o.sales),0) total_sales
, round(sum(o.profit),0) total_profit
from orders o left join people p 
on o.region=p.region 
group by p.person, o.region
order by total_sales desc , total_profit desc 

show datestyle;
SET datestyle = "ISO, MDY";





