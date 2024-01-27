create schema zomato_sales;
drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid, gold_signup_date) 
VALUES 
  (2, '2018-06-15'),
  (4, '2019-01-08'),
  (5, '2018-12-03'),
  (6, '2017-11-25'),
  (7, '2019-08-14');


drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

# Retrieve all columns from the sales table for transactions that occurred in 2017.

select * from sales
where year(`created_date`) = "2017";

# List the product names and prices for products with a price greater than 500.

select * from product
where `price` > 500;

# Count the number of sales made for each product. Include the product name in the result.

select p.product_name  , count(*) as sales_count from sales s
join product p on s.product_id = p.product_id
group by p.product_name;

# Retrieve the user IDs and signup dates for gold users who signed up before 2017.

select * from goldusers_signup
where year(`gold_signup_date`)<="2017";

# Calculate the total revenue generated from sales.

select p.product_id , sum(`price`) as total_price 
from product p
join sales s on p.product_id = s.product_id 
group by p.product_id;

# Find the average price of products purchased by each user.

select s.userid , p.product_id , avg(`price`) as avg_price 
from product p
join sales s on p.product_id = s.product_id
group by s.userid,p.product_id;

# Retrieve the details of users who made a purchase in 2018.

select u.userid , created_date 
from sales s
join users u on u.userid = s.userid 
where year(s.created_date) = "2018";

# List the user IDs and product names for products priced between 300 and 800.

select s.product_id , price 
from product p 
join sales s on p.product_id = s.product_id 
where p.price between 300 and 800;

# Count the number of gold users who made a purchase.

select count(distinct g.userid) as gold
from goldusers_signup g
join sales s on s.userid = g.userid;

# Retrieve the product names and prices for products that have never been purchased.

select p.product_id , p.price 
from product p
join sales s on s.product_id = p.product_id
where s.product_id is null;

# Calculate the total revenue for each year.

select year(s.created_date) as salesyear , sum(p.price) as total_rev
from sales s
join product p on s.product_id = p.product_id
group by salesyear;

# Find the product name with the highest price.

select * from sales;
select * from product;

select p.price , p.product_name 
from product as p
join sales s on s.product_id = p.product_id
order by p.price desc
limit 1;

# Retrieve the user IDs and gold signup dates for gold users who made a purchase in 2016.

select * from goldusers_signup
where year(`gold_signup_date`) = "2016";

# List the product names and prices for products purchased by gold users.

select * from product;
select * from sales;

select p.product_name , p.price 
from product p
join sales s on s.product_id = p.product_id
join goldusers_signup g on s.userid = g.userid;

# Retrieve the user IDs and signup dates for users who have never made a purchase

SELECT u.userid, u.signup_date
FROM users u
LEFT JOIN sales s ON u.userid = s.userid
WHERE s.userid IS NULL;


