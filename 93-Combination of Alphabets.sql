-- # 93/100 SQL PROBLEM
-- Write the sql query to find the combinations of the Alphabets. Write a generic Query.

-- DDL& DML QUERY:
 drop table testcases;
 CREATE TABLE TestCases
(
TestCase VARCHAR(30) 
);


INSERT INTO TestCases (TestCase) VALUES
('A'),('B'),('C') ;

INPUT TABLE:
TestCase
A
B
C

OUTPUT TABLE:
combinations
A,B,C
A,C,B
B,A,C
B,C,A
C,A,B
C,B,A
select * from testcases;


select concat_ws(',',t.testcase,t1.testcase,t2.testcase) as combinations from testcases t
join testcases t1
on t.testcase!=t1.testcase
join testcases t2
on t.testcase!=t2.testcase and t1.testcase!=t2.testcase
order by t.testcase,t1.testcase;

with recursive cte as(
select testcase as combinations,1 as num
from testcases
union all
select concat_ws(',',c.combinations,t.testcase) as combinations, num+1 
from cte c
cross join testcases t
where num<(select count(distinct testcase) from testcases) and c.combinations not like concat('%',t.testcase,'%') )
select combinations from cte
where num=(select count(distinct testcase) from testcases)
order by combinations;