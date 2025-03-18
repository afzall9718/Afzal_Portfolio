SELECT Year, concat(Country, Year), count(concat(Country, Year))
FROM world_life_expectancy
group by Country, Year
having count(concat(Country, Year)) > 1
;


SELECT * from world_life_expectancy;


SELECT  *
FROM (
	SELECT Row_ID, 
	concat(Country, Year), 
	ROW_NUMBER() OVER( PARTITION BY  concat(Country, Year) order by concat(Country, Year)) as row_num 
	FROM world_life_expectancy
	) as row_table
    where row_num >1
;
    
    
DELETE FROM world_life_expectancy
	where Row_ID IN (
    SELECT  Row_ID
FROM (
	SELECT Row_ID, 
	concat(Country, Year), 
	ROW_NUMBER() OVER( PARTITION BY  concat(Country, Year) order by concat(Country, Year)) as row_num 
	FROM world_life_expectancy
	) as row_table
    where row_num >1);
    





select distinct(status)
from world_life_expectancy ;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country= t2.Country
Set t1.status= 'Developing'
where t1.status = ""
AND t2.status <> ""
AND t2.status= 'Developing'; 




UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country= t2.Country
Set t1.status= 'Developed'
where t1.status = ""
AND t2.status <> ""
AND t2.status= 'Developed'; 


SELECT * from world_life_expectancy
where `Life expectancy` = "";


select t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country = t2.Country
AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
ON t1.Country = t3.Country
AND t1.Year = t3.Year +1
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country = t2.Country
AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
ON t1.Country = t3.Country
AND t1.Year = t3.Year +1
SET t1.`Life expectancy`= ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
where t1.`Life expectancy`='';









