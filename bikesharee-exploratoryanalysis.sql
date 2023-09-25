
select *
from bikeshare
--Check the total number of rides for both members and casuals

SELECT count (ride_id)
from bikeshare
where member_casual = 'member'

SELECT count (ride_id)
from bikeshare
where member_casual = 'casual'

--check the number of rides by casual and members per day
SELECT count (ride_id), day
from bikeshare
where member_casual = 'member'
group by day

SELECT count (ride_id), day
from bikeshare
where member_casual = 'casual'
group by day

--check the number of rides by casual and members per month
SELECT count (ride_id), month
from bikeshare
where member_casual = 'member'
group by month

SELECT count (ride_id), month
from bikeshare
where member_casual = 'casual'
group by month

--check the number of rides by casual and members per season
SELECT count (ride_id), season
from bikeshare
where member_casual = 'member'
group by season

SELECT count (ride_id), season
from bikeshare
where member_casual = 'casual'
group by season


  SELECT 
    CAST(AVG(CAST(duration AS FLOAT)) AS DATETIME), member_casual 
FROM bikeshare
Group by member_casual

--create a CTE for time duration and check the average timee it took for meembbers and casuals to complete a trip

with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select member_casual, avg (TotalSeconds)
from time_duration
group by member_casual

--From the reessults, it took members 753 seconds to complete a single trip and members 1446 seconds

--next, check how many seconds both members and casuals averaged in a month

with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select avg (TotalSeconds), month
from time_duration
where member_casual = 'member'
group by month


with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select avg (TotalSeconds), month
from time_duration
where member_casual = 'casual'
group by month

--next, check how many seconds both members and casuals averaged on weekdays and weekends

with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select avg (TotalSeconds), weekday_weekend
from time_duration
where member_casual = 'member'
group by weekday_weekend


with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select avg (TotalSeconds), weekday_weekend
from time_duration
where member_casual = 'casual'
group by weekday_weekend


--we will now check how many seconds were averaged by members and casuals in various seasons
with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select avg (TotalSeconds), season
from time_duration
where member_casual = 'casual'
group by season


with time_duration as( 
select duration, member_casual, weekday_weekend, month, day, season, cast(
    DATEPART(HOUR, duration) * 3600 +
    DATEPART(MINUTE, duration) * 60 +
    DATEPART(SECOND, duration)as bigint) AS TotalSeconds
FROM bikeshare
)
select avg (TotalSeconds), season
from time_duration
where member_casual = 'member'
group by season

