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
count(job_id) as jobs_reviewed,
sum(time_spent) as minutes,
count(job_id)/sum(time_spent)*60 as job_reviewed_per_hour
from job_data
group by day
order by day;

-- step 1 - Calculate the daily total events and total time spent
select date_ as day,
	count(job_id) as total_events,
	sum(time_spent) as total_time
    from job_data
    group by date_;

-- step 2 - Calculate the 7-day rolling average of events per second
select temp.day,
avg(temp.total_events / temp.total_time) as rolling_avg
from 
    (select date_ as day,
	count(job_id) as total_events,
	sum(time_spent) as total_time
    from job_data
    group by date_
    ) temp
group by temp.day
order by temp.day;

-- calculate the percentage share of each language over the last 30 days.
select language, 
(count(language)/total_lang.total_count*100) as percent_share
from job_data 
join 
	(select count(language) as total_count
	from job_data) as total_lang
group by language, total_lang.total_count
order by percent_share desc;

-- filter the groups to include only those with more than one occurrence, i.e., duplicate rows.
select date_, job_id, actor_id, event, language, time_spent, org, count(*)
from job_data
group by date_, job_id, actor_id, event, language, time_spent, org
having count(*) > 1;