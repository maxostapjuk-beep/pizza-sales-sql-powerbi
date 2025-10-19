--Total revenue
select round(sum(total_price), 2) as total_revenue
from pizza_sales;

--Average Order Value
select round((sum(total_price) / count(distinct order_id)), 2) as avg_order_value
from pizza_sales;

--Total Orders
select count(distinct order_id) as total_orders
from pizza_sales;

--Average Pizzas Per Order
select cast(cast(sum(quantity) AS DECIMAL (10,2)) / 
cast(count(distinct order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) as avg_pizzas_per_order
from pizza_sales;

--Hourly Trend For Total Orders
select datepart(hour, order_time) as daily_hour, count(distinct order_id) as total_orders
from pizza_sales
group by datepart(hour, order_time)
order by daily_hour;

--Daily Trend For Total Orders (Monthly trend by replacing ‘Day_name’ (‘Month_name’) and ‘dw’ (‘month’))
select datename(dw, order_date) as Day_name, count(distinct order_id) as total_orders
from pizza_sales
group by datename(dw, order_date)
order by total_orders desc;

--Percentage Of Sales By Pizza Size (we also calculated categories by replacing ‘size’ (‘category’))
with temp as 
(select sum(total_price) as sales_per_size, pizza_size
from pizza_sales
group by pizza_size)

select 
pizza_size, 
round(Sales_Per_Size, 2) as Sales_Per_Size, 
round((Sales_Per_Size / (select sum(total_price) from pizza_sales)), 4) * 100 as Sales_Size_Percentage
from temp
order by Sales_Size_Percentage desc;

--Top 5 bestsellers by Revenue, Total Quantity and Total Orders
select top 5
	pizza_name,
	sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

select top 5
	pizza_name,
	sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc;

select top 5
	pizza_name,
	sum(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders  desc;


--Bottom 5 bestsellers by Revenue, Total Quantity and Total Orders
select top 5
	pizza_name,
	round(sum(total_price), 2) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc;

select top 5
	pizza_name,
	sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity asc;

select top 5
	pizza_name,
	sum(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders  asc;

