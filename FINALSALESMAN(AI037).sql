--Salesman
create table salesman
(
salesman_id varchar(20),
name VARCHAR(20),
city VARCHAR(20),
comission VARCHAR(20),
PRIMARY KEY (salesman_id)
);
select * from salesman

--Customers
create table customer
(
customer_id varchar(20),
name varchar(20),
city varchar(20),
grade int,
primary key(customer_id)
);
select * from customer

--Orders
create table orders
(
ord_no varchar(20),
purchase_amt int,
ord_date date,
customer_id varchar(20),
salesman_id varchar(20),
primary key(ord_no),
foreign key(customer_id) references customer(customer_id) on delete cascade,
foreign key(salesman_id) references  salesman(salesman_id) on delete cascade,
);
select * from orders

--insert items in salesman
insert into salesman values('1','Guru','Mangalore','5')
insert into salesman values('2','Ravi','Puttur','3')
insert into salesman values('3','Girish','Udupi','3')
select * from salesman

--insert customers
insert into customer values('11','Srikanth','Puttur','4')
insert into customer values('12','Sandeep','Mangalore','2')
insert into customer values('13','Uday','Puttur','3')
insert into customer values('14','Mahesh','Sullia','2')
insert into customer values('15','Shivaram','Puttur','2')
insert into customer values('16','Shyam','Mangalore','5')
select * from customer

--order details
insert into orders values('111',2500,'11-JUL-17','11','2')
insert into orders values('112',1999,'09-JUL-17','12','1')
insert into orders values('113',999,'12-JUL-17','13','2')
insert into orders values('114',9999,'12-JUL-17','14','3')
insert into orders values('115',7999,'11-JUL-17','15','2')
insert into orders values('116',1099,'09-JUL-17','16','2')
select * from orders

--1.Count the customer with grades above Bangalore's average
select count(*) as count
from customer where grade>(select avg(grade) from customer where city='Puttur');

--2.Find the name and number of all slaesman who had more than one customer.
select s.salesman_id,s.name,count(customer_id) as count
from salesman s,orders o 
where s.salesman_id=o.salesman_id group by s.salesman_id,s.name having count(customer_id)>1;

--3.List all the salesman and indicate those who have and dont have customers in their cities(USE UNION OPERATION)
select name,'exists' as same_city
from salesman s
where city in(select city from customer where s.salesman_id=salesman_id)
union
select name,'not exists' as same_city
from salesman s where
city not in(select city from customer where s.salesman_id=salesman_id);

--4.Create a view that finds the salesman whp has the customer with the highest order of a day.
create view highest_order as
select s.salesman_id,s.name,o.purchase_amt,o.ord_date
from salesman s,orders o
where s.salesman_id = o.salesman_id;
select name,ord_date
from highest_order h
where purchase_amt =
(select max(purchase_amt)
from highest_order
where h.ord_date = ord_date);

--5.Demonstrate the delete operation by removing salesman with id 3.All his orders must also be deleted
delete from salesman where salesman_id=3;

--6.Retrieve salesman details along with count of orders,total purchase amount of the orders assigned to him and comission earned by him
--6.Retrieve salesman details along with count of orders,total purchase amount of the orders assigned to him and comission earned by him.
select s.salesman_id,s.name,s.city,count(*) as count,sum(purchase_amt) as totalamt ,sum((purchase_amt)*comission)/100 as comission_earned from salesman s,orders o where s.salesman_id=o.salesman_id
group by s.salesman_id,s.name,s.city,s.comission


