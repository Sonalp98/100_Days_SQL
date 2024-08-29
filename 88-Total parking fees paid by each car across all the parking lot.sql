# 88/100 SQL Problem (LeetCode Medium)
-- Find total parking fees paid by each car across all the parking lot, average hourly fees rounded to 2 decimal paid by each car. 
-- Also find the parking lot where each car spent most total time.
-- An individual car cannot be in multiple parking lot at the same time

-- DDL & DML Query:
CREATE TABLE If not exists ParkingTransactions (
 lot_id INT,
 car_id INT,
 entry_time DATETIME,
 exit_time DATETIME,
 fee_paid DECIMAL(10, 2)
);

Truncate table ParkingTransactions;
insert into ParkingTransactions (lot_id, car_id, entry_time, exit_time, fee_paid) values ('1', '1001', '2023-06-01 08:00:00', '2023-06-01 10:30:00', '5.0');
insert into ParkingTransactions (lot_id, car_id, entry_time, exit_time, fee_paid) values ('1', '1001', '2023-06-02 11:00:00', '2023-06-02 12:45:00', '3.0');
insert into ParkingTransactions (lot_id, car_id, entry_time, exit_time, fee_paid) values ('2', '1001', '2023-06-01 10:45:00', '2023-06-01 12:00:00', '6.0');
insert into ParkingTransactions (lot_id, car_id, entry_time, exit_time, fee_paid) values ('2', '1002', '2023-06-01 09:00:00', '2023-06-01 11:30:00', '4.0');
insert into ParkingTransactions (lot_id, car_id, entry_time, exit_time, fee_paid) values ('3', '1001', '2023-06-03 07:00:00', '2023-06-03 09:00:00', '4.0');
insert into ParkingTransactions (lot_id, car_id, entry_time, exit_time, fee_paid) values ('3', '1002', '2023-06-02 12:00:00', '2023-06-02 14:00:00', '2.0');

-- Input Table:
-- lot_id car_id entry_time exit_time fee_paid
1 1001 2023-06-01 08:00:00 2023-06-01 10:30:00 5.00
1 1001 2023-06-02 11:00:00 2023-06-02 12:45:00 3.00
2 1001 2023-06-01 10:45:00 2023-06-01 12:00:00 6.00
2 1002 2023-06-01 09:00:00 2023-06-01 11:30:00 4.00
3 1001 2023-06-03 07:00:00 2023-06-03 09:00:00 4.00
3 1002 2023-06-02 12:00:00 2023-06-02 14:00:00 2.00

Output Table:
car_id total_fee avg_hr_fee most_time_lot
1001 18.00 2.40 1
1002 6.00 1.33 2
select * from ParkingTransactions;
With cte as(
select *,timestampdiff(minute,entry_time,exit_time) as diff_minutes,
first_value(lot_id) over(partition by car_id order by timestampdiff(minute,entry_time,exit_time) desc) as most_time_lot
from ParkingTransactions)
select car_id,sum(fee_paid) as total_fee, 
round(sum(fee_paid)*60/sum(diff_minutes),2) as avg_hr_fee,most_time_lot
from cte
group by car_id,most_time_lot;