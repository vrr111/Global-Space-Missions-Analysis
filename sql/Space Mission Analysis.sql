show databases;
USE Space_Mission_Analysis;

-- Database Validation

-- Check if data is imported correctly
SELECT *
FROM space_missions;

-- Count total number of missions
SELECT COUNT(*) AS Total_Missions
FROM space_missions;

-- View first 10 records
SELECT *
FROM space_missions
LIMIT 10;

-- Check for missing values
SELECT
SUM(CASE WHEN Company IS NULL THEN 1 ELSE 0 END) AS Company_Null,
SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Null,
SUM(CASE WHEN Rocket IS NULL THEN 1 ELSE 0 END) AS Rocket_Null,
SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS Price_Null,
SUM(CASE WHEN MissionStatus IS NULL THEN 1 ELSE 0 END) AS MissionStatus_Null
FROM space_missions;

-- Find first and last launch date
SELECT
MIN(Launch_DateTime) AS First_Launch,
MAX(Launch_DateTime) AS Last_Launch
FROM space_missions;

-- Count unique companies
SELECT COUNT(DISTINCT Company) AS Total_Companies
FROM space_missions;

-- Count unique rockets
SELECT COUNT(DISTINCT Rocket) AS Total_Rockets
FROM space_missions;

-- Count unique countries
SELECT COUNT(DISTINCT Country) AS Total_Countries
FROM space_missions;

-- Count unique launch sites
SELECT COUNT(DISTINCT Launch_Site) AS Total_Launch_Sites
FROM space_missions;

-- Display table structure
DESCRIBE space_missions;


-- Total successful and failed missions

SELECT MissionStatus,
       COUNT(*) AS Total_Missions
FROM space_missions
GROUP BY MissionStatus
ORDER BY Total_Missions DESC;


-- Total launches by rocket status

SELECT RocketStatus,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY RocketStatus;


-- Top 10 companies by number of launches

SELECT Company,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Company
ORDER BY Total_Launches DESC
LIMIT 10;


-- Top 10 countries by number of launches

SELECT Country,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Country
ORDER BY Total_Launches DESC
LIMIT 10;


-- Top 10 rockets used in missions

SELECT Rocket,
       COUNT(*) AS Total_Missions
FROM space_missions
GROUP BY Rocket
ORDER BY Total_Missions DESC
LIMIT 10;


-- Top 10 launch sites

SELECT Launch_Site,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Launch_Site
ORDER BY Total_Launches DESC
LIMIT 10;


-- Number of launches every year

SELECT Launch_Year,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Launch_Year
ORDER BY Launch_Year;


-- Number of launches by decade

SELECT Launch_Decade,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Launch_Decade
ORDER BY Launch_Decade;


-- Average launch price by company
-- Price ->  Cost of the rocket in millions of US dollars


SELECT Company,
       ROUND(AVG(Price),2) AS Average_Price
FROM space_missions
GROUP BY Company
ORDER BY Average_Price DESC;

-- Missions launched after the year 2000

SELECT *
FROM space_missions
WHERE Launch_Year >= 2000;


-- Top 10 most expensive missions

SELECT Mission,
       Company,
       Rocket,
       Price
FROM space_missions
ORDER BY Price DESC
LIMIT 10;


-- Top 10 cheapest missions

SELECT Mission,
       Company,
       Rocket,
       Price
FROM space_missions
ORDER BY Price
LIMIT 10;


-- Companies with more than 50 launches

SELECT Company,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Company
HAVING COUNT(*) > 50
ORDER BY Total_Launches DESC;


-- Countries with more than 100 launches

SELECT Country,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Country
HAVING COUNT(*) > 100
ORDER BY Total_Launches DESC;


-- Average launch price by country

SELECT Country,
       ROUND(AVG(Price),2) AS Average_Price
FROM space_missions
GROUP BY Country
ORDER BY Average_Price DESC;


-- Number of successful missions by company

SELECT Company,
       COUNT(*) AS Successful_Missions
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Company
ORDER BY Successful_Missions DESC;


-- Number of failed missions by company

SELECT Company,
       COUNT(*) AS Failed_Missions
FROM space_missions
WHERE MissionStatus <> 'Success'
GROUP BY Company
ORDER BY Failed_Missions DESC;


-- Launches by time of the day

SELECT Launch_Period,
       COUNT(*) AS Total_Launches
FROM space_missions
GROUP BY Launch_Period
ORDER BY Total_Launches DESC;


-- Average launch price by rocket status

SELECT RocketStatus,
       ROUND(AVG(Price),2) AS Average_Price
FROM space_missions
GROUP BY RocketStatus;

-- Company with the highest number of successful missions

SELECT Company,
       COUNT(*) AS Successful_Missions
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Company
ORDER BY Successful_Missions DESC
LIMIT 1;


-- Country with the highest number of successful missions

SELECT Country,
       COUNT(*) AS Successful_Missions
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Country
ORDER BY Successful_Missions DESC
LIMIT 1;


-- Top 5 rockets with the highest number of successful missions

SELECT Rocket,
       COUNT(*) AS Successful_Missions
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Rocket
ORDER BY Successful_Missions DESC
LIMIT 5;


-- Launch period with the highest number of successful missions

SELECT Launch_Period,
       COUNT(*) AS Successful_Missions
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Launch_Period
ORDER BY Successful_Missions DESC;


-- Rank companies by total launches

SELECT Company,
       COUNT(*) AS Total_Launches,
       RANK() OVER(ORDER BY COUNT(*) DESC) AS Company_Rank
FROM space_missions
GROUP BY Company;


-- Rank countries by successful missions

SELECT Country,
       COUNT(*) AS Successful_Missions,
       DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS Country_Rank
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Country;


-- Find missions that cost more than the average launch price

SELECT Mission,
       Company,
       Rocket,
       Price
FROM space_missions
WHERE Price >
(
    SELECT AVG(Price)
    FROM space_missions
)
ORDER BY Price DESC;


-- Calculate mission success percentage

SELECT
ROUND(
SUM(CASE WHEN MissionStatus='Success' THEN 1 ELSE 0 END)
*100.0/
COUNT(*),2
) AS Success_Percentage
FROM space_missions;


-- Top 5 companies based on average launch price

SELECT Company,
       ROUND(AVG(Price),2) AS Average_Price
FROM space_missions
GROUP BY Company
ORDER BY Average_Price DESC
LIMIT 5;


-- Year-wise mission success

SELECT Launch_Year,
       COUNT(*) AS Successful_Missions
FROM space_missions
WHERE MissionStatus='Success'
GROUP BY Launch_Year
ORDER BY Launch_Year;