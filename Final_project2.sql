Create Database Final_project2;
USE Final_project2;

Create Table Station(ID Int Primary key,
City Char(20),
State Char(2),
LAT_N INT,
LONG_W Int);

Describe station;

Insert Into Station(ID, City, State, LAT_N, LONG_W)
Values
(13, "Phoenix", "AZ", 33, 112),
(44, "Denver", "CO", 40, 105),
(66, "Caribou", "ME", 47, 68);

Select * From station;

Select * 
From station 
Where LAT_N > 39.7;

Create Table STATS(ID INT, 
MONTH INT, 
TEMP_F DOUBLE, 
RAIN_I DOUBLE);

DROP TABLE STATS;

INSERT INTO STATS(ID, MONTH, TEMP_F, RAIN_I)
VALUES
(13, 1, 57.4, 0.31),
(13, 7, 91.7, 5.15),
(44, 1, 27.3, 0.18),
(44, 7, 74.8, 2.11),
(66, 1, 6.7, 2.1),
(66, 7, 65.8, 4.52);

Select * FROM STATS;


-- Execute a query to display temperature stats (from STATS table) for each city (from Station table). --
SELECT Station.ID, Station.city, STATS.TEMP_F
FROM Station INNER JOIN STATS on STATS.ID = STATION.ID;

-- Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged. 
-- It should also show the corresponding cities.--
SELECT Station.ID, Station.city, STATS.MONTH, STATS.Rain_I
FROM Station INNER JOIN STATS on STATS.ID = STATION.ID
ORDER BY MONTH, Rain_I DESC;

-- Execute a query to look at temperatures for July from table STATS, lowest temperatures first,
picking up city name and latitude.--
SELECT Station.ID, Station.city, station.LAT_N, STATS.MONTH, STATS.TEMP_F
FROM Station INNER JOIN STATS on STATS.ID = STATION.ID
WHERE MONTH = 7
ORDER BY TEMP_F ASC;

-- Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.--
SELECT  Station.city, Round(AVG(STATS.Rain_I), 2) as Avg_Rain, MAX(STATS.TEMP_F) as Max_Temp, MIN(STATS.TEMP_F) as MIN_Temp
FROM Station INNER JOIN STATS on STATS.ID = STATION.ID
Group by Station.city;

-- Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.--
SELECT Station.ID, Station.city, STATS.MONTH, 
Round((STATS.Rain_I *2.54),2) as Rain_CM, 
Round(((STATS.TEMP_F  - 32)*5/9), 2) as TEMP_Celcius 
FROM Station INNER JOIN STATS on STATS.ID = STATION.ID;

-- Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low. --
Update Stats
SET RAIN_I= Round((RAIN_I+0.01),2);

-- Update Denver's July temperature reading as 74.9--
Update Stats
INNER JOIN Station on STATS.ID = STATION.ID
Set Stats.TEMP_F = 74.9
Where MONTH = 7 and City= "Denver";


