# 94/100 SQL PROBLEM

-- You are given the travel data for each customer in no particular order. 
-- You need to find the start location and end location of the customer.

-- DDL & DML Query:
CREATE TABLE travel_data (
 customer VARCHAR(10),
 start_loc VARCHAR(50),
 end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
 ('c1', 'New York', 'Lima'),
 ('c1', 'London', 'New York'),
 ('c1', 'Lima', 'Sao Paulo'),
 ('c1', 'Sao Paulo', 'New Delhi'),
 ('c2', 'Mumbai', 'Hyderabad'),
 ('c2', 'Surat', 'Pune'),
 ('c2', 'Hyderabad', 'Surat'),
 ('c3', 'Kochi', 'Kurnool'),
 ('c3', 'Lucknow', 'Agra'),
 ('c3', 'Agra', 'Jaipur'),
 ('c3', 'Jaipur', 'Kochi');
 
/* Input table:
customer start_loc end_loc
c1 New York Lima
c1 London New York
c1 Lima Sao Paulo
c1 Sao Paulo New Delhi
c2 Mumbai Hyderabad
c2 Surat Pune
c2 Hyderabad Surat
c3 Kochi Kurnool
c3 Lucknow Agra
c3 Agra Jaipur
c3 Jaipur Kochi

Output Table:
customer start_point end_point total_visit
c1 London New Delhi 5
c2 Mumbai Pune 4
c3 Lucknow Kurnool 5 */
With cte as(
select customer,count(*) as cnt from(
select customer, start_loc from travel_data
union 
select customer, end_loc from travel_data)s
group by customer)
select t.customer, 
max(case when start_loc not in(select distinct end_loc from travel_data) then start_loc end) as start,
max(case when end_loc not in(select distinct start_loc from travel_data) then end_loc end) as end,
c.cnt as total_visits
from travel_data t
join cte c
on t.customer=c.customer
group by t.customer,c.cnt;

select customer, 
max(case when start_loc not in(select distinct end_loc from travel_data) then start_loc end) as start,
max(case when end_loc not in(select distinct start_loc from travel_data) then end_loc end) as end,
count(start_loc)+1 as total_visits
from travel_data 
group by customer;


-- Using self join
select t.customer,
max(case when t1.start_loc is null then t.start_loc end) as start,
max(case when t2.start_loc is null then t.end_loc end) as end
from travel_data t
left join travel_data t1
on t.customer=t1.customer and t.start_loc=t1.end_loc
left join travel_data t2
on t.customer=t2.customer and t.end_loc=t2.start_loc
group by t.customer