CREATE TABLE price_changes (
 productid INT,
 new_price DECIMAL(10, 2),
 change_date DATE
);

INSERT INTO price_changes (productid, new_price, change_date)
VALUES 
(1, 20.00, '2019-08-14'),
(2, 55.00, '2019-08-14'),
(1, 30.00, '2019-08-15'),
(1, 35.00, '2019-08-16'),
(2, 65.00, '2019-08-17'),
(3, 20.00, '2019-08-18'),
(2, 50.00, '2019-08-15'),
(3, 30.00, '2019-08-19'),
(4, 33.00, '2019-08-15'),
(1, 80.00, '2019-08-19');

/*INPUT TABLE:
-- productid new_price change_date
1 20.00 2019-08-14
2 55.00 2019-08-14
1 30.00 2019-08-15
1 35.00 2019-08-16
2 65.00 2019-08-17
3 20.00 2019-08-18
2 50.00 2019-08-15
3 30.00 2019-08-19
4 33.00 2019-08-15
1 80.00 2019-08-19

OUTPUT TABLE:
productid price
1 35.00
2 50.00
3 10.00
4 33.00*/

select * from price_changes;
-- WRITE A SOLUTION TO FIND THE PRICES OF ALL PRODUCTS ON '2019-08-16'. ASSUME THE PRICE OF ALL PRODUCT BEFORE ANY CHANGE IS 10.
select productid,max(case when change_date=last_date then new_price when last_date=0 then 10 end ) as price from(
select *,max(case when change_date <='2019-08-16' then change_date else 0 end) over(partition by productid) as last_date
from price_changes) s
group by productid;


With cte as(
select *,max(case when change_date <='2019-08-16' then change_date else 0 end) over(partition by productid) as last_date
from price_changes)
select productid,
max(case when change_date=last_date then new_price 
		 when last_date=0 then 10 end ) as price 
from cte
group by productid;
