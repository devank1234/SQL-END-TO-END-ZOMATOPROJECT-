create database zomato;
use zomato;
CREATE TABLE users
(userid integer primary key,signup_date date); 
INSERT INTO users
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');
CREATE TABLE gold_user
(userid integer,
foreign key(userid) references users(userid),
gold_signup_date date); 
INSERT INTO gold_user
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');
CREATE TABLE product
(product_id integer primary key,product_name text,price integer); 
INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);
CREATE TABLE sales
(userid integer,
foreign key(userid) references users(userid),
product_id integer,
foreign key(product_id) references product(product_id),
created_date date
);
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
#answer1
select  s.userid,sum(price)
from sales as s
left join product as p
on s.product_id = p.product_id
group by userid;
#answer 2
select userid , count(created_date) as total_days
from sales
group by userid;
#answer3
select * 
from(
select *,
dense_rank() over (partition by userid order by created_date) RN 
from sales) TEMP
where RN=1;
#answer6
select *
from sales
where  userid=1 and created_date > 2014-09-02
order by created_date asc 
limit 1;
select *
from sales
where  userid=2 and created_date > 2015-01-15
order by created_date asc 
limit 1;
select *
from sales
where  userid=3 and created_date > 2014-04-11
order by created_date asc 
limit 1;
#answer7
select *
from sales
where  userid=1 and created_date < 2014-09-02
order by created_date desc 
limit 1;
select *
from sales
where  userid=2 and created_date < 2015-01-15
order by created_date desc 
limit 1;
select *
from sales
where  userid=3 and created_date < 2014-04-11
order by created_date desc 
limit 1;
#answer 8 
select s.userid,count(product_name),sum(price)
from sales as s
left join product as p
on s.product_id = p.product_id
where created_date<2015-01-15
group by userid;
#answer9
select s.product_id, sum(price)*5 as total_points
from sales as s
left join product as p
on s.product_id = p.product_id
group by product_id;
#answer10
select price*5 as points
from sales as s
left join product as p
on s.product_id = p.product_id
where userid=1 and price=330
limit 1;#this is equal to 1650
select price * 5 as zp 
from sales as s
left join product as p
on s.product_id = p.product_id
where userid=3 and price=870
limit 1;#this is equal to 4350 so, 3 earn more than 1 
#answer11
select  price,
dense_rank() OVER(order by price desc) as rnk
from sales as s
left join product as p
on s.product_id = p.product_id;
#answer 12
select  userid , min(created_date) 
from sales as s
left join product as p
on s.product_id = p.product_id
where created_date > 2017-09-22
group by userid;
#answer4
select count(product_id)
from sales
where product_id=2; 
select userid , count(product_id)
from sales 
where product_id=2
group by userid;
#answer 5
select * 
from sales
where userid=1 and product_id=2;
select *
from sales
where userid=2 and product_id=3;
select * 
from sales
where userid=3 and product_id=2;













