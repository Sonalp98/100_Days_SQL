# 92/100 SQL PROBLEM ( Deloitte Interview Questions )
Q.1 Find the top 3 highest-paid employees in each department.
Q.2 Find the average salary of employees hired in the last 5 years.
Q.3 Find the employees whose salary is less than the average salary of employees hired in the last 5 years. 

DDL & DML Query:
drop table if exists departments;
drop table if exists employees;
CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(50),
 LastName VARCHAR(50),
 DepartmentID INT,
 Salary DECIMAL(10, 2),
 DateHired DATE,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, DateHired) VALUES
(1, 'Alice', 'Smith', 1, 50000, '2020-01-15'),
(2, 'Bob', 'Johnson', 1, 60000, '2018-03-22'),
(3, 'Charlie', 'Williams', 2, 70000, '2019-07-30'),
(4, 'David', 'Brown', 2, 80000, '2017-11-11'),
(5, 'Eve', 'Davis', 3, 90000, '2021-02-25'),
(6, 'Frank', 'Miller', 3, 55000, '2020-09-10'),
(7, 'Grace', 'Wilson', 2, 75000, '2016-04-05'),
(8, 'Henry', 'Moore', 1, 65000, '2022-06-17');


Input Table:
Employees Table:
EmployeeID FirstName LastName DepartmentID Salary DateHired
1 Alice Smith 1 50000.00 2020-01-15
2 Bob Johnson 1 60000.00 2018-03-22
3 Charlie Williams 2 70000.00 2019-07-30
4 David Brown 2 80000.00 2017-11-11
5 Eve Davis 3 90000.00 2021-02-25
6 Frank Miller 3 55000.00 2020-09-10
7 Grace Wilson 2 75000.00 2016-04-05
8 Henry Moore 1 65000.00 2022-06-17

Departments Table:
DepartmentID DepartmentName
1 HR
2 Engineering
3 Sales
select * from employees;
select * from departments;

-- Q.1 Find the top 3 highest-paid employees in each department.
select departmentname,emp_name from(
Select concat(FirstName,LastName) as emp_name,DepartmentName,row_number() over(partition by e.departmentid order by salary desc) as rn
from employees e
left join departments d
on e.departmentid=d.departmentid) s
where rn <=3;
-- Q.2 Find the average salary of employees hired in the last 5 years.
select * from employees;
select round(avg(salary),2) as avg_saalry
from employees 
where year(datehired)>=(year(curdate())-5);


-- Q.3 Find the employees whose salary is less than the average salary of employees hired in the last 5 years. 
select employeeid,concat(firstname,lastname) as emp_name from employees
where salary <(
select round(avg(salary),2) as avg_saalry
from employees 
where year(datehired) >= (year(curdate())-5));

select subdate(curdate(),interval 5 year);
select date_sub(curdate(),interval 5 year);
select date_add(curdate(),interval -5 year);
select adddate(curdate(),interval -5 year);
select curdate() - interval 5 year;