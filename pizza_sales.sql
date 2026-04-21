create database pizza_project;
use  pizza_project;

create table pizza_sales(
pizza_id int, order_id int, pizza_name_id varchar(40), quantity int,
order_date date, order_time time, unit_price decimal(10,2),  total_price decimal(10,2),
pizza_size varchar(10), pizza_category varchar(30), pizza_ingredients varchar(160), pizza_name varchar(50));

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pizza_sales_excel_file.csv'
into table pizza_sales
fields terminated by','
enclosed by'"'
lines terminated by '\r\n'
ignore 1 rows;

#problem statement - Total revenue : The sum of the total price of all pizza orders.
#Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders.
#Total Pizzas Sold: The sum of the quantities of all pizzas sold.
#Total Orders: The total number of orders placed.
#Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders


select *from pizza_sales;
select sum(total_price) as total_revenue from pizza_sales;
select sum(total_price)/count(distinct order_id) as average_order_value from pizza_sales;
select sum(quantity) as total_pizza_sold from pizza_sales ;
select count(distinct order_id) as total_orders from pizza_sales;
select sum(total_price) from pizza_sales;
select sum(quantity)/count(distinct order_id) as total_pizza_sold from pizza_sales;

#chart requirements
#1.Daily Trend for Total Orders:
#Create a bar chart that displays the daily trend of total orders over a specific time period. This chart will
#help us identify any patterns or fluctuations in order volumes on a daily basis.

#2.Hourly Trend for Total Orders:
#Create a line chart that illustrates the hourly trend of total orders throughout the day. This chart will allow
#us to identify peak hours or periods of high order activity.

#3.Percentage of Sales by Pizza Category:
#Create a pie chart that shows the distribution of sales across different pizza categories. This chart will
#provide insights into the popularity of various pizza categories and their contribution to overall sales.

#4.Percentage of Sales by Pizza Size:
#Generate a pie chart that represents the percentage of sales attributed to different pizza sizes. This
#chart will help us understand customer preferences for pizza sizes and their impact on sales.

#5.Total Pizzas Sold by Pizza Category:
#Create a funnel chart that presents the total number of pizzas sold for each pizza category. This chart
#will allow us to compare the sales performance of different pizza categories.

#6.Top 5 Best Sellers by Total Pizzas Sold:
#Create a bar chart highlighting the top 5 best-selling pizzas based on the total number of pizzas sold
#This chart will help us identify the most popular pizza options.

#7.Bottom 5 Worst Sellers by Total Pizzas Sold:
#Create a bar chart showcasing the bottom 5 worst-selling pizzas based on the total number of pizzas
#sold. This chart will enable us to identify underperforming or less popular pizza options.

select dayname(order_date) as order_day, count(distinct order_id) as total_orders from pizza_sales group by order_day order by field(order_day, 'Monday', 'Tuesday',
'Wednesday','Thursday','Friday','Saturday','Sunday');

select monthname(order_date) as month_name , count(distinct order_id) as total_orders from pizza_sales group by month(order_date),monthname(order_date) order by month(order_date);

select pizza_category , sum(total_price) as total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales )as percentage from pizza_sales  group by  pizza_category; 

select pizza_category , sum(total_price) as total_sales, sum(total_price)*100/ (select sum(total_price) from pizza_sales where month(order_date) = 1) as percentage from pizza_sales
where month(order_date) =6 group by  pizza_category;

select pizza_size , sum(total_price) as total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales )
as percentage from pizza_sales group by  pizza_size order by FIELD(pizza_size, 'S','M','L','XL','XXL'); 

select pizza_name, sum(total_price) as total_revenue from pizza_sales group by pizza_name order by total_revenue ;

select pizza_name, sum(total_price) as total_revenue from pizza_sales group by pizza_name order by total_revenue desc;

select pizza_name, sum(total_price) as total_revenue from pizza_sales group by pizza_name order by total_revenue limit 5;

