-- 1. View the players table 
SELECT * FROM players;

-- 2. Which players have the same birthday
WITH bn AS (SELECT 	CAST(concat(birthYear, '-', birthMonth, '-', birthDay) AS DATE)
		AS birthdate,nameGiven
		FROM players)
SELECT birthdate, GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players
FROM bn
WHERE YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate;

/* 
-- TASK 3. Create a summary table that shows for each team, 
what percent of players bat right, left and both */
 
WITH up AS (SELECT DISTINCT s.teamID, s.playerID, p.bats
           FROM salaries s LEFT JOIN players p
           ON s.playerID = p.playerID) -- unique players CTE

SELECT teamID,
		ROUND(SUM(CASE WHEN bats = 'R' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) 
        AS bats_right,
        ROUND(SUM(CASE WHEN bats = 'L' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) 
        AS bats_left,
        ROUND(SUM(CASE WHEN bats = 'B' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) 
        AS bats_both
FROM up
GROUP BY teamID;

/*
-- Task 4. How have average height and weight at debut game changed over the years, 
and what's the decade-over-decade difference? */

WITH hw AS (SELECT	FLOOR(YEAR(debut) / 10) * 10 AS decade,
					AVG(height) AS avg_height, AVG(weight) AS avg_weight
			FROM	players
			GROUP BY decade)
            
SELECT	decade,
		avg_height - LAG(avg_height) OVER(ORDER BY decade) AS height_diff,
        avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff
FROM	hw
WHERE	decade IS NOT NULL;

