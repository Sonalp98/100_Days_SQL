# 83/100 SQL Problem 
-- Write the sql query to find employees absent on which date?

-- DDL & DML Query:

CREATE TABLE employee_attendance (
 Employee_Name varchar(10),
 Date DATE);

 INSERT INTO employee_attendance (Employee_Name, Date) VALUES
('Adam', '2024-01-01'),
('Adam', '2024-01-03'),
('Adam', '2024-01-04'),
('Adam', '2024-01-05'),
('Adam', '2024-01-06'),
('Andrew', '2024-01-03'),
('Andrew', '2024-01-04'),
('Andrew', '2024-01-05'),
('Andrew', '2024-01-06'),
('Andrew', '2024-01-07'),
('Stephen', '2024-01-02'),
('Stephen', '2024-01-03'),
('Stephen', '2024-01-04'),
('Stephen', '2024-01-05'),
('Stephen', '2024-01-06'),
('Phillip', '2024-01-01'),
('Phillip', '2024-01-02'),
('Phillip', '2024-01-03'),
('Phillip', '2024-01-04'),
('Phillip', '2024-01-05'),
('Phillip', '2024-01-07'),
('Samantha', '2024-01-01'),
('Samantha', '2024-01-02'),
('Samantha', '2024-01-03'),
('Samantha', '2024-01-05'),
('Samantha', '2024-01-07');

/*Input Table:
Employee_Name Date
Adam 2024-01-01
Adam 2024-01-03
Adam 2024-01-04
Adam 2024-01-05
Adam 2024-01-06
Andrew 2024-01-03
Andrew 2024-01-04
Andrew 2024-01-05
Andrew 2024-01-06
Andrew 2024-01-07
Stephen 2024-01-02
Stephen 2024-01-03
Stephen 2024-01-04
Stephen 2024-01-05
Stephen 2024-01-06
Phillip 2024-01-01
Phillip 2024-01-02
Phillip 2024-01-03
Phillip 2024-01-04
Phillip 2024-01-05
Phillip 2024-01-07
Samantha 2024-01-01
Samantha 2024-01-02
Samantha 2024-01-03
Samantha 2024-01-05
Samantha 2024-01-07

Output Table:
date employee_name
2024-01-02 Adam
2024-01-07 Adam
2024-01-01 Andrew
2024-01-02 Andrew
2024-01-06 Phillip
2024-01-04 Samantha
2024-01-06 Samantha
2024-01-01 Stephen
2024-01-07 Stephen*/
select * from employee_attendance;


with recursive cte as(
select distinct min(date) over() as date,Employee_name 
from employee_attendance
union
select date+1,Employee_name
from cte 
where  date < (select max(date) from employee_attendance))
select c.date,c.employee_name from cte c
left join employee_attendance e
on c.date=e.date and c.employee_name=e.employee_name
where e.employee_name is null
order by c.employee_name,c.date;

with recursive cte as(
select '2024-01-01' as date,employee_name
from(select distinct employee_name from employee_attendance) s
union all
select adddate(date, interval 1 day),employee_name
from cte 
where date < (select max(date) from employee_attendance))
select * from cte
order by employee_name,date;