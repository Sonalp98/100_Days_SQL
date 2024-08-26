create table job_positions
(
 id int,
 title varchar(100),
 groupss varchar(10),
 levels varchar(10),
 payscale int,
 totalpost int
);
insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1);
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5);
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);

drop table if exists job_employees;
create table job_employees
(
 id int,
 name varchar(100),
 position_id int
);
insert into job_employees values (1, 'John Smith', 1);
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2);
insert into job_employees values (5, 'William Lee', 3);
insert into job_employees values (6, 'Jessica Clark', 3);
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);
select * from job_positions;
select * from job_employees;
with recursive cte as(
select id,title,groupss,levels,payscale,totalpost,1 as level from job_positions
union all 
select id,title,groupss,levels,payscale,totalpost,1+level as level from cte 
where level < totalpost),
cte2 as( select *,row_number() over(partition by position_id) as rn from job_employees)
select c.title,c.groupss,c.levels,c.payscale,coalesce(c2.name,'vacant') as emp_name
from cte c
left join cte2 c2
on c.id=c2.position_id and c.level=c2.rn
order by c.id;

with recursive cte as(
select id,title,groupss,levels,payscale,totalpost as post from job_positions
union all 
select id,title,groupss,levels,payscale,post-1 as post from cte 
where post>1),
cte2 as( select *,row_number() over(partition by position_id) as rn from job_employees)
select c.title,c.groupss,c.levels,c.payscale,coalesce(c2.name,'vacant') as emp_name
from cte c
left join cte2 c2
on c.id=c2.position_id and c.post=c2.rn
order by c.id;