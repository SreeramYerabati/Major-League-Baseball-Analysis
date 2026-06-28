# ⚾ Major League Baseball Historical Analysis using SQL & Power BI

## Overview

This project analyzes historical Major League Baseball (MLB) data using SQL for data exploration and Power BI for interactive visualization. The objective is to uncover insights into player careers, school contributions, salary trends, and player characteristics using relational data.

---

## Dataset

The analysis is based on the Lahman Baseball Dataset and uses the following datasets:

* Players
* Salaries
* Schools
* School Details

---

## Business Objectives

The project answers the following analytical questions:

### School Analysis

* Which schools have produced the most MLB players?
* How has the number of schools producing MLB players changed over time?
* Which schools dominated player production across different decades?

### Salary Analysis

* Which teams have spent the most on player salaries?
* How have cumulative team payrolls changed over time?
* When did each team first exceed significant payroll milestones?

### Player Career Analysis

* What is the average MLB career length?
* Which players spent their entire careers with a single team?
* How do debut and retirement ages compare?

### Player Comparison Analysis

* How has player height and weight evolved over different decades?
* What is the distribution of batting handedness?
* What demographic trends can be observed among MLB players?

---

## SQL Functions used

* INNER JOIN
* Common Table Expressions (CTEs)
* Aggregate Functions
* Window Functions

  * DENSE_RANK()
  * ROW_NUMBER()
  * NTILE()
  * LAG()
* CASE Expressions
* GROUP BY and HAVING
* Date Functions
* Running Totals
* Ranking and Partitioning

---

## Power BI Dashboard

**Note** : The primary analysis was conducted using SQL, with Power BI used solely as a visualization layer to communicate analytical findings effectively to business stakeholders and non-technical audiences.

The dashboard summarizes key insights from the SQL analysis through interactive visualizations.

### Dashboard Features

* KPI Cards

  * Total Players
  * Total Schools
  * Total Teams
  * Average Salary
  * Total Salary

* Interactive Slicers

  * Year
  * School
  * Team

* Visualizations

  * Player Debuts by Decade
  * Top Schools Producing MLB Players
  * Top Teams by Total Salary
  * Player Distribution by Birth Country

---

## Key Insights

- Analyzed a historical dataset of **18,589** rows of Major League Baseball players spanning more than a century of professional baseball history.
- Identified **1,038** educational institutions that produced MLB players, with a relatively small number of universities contributing a significant share of professional athletes.
- Discovered that MLB teams have collectively spent over **$48 billion** in player salaries, illustrating the substantial growth in payrolls throughout the league's history.
- Found the average MLB player salary to be approximately **$1.93 million**, highlighting the evolution of player compensation over time.
- Determined that approximately **89.5%** of players were born in the **United States**, while the remaining **10.5%** originated from other countries, reflecting the increasing international presence in Major League Baseball.
---

## Technologies Used

* SQL (MySQL)
* Power BI
* Microsoft Excel (CSV datasets)

---
## SQL Samples

```SQL
-- In each decade, how many schools were there that produced players
SELECT	FLOOR(yearID / 10)*10 AS decade,
		COUNT(DISTINCT schoolID) AS num_schools
FROM	schools
GROUP BY decade
ORDER BY decade;
```
```SQL
-- What are the names of the top 5 schools that produced the most players?
SELECT 	sd. name_full, COUNT(DISTINCT sc.playerID) AS num_players
FROM 	schools as sc LEFT JOIN school_details as sd
		on sc.schoolID = sd.schoolID
GROUP BY sc.schoolID
ORDER BY num_players DESC
LIMIT 5;

```
```SQL
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
```
---
## Author

**Sreeram Chandra**

Feel free to connect with me on LinkedIn or explore more of my analytics projects on GitHub.
