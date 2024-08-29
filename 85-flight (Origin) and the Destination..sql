-- # 85/100 SQL Problem
-- Write SQL query to find the city traveler took the flight (Origin) and the Destination.

-- DDL & DML Query:
CREATE TABLE Flights (
 TripID INT,
 FlightName VARCHAR(50),
 DepartureCity VARCHAR(50),
 ArrivalCity VARCHAR(50)
);
INSERT INTO Flights (TripID, FlightName, DepartureCity, ArrivalCity) VALUES
(1, 'Flight1', 'Delhi', 'Hyderabad'),
(1, 'Flight2', 'Hyderabad', 'Kochi'),
(1, 'Flight3', 'Kochi', 'Mangalore'),
(2, 'Flight1', 'Mumbai', 'Ayodhya'),
(2, 'Flight2', 'Ayodhya', 'Gorakhpur'),
(3, 'Flight3', 'vizag', 'chennai'),
(3, 'Flight4', 'chennai', 'tirupati'),
(4, 'Flight1', 'Patna', 'Agra');

Input Table:
TripID FlightName DepartureCity ArrivalCity
1 Flight1 Delhi Hyderabad
1 Flight2 Hyderabad Kochi
1 Flight3 Kochi Mangalore
2 Flight1 Mumbai Ayodhya
2 Flight2 Ayodhya Gorakhpur
3 Flight3 vizag chennai
3 Flight4 chennai tirupati
4 Flight1 Patna Agra

Output Table:
tripid origin destination
1 Delhi Mangalore
2 Mumbai Gorakhpur
3 vizag tirupati
4 Patna Agra

select * from flights;
select tripid,
max(case when departurecity not in(select distinct arrivalcity from flights) then departurecity end)  as origin,
max(case when arrivalcity not in(select distinct departurecity from flights) then arrivalcity end ) as destination
from flights
group by tripid;

-- 
with cte as(
select *,lead(departurecity) over(partition by tripid order by flightname) as next_city,
row_number() over(partition by tripid order by flightname) as rn
from flights)
select tripid,
max(case when (rn=1 and next_city=arrivalcity) or (rn=1 and next_city is null) then departurecity end) as origin,
max(case when next_city is null then arrivalcity end) as destination
from cte
group by tripid