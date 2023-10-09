SELECT *
FROM migrant.dbo.missing_migrant

--Converting all the columns with numbers from text string to integer before exploratory data analysis

Update migrant.dbo.missing_migrant
     SET 
     number_of_dead  = CAST (number_of_dead AS int),
     number_of_missing = CAST (number_of_missing AS int),
	 [total_number_of dead_missing] = CAST ([total_number_of dead_missing] AS int),
	 number_of_survivors = CAST (number_of_survivors AS int),
	 number_of_females = CAST (number_of_females AS int),
	 number_of_males = CAST (number_of_males AS int),
	 number_of_children = CAST (number_of_children AS int)


	 --What is the number of missing incidents reported per country of origin?

	 SELECT country_of_origin, COUNT(country_of_origin), COUNT (region_of_origin)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY country_of_origin 
	 ORDER BY count(country_of_origin) DESC


	 --What is the number of missing incidents reported per region of origin?

	 SELECT region_of_origin, COUNT (region_of_origin)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY region_of_origin
	 ORDER BY COUNT (region_of_origin) DESC


	 --how do the number of reported missing incidents move from year to year per refion of origin?
	 
SELECT incident_year, region_of_origin, COUNT(*) AS incident_count
FROM migrant.dbo.missing_migrant
GROUP BY incident_year, region_of_origin
ORDER BY incident_year, region_of_origin

 --how do the number of reported missing incidents move monthly per refion of origin?
	 
SELECT month, region_of_origin, COUNT(*) AS incident_count
FROM migrant.dbo.missing_migrant
GROUP BY month, region_of_origin
ORDER BY month, region_of_origin

----number of missing males and females reported

SELECT region_of_origin, SUM (number_of_females), SUM (number_of_males)
FROM migrant.dbo.missing_migrant
GROUP BY region_of_origin
ORDER BY SUM (number_of_females), SUM (number_of_males)

--I'm from Africa, and I'm interested in understanding how the 
--various african regions add up to the total missing migrants from africa
WITH RegionCounts AS (
    SELECT region_of_origin, COUNT(*) AS region_count
    FROM migrant.dbo.missing_migrant
    WHERE region_of_origin IN ('northern africa', 'western africa', 'middle africa', 'eastern africa')
    GROUP BY region_of_origin
)

SELECT region_of_origin, region_count, (region_count * 100.0) / SUM(region_count) OVER () AS region_percentage
FROM RegionCounts;



 --What is the number of deaths reported per country of origin?

	 SELECT country_of_origin, SUM(number_of_dead)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY country_of_origin 
	 ORDER BY SUM(number_of_dead) DESC


	 --What is the number of deaths reported per region of origin?

	 SELECT region_of_origin, SUM(number_of_dead)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY region_of_origin
	 ORDER BY SUM(number_of_dead) DESC

--What is the number of missing immigrants reported per country of origin?

	 SELECT country_of_origin, SUM(number_of_missing)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY country_of_origin 
	 ORDER BY SUM(number_of_missing) DESC


	 --What is the number of missing immigrants reported per region of origin?

	 SELECT region_of_origin, SUM(number_of_missing)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY region_of_origin
	 ORDER BY SUM(number_of_missing) DESC

--What is the number of survivors reported per country of origin?

	 SELECT country_of_origin, SUM(number_of_survivors)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY country_of_origin 
	 ORDER BY SUM(number_of_survivors) DESC


	 --What is the number of survivors reported per region of origin?

	 SELECT region_of_origin, SUM(number_of_survivors)
	 FROM migrant.dbo.missing_migrant
	 GROUP BY region_of_origin
	 ORDER BY SUM(number_of_survivors) DESC



