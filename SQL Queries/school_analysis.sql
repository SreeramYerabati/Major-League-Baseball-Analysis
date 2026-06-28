use school_baseball_db;

-- View the schools and school details tables
SELECT * FROM schools; 
SELECT * FROM school_details;

-- In each decade, how many schools were there that produced players
SELECT	FLOOR(yearID / 10)*10 AS decade,
		COUNT(DISTINCT schoolID) AS num_schools
FROM	schools
GROUP BY decade
ORDER BY decade;

-- What are the names of the top 5 schools that produced the most players?
SELECT 	sd. name_full, COUNT(DISTINCT sc.playerID) AS num_players
FROM 	schools as sc LEFT JOIN school_details as sd
		on sc.schoolID = sd.schoolID
GROUP BY sc.schoolID
ORDER BY num_players DESC
LIMIT 5;

-- For each decade, what were the names of the top 3 schools that produced the most players
with ds as (SELECT 	floor(sc.yearID /10) *10 as decade, sd. name_full, 
			COUNT(DISTINCT sc.playerID) AS num_players
			FROM 	schools as sc LEFT JOIN school_details as sd
					on sc.schoolID = sd.schoolID
			GROUP BY decade, sd.name_full),
	rn as (select decade, name_full, num_players,
	dense_rank() over(partition by decade order by num_players desc) as row_num 
	from ds)
SELECT decade, name_full, num_players FROM rn 
WHERE row_num <= 3
order by decade desc, num_players;
--