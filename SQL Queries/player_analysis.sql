-- TASK 1. View the players table and find the number of players in the table
SELECT * FROM players;
SELECT COUNT(DISTINCT playerID) AS Total_players FROM players;

/*
-- 	TASK 2. For each player, calculate their age at their first game, 
	their last game, and their career length (all in years). 
	Sort from longest career to shortest career. */
SELECT  nameGiven,
        TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE),
        debut) AS starting_age,
        TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE),
        finalGame) AS end_age,-
        TIMESTAMPDIFF(YEAR, debut, finalGame) AS career_length
FROM players
ORDER BY career_length DESC;

-- TASK.3 What team did each player play on for their starting and ending years?
SELECT 	p.nameGiven,
		s.yearID AS starting_year, s.teamID AS starting_team, 
        e.yearID AS ending_year, e.teamID AS ending_team
FROM players p INNER JOIN salaries s 
					on p.playerID = s.playerID
					AND YEAR(p.debut) = s.yearID
			   INNER JOIN salaries e
					on p.playerID = e.playerID
					AND YEAR(P.finalGame) = e.yearID;

/* 
-- 4. How many players started and ended on the same team 
and also played for over a decade                    */
SELECT 	p.nameGiven,
		s.yearID AS starting_year, s.teamID AS starting_team, 
        e.yearID AS ending_year, e.teamID AS ending_team
FROM players p INNER JOIN salaries s 
					on p.playerID = s.playerID
					AND YEAR(p.debut) = s.yearID
			   INNER JOIN salaries e
					on p.playerID = e.playerID
					AND YEAR(P.finalGame) = e.yearID
WHERE s.teamID = e.teamID
AND e.yearID - s.yearID > 10;



