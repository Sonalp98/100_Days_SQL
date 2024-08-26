-- Q89. Quantity of some products are given in the table. 
-- Write the sql query to print product the number of time the quantity is given in the table.

-- DDL & DML Query:
drop table if exists products;
CREATE TABLE Products
(
Product  VARCHAR(100),
Quantity      INTEGER NOT NULL
) ;
INSERT INTO Products
VALUES
('Mobile',3),
('TV',5),
('Tablet',4);

Input table:
Product Quantity
Mobile 3
TV 5
Tablet 4

Output Table:
product Quantity
Mobile 3
Mobile 2
Mobile 1
Tablet 4
Tablet 3
Tablet 2
Tablet 1
TV 5
TV 4
TV 3
TV 2
TV 1
select * from products;
with recursive cte as( select product,quantity from products
union all
select product,quantity-1 as quantity from cte where quantity >1)
select * from cte
order by product;


with recursive cte as( select 1 as n
union all
select n+1 from cte where n<(select max(quantity) from products) )
select p.product,c.n as quantity from cte c
join products p
on p.quantity >= c.n
order by product,c.n desc;
