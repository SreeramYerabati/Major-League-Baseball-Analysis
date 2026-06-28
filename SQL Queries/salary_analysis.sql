-- TASK-1. View the salaries table
SELECT * FROM salaries;
select distinct * from salaries;

-- TASK-2. Return the top 20% of teams in terms of average annual spending
WITH ts AS (SELECT teamID, yearID, SUM(salary) AS total_spending
FROM salaries
GROUP BY teamID, yearID
ORDER BY teamID, yearID),
sp AS (SELECT teamID, AVG(total_spending) AS avg_spend,
NTILE(5) over(ORDER BY AVG(total_spending) DESC) AS spend_pct
FROM ts
GROUP BY teamID)
SELECT teamID, ROUND(avg_spend / 1000000, 1) AS avg_spend_millions
FROM sp
WHERE spend_pct = 1;
--

-- TASK-2.For each team, show the cumulative sum of spending over the years
WITH ts AS (SELECT teamID, yearID, SUM(salary) AS total_spend 
			FROM salaries
			GROUP BY teamID, yearID
			ORDER BY teamID, yearID)
SELECT teamID, yearID, 
		ROUND(SUM(total_spend) OVER(PARTITION BY teamID ORDER BY yearID) / 1000000, 1) 
        AS Cumulative_Sum
FROM ts;
--
--       
-- TASK-2. Return the first year that each team's cumulative spending surpassed 1 billion     
WITH ts AS (SELECT teamID, yearID, SUM(salary) AS total_spend 
			FROM salaries
			GROUP BY teamID, yearID
			ORDER BY teamID, yearID),
	cs AS  (           
			SELECT teamID, yearID, 
			SUM(total_spend) OVER(PARTITION BY teamID ORDER BY yearID)
			AS Cumulative_Sum
			FROM ts),
	rn AS	(SELECT teamID, yearID, Cumulative_Sum,
			ROW_NUMBER() OVER(PARTITION BY teamID ORDER BY Cumulative_Sum) as rn
			FROM cs 
			WHERE Cumulative_Sum > 1000000000) 
SELECT teamID, yearID, ROUND(Cumulative_Sum / 1000000000, 2) AS Cumulative_Sum_Billions
FROM rn
WHERE rn = 1;            
--
--



