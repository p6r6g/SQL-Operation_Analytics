create database jobs;
use jobs;

create table job_data (
	date_ date,
    job_id int,
    actor_id int,
    event varchar(20),
    language varchar(20),
    time_spent int,
    org char(1)
);

insert into job_data (date_, job_id, actor_id, event, language, time_spent, org ) values 
	('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
	('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
	('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
	('2020-11-28', 23, 1005, 'transfer', 'Persian', 22, 'D'),
	('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
	('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
	('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
	('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');
    
select * from job_data;

select date_ as day, 
count(job_id) as jobs_reviewed_per_day,
count(job_id)/24 as jobs_reviewed_per_hour
from job_data
group by day
order by day;

select date_ as day,
count(job_id) as jobs_reviewed,
sum(time_spent) as minutes,
jobs_reviewed 
from job_data
group by day;