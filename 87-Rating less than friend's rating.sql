CREATE TABLE Friends (
id INT,
friend_id INT 
);
DROP TABLE IF EXISTS Ratings;
CREATE TABLE Ratings (
id INT PRIMARY KEY,
 rating INT
);
INSERT INTO Friends (id, friend_id)
VALUES
(1, 2),
(1, 3),
(2, 3),
(3, 4),
(4, 1),
(4, 2),
(5,NULL),
(6,NULL);
INSERT INTO Ratings (id, rating)
VALUES
(1, 85),
(2, 90),
(3, 75),
(4, 88),
(5, 82),
(6, 91);
select * from Ratings;
select * from friends;

-- Retrieve all the Ids of a person whose rating is greater than friend's id. 
-- If person do not have any friend, retrieve only their id only if rating is greater than 85.
select f.id
from friends f
left join ratings r
on f.id=r.id
left join ratings r1
on f.friend_id=r1.id
group by id
having max(r.rating) > max(r1.rating) or (max(friend_id) is null and max(r.rating) > 85);


select id from(
select f.id,min(case when r.rating > r1.rating then 1 
                 when friend_id is null and r.rating > 85 then 1 else 0 end) over(partition by f.id) as flag
from friends f
left join ratings r
on f.id=r.id
left join ratings r1
on f.friend_id=r1.id) s
where flag=1;




select id from(
select f.id,min(case when r.rating > r1.rating then 1 
                 when friend_id is null and r.rating > 85 then 1 else 0 end) as flag
from friends f
left join ratings r
on f.id=r.id
left join ratings r1
on f.friend_id=r1.id
group by f.id) s
where flag=1;