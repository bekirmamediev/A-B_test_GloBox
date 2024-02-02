--Can a user show up more than once in the activity table?
SELECT 
	COUNT(uid) as activity_id 
  , COUNT(DISTINCT uid) as distinct_activity_id 
FROM activity

--What are the start and end dates of the experiment?
SELECT 
	min(dt) as start_date 
  , max(dt) as end_date 
FROM activity

--How many total users were in the experiment?
SELECT 
	COUNT(DISTINCT id) total_users
FROM users 

--How many users were in the control and treatment groups?
SELECT 
	COUNT(g.uid)
FROM groups g
GROUP BY g.group 

--What was the conversion rate of all users?
SELECT 
  CAST((SELECT COUNT(DISTINCT a.uid) FROM activity a) as FLOAT)/CAST(COUNT(id) as FLOAT) as total_conversion
FROM users
  
 

--What is the user conversion rate for the control and treatment groups?
SELECT 
	CAST((COUNT(DISTINCT a.uid)) as FLOAT)/CAST((COUNT(DISTINCT u.id)) as FLOAT) as conversion_per_group
  , g.group
FROM users u 
LEFT JOIN activity a ON a.uid = u.id
LEFT JOIN groups g ON g.uid = u.id
GROUP BY g.group


--What is the average amount spent per user for the control and treatment groups, 
--including users who did not convert?
SELECT 
	SUM(a.spent)/COUNT(DISTINCT id) as avg_spent
FROM users u
LEFT JOIN activity a ON a.uid = u.id
LEFT JOIN groups g ON g.uid = u.id
GROUP BY g.group

--Extract data 
SELECT 
	u.id
  , u.country
  , u.gender
  , COALESCE(g.device, 'no information') as device 
  , g.group
  , COALESCE(SUM(a.spent), 0) as total_spent
FROM users u 
LEFT JOIN groups g ON u.id = g.uid
LEFT JOIN activity a ON a.uid = u.id
GROUP BY u.id
  , u.country
  , u.gender
  , g.device
  , g.group
  
  
--Extract data for novelty effect 
SELECT 
	u.id
  , u.country
  , u.gender
  , COALESCE(g.device, 'no information') as device 
  , g.group
  , COALESCE(SUM(a.spent), 0) as total_spent
  , a.dt
FROM users u 
LEFT JOIN groups g ON u.id = g.uid
LEFT JOIN activity a ON a.uid = u.id
GROUP BY u.id
  , u.country
  , u.gender
  , g.device
  , g.group
  , a.dt
