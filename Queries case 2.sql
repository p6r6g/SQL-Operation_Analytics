use project3_case2;

select * from users;
select * from events;
select * from email_events;




-- task 1
select
    users.user_id,
    year(events.occurred_at) as year,
    week(events.occurred_at) as week,
    count(distinct events.event_name) as total_events,
    count(distinct email_events.action) as total_emails
from users
left join events on users.user_id = events.user_id
left join email_events on users.user_id = email_events.user_id
group by
    users.user_id,
    year(events.occurred_at),
    week(events.occurred_at)
order by
    users.user_id, year, week;
    
    
    

-- task 2 
select
    year(created_at) as year,
    month(created_at) as month,
    count(user_id) as new_users
from users
group by
    year(created_at),
    month(created_at)
order by year, month;





-- task 3
select s.signup_year, s.signup_week,
    count(distinct s.user_id) as retained_users_count
from (
	select user_id,
		year(created_at) as signup_year,
		week(created_at) as signup_week
	from users
) s
left join (
	select user_id,
		year(occurred_at) as activity_year,
		week(occurred_at) as activity_week
	from events
	group by user_id, year(occurred_at), week(occurred_at)
) a
on  s.user_id = a.user_id
	and a.activity_year = s.signup_year
    and a.activity_week >= s.signup_week
    and a.activity_week < s.signup_week + 1
    -- only counting activities in the same week as sign-up
group by s.signup_year, s.signup_week
order by s.signup_year, s.signup_week;





-- task 4
select
    year(occurred_at) as year,
    week(occurred_at) as week,
    device,
    count(user_id) as total_events
from events 
group by
    year(occurred_at), week(occurred_at), device
order by 
	year, week, device;




-- task 5
select
    year(occurred_at) as year,
    week(occurred_at) as week,
    count(user_id) as total_email_actions
from email_events
group by
    year(occurred_at), week(occurred_at)
order by
    year, week;
