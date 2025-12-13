-- Create Database
CREATE DATABASE TravelTourismDB;
USE TravelTourismDB;
DROP DATABASE TravelTourismDB;


---------------------------------------------------
-- Table 1: Countries
---------------------------------------------------
CREATE TABLE Countries (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL UNIQUE,
    iso_code CHAR(3) NOT NULL UNIQUE,
    region VARCHAR(100) NOT NULL,
    population BIGINT CHECK (population >= 0),
    currency VARCHAR(50) NOT NULL,
    language VARCHAR(50) NOT NULL,
    timezone VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO Countries (country_name, iso_code, region, population, currency, language, timezone)
VALUES
('India','IND','Asia',1380004385,'INR','Hindi','IST'),
('United States','USA','North America',331002651,'USD','English','EST'),
('France','FRA','Europe',65273511,'EUR','French','CET'),
('Japan','JPN','Asia',126476461,'JPY','Japanese','JST'),
('Australia','AUS','Oceania',25499884,'AUD','English','AEST'),
('Brazil','BRA','South America',212559417,'BRL','Portuguese','BRT'),
('Canada','CAN','North America',37742154,'CAD','English/French','EST'),
('Germany','DEU','Europe',83783942,'EUR','German','CET'),
('Italy','ITA','Europe',60461826,'EUR','Italian','CET'),
('UK','GBR','Europe',67886011,'GBP','English','GMT'),
('China','CHN','Asia',1439323776,'CNY','Mandarin','CST'),
('Russia','RUS','Europe/Asia',145934462,'RUB','Russian','MSK'),
('Spain','ESP','Europe',46754778,'EUR','Spanish','CET'),
('Mexico','MEX','North America',128932753,'MXN','Spanish','CST'),
('South Africa','ZAF','Africa',59308690,'ZAR','Zulu/English','SAST'),
('Egypt','EGY','Africa',102334404,'EGP','Arabic','EET'),
('Turkey','TUR','Europe/Asia',84339067,'TRY','Turkish','TRT'),
('Thailand','THA','Asia',69799978,'THB','Thai','ICT'),
('Singapore','SGP','Asia',5850342,'SGD','English/Malay','SGT'),
('UAE','ARE','Asia',9890402,'AED','Arabic','GST');

-- SELECT Queries
-- Select all records
SELECT * FROM Countries;

-- Select only country name and currency
SELECT country_name, currency FROM Countries;

-- Select countries in Asia
SELECT country_name, region, population FROM Countries WHERE region = 'Asia';

-- Select top 5 most populated countries
SELECT country_name, population FROM Countries ORDER BY population DESC LIMIT 5;

-- TRUNCATE TABLE
TRUNCATE TABLE Countries;

-- DROP TABLE
DROP TABLE Countries;

-- Add a new column
ALTER TABLE Countries ADD continent VARCHAR(50);

-- Modify a column
ALTER TABLE Countries MODIFY population BIGINT NOT NULL;

-- Drop a column
ALTER TABLE Countries DROP COLUMN continent;

-- Update population of India
UPDATE Countries
SET population = 1400000000
WHERE country_name = 'India';

-- Delete a country
DELETE FROM Countries
WHERE country_name = 'Singapore';

-- Sort countries by population descending
SELECT country_name, population
FROM Countries
ORDER BY population DESC;

-- Total population of all countries
SELECT SUM(population) AS total_population FROM Countries;

-- Average population
SELECT AVG(population) AS avg_population FROM Countries;

-- Operator Queries
-- Comparison Operators
-- Countries with population greater than 100 million
SELECT country_name, population
FROM Countries
WHERE population > 100000000;

-- Logical Operators
-- Countries in Asia OR Europe region
SELECT country_name, region
FROM Countries
WHERE region = 'Asia' OR region = 'Europe';

-- BETWEEN Operator
-- Countries with population between 50 million and 200 million
SELECT country_name, population
FROM Countries
WHERE population BETWEEN 50000000 AND 200000000;

-- IN Operator
-- Countries using Euro
SELECT country_name
FROM Countries
WHERE currency IN ('EUR');

-- Clauses
-- WHERE Clause
SELECT * FROM Countries
WHERE region = 'Asia';

-- ORDER BY Clause
SELECT country_name, population
FROM Countries
ORDER BY population DESC;

-- GROUP BY and HAVING
SELECT region, COUNT(*) AS total_countries
FROM Countries
GROUP BY region
HAVING COUNT(*) > 2;

-- LIMIT Clause
SELECT * FROM Countries
ORDER BY population DESC
LIMIT 5;

-- Alias
-- Column Alias
SELECT country_name AS Name, population AS Population
FROM Countries;

-- Table Alias
SELECT c.country_name, c.currency
FROM Countries AS c
WHERE c.region = 'Europe';

-- ON DELETE CASCADE and ON UPDATE CASCADE
CREATE TABLE Cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id)
        REFERENCES Countries(country_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO Cities (city_name, country_id)
VALUES ('Mumbai', 1), ('New York', 2), ('Tokyo', 4);
-- ON DELETE CASCADE:
DELETE FROM Countries WHERE country_id = 1; 

-- ON UPDATE CASCADE:
UPDATE Countries SET country_id = 50 WHERE country_name = 'Japan'; 

-- Scalar Subquery
SELECT country_name, population FROM Countries WHERE population > (SELECT AVG(population) FROM Countries);

-- Correlated Subquery
SELECT country_name, region, population FROM Countries c1 WHERE population = (
  SELECT MAX(c2.population)
  FROM Countries c2
  WHERE c2.region = c1.region
);

-- IN Subquery
SELECT country_name, region FROM Countries
WHERE region IN (
  SELECT region FROM Countries WHERE country_name IN ('Japan', 'India')
);

-- EXISTS Subquery
SELECT c.country_name FROM Countries c
WHERE EXISTS (
  SELECT 1 FROM Country_Economy e WHERE e.country_id = c.country_id
);

-- ANY and ALL Subquery
SELECT country_name, population FROM Countries
WHERE population > ANY (
  SELECT population FROM Countries WHERE region = 'Europe'
);


SELECT country_name, population
FROM Countries
WHERE population > ALL (
  SELECT population FROM Countries WHERE region = 'Europe'
);

-- Subquery in FROM Clause
SELECT region, AVG(population) AS avg_population
FROM (
  SELECT region, population FROM Countries
) AS region_data
GROUP BY region;

-- String Functions
SELECT 
  UPPER(country_name) AS UppercaseName,
  LOWER(region) AS LowercaseRegion,
  CONCAT(country_name, ' (', iso_code, ')') AS FullName,
  SUBSTRING(country_name, 1, 3) AS ShortCode
FROM Countries;

-- Numeric Functions
SELECT 
  country_name,
  ROUND(population / 1000000, 2) AS PopulationInMillions,
  FLOOR(population / 1000000000) AS BillionPart,
  CEIL(population / 1000000000) AS RoundedUpBillion
FROM Countries;

-- Date,Time Functions
SELECT 
  country_name,
  NOW() AS CurrentTime,
  CURDATE() AS CurrentDate,
  DATEDIFF(CURDATE(), '2000-01-01') AS DaysSince2000,
  YEAR(CURDATE()) AS CurrentYear,
  MONTH(CURDATE()) AS CurrentMonth
FROM Countries
LIMIT 5;

-- Aggregate Functions
SELECT 
  COUNT(*) AS TotalCountries,
  SUM(population) AS TotalPopulation,
  AVG(population) AS AvgPopulation,
  MIN(population) AS SmallestPopulation,
  MAX(population) AS LargestPopulation
FROM Countries;

-- User-Defined Function 
DELIMITER //

CREATE FUNCTION RegionCategory(region_name VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE msg VARCHAR(100);
    IF region_name LIKE '%Asia%' THEN
        SET msg = 'Asian Region';
    ELSEIF region_name LIKE '%Europe%' THEN
        SET msg = 'European Region';
    ELSEIF region_name LIKE '%America%' THEN
        SET msg = 'American Region';
    ELSE
        SET msg = 'Other Region';
    END IF;
    RETURN msg;
END //

DELIMITER ;


-- SIMPLE VIEW
CREATE VIEW Asian_Countries AS
SELECT country_name, iso_code, population, currency
FROM Countries
WHERE region LIKE '%Asia%';

-- Complex View With JOIN
CREATE VIEW Country_Currency_View AS
SELECT c.country_name, c.region, c.population,c.currency, ci.symbol
FROM Countries c
JOIN Currency_Info ci
ON c.currency = ci.currency;

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE GetCountriesByRegion(IN reg VARCHAR(100))
BEGIN
    SELECT country_name, iso_code, population, currency, language
    FROM Countries
    WHERE region LIKE CONCAT('%', reg, '%');
END //

DELIMITER ;

CALL GetCountriesByRegion('Asia');

-- WINDOW FUNCTIONS
SELECT country_name, region, population,
       RANK() OVER (PARTITION BY region ORDER BY population DESC) AS pop_rank
FROM Countries
WHERE region LIKE '%Asia%';


-- DCL Commands
-- creating a user
CREATE USER 'country_user'@'localhost' IDENTIFIED BY 'Password123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Countries TO 'country_user'@'localhost';

-- Revoke 
REVOKE INSERT ON Countries FROM 'country_user'@'localhost';

-- Applying changes
FLUSH PRIVILEGES;

-- TCL Commands
-- Transaction Example
START TRANSACTION;

UPDATE Countries
SET population = population + 10000
WHERE country_name = 'India';

SAVEPOINT sp1;

UPDATE Countries
SET population = population - 50000
WHERE country_name = 'China';

-- Rollback to savepoint
ROLLBACK TO sp1;

COMMIT;

-- TRIGGERS
CREATE TABLE Country_Update_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    old_population BIGINT,
    new_population BIGINT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger capturing population change
DELIMITER //

CREATE TRIGGER LogPopulationUpdate
BEFORE UPDATE ON Countries
FOR EACH ROW
BEGIN
    IF OLD.population <> NEW.population THEN
        INSERT INTO Country_Update_Log (country_id, old_population, new_population)
        VALUES (OLD.country_id, OLD.population, NEW.population);
    END IF;
END //

DELIMITER ;


-- -------------------------------------------------
-- Table 2: Cities
-- -------------------------------------------------
CREATE TABLE Cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    population INT CHECK (population >= 0),
    is_capital BOOLEAN DEFAULT FALSE,
    area_km2 DECIMAL(10,2),
    airport_code VARCHAR(10) UNIQUE,
    postal_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

INSERT INTO Cities (city_name, country_id, population, is_capital, area_km2, airport_code, postal_code)
VALUES
('New Delhi',1,18000000,TRUE,1484.0,'DEL','110001'),
('Mumbai',1,22000000,FALSE,603.0,'BOM','400001'),
('New York',2,8500000,FALSE,783.8,'JFK','10001'),
('Washington DC',2,700000,TRUE,177.0,'DCA','20001'),
('Paris',3,11000000,TRUE,105.4,'CDG','75000'),
('Tokyo',4,37000000,TRUE,2194.1,'HND','100-0001'),
('Sydney',5,5312000,TRUE,12367.7,'SYD','2000'),
('Rio de Janeiro',6,6748000,FALSE,1182.3,'GIG','20000-000'),
('Toronto',7,2809000,FALSE,630.2,'YYZ','M5H'),
('Berlin',8,3700000,TRUE,891.8,'BER','10115'),
('Rome',9,2873000,TRUE,1287.4,'FCO','00184'),
('London',10,8982000,TRUE,1572.0,'LHR','SW1A'),
('Beijing',11,21540000,TRUE,16410.5,'PEK','100000'),
('Moscow',12,11920000,TRUE,2511.0,'SVO','101000'),
('Madrid',13,6642000,TRUE,604.3,'MAD','28001'),
('Mexico City',14,9209944,TRUE,1485.0,'MEX','01000'),
('Cape Town',15,433688,FALSE,400.3,'CPT','8000'),
('Cairo',16,9900000,TRUE,606.0,'CAI','11511'),
('Bangkok',17,8281000,TRUE,1568.7,'BKK','10100'),
('Dubai',19,3331420,FALSE,4114.0,'DXB','00000');

-- SELECT Queries
-- Select all cities
SELECT * FROM Cities;

-- Select only capitals
SELECT city_name, population, country_id 
FROM Cities 
WHERE is_capital = TRUE;

-- Select cities with population over 10 million
SELECT city_name, population 
FROM Cities 
WHERE population > 10000000;

-- Select city along with its country name (JOIN with Countries)
SELECT c.city_name, co.country_name, c.population, c.is_capital
FROM Cities c
JOIN Countries co ON c.country_id = co.country_id;

-- TRUNCATE TABLE
TRUNCATE TABLE Cities;

-- DROP TABLE
DROP TABLE Cities;

-- Modify column population to BIGINT
ALTER TABLE Cities MODIFY population BIGINT NOT NULL;

-- Drop a column
ALTER TABLE Cities DROP COLUMN postal_code;

-- Update population of New Delhi
UPDATE Cities
SET population = 18500000
WHERE city_name = 'New Delhi';

-- Make Mumbai capital temporarily
UPDATE Cities
SET is_capital = TRUE
WHERE city_name = 'Mumbai';

-- Total population of all cities
SELECT SUM(population) AS total_population FROM Cities;

-- Average population of cities
SELECT AVG(population) AS avg_population FROM Cities;

-- Cities starting with 'M'
SELECT city_name FROM Cities
WHERE city_name LIKE 'M%';

-- Operators
-- Comparison Operators
-- Cities with population greater than 10 million
SELECT city_name, population
FROM Cities
WHERE population > 10000000;

-- Logical Operators
-- Cities in India or the USA having population more than 5 million
SELECT city_name, population FROM Cities WHERE (country_id IN (1, 2)) AND population > 5000000;

-- BETWEEN Operator
-- Cities with area between 500 and 2000 km²
SELECT city_name, area_km2 FROM Cities WHERE area_km2 BETWEEN 500 AND 2000;

-- LIKE Operator
-- Cities whose name starts with 'N'
SELECT city_name FROM Cities WHERE city_name LIKE 'N%';

-- Clauses
-- WHERE Clause
SELECT city_name, population FROM Cities WHERE is_capital = TRUE;

-- ORDER BY Clause
-- List cities in descending order of population
SELECT city_name, population FROM Cities ORDER BY population DESC;

-- LIMIT Clause
-- Show top 5 most populated cities
SELECT city_name, population FROM Cities ORDER BY population DESC LIMIT 5;

-- ALIAS Usage
-- Column Alias
SELECT city_name AS City, population AS Population, area_km2 AS "Area (km²)" FROM Cities;

-- Table Alias
-- Using alias 'c' for Cities table
SELECT c.city_name, c.population FROM Cities AS c WHERE c.is_capital = TRUE;

-- ON DELETE CASCADE and ON UPDATE CASCADE.

ALTER TABLE Cities
DROP FOREIGN KEY cities_ibfk_1,   -- name might vary, use SHOW CREATE TABLE Cities to check
ADD CONSTRAINT fk_country
FOREIGN KEY (country_id)
REFERENCES Countries(country_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Applying ON DELETE CASCADE
DELETE FROM Countries WHERE country_id = 1; 

-- Applying ON UPDATE CASCADE
UPDATE Countries SET country_id = 30 WHERE country_id = 2; 


-- JOINS
-- INNER JOIN
SELECT c.city_name, co.country_name, co.region, c.population AS city_population FROM Cities c
INNER JOIN Countries co ON c.country_id = co.country_id;

-- LEFT JOIN
SELECT co.country_name, c.city_name, c.population FROM Countries co
LEFT JOIN Cities c ON co.country_id = c.country_id;

-- RIGHT JOIN
SELECT co.country_name, c.city_name, co.region FROM Countries co
RIGHT JOIN Cities c ON co.country_id = c.country_id;

-- FULL OUTER JOIN
SELECT co.country_name, c.city_name FROM Countries co
LEFT JOIN Cities c ON co.country_id = c.country_id
UNION
SELECT co.country_name, c.city_name FROM Countries co
RIGHT JOIN Cities c ON co.country_id = c.country_id;

-- SELF JOIN
SELECT a.city_name AS City1, b.city_name AS City2, a.country_id
FROM Cities a
JOIN Cities b 
    ON a.country_id = b.country_id 
   AND a.city_id <> b.city_id
ORDER BY a.country_id;

-- CROSS JOIN
SELECT c.city_name, co.country_name
FROM Cities c
CROSS JOIN Countries co;

-- Scalar Subquery
SELECT 
    city_name, 
    population
FROM Cities
WHERE population > (SELECT AVG(population) FROM Cities);

-- Correlated Subquery
SELECT city_name, country_id, population FROM Cities c1
WHERE population = (
    SELECT MAX(c2.population)
    FROM Cities c2
    WHERE c2.country_id = c1.country_id
);

-- IN Subquery
SELECT city_name FROM Cities
WHERE country_id IN (
    SELECT country_id FROM Countries WHERE region = 'Asia'
);

-- EXISTS Subquery
SELECT country_name FROM Countries co
WHERE EXISTS (
    SELECT 1 FROM Cities c WHERE c.country_id = co.country_id
);

-- ANY Subquery 

SELECT city_name, population FROM Cities
WHERE population > ANY (
    SELECT population FROM Cities c
    JOIN Countries co ON c.country_id = co.country_id
    WHERE co.region = 'Europe'
);


--  ALL Subquery

SELECT city_name, population FROM Cities
WHERE population > ALL (
    SELECT population FROM Cities c
    JOIN Countries co ON c.country_id = co.country_id
    WHERE co.region = 'Europe'
);

-- Subquery in FROM Clause
SELECT co.country_name, t.avg_population FROM Countries co
JOIN (
    SELECT country_id, AVG(population) AS avg_population
    FROM Cities
    GROUP BY country_id
) t ON co.country_id = t.country_id;

-- String Functions
SELECT 
    UPPER(city_name) AS UpperCity,
    LOWER(postal_code) AS LowerPostal,
    CONCAT(city_name, ', ', (SELECT country_name FROM Countries WHERE country_id = Cities.country_id)) AS FullLocation,
    SUBSTRING(city_name, 1, 4) AS ShortName
FROM Cities;

-- Numeric Functions
SELECT 
    city_name,
    ROUND(area_km2, 0) AS RoundedArea,
    FLOOR(population / 1000000) AS Millions,
    CEIL(population / 1000000) AS CeilMillions
FROM Cities;

-- Date,Time Functions
SELECT 
    city_name,
    NOW() AS CurrentTimestamp,
    CURDATE() AS TodayDate,
    DATEDIFF(CURDATE(), created_at) AS DaysSinceAdded,
    YEAR(created_at) AS YearAdded,
    MONTH(created_at) AS MonthAdded
FROM Cities
LIMIT 5;

-- Aggregate Functions
SELECT 
    COUNT(*) AS TotalCities,
    SUM(population) AS TotalPopulation,
    AVG(population) AS AvgPopulation,
    MIN(population) AS MinPopulation,
    MAX(population) AS MaxPopulation
FROM Cities;

-- User-Defined Function (UDF)

DELIMITER //

CREATE FUNCTION CityCategory(pop INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(50);
    IF pop > 10000000 THEN
        SET category = 'Mega City';
    ELSEIF pop BETWEEN 1000000 AND 10000000 THEN
        SET category = 'Large City';
    ELSE
        SET category = 'Small City';
    END IF;
    RETURN category;
END //

DELIMITER ;

-- Use the UDF
SELECT 
    city_name, 
    population, 
    CityCategory(population) AS City_Size
FROM Cities;


-- SIMPLE VIEW
CREATE VIEW Capital_Cities AS
SELECT city_name, country_id, population, airport_code
FROM Cities
WHERE is_capital = TRUE;

-- COMPLEX VIEW
CREATE VIEW MegaCities AS
SELECT ci.city_name, ci.population, co.country_name, co.region
FROM Cities ci
JOIN Countries co
ON ci.country_id = co.country_id
WHERE ci.population > 10000000
ORDER BY ci.population DESC;

-- STORED PROCEDURE
Procedure to get cities of a specific country
DELIMITER //

CREATE PROCEDURE GetCitiesByCountry(IN countryName VARCHAR(100))
BEGIN
    SELECT ci.city_name, ci.population, ci.area_km2, ci.is_capital
    FROM Cities ci
    JOIN Countries co ON ci.country_id = co.country_id
    WHERE co.country_name = countryName;
END //

DELIMITER ;

-- Execute
CALL GetCitiesByCountry('India');


-- WINDOW FUNCTIONS
SELECT co.region, co.country_name, ci.city_name, ci.population,
       RANK() OVER (PARTITION BY co.region ORDER BY ci.population DESC) AS region_rank
FROM Cities ci
JOIN Countries co ON ci.country_id = co.country_id;


-- DCL COMMANDS
-- Create user
CREATE USER 'city_user'@'localhost' IDENTIFIED BY 'CityPass123';

--- Grant 
GRANT SELECT, INSERT, UPDATE ON Cities TO 'city_user'@'localhost';

-- Revoke 
REVOKE UPDATE ON Cities FROM 'city_user'@'localhost';

-- Reload privileges
FLUSH PRIVILEGES;

-- TCL COMMANDS
START TRANSACTION;

UPDATE Cities
SET population = population + 50000
WHERE city_name = 'Mumbai';

SAVEPOINT sp1;

UPDATE Cities
SET population = population - 100000
WHERE city_name = 'Tokyo';

-- Undo second update
ROLLBACK TO sp1;

COMMIT;

-- TRIGGERS
CREATE TABLE City_Update_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT,
    old_population INT,
    new_population INT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to log changes to population
DELIMITER //

CREATE TRIGGER LogCityPopulationUpdate
BEFORE UPDATE ON Cities
FOR EACH ROW
BEGIN
    IF OLD.population <> NEW.population THEN
        INSERT INTO City_Update_Log (city_id, old_population, new_population)
        VALUES (OLD.city_id, OLD.population, NEW.population);
    END IF;
END //

DELIMITER ;



-- -------------------------------------------------
-- Table 3: Destinations
-- -------------------------------------------------
CREATE TABLE Destinations (
    destination_id INT PRIMARY KEY AUTO_INCREMENT,
    city_id INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(50) CHECK (category IN ('Beach','Mountain','City','Historical','Cultural')),
    rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5),
    entry_fee DECIMAL(10,2) DEFAULT 0,
    open_hours VARCHAR(100),
    website VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- 20 destinations
INSERT INTO Destinations (city_id, name, description, category, rating, entry_fee, open_hours, website)
VALUES
(1,'Red Fort','Historical fort in Delhi','Historical',4.5,500,'9AM-6PM','www.redfortdelhi.in'),
(2,'Marine Drive','Seafront in Mumbai','City',4.3,0,'Open 24/7','www.mumbai.gov.in'),
(3,'Statue of Liberty','Iconic landmark','Cultural',4.7,2000,'9AM-5PM','www.statueofliberty.org'),
(5,'Eiffel Tower','Landmark of Paris','Cultural',4.8,2500,'9AM-11PM','www.toureiffel.paris'),
(6,'Mount Fuji','Volcanic mountain','Mountain',4.9,0,'Open 24/7','www.japantravel.jp'),
(7,'Sydney Opera House','Famous cultural venue','Cultural',4.7,1500,'10AM-9PM','www.sydneyoperahouse.com'),
(8,'Christ the Redeemer','Statue in Rio','Historical',4.6,800,'8AM-7PM','www.christtheredeemer.org'),
(9,'CN Tower','Iconic tower in Toronto','City',4.5,1200,'9AM-10PM','www.cntower.ca'),
(10,'Brandenburg Gate','Berlin landmark','Historical',4.6,0,'Open 24/7','www.visitberlin.de'),
(11,'Colosseum','Ancient amphitheater','Historical',4.7,1500,'8AM-7PM','www.colosseum.it'),
(12,'Big Ben','London clock tower','Historical',4.8,0,'Open 24/7','www.visitlondon.com'),
(13,'Great Wall','Ancient wall in Beijing','Historical',4.9,300,'7AM-6PM','www.greatwall.cn'),
(14,'Kremlin','Historic complex','Historical',4.7,1000,'9AM-5PM','www.kremlin.ru'),
(15,'Royal Palace','Madrid landmark','Cultural',4.5,800,'9AM-6PM','www.patrimonionacional.es'),
(16,'Zócalo','Central square of Mexico','City',4.4,0,'Open 24/7','www.mexicocity.com'),
(17,'Table Mountain','Cape Town mountain','Mountain',4.8,600,'7AM-7PM','www.tablemountain.net'),
(18,'Pyramids of Giza','Ancient pyramids','Historical',4.9,1000,'8AM-5PM','www.egypt.travel'),
(19,'Grand Palace','Bangkok cultural site','Cultural',4.7,500,'8:30AM-3:30PM','www.royalgrandpalace.th'),
(20,'Burj Khalifa','Tallest building','City',4.9,3000,'9AM-11PM','www.burjkhalifa.ae'),
(4,'Lincoln Memorial','Monument in Washington','Historical',4.6,0,'Open 24/7','www.nps.gov');

-- SELECT Queries 

-- Select all destinations
SELECT * FROM Destinations;

-- Select only Historical destinations
SELECT name, city_id, rating 
FROM Destinations 
WHERE category = 'Historical';

-- Select top 5 destinations by rating
SELECT name, category, rating 
FROM Destinations 
ORDER BY rating DESC 
LIMIT 5;

-- Select destinations with entry fee greater than 1000
SELECT name, entry_fee, city_id 
FROM Destinations 
WHERE entry_fee > 1000;

-- Join with Cities to get destination and city name
SELECT d.name AS destination, c.city_name, d.category, d.rating
FROM Destinations d
JOIN Cities c ON d.city_id = c.city_id;

-- TRUNCATE TABLE
TRUNCATE TABLE Destinations;

-- DROP TABLE
DROP TABLE Destinations;

-- Update entry fee for Red Fort
UPDATE Destinations
SET entry_fee = 600
WHERE name = 'Red Fort';

-- Delete a destination
DELETE FROM Destinations
WHERE name = 'Burj Khalifa';

-- Free entry destinations
SELECT name, entry_fee FROM Destinations
WHERE entry_fee = 0;

-- Count destinations per category
SELECT category, COUNT(*) AS total_destinations
FROM Destinations
GROUP BY category;

-- Operators
-- Comparison Operators
-- Destinations with rating greater than 4.7
SELECT name, rating FROM Destinations WHERE rating > 4.7;

-- Logical Operators 
-- Cultural or Historical destinations with entry fee more than 1000
SELECT name, category, entry_fee FROM Destinations WHERE (category = 'Cultural' OR category = 'Historical') AND entry_fee > 1000;

-- BETWEEN Operator
-- Destinations with entry fee between 500 and 2000
SELECT name, entry_fee FROM Destinations WHERE entry_fee BETWEEN 500 AND 2000;

-- LIKE Operator
-- Destinations whose name contains the word 'Tower'
SELECT name FROM Destinations WHERE name LIKE '%Tower%';

-- CLAUSES
-- WHERE Clause
-- Show all historical destinations
SELECT name, category FROM Destinations WHERE category = 'Historical';

-- ORDER BY Clause
-- Sort destinations by rating (highest first)
SELECT name, category, rating FROM Destinations ORDER BY rating DESC;

-- LIMIT Clause
-- Top 5 highest-rated destinations
SELECT name, rating FROM Destinations ORDER BY rating DESC LIMIT 5;

-- DISTINCT Clause
-- Show distinct destination categories
SELECT DISTINCT category FROM Destinations;

-- ALIAS
-- Column Alias
SELECT name AS Destination, rating AS Rating, entry_fee AS "Entry Fee (₹)" FROM Destinations;

-- Table Alias
SELECT d.name, d.category, d.rating FROM Destinations AS d WHERE d.rating >= 4.8;

-- ON DELETE CASCADE and ON UPDATE CASCADE
-- Alter Table to Add Cascades
ALTER TABLE Destinations
DROP FOREIGN KEY destinations_ibfk_1,  -- key name may differ; check using SHOW CREATE TABLE Destinations
ADD CONSTRAINT fk_city
FOREIGN KEY (city_id)
REFERENCES Cities(city_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ON DELETE CASCADE
DELETE FROM Cities
WHERE city_id = 5;  -- Deletes city 'Sydney' and also 'Sydney Opera House' from Destinations

-- ON UPDATE CASCADE
UPDATE Cities SET city_id = 25 WHERE city_id = 3;   -- All destinations linked to city_id 3 (New York) will update to 25 automatically


-- JOINS
-- INNER JOIN
SELECT d.name AS Destination, c.city_name AS City, co.country_name AS Country, d.category, d.rating
FROM Destinations d
INNER JOIN Cities c ON d.city_id = c.city_id
INNER JOIN Countries co ON c.country_id = co.country_id;

-- LEFT JOIN
SELECT c.city_name, d.name AS Destination, d.category
FROM Cities c
LEFT JOIN Destinations d ON c.city_id = d.city_id;

-- RIGHT JOIN
SELECT c.city_name, d.name AS Destination, d.category
FROM Cities c
RIGHT JOIN Destinations d ON c.city_id = d.city_id;

-- FULL OUTER JOIN 
SELECT c.city_name, d.name AS Destination FROM Cities c
LEFT JOIN Destinations d ON c.city_id = d.city_id
UNION
SELECT c.city_name, d.name AS Destination FROM Cities c
RIGHT JOIN Destinations d ON c.city_id = d.city_id;

-- SELF JOIN
SELECT a.name AS Destination1, b.name AS Destination2, a.category
FROM Destinations a
JOIN Destinations b 
    ON a.category = b.category 
   AND a.destination_id <> b.destination_id
ORDER BY a.category;

-- CROSS JOIN
SELECT d.name AS Destination, co.country_name
FROM Destinations d
CROSS JOIN Countries co;

-- Scalar Subquery
SELECT name, rating
FROM Destinations
WHERE rating > (SELECT AVG(rating) FROM Destinations);

-- Correlated Subquery
SELECT name, category, rating
FROM Destinations d1
WHERE rating = (
    SELECT MAX(d2.rating)
    FROM Destinations d2
    WHERE d2.category = d1.category
);

-- IN Subquery
SELECT d.name, d.category
FROM Destinations d
WHERE d.city_id IN (
    SELECT c.city_id 
    FROM Cities c 
    JOIN Countries co ON c.country_id = co.country_id
    WHERE co.region = 'Asia'
);

-- EXISTS Subquery
SELECT c.city_name FROM Cities c
WHERE EXISTS (
    SELECT 1 FROM Destinations d WHERE d.city_id = c.city_id
);

-- ANY Subquery

SELECT d.name, d.entry_fee
FROM Destinations d
WHERE d.entry_fee > ANY (
    SELECT d2.entry_fee
    FROM Destinations d2
    JOIN Cities c ON d2.city_id = c.city_id
    JOIN Countries co ON c.country_id = co.country_id
    WHERE co.region = 'Europe'
);

-- ALL Subquery

SELECT d.name, d.entry_fee
FROM Destinations d
WHERE d.entry_fee > ALL (
    SELECT d2.entry_fee
    FROM Destinations d2
    JOIN Cities c ON d2.city_id = c.city_id
    JOIN Countries co ON c.country_id = co.country_id
    WHERE co.region = 'Europe'
);

-- Subquery in FROM Clause

SELECT category, AVG(entry_fee) AS avg_fee
FROM (
    SELECT category, entry_fee FROM Destinations
) AS category_data
GROUP BY category;

-- String Functions
SELECT 
    UPPER(name) AS UpperName,
    LOWER(category) AS LowerCategory,
    CONCAT(name, ' - ', category) AS FullDescription,
    SUBSTRING(name, 1, 5) AS ShortName
FROM Destinations;

-- Numeric Functions
SELECT 
    name,
    ROUND(entry_fee, 0) AS RoundedFee,
    FLOOR(rating) AS RatingFloor,
    CEIL(rating) AS RatingCeil
FROM Destinations;

-- Date,Time Functions
SELECT 
    name,
    NOW() AS CurrentTimestamp,
    CURDATE() AS Today,
    DATEDIFF(CURDATE(), created_at) AS DaysSinceAdded,
    YEAR(created_at) AS YearAdded,
    MONTH(created_at) AS MonthAdded
FROM Destinations
LIMIT 5;

-- Aggregate Functions
SELECT 
    COUNT(*) AS TotalDestinations,
    AVG(rating) AS AverageRating,
    SUM(entry_fee) AS TotalEntryFees,
    MIN(entry_fee) AS MinFee,
    MAX(entry_fee) AS MaxFee
FROM Destinations;

-- User-Defined Function 

DELIMITER //

CREATE FUNCTION RatingCategory(r DECIMAL(2,1))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(50);
    IF r >= 4.8 THEN
        SET category = 'Excellent';
    ELSEIF r >= 4.5 THEN
        SET category = 'Very Good';
    ELSEIF r >= 4.0 THEN
        SET category = 'Good';
    ELSE
        SET category = 'Average';
    END IF;
    RETURN category;
END //

DELIMITER ;

-- Use the function:
SELECT 
    name, 
    rating, 
    RatingCategory(rating) AS Rating_Level
FROM Destinations;


-- SIMPLE VIEW
CREATE VIEW Top_Rated_Destinations AS
SELECT name, category, rating, city_id
FROM Destinations
WHERE rating >= 4.5;

-- COMPLEX VIEW WITH JOINS AND AGGREGATES
CREATE VIEW Country_Destination_Stats AS
SELECT co.country_name,
       COUNT(d.destination_id) AS total_destinations,
       AVG(d.rating) AS avg_rating
FROM Countries co
JOIN Cities c ON co.country_id = c.country_id
JOIN Destinations d ON c.city_id = d.city_id
GROUP BY co.country_name;

-- STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetDestinationsByCategory(IN cat VARCHAR(50))
BEGIN
    SELECT d.name, d.rating, d.entry_fee, c.city_name, co.country_name
    FROM Destinations d
    JOIN Cities c ON d.city_id = c.city_id
    JOIN Countries co ON c.country_id = co.country_id
    WHERE d.category = cat;
END //

DELIMITER ;

-- Execute
CALL GetDestinationsByCategory('Historical');

-- WINDOW FUNCTIONS
SELECT name, category, rating,
       RANK() OVER (PARTITION BY category ORDER BY rating DESC) AS category_rank
FROM Destinations;

-- DCL COMMANDS
-- Create user
CREATE USER 'dest_user'@'localhost' IDENTIFIED BY 'DestPass123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Destinations TO 'dest_user'@'localhost';

-- Revoke 
REVOKE UPDATE ON Destinations FROM 'dest_user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- TCL COMMANDS
START TRANSACTION;

UPDATE Destinations
SET entry_fee = entry_fee + 100
WHERE category = 'Historical';

SAVEPOINT sp1;

UPDATE Destinations
SET rating = rating - 0.3
WHERE name = 'Burj Khalifa';

-- Undo second update
ROLLBACK TO sp1;

COMMIT;

-- TRIGGERS
CREATE TABLE Destination_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT,
    old_rating DECIMAL(2,1),
    new_rating DECIMAL(2,1),
    old_fee DECIMAL(10,2),
    new_fee DECIMAL(10,2),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to log rating or entry_fee changes
DELIMITER //

CREATE TRIGGER Log_Destination_Changes
BEFORE UPDATE ON Destinations
FOR EACH ROW
BEGIN
    IF OLD.rating <> NEW.rating OR OLD.entry_fee <> NEW.entry_fee THEN
        INSERT INTO Destination_Log(destination_id, old_rating, new_rating, old_fee, new_fee)
        VALUES (
            OLD.destination_id,
            OLD.rating, NEW.rating,
            OLD.entry_fee, NEW.entry_fee
        );
    END IF;
END //

DELIMITER ;



-- -------------------------------------------------
-- Table 4: Hotels
-- -------------------------------------------------
CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT NOT NULL,
    hotel_name VARCHAR(150) NOT NULL,
    address VARCHAR(255) NOT NULL,
    star_rating INT CHECK (star_rating BETWEEN 1 AND 5),
    contact_number VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    price_per_night DECIMAL(10,2) CHECK (price_per_night > 0),
    rooms_available INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

-- 20 hotels
INSERT INTO Hotels (destination_id, hotel_name, address, star_rating, contact_number, email, price_per_night, rooms_available)
VALUES
(1,'Delhi Palace','Chandni Chowk, Delhi',5,'911234567890','info@delhipalace.com',8000,50),
(2,'Sea View Hotel','Marine Drive, Mumbai',4,'912345678901','contact@seaview.com',6000,40),
(3,'NYC Grand','Manhattan, New York',5,'19876543210','stay@nycgrand.com',25000,100),
(5,'Paris Luxury Inn','Champs Elysees, Paris',5,'33123456789','book@parisluxury.com',20000,60),
(6,'Fuji Resort','Mount Fuji area, Japan',4,'81123456789','hello@fujiresort.jp',15000,30),
(7,'Opera House Hotel','Sydney Harbour',5,'61234567890','opera@sydney.com',18000,80),
(8,'Rio Beach Hotel','Copacabana, Rio',4,'552134567890','rio@beach.com',9000,45),
(9,'Toronto Central','Downtown Toronto',4,'14161234567','info@torontohotel.ca',12000,50),
(10,'Berlin Central Inn','Alexanderplatz, Berlin',4,'491234567890','berlin@central.de',10000,70),
(11,'Roma Heritage','Colosseum area, Rome',5,'39061234567','book@romahotel.it',15000,65),
(12,'London Royal','Westminster, London',5,'442012345678','contact@londonroyal.co.uk',22000,90),
(13,'Beijing Wall View','Great Wall area',4,'861234567890','wallview@bj.cn',8000,40),
(14,'Moscow Imperial','Red Square, Moscow',5,'74951234567','moscow@imperial.ru',14000,55),
(15,'Madrid Central','Puerta del Sol, Madrid',4,'341234567890','central@madrid.es',9000,50),
(16,'Mexico Plaza','Zócalo, Mexico City',3,'521234567890','plaza@mexico.mx',7000,60),
(17,'Cape Town Lodge','Waterfront, Cape Town',4,'271234567890','capetown@lodge.za',8500,35),
(18,'Cairo Pyramids Hotel','Giza area, Cairo',5,'201234567890','cairo@pyramids.eg',12000,75),
(19,'Bangkok Royal','Siam Square, Bangkok',4,'661234567890','royal@bangkok.th',9500,40),
(20,'Dubai Sky Hotel','Downtown Dubai',5,'971234567890','sky@dubai.ae',25000,100);

-- SELECT Queries 
-- Select all hotels
SELECT * FROM Hotels;

-- Select 5-star hotels only
SELECT hotel_name, address, price_per_night 
FROM Hotels 
WHERE star_rating = 5;

-- Select hotels with price < 10,000
SELECT hotel_name, price_per_night, rooms_available
FROM Hotels
WHERE price_per_night < 10000;

-- Select hotels with available rooms > 50
SELECT hotel_name, rooms_available 
FROM Hotels 
WHERE rooms_available > 50;

-- TRUNCATE TABLE
TRUNCATE TABLE Hotels;

-- DROP TABLE
DROP TABLE Hotels;

-- Add a column for hotel website
ALTER TABLE Hotels ADD website VARCHAR(200);

-- Add a column for hotel website
ALTER TABLE Hotels ADD website VARCHAR(200);

-- Update price per night for Delhi Palace
UPDATE Hotels
SET price_per_night = 8500
WHERE hotel_name = 'Delhi Palace';

-- Hotels with 5-star rating
SELECT hotel_name, star_rating FROM Hotels
WHERE star_rating = 5;

-- Hotels under 10000 per night
SELECT hotel_name, price_per_night FROM Hotels
WHERE price_per_night < 10000;

-- Average price per night
SELECT AVG(price_per_night) AS avg_price FROM Hotels;

-- Maximum rooms available
SELECT MAX(rooms_available) AS max_rooms FROM Hotels;

-- OPERATORS
-- Comparison Operators
-- Hotels with star rating equal to 5
SELECT hotel_name, star_rating FROM Hotels WHERE star_rating = 5;

-- Logical Operators
-- 5-star hotels with price per night above ₹15,000
SELECT hotel_name, star_rating, price_per_night FROM Hotels WHERE star_rating = 5 AND price_per_night > 15000;

-- BETWEEN Operator
-- Hotels with prices between ₹8,000 and ₹15,000
SELECT hotel_name, price_per_night FROM Hotels WHERE price_per_night BETWEEN 8000 AND 15000;

-- IN Operator
-- Hotels in selected destinations
SELECT hotel_name, destination_id FROM Hotels WHERE destination_id IN (1, 5, 12, 20);

-- CLAUSES
-- WHERE Clause
-- All 4-star hotels
SELECT hotel_name, star_rating FROM Hotels WHERE star_rating = 4;

-- ORDER BY Clause
-- Hotels sorted by price per night 
SELECT hotel_name, price_per_night FROM Hotels ORDER BY price_per_night DESC;

-- DISTINCT Clause
-- Show unique star ratings available
SELECT DISTINCT star_rating FROM Hotels;

-- ALIAS 
-- Column Alias
SELECT hotel_name AS "Hotel", price_per_night AS "Price (₹)", rooms_available AS "Available Rooms" FROM Hotels;

-- Table Alias
SELECT h.hotel_name, h.star_rating, h.price_per_night FROM Hotels AS h WHERE h.star_rating >= 4;

-- ON DELETE CASCADE and ON UPDATE CASCADE
-- ALTER TABLE Hotels
DROP FOREIGN KEY hotels_ibfk_1   -- key name may vary; use SHOW CREATE TABLE Hotels to confirm
ADD CONSTRAINT fk_destination
FOREIGN KEY (destination_id)
REFERENCES Destinations(destination_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ON DELETE CASCADE
DELETE FROM Destinations WHERE destination_id = 12; -- Deletes destination 'Big Ben' and its hotel 'London Royal'

-- ON UPDATE CASCADE
UPDATE Destinations SET destination_id = 50 WHERE destination_id = 7; -- All hotels linked to destination_id 7 (Sydney Opera House) now link to 50


-- JOINS
-- INNER JOIN
SELECT h.hotel_name,d.name AS destination_name,c.city_name,h.star_rating,d.category
FROM Hotels h
INNER JOIN Destinations d ON h.destination_id = d.destination_id
INNER JOIN Cities c ON d.city_id = c.city_id;

-- LEFT JOIN

SELECT d.name AS destination_name,h.hotel_name,c.city_name,d.category
FROM Destinations d
LEFT JOIN Hotels h ON d.destination_id = h.destination_id
LEFT JOIN Cities c ON d.city_id = c.city_id;

-- RIGHT JOIN
SELECT h.hotel_name,d.name AS destination_name,c.city_name,h.star_rating
FROM Hotels h
RIGHT JOIN Destinations d ON h.destination_id = d.destination_id
RIGHT JOIN Cities c ON d.city_id = c.city_id;

-- FULL OUTER JOIN
SELECT d.name AS destination_name,h.hotel_name,c.city_name
FROM Destinations d
LEFT JOIN Hotels h ON d.destination_id = h.destination_id
LEFT JOIN Cities c ON d.city_id = c.city_id
UNION
SELECT d.name AS destination_name,h.hotel_name,c.city_name
FROM Destinations d
RIGHT JOIN Hotels h ON d.destination_id = h.destination_id
RIGHT JOIN Cities c ON d.city_id = c.city_id;

-- SELF JOIN
SELECT d1.name AS Destination1, d2.name AS Destination2, c.city_name
FROM Destinations d1
JOIN Destinations d2 
  ON d1.city_id = d2.city_id 
 AND d1.destination_id <> d2.destination_id
JOIN Cities c ON d1.city_id = c.city_id;

-- CROSS JOIN
SELECT h.hotel_name, d.name AS destination_name
FROM Hotels h
CROSS JOIN Destinations d;

-- Scalar Subquery
SELECT hotel_name, price_per_night FROM Hotels WHERE price_per_night > (SELECT AVG(price_per_night) FROM Hotels);

-- Correlated Subquery
SELECT h1.hotel_name, h1.rooms_available FROM Hotels h1
WHERE h1.rooms_available > (
    SELECT AVG(h2.rooms_available)
    FROM Hotels h2
    WHERE h2.destination_id = h1.destination_id
);

-- IN Subquery
SELECT hotel_name FROM Hotels
WHERE destination_id IN (
    SELECT destination_id FROM Destinations WHERE country IN ('India', 'Japan')
);

-- EXISTS Subquery
SELECT destination_name FROM Destinations d
WHERE EXISTS (
    SELECT 1 FROM Hotels h 
    WHERE h.destination_id = d.destination_id AND h.star_rating = 5
);

-- ALL Subquery
SELECT hotel_name, price_per_night FROM Hotels
WHERE price_per_night < ALL (
    SELECT price_per_night FROM Hotels WHERE star_rating = 5
);

-- Subquery in FROM Clause
SELECT 
    star_rating, 
    ROUND(AVG(price_per_night),2) AS avg_price
FROM (
    SELECT star_rating, price_per_night FROM Hotels
) AS temp
GROUP BY star_rating;

-- String Functions
SELECT UPPER(hotel_name) AS UpperName FROM Hotels;

SELECT LOWER(email) AS LowerEmail FROM Hotels;

-- Concatenate
SELECT CONCAT(hotel_name, ' - ', address) AS FullDetails FROM Hotels;

-- Substring
SELECT SUBSTRING(hotel_name, 1, 5) AS ShortName FROM Hotels;

-- Numeric Functions
-- Round
SELECT hotel_name, ROUND(price_per_night, -3) AS RoundedPrice FROM Hotels;

-- Floor
SELECT hotel_name, FLOOR(price_per_night/1000) AS PriceK FROM Hotels;

-- Ceil
SELECT hotel_name, CEIL(price_per_night/1000) AS PriceK_Ceiled FROM Hotels;

-- Date,Time Functions
-- Current timestamp
SELECT hotel_name, NOW() AS CurrentTime FROM Hotels;

-- Current date
SELECT CURDATE() AS Today;

-- Days since created
SELECT hotel_name, DATEDIFF(CURDATE(), created_at) AS DaysSinceAdded FROM Hotels;

-- Extract year and month
SELECT hotel_name, YEAR(created_at) AS CreatedYear, MONTH(created_at) AS CreatedMonth FROM Hotels;

-- Aggregate Functions
SELECT 
    COUNT(*) AS TotalHotels,
    SUM(price_per_night) AS TotalRevenuePotential,
    AVG(price_per_night) AS AvgPrice,
    MIN(price_per_night) AS Cheapest,
    MAX(price_per_night) AS MostExpensive
FROM Hotels;

-- User-Defined Function

DELIMITER //
CREATE FUNCTION GetDiscountedPrice(original DECIMAL(10,2), discount_percent INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN original - (original * discount_percent / 100);
END //
DELIMITER ;

-- Use the function
SELECT 
    hotel_name, 
    price_per_night,
    GetDiscountedPrice(price_per_night, 10) AS DiscountedPrice
FROM Hotels;


-- SIMPLE VIEW
CREATE VIEW Five_Star_Hotels AS
SELECT hotel_name, address, price_per_night, rooms_available
FROM Hotels
WHERE star_rating = 5;

-- COMPLEX VIEW 
CREATE VIEW Country_FiveStar_Stats AS
SELECT co.country_name,
       COUNT(*) AS total_fivestar,
       AVG(h.price_per_night) AS avg_fivestar_price
FROM Hotels h
JOIN Destinations d ON h.destination_id = d.destination_id
JOIN Cities c ON d.city_id = c.city_id
JOIN Countries co ON c.country_id = co.country_id
WHERE h.star_rating = 5
GROUP BY co.country_name;

-- STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetHotelsByDestination(IN destName VARCHAR(150))
BEGIN
    SELECT h.hotel_name, h.star_rating, h.price_per_night, h.rooms_available,
           d.name AS destination_name
    FROM Hotels h
    JOIN Destinations d ON h.destination_id = d.destination_id
    WHERE d.name = destName;
END //

DELIMITER ;

-- Execute
CALL GetHotelsByDestination('Eiffel Tower');

-- WINDOW FUNCTIONS
SELECT hotel_name, price_per_night, rooms_available,
       SUM(rooms_available) OVER (ORDER BY price_per_night DESC) AS running_rooms
FROM Hotels;

-- DCL COMMANDS
-- Create user for hotel management
CREATE USER 'hotel_user'@'localhost' IDENTIFIED BY 'HotelPass123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Hotels TO 'hotel_user'@'localhost';

-- Revoke 
REVOKE UPDATE ON Hotels FROM 'hotel_user'@'localhost';

-- Reload permissions
FLUSH PRIVILEGES;

-- TCL COMMANDS
START TRANSACTION;

UPDATE Hotels
SET price_per_night = price_per_night + 500
WHERE star_rating = 5;

SAVEPOINT sp1;

UPDATE Hotels
SET rooms_available = rooms_available - 10
WHERE hotel_name = 'Dubai Sky Hotel';

-- Undo second update
ROLLBACK TO sp1;

COMMIT;

-- TRIGGERS
CREATE TABLE Hotel_Update_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    old_rooms INT,
    new_rooms INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to log hotel price or room changes
DELIMITER //

CREATE TRIGGER LogHotelUpdates
BEFORE UPDATE ON Hotels
FOR EACH ROW
BEGIN
    IF OLD.price_per_night <> NEW.price_per_night
       OR OLD.rooms_available <> NEW.rooms_available THEN
        INSERT INTO Hotel_Update_Log (hotel_id, old_price, new_price, old_rooms, new_rooms)
        VALUES (OLD.hotel_id, OLD.price_per_night, NEW.price_per_night,
                OLD.rooms_available, NEW.rooms_available);
    END IF;
END //

DELIMITER ;



-- -------------------------------------------------
-- Table 5: Flights
-- -------------------------------------------------
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    departure_city_id INT NOT NULL,
    arrival_city_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    airline VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    seats_available INT DEFAULT 100,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (departure_city_id) REFERENCES Cities(city_id),
    FOREIGN KEY (arrival_city_id) REFERENCES Cities(city_id)
);

-- 20 flights
INSERT INTO Flights (flight_number, departure_city_id, arrival_city_id, departure_time, arrival_time, airline, price, seats_available)
VALUES
('AI101',1,2,'2025-10-01 09:00:00','2025-10-01 11:00:00','Air India',5500,120),
('DL202',2,3,'2025-10-05 18:00:00','2025-10-05 22:00:00','Delta Airlines',45000,80),
('AF303',5,3,'2025-10-10 07:30:00','2025-10-10 12:30:00','Air France',52000,90),
('JL404',6,5,'2025-10-15 14:00:00','2025-10-15 19:00:00','Japan Airlines',47000,100),
('QF505',7,2,'2025-10-20 20:00:00','2025-10-21 04:00:00','Qantas',60000,85),
('EK606',20,12,'2025-11-01 02:00:00','2025-11-01 07:00:00','Emirates',35000,70),
('BA707',12,10,'2025-11-02 06:00:00','2025-11-02 08:30:00','British Airways',20000,95),
('LH808',10,13,'2025-11-03 08:00:00','2025-11-03 11:30:00','Lufthansa',18000,100),
('TK909',13,14,'2025-11-04 10:00:00','2025-11-04 15:00:00','Turkish Airlines',25000,110),
('SQ010',19,20,'2025-11-05 22:00:00','2025-11-06 02:00:00','Singapore Airlines',30000,75),
('AI111',1,5,'2025-11-06 09:00:00','2025-11-06 18:00:00','Air India',20000,60),
('UA212',3,4,'2025-11-07 11:00:00','2025-11-07 14:00:00','United Airlines',28000,100),
('CX313',11,19,'2025-11-08 15:00:00','2025-11-08 20:00:00','Cathay Pacific',32000,85),
('VA414',7,16,'2025-11-09 17:00:00','2025-11-09 23:00:00','Virgin Australia',27000,95),
('ET515',15,18,'2025-11-10 19:00:00','2025-11-11 01:00:00','Ethiopian Airlines',15000,80),
('QR616',20,6,'2025-11-11 21:00:00','2025-11-12 06:00:00','Qatar Airways',36000,90),
('KE717',6,11,'2025-11-12 08:00:00','2025-11-12 14:00:00','Korean Air',40000,70),
('SU818',14,12,'2025-11-13 09:00:00','2025-11-13 13:30:00','Aeroflot',22000,85),
('AZ919',9,11,'2025-11-14 13:00:00','2025-11-14 15:30:00','Alitalia',18000,100),
('IB020',15,16,'2025-11-15 14:00:00','2025-11-15 18:00:00','Iberia',20000,75);

-- SELECT Queries 

-- Select all flights
SELECT * FROM Flights;

-- Find flights by a specific airline
SELECT flight_number, airline, price 
FROM Flights 
WHERE airline = 'Air India';

-- Find flights with price less than 25,000
SELECT flight_number, airline, price 
FROM Flights 
WHERE price < 25000;

-- Find flights with available seats > 90
SELECT flight_number, airline, seats_available 
FROM Flights 
WHERE seats_available > 90;

-- TRUNCATE TABLE
TRUNCATE TABLE Flights;

-- DROP TABLE
DROP TABLE Flights;

-- Modify price column precision
ALTER TABLE Flights MODIFY price DECIMAL(12,2);

-- Drop a column
ALTER TABLE Flights DROP COLUMN duration_minutes;

-- Update flight price for DL202
UPDATE Flights
SET price = 47000
WHERE flight_number = 'DL202';

-- Delete a flight
DELETE FROM Flights
WHERE flight_number = 'IB020';

-- Flights cheaper than 20000
SELECT flight_number, price FROM Flights
WHERE price < 20000;

-- Flights operated by airlines containing 'Air'
SELECT flight_number, airline FROM Flights
WHERE airline LIKE '%Air%';

-- Operators 
-- Comparison Operators
SELECT flight_number, airline, price FROM Flights WHERE price > 30000;

-- Logical Operators
SELECT flight_number, airline, price, seats_available FROM Flights WHERE price BETWEEN 20000 AND 40000 AND seats_available > 80;

-- IN Operator
SELECT flight_number, airline FROM Flights WHERE airline IN ('Air India', 'Emirates', 'Qatar Airways');

-- Arithmetic Operators
SELECT flight_number, price, (price * 0.10) AS discount_amount FROM Flights;

-- Clauses Examples
-- ORDER BY
SELECT flight_number, airline, price FROM Flights ORDER BY price DESC;

-- GROUP BY and HAVING
SELECT airline, COUNT(*) AS total_flights, AVG(price) AS avg_price FROM Flights GROUP BY airline HAVING COUNT(*) > 1;

-- Aliases 
-- Column Alias
SELECT flight_number AS FlightNo, airline AS AirlineName, price AS TicketPrice FROM Flights;

-- Table Alias
SELECT f.flight_number, f.airline, f.price FROM Flights AS f WHERE f.price > 25000;

-- ON DELETE CASCADE and ON UPDATE CASCADE
ALTER TABLE Flights
DROP FOREIGN KEY Flights_ibfk_1,
DROP FOREIGN KEY Flights_ibfk_2;

ALTER TABLE Flights
ADD CONSTRAINT fk_departure
FOREIGN KEY (departure_city_id) REFERENCES Cities(city_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Flights
ADD CONSTRAINT fk_arrival
FOREIGN KEY (arrival_city_id) REFERENCES Cities(city_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- JOINS
-- INNER JOIN 
SELECT f.flight_number, c1.city_name AS departure_city, c2.city_name AS arrival_city, f.airline, f.price
FROM Flights f
INNER JOIN Cities c1 ON f.departure_city_id = c1.city_id
INNER JOIN Cities c2 ON f.arrival_city_id = c2.city_id;

-- LEFT JOIN
SELECT f.flight_number, c1.city_name AS departure_city, c2.city_name AS arrival_city, f.price
FROM Flights f
LEFT JOIN Cities c1 ON f.departure_city_id = c1.city_id
LEFT JOIN Cities c2 ON f.arrival_city_id = c2.city_id;

-- RIGHT JOIN 
SELECT f.flight_number, c1.city_name AS departure_city, c2.city_name AS arrival_city, f.airline
FROM Flights f
RIGHT JOIN Cities c2 ON f.arrival_city_id = c2.city_id
LEFT JOIN Cities c1 ON f.departure_city_id = c1.city_id;

-- FULL OUTER JOIN 
SELECT f.flight_number, c1.city_name AS departure_city, c2.city_name AS arrival_city
FROM Flights f
LEFT JOIN Cities c1 ON f.departure_city_id = c1.city_id
LEFT JOIN Cities c2 ON f.arrival_city_id = c2.city_id
UNION
SELECT f.flight_number, c1.city_name AS departure_city, c2.city_name AS arrival_city
FROM Flights f
RIGHT JOIN Cities c1 ON f.departure_city_id = c1.city_id
RIGHT JOIN Cities c2 ON f.arrival_city_id = c2.city_id;

-- SELF JOIN 
SELECT f1.flight_number AS flight_1, f2.flight_number AS flight_2, c1.city_name AS route_from, c2.city_name AS route_to
FROM Flights f1
JOIN Flights f2 
    ON f1.departure_city_id = f2.departure_city_id
   AND f1.arrival_city_id = f2.arrival_city_id
   AND f1.airline <> f2.airline
JOIN Cities c1 ON f1.departure_city_id = c1.city_id
JOIN Cities c2 ON f1.arrival_city_id = c2.city_id;

-- CROSS JOIN
SELECT c1.city_name AS departure_city, c2.city_name AS arrival_city
FROM Cities c1
CROSS JOIN Cities c2;

-- SUBQUERIES
-- Scalar Subquery
SELECT flight_number, airline, price
FROM Flights
WHERE price > (SELECT AVG(price) FROM Flights);

-- Correlated Subquery 
SELECT f1.flight_number, f1.airline, f1.price FROM Flights f1
WHERE f1.price > (
    SELECT AVG(f2.price)
    FROM Flights f2
    WHERE f2.airline = f1.airline
);

-- IN Subquery
SELECT flight_number, airline FROM Flights
WHERE departure_city_id IN (
    SELECT city_id FROM Cities WHERE is_capital = TRUE
);

-- EXISTS Subquery
SELECT flight_number, airline FROM Flights f
WHERE EXISTS (
    SELECT 1 
    FROM Cities c 
    WHERE f.arrival_city_id = c.city_id AND c.population > 10000000
);

-- ALL Subquery 
SELECT flight_number, airline, price FROM Flights
WHERE price < ALL (SELECT price FROM Flights WHERE airline = 'Air India');

-- Subquery in FROM Clause
SELECT airline, ROUND(avg_price,2)
FROM (
    SELECT airline, AVG(price) AS avg_price
    FROM Flights
    GROUP BY airline
) AS t;

-- STRING FUNCTIONS
-- uppercase
SELECT UPPER(airline) AS airline_upper FROM Flights;

-- lowercase
SELECT LOWER(airline) AS airline_lower FROM Flights;

-- Concat
SELECT CONCAT(flight_number, ' - ', airline) AS flight_info FROM Flights;

-- substring 
SELECT SUBSTRING(flight_number, 1, 2) AS flight_code FROM Flights;

-- NUMERIC FUNCTIONS
-- Round price
SELECT flight_number, ROUND(price, 0) AS rounded_price FROM Flights;

-- Floor and Ceil
SELECT flight_number, FLOOR(price/1000) AS thousands_floor, CEIL(price/1000) AS thousands_ceil FROM Flights;

-- DATE,TIME FUNCTIONS
-- Current timestamp
SELECT NOW() AS current_time;

-- Current date
SELECT CURDATE() AS today_date;

-- Calculate flight duration
SELECT flight_number, 
       TIMESTAMPDIFF(HOUR, departure_time, arrival_time) AS duration_hours
FROM Flights;

-- Extract year and month
SELECT flight_number, YEAR(departure_time) AS dep_year, MONTH(departure_time) AS dep_month FROM Flights;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(*) AS total_flights,
    SUM(price) AS total_revenue,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM Flights;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION GetFlightDuration(dep DATETIME, arr DATETIME)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE hours_diff INT;
    SET hours_diff = TIMESTAMPDIFF(HOUR, dep, arr);
    RETURN hours_diff;
END//

DELIMITER ;

-- Usage:
SELECT flight_number, GetFlightDuration(departure_time, arrival_time) AS duration_hours
FROM Flights;

-- SIMPLE VIEWS
CREATE VIEW view_basic_flights AS
SELECT flight_id, flight_number, airline, price, seats_available
FROM Flights;

-- Complex View= Average flight price by airline (Aggregate)
CREATE VIEW view_avg_price_by_airline AS
SELECT 
    airline,
    AVG(price) AS avg_price,
    COUNT(flight_id) AS total_flights
FROM Flights
GROUP BY airline;

-- STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE search_flights(
    IN dep_city INT,
    IN arr_city INT,
    IN max_price DECIMAL(10,2)
)
BEGIN
    SELECT 
        flight_id, flight_number, airline, price, seats_available
    FROM Flights
    WHERE departure_city_id = dep_city
      AND arrival_city_id = arr_city
      AND price <= max_price;
END //

DELIMITER ;

-- WINDOW FUNCTIONS
SELECT flight_id, flight_number, airline, price,
    RANK() OVER (PARTITION BY airline ORDER BY price ASC) AS price_rank
FROM Flights;

-- DCL 
-- Create User
CREATE USER 'flightUser'@'localhost' IDENTIFIED BY 'password123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Flights TO 'flightUser'@'localhost';

-- Revoke Permission
REVOKE UPDATE ON Flights FROM 'flightUser'@'localhost';

-- Apply permissions
FLUSH PRIVILEGES;

-- TCL 
-- ROLLBACK 
START TRANSACTION;

UPDATE Flights 
SET seats_available = seats_available - 1 
WHERE flight_id = 3;

-- Something went wrong
ROLLBACK;

-- If successful, use COMMIT
COMMIT;

-- TRIGGER
CREATE TABLE IF NOT EXISTS FlightPriceLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT NOT NULL,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- trigger to prevent negative seats
DELIMITER //
CREATE TRIGGER trg_check_seats
BEFORE UPDATE ON Flights
FOR EACH ROW
BEGIN
    IF NEW.seats_available < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Seats cannot be negative!';
    END IF;
END//
DELIMITER ;

-- trigger to log price changes (AFTER UPDATE)
DELIMITER //
CREATE TRIGGER trg_price_change
AFTER UPDATE ON Flights
FOR EACH ROW
BEGIN
    IF OLD.price IS NULL AND NEW.price IS NOT NULL
       OR OLD.price IS NOT NULL AND OLD.price <> NEW.price THEN
        INSERT INTO FlightPriceLog (flight_id, old_price, new_price)
        VALUES (OLD.flight_id, OLD.price, NEW.price);
    END IF;
END//
DELIMITER ;




-- -------------------------------------------------
-- Table 6: Airlines
-- -------------------------------------------------
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_name VARCHAR(100) NOT NULL UNIQUE,
    country_id INT NOT NULL,
    iata_code CHAR(2) UNIQUE,
    icao_code CHAR(3) UNIQUE,
    headquarters VARCHAR(100),
    founded_year YEAR,
    fleet_size INT CHECK (fleet_size >= 0),
    website VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    INSERT INTO Airlines (airline_name, country_id, iata_code, icao_code, headquarters, founded_year, fleet_size, website)
VALUES
('Air India',1,'AI','AIC','New Delhi',1932,150,'www.airindia.in'),
('IndiGo',1,'6E','IGO','Gurgaon',2006,280,'www.goindigo.in'),
('Delta Airlines',2,'DL','DAL','Atlanta',1929,900,'www.delta.com'),
('United Airlines',2,'UA','UAL','Chicago',1926,850,'www.united.com'),
('Air France',3,'AF','AFR','Paris',1933,225,'www.airfrance.com'),
('Japan Airlines',4,'JL','JAL','Tokyo',1951,160,'www.jal.co.jp'),
('Qantas',5,'QF','QFA','Sydney',1920,130,'www.qantas.com'),
('LATAM',6,'LA','LAN','Santiago',2012,320,'www.latam.com'),
('Air Canada',7,'AC','ACA','Montreal',1937,180,'www.aircanada.com'),
('Lufthansa',8,'LH','DLH','Frankfurt',1953,350,'www.lufthansa.com'),
('South African Airways',9,'SA','SAA','Johannesburg',1934,65,'www.flysaa.com'),
('Alitalia',10,'AZ','AZA','Rome',1946,100,'www.alitalia.com'),
('Air China',11,'CA','CCA','Beijing',1988,420,'www.airchina.com'),
('British Airways',12,'BA','BAW','London',1974,270,'www.ba.com'),
('Aeromexico',13,'AM','AMX','Mexico City',1934,70,'www.aeromexico.com'),
('Aeroflot',14,'SU','AFL','Moscow',1923,200,'www.aeroflot.ru'),
('Iberia',15,'IB','IBE','Madrid',1927,90,'www.iberia.com'),
('Thai Airways',16,'TG','THA','Bangkok',1960,80,'www.thaiairways.com'),
('Singapore Airlines',17,'SQ','SIA','Singapore',1947,130,'www.singaporeair.com'),
('Emirates',18,'EK','UAE','Dubai',1985,250,'www.emirates.com');

DROP TABLE Airlines;

-- SELECT Queries 
-- Select all airlines
SELECT * FROM Airlines;

-- Select airline names and headquarters
SELECT airline_name, headquarters FROM Airlines;

-- Find airlines founded before 1950
SELECT airline_name, founded_year 
FROM Airlines 
WHERE founded_year < 1950;

-- Find airlines with fleet size greater than 200
SELECT airline_name, fleet_size 
FROM Airlines 
WHERE fleet_size > 200;

-- TRUNCATE TABLE
TRUNCATE TABLE Airlines;

-- DROP TABLE
DROP TABLE Airlines;

-- Add a column for CEO name
ALTER TABLE Airlines ADD ceo_name VARCHAR(100);

-- Modify fleet_size to BIGINT
ALTER TABLE Airlines MODIFY fleet_size BIGINT;

-- Update fleet size of Air India
UPDATE Airlines
SET fleet_size = 160
WHERE airline_name = 'Air India';

-- Update website for Emirates
UPDATE Airlines
SET website = 'www.emirates.com/new'
WHERE airline_name = 'Emirates';

-- Sort airlines by fleet size descending
SELECT airline_name, fleet_size
FROM Airlines
ORDER BY fleet_size DESC;

-- Sort airlines by founded year ascending
SELECT airline_name, founded_year
FROM Airlines
ORDER BY founded_year ASC;

-- Average fleet size
SELECT AVG(fleet_size) AS avg_fleet FROM Airlines;

-- Count of airlines per country
SELECT country_id, COUNT(*) AS total_airlines
FROM Airlines
GROUP BY country_id;

-- Operators 
-- Comparison Operator
SELECT airline_name, fleet_size, founded_year FROM Airlines WHERE fleet_size > 200;

-- Logical Operators 
SELECT airline_name, country_id, fleet_size FROM Airlines WHERE fleet_size > 100 AND founded_year < 2000;

-- BETWEEN Operator
SELECT airline_name, founded_year FROM Airlines WHERE founded_year BETWEEN 1920 AND 1950;

-- IN Operator
SELECT airline_name, country_id FROM Airlines WHERE country_id IN (1, 2, 3);

-- Arithmetic Operator
SELECT airline_name, fleet_size, (fleet_size * 2) AS double_fleet FROM Airlines;

-- Clauses 
-- ORDER BY
SELECT airline_name, fleet_size FROM Airlines ORDER BY fleet_size DESC;

-- LIMIT
SELECT airline_name, country_id, fleet_size FROM Airlines LIMIT 5;

-- DISTINCT
SELECT DISTINCT country_id FROM Airlines;

-- Alias
-- Column Alias
SELECT airline_name AS Airline, fleet_size AS Fleet, founded_year AS YearFounded FROM Airlines;

-- Table Alias
SELECT a.airline_name, a.iata_code, a.fleet_size FROM Airlines AS a WHERE a.fleet_size > 100;

-- JOINS
-- INNER JOIN
SELECT a.airline_name, c.country_name, a.headquarters FROM Airlines a
INNER JOIN Countries c ON a.country_id = c.country_id;

-- LEFT JOIN
SELECT a.airline_name, c.country_name FROM Airlines a
LEFT JOIN Countries c ON a.country_id = c.country_id;

-- RIGHT JOIN
SELECT a.airline_name, c.country_name FROM Airlines a
RIGHT JOIN Countries c ON a.country_id = c.country_id;

-- FULL OUTER JOIN 
SELECT a.airline_name, c.country_name FROM Airlines a
LEFT JOIN Countries c ON a.country_id = c.country_id
UNION
SELECT a.airline_name, c.country_name FROM Airlines a
RIGHT JOIN Countries c ON a.country_id = c.country_id;

-- SELF JOIN
SELECT a1.airline_name AS Airline1, a2.airline_name AS Airline2, a1.founded_year FROM Airlines a1
JOIN Airlines a2 ON a1.founded_year = a2.founded_year AND a1.airline_id <> a2.airline_id;

-- CROSS JOIN
SELECT a.airline_name, c.country_name FROM Airlines a
CROSS JOIN Countries c;

-- SCALAR SUBQUERY
SELECT airline_name, fleet_size FROM Airlines
WHERE fleet_size = (SELECT MAX(fleet_size) FROM Airlines);

-- CORRELATED SUBQUERY
SELECT airline_name, fleet_size FROM Airlines a
WHERE fleet_size > (
    SELECT AVG(fleet_size)
    FROM Airlines b
    WHERE b.country_id = a.country_id
);

-- IN SUBQUERY
SELECT airline_name FROM Airlines
WHERE country_id IN (
    SELECT country_id FROM Countries WHERE region = 'Asia'
);

-- EXISTS SUBQUERY
SELECT country_name FROM Countries c
WHERE EXISTS (
    SELECT 1 FROM Airlines a WHERE a.country_id = c.country_id
);

-- ALL SUBQUERY
SELECT airline_name, fleet_size FROM Airlines
WHERE fleet_size > ALL (
    SELECT fleet_size FROM Airlines WHERE country_id = 2
);

-- SUBQUERY IN FROM CLAUSE
SELECT t.country_id, t.avg_fleet
FROM (
    SELECT country_id, AVG(fleet_size) AS avg_fleet
    FROM Airlines
    GROUP BY country_id
) AS t
WHERE t.avg_fleet > 100;

-- STRING FUNCTIONS
SELECT 
    UPPER(airline_name) AS UpperName,
    LOWER(headquarters) AS LowerHQ,
    CONCAT(airline_name, ' - ', iata_code) AS AirlineCode,
    SUBSTRING(website, 5, 10) AS WebsitePart
FROM Airlines;

-- NUMERIC FUNCTIONS
SELECT 
    airline_name,
    ROUND(fleet_size / 10, 1) AS Rounded,
    FLOOR(fleet_size / 10) AS FloorValue,
    CEIL(fleet_size / 10) AS CeilValue
FROM Airlines;

-- DATE,TIME FUNCTIONS
SELECT 
    airline_name,
    founded_year,
    YEAR(CURDATE()) - founded_year AS Years_Old,
    NOW() AS Current_Time,
    CURDATE() AS Current_Date
FROM Airlines;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(*) AS TotalAirlines,
    SUM(fleet_size) AS TotalFleet,
    AVG(fleet_size) AS AverageFleet,
    MIN(fleet_size) AS SmallestFleet,
    MAX(fleet_size) AS LargestFleet
FROM Airlines;

-- USER-DEFINED FUNCTION 
DELIMITER //

CREATE FUNCTION AirlineAge(founded YEAR)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURDATE()) - founded;
    RETURN age;
END //

DELIMITER ;

-- Usage
SELECT airline_name, AirlineAge(founded_year) AS Airline_Age
FROM Airlines;

-- SIMPLE VIEWS
CREATE VIEW vw_airlines_basic AS
SELECT airline_id, airline_name, iata_code, founded_year
FROM Airlines;

-- COMPLEX VIEWS 
CREATE VIEW vw_airlines_with_country AS
SELECT a.airline_name, a.iata_code, a.fleet_size,
       c.country_name
FROM Airlines a
JOIN Countries c ON a.country_id = c.country_id;

-- STORED PROCEDURES
DELIMITER //
CREATE PROCEDURE GetAirlinesByCountry(IN cid INT)
BEGIN
    SELECT airline_name, iata_code, fleet_size
    FROM Airlines
    WHERE country_id = cid;
END//
DELIMITER ;

-- WINDOW FUNCTIONS
SELECT airline_name, fleet_size,
       RANK() OVER (ORDER BY fleet_size DESC) AS fleet_rank
FROM Airlines;

-- DCL 
-- Create user
CREATE USER 'air_user'@'localhost' IDENTIFIED BY 'password123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Airlines TO 'air_user'@'localhost';

-- Revoke 
REVOKE INSERT ON Airlines FROM 'air_user'@'localhost';

-- Reload
FLUSH PRIVILEGES;

-- TCL 
START TRANSACTION;

UPDATE Airlines SET fleet_size = fleet_size + 10 WHERE airline_id = 1;

UPDATE Airlines SET fleet_size = fleet_size - 5 WHERE airline_id = 2;

-- If everything is correct
COMMIT;

-- If something goes wrong
ROLLBACK;

-- TRIGGERS
DELIMITER //
CREATE TRIGGER trg_no_negative_fleet
BEFORE UPDATE ON Airlines
FOR EACH ROW
BEGIN
    IF NEW.fleet_size < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fleet size cannot be negative!';
    END IF;
END//
DELIMITER ;

-- Create log table for trigger 2
CREATE TABLE IF NOT EXISTS AirlineFleetLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_id INT,
    old_fleet INT,
    new_fleet INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



---------------------------------------------------
-- Table 7: Customers
---------------------------------------------------
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    country_id INT,
    passport_number VARCHAR(20) UNIQUE,
    date_of_birth DATE,
    gender CHAR(1) CHECK (gender IN ('M','F')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

INSERT INTO Customers (first_name,last_name,email,phone,country_id,passport_number,date_of_birth,gender)
VALUES
('Amit','Sharma','amit.sharma@mail.com','911234567890',1,'IND12345','1990-05-12','M'),
('Priya','Verma','priya.verma@mail.com','911234567891',1,'IND12346','1995-08-22','F'),
('John','Smith','john.smith@mail.com','1212345678',2,'USA98765','1988-01-15','M'),
('Emily','Clark','emily.clark@mail.com','1212345679',2,'USA98766','1992-04-10','F'),
('Pierre','Dubois','pierre.dubois@mail.com','3312345678',3,'FRA45678','1985-03-05','M'),
('Marie','Claire','marie.claire@mail.com','3312345679',3,'FRA45679','1990-11-18','F'),
('Hiroshi','Tanaka','hiroshi.tanaka@mail.com','8112345678',4,'JPN67890','1987-02-20','M'),
('Yumi','Sato','yumi.sato@mail.com','8112345679',4,'JPN67891','1991-07-14','F'),
('Liam','Brown','liam.brown@mail.com','6123456789',5,'AUS34567','1989-12-01','M'),
('Olivia','Wilson','olivia.wilson@mail.com','6123456790',5,'AUS34568','1993-09-30','F'),
('Carlos','Silva','carlos.silva@mail.com','5512345678',6,'BRA11223','1984-06-25','M'),
('Ana','Souza','ana.souza@mail.com','5512345679',6,'BRA11224','1992-02-28','F'),
('David','Lee','david.lee@mail.com','1412345678',7,'CAN33445','1986-08-08','M'),
('Sophia','Taylor','sophia.taylor@mail.com','1412345679',7,'CAN33446','1994-01-22','F'),
('Hans','Muller','hans.muller@mail.com','4912345678',8,'GER55667','1983-04-03','M'),
('Lena','Schmidt','lena.schmidt@mail.com','4912345679',8,'GER55668','1996-05-19','F'),
('Thabo','Nkosi','thabo.nkosi@mail.com','2712345678',9,'ZAF77889','1987-10-11','M'),
('Zanele','Khumalo','zanele.khumalo@mail.com','2712345679',9,'ZAF77890','1991-03-17','F'),
('Marco','Rossi','marco.rossi@mail.com','3912345678',10,'ITA99112','1985-11-23','M'),
('Giulia','Bianchi','giulia.bianchi@mail.com','3912345679',10,'ITA99113','1993-07-09','F');


-- SELECT Queries
-- Select all customers
SELECT * FROM Customers;

-- Get customer full names and emails
SELECT CONCAT(first_name, ' ', last_name) AS full_name, email FROM Customers;

-- Find all female customers
SELECT first_name, last_name, gender FROM Customers WHERE gender = 'F';

-- Find customers born before 1990
SELECT first_name, last_name, date_of_birth 
FROM Customers 
WHERE date_of_birth < '1990-01-01';

-- TRUNCATE TABLE
TRUNCATE TABLE Customers;

-- DROP TABLE
DROP TABLE Customers;

-- Add a column for loyalty points
ALTER TABLE Customers ADD loyalty_points INT DEFAULT 0;

-- Modify phone column to VARCHAR(25)
ALTER TABLE Customers MODIFY phone VARCHAR(25);

-- Update email for Amit Sharma
UPDATE Customers
SET email = 'amit.sharma2025@mail.com'
WHERE first_name='Amit' AND last_name='Sharma';

-- Update country_id for Olivia Wilson
UPDATE Customers
SET country_id = 6
WHERE first_name='Olivia' AND last_name='Wilson';

-- Female customers
SELECT first_name, last_name, gender FROM Customers
WHERE gender = 'F';

-- Customers born before 1990
SELECT first_name, last_name, date_of_birth FROM Customers
WHERE date_of_birth < '1990-01-01';

-- Count of customers by gender
SELECT gender, COUNT(*) AS total_customers
FROM Customers
GROUP BY gender;

-- Average age (approximation)
SELECT AVG(YEAR(CURDATE()) - YEAR(date_of_birth)) AS avg_age
FROM Customers;

-- Operators 
-- Comparison Operator
SELECT first_name, last_name, country_id FROM Customers WHERE country_id = 1;

-- Logical Operators
SELECT first_name, last_name, gender, country_id FROM Customers WHERE gender = 'F' AND country_id = 1;

-- BETWEEN Operator
SELECT first_name, last_name, date_of_birth FROM Customers WHERE date_of_birth BETWEEN '1985-01-01' AND '1990-12-31';

-- LIKE Operator
SELECT first_name, last_name, email FROM Customers WHERE email LIKE '%mail.com';

-- Clauses 
-- ORDER BY
SELECT first_name, last_name, date_of_birth FROM Customers ORDER BY date_of_birth ASC;

-- GROUP BY and HAVING
SELECT country_id, COUNT(*) AS total_customers FROM Customers GROUP BY country_id HAVING COUNT(*) > 2;

-- LIMIT
SELECT first_name, last_name, email FROM Customers LIMIT 5;

-- DISTINCT
SELECT DISTINCT country_id FROM Customers;

-- Alias
-- Column Alias
SELECT first_name AS FirstName, last_name AS LastName, email AS EmailAddress
FROM Customers;

-- Table Alias
SELECT c.first_name, c.last_name, c.email FROM Customers AS c WHERE c.gender = 'M';

-- ON DELETE CASCADE & ON UPDATE CASCADE
ALTER TABLE Customers
DROP FOREIGN KEY Customers_ibfk_1;

ALTER TABLE Customers
ADD CONSTRAINT fk_country_customer
FOREIGN KEY (country_id) REFERENCES Countries(country_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- JOINS
-- INNER JOIN
SELECT c.first_name, c.last_name, co.country_name FROM Customers c
INNER JOIN Countries co ON c.country_id = co.country_id;

-- LEFT JOIN
SELECT c.first_name, c.last_name, co.country_name FROM Customers c
LEFT JOIN Countries co ON c.country_id = co.country_id;

-- RIGHT JOIN
SELECT c.first_name, c.last_name, co.country_name FROM Customers c
RIGHT JOIN Countries co ON c.country_id = co.country_id;

-- FULL OUTER JOIN 
SELECT c.first_name, c.last_name, co.country_name FROM Customers c
LEFT JOIN Countries co ON c.country_id = co.country_id
UNION
SELECT c.first_name, c.last_name, co.country_name FROM Customers c
RIGHT JOIN Countries co ON c.country_id = co.country_id;

-- SELF JOIN

SELECT c1.first_name AS Customer1, c2.first_name AS Customer2, co.country_name
FROM Customers c1
JOIN Customers c2 ON c1.country_id = c2.country_id AND c1.customer_id <> c2.customer_id
JOIN Countries co ON c1.country_id = co.country_id;

-- CROSS JOIN
SELECT c.first_name, co.country_name FROM Customers c
CROSS JOIN Countries co;

-- SCALAR SUBQUERY
SELECT first_name, last_name, date_of_birth FROM Customers
WHERE date_of_birth = (SELECT MAX(date_of_birth) FROM Customers);

-- CORRELATED SUBQUERY
SELECT first_name, last_name, date_of_birth FROM Customers c
WHERE TIMESTAMPDIFF(YEAR, c.date_of_birth, CURDATE()) >
(
  SELECT AVG(TIMESTAMPDIFF(YEAR, c2.date_of_birth, CURDATE()))
  FROM Customers c2
  WHERE c2.country_id = c.country_id
);

-- IN SUBQUERY
SELECT first_name, last_name FROM Customers WHERE country_id IN (SELECT country_id FROM Countries WHERE region = 'Asia');

-- EXISTS SUBQUERY
SELECT co.country_name FROM Countries co
WHERE EXISTS (SELECT 1 FROM Customers c WHERE c.country_id = co.country_id);

-- ALL SUBQUERY
SELECT first_name, last_name, date_of_birth FROM Customers
WHERE date_of_birth < ALL (
    SELECT date_of_birth FROM Customers WHERE country_id = 1
);

-- SUBQUERY IN FROM CLAUSE
SELECT t.country_id, t.avg_age
FROM (
    SELECT country_id, AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS avg_age
    FROM Customers
    GROUP BY country_id
) AS t
WHERE t.avg_age > 30;

-- STRING FUNCTIONS
SELECT 
    UPPER(first_name) AS UpperName,
    LOWER(last_name) AS LowerName,
    CONCAT(first_name, ' ', last_name) AS FullName,
    SUBSTRING(email, 1, 10) AS Email_Prefix
FROM Customers;

-- NUMERIC FUNCTIONS
SELECT 
    first_name, 
    ROUND(customer_id * 1.75, 2) AS RoundedScore,
    FLOOR(customer_id * 1.75) AS FloorScore,
    CEIL(customer_id * 1.75) AS CeilScore
FROM Customers;

-- DATE,TIME FUNCTIONS
SELECT 
    first_name,
    date_of_birth,
    YEAR(date_of_birth) AS BirthYear,
    MONTH(date_of_birth) AS BirthMonth,
    DATEDIFF(CURDATE(), date_of_birth) AS DaysOld,
    NOW() AS CurrentTime,
    CURDATE() AS TodayDate
FROM Customers;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(*) AS TotalCustomers,
    COUNT(DISTINCT country_id) AS UniqueCountries,
    MIN(date_of_birth) AS OldestDOB,
    MAX(date_of_birth) AS YoungestDOB,
    AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS AvgAge
FROM Customers;

-- USER-DEFINED FUNCTION 
DELIMITER //

CREATE FUNCTION GetAge(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    RETURN age;
END //

DELIMITER ;

-- Usage
SELECT first_name, last_name, GetAge(date_of_birth) AS Age
FROM Customers;

-- SIMPLE VIEWS
CREATE VIEW vw_customers_basic AS
SELECT customer_id, first_name, last_name, email
FROM Customers;

-- COMPLEX VIEWS
CREATE VIEW vw_customers_with_country AS
SELECT c.customer_id, c.first_name, c.last_name, c.email,
       ct.country_name
FROM Customers c
JOIN Countries ct
ON c.country_id = ct.country_id;

-- STORED PROCEDURES
-- Get customers by country
DELIMITER //
CREATE PROCEDURE GetCustomersByCountry(IN cid INT)
BEGIN
    SELECT first_name, last_name, email
    FROM Customers
    WHERE country_id = cid;
END//
DELIMITER ;

-- Update customer phone
DELIMITER //
CREATE PROCEDURE UpdateCustomerPhone(
    IN cust_id INT,
    IN new_phone VARCHAR(20)
)
BEGIN
    UPDATE Customers
    SET phone = new_phone
    WHERE customer_id = cust_id;
END//
DELIMITER ;

-- WINDOW FUNCTIONS
-- Rank 
SELECT customer_id, first_name, last_name, date_of_birth,
       RANK() OVER (ORDER BY date_of_birth ASC) AS age_rank
FROM Customers;

-- Partition by 
SELECT first_name, last_name, gender,
       ROW_NUMBER() OVER (PARTITION BY gender ORDER BY date_of_birth) AS row_num
FROM Customers;

-- DCL 
-- Create user
CREATE USER 'cust_user'@'localhost' IDENTIFIED BY 'password123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Customers TO 'cust_user'@'localhost';

-- Revoke 
REVOKE UPDATE ON Customers FROM 'cust_user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- TCL 
START TRANSACTION;

UPDATE Customers
SET phone = '9999999999'
WHERE customer_id = 1;

UPDATE Customers
SET email = 'new.email@mail.com'
WHERE customer_id = 2;

-- Commit if correct
COMMIT;

-- rollback if wrong
ROLLBACK;

-- TRIGGERS 
CREATE TABLE IF NOT EXISTS CustomerLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    old_email VARCHAR(100),
    new_email VARCHAR(100),
    old_phone VARCHAR(20),
    new_phone VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prevent invalid gender
DELIMITER //
CREATE TRIGGER trg_check_gender
BEFORE INSERT ON Customers
FOR EACH ROW
BEGIN
   IF NEW.gender NOT IN ('M','F') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gender must be M or F';
   END IF;
END//
DELIMITER ;

-- Log updates to email & phone
DELIMITER //
CREATE TRIGGER trg_log_customer_updates
AFTER UPDATE ON Customers
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email
       OR OLD.phone <> NEW.phone THEN
        INSERT INTO CustomerLog(customer_id, old_email, new_email, old_phone, new_phone)
        VALUES (OLD.customer_id, OLD.email, NEW.email, OLD.phone, NEW.phone);
    END IF;
END//
DELIMITER ;


-- -------------------------------------------------
-- Table 8: Bookings
-- -------------------------------------------------
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    flight_id INT,
    hotel_id INT,
    booking_date DATE NOT NULL,
    total_amount DECIMAL(10,2) CHECK (total_amount > 0),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending','Completed','Cancelled')),
    check_in DATE,
    check_out DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

INSERT INTO Bookings (customer_id,flight_id,hotel_id,booking_date,total_amount,payment_status,check_in,check_out)
VALUES
(1,1,1,'2025-09-01',12000,'Completed','2025-10-01','2025-10-05'),
(2,2,2,'2025-09-02',9000,'Completed','2025-10-06','2025-10-10'),
(3,3,3,'2025-09-03',65000,'Completed','2025-10-11','2025-10-15'),
(4,4,4,'2025-09-04',60000,'Pending','2025-10-16','2025-10-20'),
(5,5,5,'2025-09-05',80000,'Completed','2025-10-21','2025-10-25'),
(6,6,6,'2025-09-06',70000,'Completed','2025-10-26','2025-10-30'),
(7,7,7,'2025-09-07',21000,'Completed','2025-11-01','2025-11-05'),
(8,8,8,'2025-09-08',15000,'Pending','2025-11-06','2025-11-10'),
(9,9,9,'2025-09-09',18000,'Completed','2025-11-11','2025-11-15'),
(10,10,10,'2025-09-10',17000,'Completed','2025-11-16','2025-11-20'),
(11,11,11,'2025-09-11',22000,'Completed','2025-11-21','2025-11-25'),
(12,12,12,'2025-09-12',14000,'Completed','2025-11-26','2025-11-30'),
(13,13,13,'2025-09-13',19500,'Pending','2025-12-01','2025-12-05'),
(14,14,14,'2025-09-14',24000,'Completed','2025-12-06','2025-12-10'),
(15,15,15,'2025-09-15',21000,'Completed','2025-12-11','2025-12-15'),
(16,16,16,'2025-09-16',32000,'Completed','2025-12-16','2025-12-20'),
(17,17,17,'2025-09-17',25000,'Completed','2025-12-21','2025-12-25'),
(18,18,18,'2025-09-18',28000,'Completed','2025-12-26','2025-12-30'),
(19,19,19,'2025-09-19',30000,'Pending','2026-01-01','2026-01-05'),
(20,20,20,'2025-09-20',35000,'Completed','2026-01-06','2026-01-10');

-- SELECT Queries 
-- View all bookings
SELECT * FROM Bookings;

-- Show booking details with customer names
SELECT b.booking_id, c.first_name, c.last_name, b.booking_date, b.total_amount, b.payment_status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id;

-- Show bookings with flights included
SELECT b.booking_id, c.first_name, c.last_name, f.flight_number, f.airline, b.total_amount
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id;

-- Find all Pending bookings
SELECT * FROM Bookings WHERE payment_status = 'Pending';

-- Calculate total revenue from Completed bookings
SELECT SUM(total_amount) AS total_revenue
FROM Bookings
WHERE payment_status = 'Completed';

-- TRUNCATE TABLE
TRUNCATE TABLE Bookings;

-- DROP TABLE
DROP TABLE Bookings;

-- Add a column for booking type
ALTER TABLE Bookings ADD booking_type VARCHAR(50) DEFAULT 'Standard';

-- Modify total_amount precision
ALTER TABLE Bookings MODIFY total_amount DECIMAL(12,2);

-- Drop a column
ALTER TABLE Bookings DROP COLUMN booking_type;

-- Update payment status for booking 4
UPDATE Bookings
SET payment_status = 'Completed'
WHERE booking_id = 4;

-- Total revenue
SELECT SUM(total_amount) AS total_revenue FROM Bookings;

-- Count bookings by payment_status
SELECT payment_status, COUNT(*) AS total_bookings
FROM Bookings
GROUP BY payment_status;

-- Average booking amount
SELECT AVG(total_amount) AS avg_booking FROM Bookings;

-- Sort by total_amount descending
SELECT booking_id, total_amount FROM Bookings
ORDER BY total_amount DESC;

-- Operators
-- Comparison Operator
SELECT * FROM Bookings WHERE total_amount >= 30000;

-- BETWEEN Operator
SELECT * FROM Bookings WHERE total_amount BETWEEN 15000 AND 30000;

-- LIKE Operator
SELECT * FROM Bookings WHERE payment_status LIKE 'C%';

-- Logical Operators
SELECT * FROM Bookings WHERE payment_status='Completed' AND total_amount>20000;

-- Clauses
-- WHERE Clause
SELECT * FROM Bookings WHERE payment_status='Pending';

-- ORDER BY
SELECT * FROM Bookings ORDER BY total_amount DESC;

-- GROUP BY
SELECT payment_status, COUNT(*) FROM Bookings GROUP BY payment_status;

-- DISTINCT
SELECT DISTINCT payment_status FROM Bookings;

-- JOIN
SELECT B.booking_id, C.first_name FROM Bookings B JOIN Customers C ON B.customer_id=C.customer_id;

-- Aliases

-- alias for columns
SELECT booking_id AS 'Booking ID', total_amount AS 'Amount (Rs)' FROM Bookings;

-- Alias for tables
SELECT b.booking_id, c.first_name, c.last_name, b.total_amount FROM Bookings AS b JOIN Customers AS c ON b.customer_id = c.customer_id;

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    flight_id INT,
    hotel_id INT,
    booking_date DATE NOT NULL,
    total_amount DECIMAL(10,2) CHECK (total_amount > 0),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending','Completed','Cancelled')),
    check_in DATE,
    check_out DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- JOINS
-- INNER JOIN
SELECT 
    b.booking_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    f.flight_number,
    b.total_amount, 
    b.payment_status
FROM Bookings b
INNER JOIN Customers c ON b.customer_id = c.customer_id
INNER JOIN Flights f ON b.flight_id = f.flight_id;

-- LEFT JOIN
SELECT 
    b.booking_id, 
    c.first_name, 
    f.flight_number,
    b.payment_status
FROM Bookings b
LEFT JOIN Flights f ON b.flight_id = f.flight_id
LEFT JOIN Customers c ON b.customer_id = c.customer_id;

-- RIGHT JOIN
SELECT 
    c.first_name, 
    c.last_name, 
    b.booking_id, 
    b.payment_status
FROM Bookings b
RIGHT JOIN Customers c ON b.customer_id = c.customer_id;

-- FULL OUTER JOIN
SELECT c.first_name, b.booking_id, b.payment_status FROM Customers c
LEFT JOIN Bookings b ON c.customer_id = b.customer_id
UNION
SELECT c.first_name, b.booking_id, b.payment_status FROM Customers c
RIGHT JOIN Bookings b ON c.customer_id = b.customer_id;

-- SELF JOIN
SELECT b1.booking_id AS Booking1, b2.booking_id AS Booking2, c.first_name
FROM Bookings b1
JOIN Bookings b2 
    ON b1.customer_id = b2.customer_id 
   AND b1.booking_id <> b2.booking_id
JOIN Customers c 
    ON b1.customer_id = c.customer_id;

-- CROSS JOIN
SELECT b.booking_id, c.first_name, c.last_name
FROM Bookings b
CROSS JOIN Customers c;

-- SCALAR SUBQUERY
SELECT * FROM Bookings WHERE total_amount = (SELECT MAX(total_amount) FROM Bookings);

-- CORRELATED SUBQUERY
SELECT b.booking_id, b.customer_id, b.total_amount FROM Bookings b
WHERE b.total_amount > (
    SELECT AVG(b2.total_amount)
    FROM Bookings b2
    WHERE b2.customer_id = b.customer_id
);

-- IN SUBQUERY
SELECT first_name, last_name FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Bookings WHERE payment_status = 'Pending'
);

-- EXISTS SUBQUERY
SELECT f.flight_number, f.airline FROM Flights f
WHERE EXISTS (
    SELECT 1 FROM Bookings b WHERE b.flight_id = f.flight_id
);

-- ALL SUBQUERY
SELECT * FROM Bookings
WHERE total_amount > ALL (
    SELECT total_amount FROM Bookings WHERE payment_status = 'Pending'
);

-- SUBQUERY IN FROM CLAUSE
SELECT payment_status, avg_amount
FROM (
    SELECT payment_status, AVG(total_amount) AS avg_amount
    FROM Bookings
    GROUP BY payment_status
) AS t
WHERE avg_amount > 20000;

-- STRING FUNCTIONS
SELECT 
    CONCAT(UPPER(c.first_name), ' ', LOWER(c.last_name)) AS FormattedName,
    SUBSTRING(b.payment_status, 1, 3) AS StatusShort
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id;

-- NUMERIC FUNCTIONS
SELECT 
    booking_id,
    ROUND(total_amount, 0) AS RoundedAmount,
    FLOOR(total_amount) AS FloorAmount,
    CEIL(total_amount / 1000) * 1000 AS CeilToThousand
FROM Bookings;

-- DATE,TIME FUNCTIONS
SELECT booking_id, DATEDIFF(check_out, check_in) AS StayDuration, YEAR(booking_date) AS BookingYear, MONTH(booking_date) AS BookingMonth,
    CURDATE() AS CurrentDate,
    NOW() AS CurrentTimestamp
FROM Bookings;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(*) AS TotalBookings,
    SUM(total_amount) AS TotalRevenue,
    AVG(total_amount) AS AvgBookingValue,
    MIN(total_amount) AS MinBooking,
    MAX(total_amount) AS MaxBooking
FROM Bookings;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION GetStayDuration(check_in DATE, check_out DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE nights INT;
    SET nights = DATEDIFF(check_out, check_in);
    RETURN nights;
END //

DELIMITER ;

-- Use it
SELECT booking_id, GetStayDuration(check_in, check_out) AS Nights
FROM Bookings;

-- SIMPLE VIEWS
CREATE VIEW vw_basic_bookings AS
SELECT booking_id, customer_id, flight_id, booking_date, total_amount, payment_status
FROM Bookings;

-- COMPLEX VIEWS 
CREATE VIEW vw_customer_bookings AS
SELECT b.booking_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, b.flight_id, b.booking_date, b.total_amount, b.payment_status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id;

-- STORED PROCEDURES
DELIMITER //
CREATE PROCEDURE get_customer_bookings(IN cust_id INT)
BEGIN
    SELECT b.booking_id, b.flight_id, b.total_amount, b.payment_status, b.booking_date
    FROM Bookings b
    WHERE b.customer_id = cust_id;
END//
DELIMITER ;

-- WINDOW FUNCTIONS
SELECT booking_id, customer_id, total_amount,
    RANK() OVER (ORDER BY total_amount DESC) AS amount_rank
FROM Bookings;

-- DCL 
-- Create User
CREATE USER 'booking_user'@'localhost' IDENTIFIED BY 'pass123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Bookings TO 'booking_user'@'localhost';

-- Revoke 
REVOKE UPDATE ON Bookings FROM 'booking_user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- TCL (Transaction Control Language)
-- Commit 
START TRANSACTION;

UPDATE Bookings 
SET payment_status = 'Completed'
WHERE booking_id = 4;

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE Bookings 
SET total_amount = -5000   
WHERE booking_id = 3;

ROLLBACK;

-- TRIGGERS
-- To Prevent Negative or Zero Total Amount
DELIMITER //

CREATE TRIGGER trg_no_negative_amount
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
    IF NEW.total_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Total amount must be greater than 0';
    END IF;
END//

DELIMITER ;


-- -------------------------------------------------
-- Table 9: Payments
-- -------------------------------------------------
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) CHECK (amount > 0),
    method VARCHAR(50) CHECK (method IN ('Credit Card','Debit Card','NetBanking','UPI','Cash')),
    transaction_id VARCHAR(50) UNIQUE,
    status VARCHAR(20) CHECK (status IN ('Success','Failed','Pending')),
    currency VARCHAR(10) DEFAULT 'INR',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Payments (booking_id,payment_date,amount,method,transaction_id,status)
VALUES
(1,'2025-09-01',12000,'Credit Card','TXN1001','Success'),
(2,'2025-09-02',9000,'UPI','TXN1002','Success'),
(3,'2025-09-03',65000,'Debit Card','TXN1003','Success'),
(4,'2025-09-04',60000,'Credit Card','TXN1004','Pending'),
(5,'2025-09-05',80000,'NetBanking','TXN1005','Success'),
(6,'2025-09-06',70000,'UPI','TXN1006','Success'),
(7,'2025-09-07',21000,'Cash','TXN1007','Success'),
(8,'2025-09-08',15000,'Credit Card','TXN1008','Pending'),
(9,'2025-09-09',18000,'Debit Card','TXN1009','Success'),
(10,'2025-09-10',17000,'NetBanking','TXN1010','Success'),
(11,'2025-09-11',22000,'UPI','TXN1011','Success'),
(12,'2025-09-12',14000,'Credit Card','TXN1012','Success'),
(13,'2025-09-13',19500,'Debit Card','TXN1013','Pending'),
(14,'2025-09-14',24000,'NetBanking','TXN1014','Success'),
(15,'2025-09-15',21000,'UPI','TXN1015','Success'),
(16,'2025-09-16',32000,'Credit Card','TXN1016','Success'),
(17,'2025-09-17',25000,'Debit Card','TXN1017','Success'),
(18,'2025-09-18',28000,'NetBanking','TXN1018','Success'),
(19,'2025-09-19',30000,'UPI','TXN1019','Pending'),
(20,'2025-09-20',35000,'Cash','TXN1020','Success');

-- SELECT Queries
-- View all payments
SELECT * FROM Payments;

-- Show payments with booking details
SELECT p.payment_id, b.booking_date, p.amount, p.method, p.status
FROM Payments p
JOIN Bookings b ON p.booking_id = b.booking_id;

-- Find all pending payments
SELECT * FROM Payments WHERE status = 'Pending';

-- Total successful payments (sum of amounts)
SELECT SUM(amount) AS total_success_payments
FROM Payments
WHERE status = 'Success';

-- Count payments by method
SELECT method, COUNT(*) AS total_transactions
FROM Payments
GROUP BY method;

-- Get top 5 highest payment transactions
SELECT payment_id, transaction_id, amount, method, status
FROM Payments
ORDER BY amount DESC
LIMIT 5;

-- TRUNCATE TABLE
TRUNCATE TABLE Payments;

-- DROP TABLE
DROP TABLE Payments;

-- Add a column for payment remarks
ALTER TABLE Payments ADD remarks VARCHAR(255);

-- Modify amount precision
ALTER TABLE Payments MODIFY amount DECIMAL(12,2);

-- Drop a column
ALTER TABLE Payments DROP COLUMN remarks;

-- Update payment status for TXN1004
UPDATE Payments
SET status = 'Success'
WHERE transaction_id = 'TXN1004';

-- Update amount for booking 8
UPDATE Payments
SET amount = 15500
WHERE booking_id = 8;

-- Sort by amount descending
SELECT payment_id, booking_id, amount
FROM Payments
ORDER BY amount DESC;

-- Sort by payment_date ascending
SELECT payment_id, payment_date
FROM Payments
ORDER BY payment_date ASC;

-- Count payments by method
SELECT method, COUNT(*) AS total_payments
FROM Payments
GROUP BY method;

-- Operators
SELECT * FROM Payments WHERE status <> 'Success';	
SELECT * FROM Payments WHERE amount > 30000;	
SELECT * FROM Payments WHERE amount < 20000;	
SELECT * FROM Payments WHERE amount >= 25000;	
SELECT * FROM Payments WHERE amount <= 15000;

-- Clauses
-- WHERE Clause
SELECT * FROM Payments WHERE amount > 20000;	

-- ORDER BY Clause
SELECT * FROM Payments ORDER BY amount DESC;	

-- GROUP BY Clause
SELECT method, COUNT(*) AS total_payments FROM Payments GROUP BY method;	

-- HAVING Clause
SELECT method, COUNT(*) AS total_payments FROM Payments GROUP BY method HAVING COUNT(*) > 3;	

-- LIMIT Clause
SELECT * FROM Payments LIMIT 5;

-- Alias 

-- Column Alias
SELECT payment_id AS ID, amount AS 'Payment Amount' FROM Payments;

-- Table Alias
SELECT p.payment_id, p.amount FROM Payments AS p;

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) CHECK (amount > 0),
    method VARCHAR(50) CHECK (method IN ('Credit Card','Debit Card','NetBanking','UPI','Cash')),
    transaction_id VARCHAR(50) UNIQUE,
    status VARCHAR(20) CHECK (status IN ('Success','Failed','Pending')),
    currency VARCHAR(10) DEFAULT 'INR',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- JOINS
-- INNER JOIN
SELECT p.payment_id, p.amount, p.method, b.total_amount, b.payment_status FROM Payments p
INNER JOIN Bookings b ON p.booking_id = b.booking_id;

-- LEFT JOIN
SELECT b.booking_id, b.total_amount, p.amount, p.status FROM Bookings b
LEFT JOIN Payments p ON b.booking_id = p.booking_id;

-- RIGHT JOIN
SELECT p.payment_id, p.method, b.total_amount, b.payment_status FROM Bookings b
RIGHT JOIN Payments p ON b.booking_id = p.booking_id;

-- FULL OUTER JOIN
SELECT b.booking_id, b.total_amount, p.amount, p.status FROM Bookings b
LEFT JOIN Payments p ON b.booking_id = p.booking_id
UNION
SELECT b.booking_id, b.total_amount, p.amount, p.status FROM Bookings b
RIGHT JOIN Payments p ON b.booking_id = p.booking_id;

-- SELF JOIN
SELECT a.payment_id AS Payment1, b.payment_id AS Payment2, a.amount FROM Payments a
JOIN Payments b ON a.amount = b.amount AND a.payment_id <> b.payment_id;

-- CROSS JOIN
SELECT b.booking_id, p.method FROM Bookings b
CROSS JOIN Payments p;

-- SUBQUERIES
-- Scalar Subquery
SELECT payment_id, amount,
       (SELECT AVG(amount) FROM Payments) AS avg_payment
FROM Payments;

-- Correlated Subquery
SELECT b.booking_id, b.total_amount FROM Bookings b
WHERE b.total_amount > (
    SELECT AVG(amount) FROM Payments p WHERE p.booking_id = b.booking_id
);

-- IN Subquery
SELECT * FROM Payments
WHERE booking_id IN (
    SELECT booking_id FROM Bookings WHERE payment_status = 'Completed'
);

-- EXISTS Subquery
SELECT * FROM Bookings b
WHERE EXISTS (
    SELECT 1 FROM Payments p
    WHERE p.booking_id = b.booking_id AND p.status = 'Success'
);

-- ANY Subquery
SELECT * FROM Payments
WHERE amount > ANY (
    SELECT amount FROM Payments WHERE status = 'Pending'
);

-- Subquery in FROM Clause
SELECT method, total
FROM (
    SELECT method, SUM(amount) AS total
    FROM Payments
    GROUP BY method
) AS sub
WHERE total > 20000;

-- STRING FUNCTIONS
SELECT 
    payment_id,
    UPPER(method) AS upper_method,
    LOWER(status) AS lower_status,
    CONCAT('TXN-', SUBSTRING(transaction_id, 4)) AS custom_txn
FROM Payments;

-- NUMERIC FUNCTIONS
SELECT 
    payment_id,
    amount,
    ROUND(amount, 0) AS rounded_amount,
    FLOOR(amount/1000) AS floor_k,
    CEIL(amount/1000) AS ceil_k
FROM Payments;

-- DATE,TIME FUNCTIONS
SELECT 
    payment_id,
    payment_date,
    NOW() AS current_time,
    CURDATE() AS today,
    DATEDIFF(CURDATE(), payment_date) AS days_since_payment,
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month
FROM Payments;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(payment_id) AS total_payments,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_payment,
    MIN(amount) AS min_payment,
    MAX(amount) AS max_payment
FROM Payments;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION PaymentCategory(amt DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF amt < 15000 THEN
        SET category = 'Low';
    ELSEIF amt BETWEEN 15000 AND 40000 THEN
        SET category = 'Medium';
    ELSE
        SET category = 'High';
    END IF;
    RETURN category;
END//

DELIMITER ;

-- Use the function:
SELECT payment_id, amount, PaymentCategory(amount) AS category
FROM Payments;

-- SIMPLE VIEW
CREATE VIEW view_simple_payments AS
SELECT payment_id,booking_id,amount,method,status,payment_date
FROM Payments;

-- COMPLEX VIEW 
CREATE VIEW view_payment_summary AS
SELECT method,
COUNT(*) AS total_transactions,
SUM(amount) AS total_amount,
AVG(amount) AS avg_amount
FROM Payments
WHERE status = 'Success'
GROUP BY method;

-- STORED PROCEDURE 
DELIMITER //
CREATE PROCEDURE get_payment_by_booking(IN p_booking_id INT)
BEGIN
    SELECT * FROM Payments
    WHERE booking_id = p_booking_id;
END //
DELIMITER ;

-- WINDOW FUNCTIONS (Ranking, Running Total, Dense Rank)
-- Running total per method
SELECT method, payment_id, amount,
SUM(amount) OVER (PARTITION BY method ORDER BY payment_id) AS running_total
FROM Payments;

-- DCL 
CREATE USER 'payment_user'@'localhost' IDENTIFIED BY 'pay123';

GRANT SELECT, INSERT, UPDATE ON Payments TO 'payment_user'@'localhost';

FLUSH PRIVILEGES;

-- TCL 
START TRANSACTION;

UPDATE Payments
SET status = 'Success'
WHERE payment_id = 4;

INSERT INTO Payments (booking_id, payment_date, amount, method, transaction_id, status)
VALUES (1, CURDATE(), 10000, 'UPI', 'TXN9999', 'Success');

COMMIT;
-- Rollback 
START TRANSACTION;
UPDATE Payments SET amount = -500 WHERE payment_id = 3;
ROLLBACK;

-- TRIGGERS 
-- Prevent negative or zero payment amount
DELIMITER //
CREATE TRIGGER trg_no_negative_payment
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount must be greater than 0';
    END IF;
END //
DELIMITER ;

-- Update Booking Status when payment succeeds
DELIMITER //
CREATE TRIGGER trg_update_booking_on_success
AFTER UPDATE ON Payments
FOR EACH ROW
BEGIN
    IF NEW.status = 'Success' THEN
        UPDATE Bookings
        SET payment_status = 'Completed'
        WHERE booking_id = NEW.booking_id;
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 10: Reviews
-- -------------------------------------------------
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    destination_id INT,
    hotel_id INT,
    flight_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Published',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

INSERT INTO Reviews (customer_id,destination_id,hotel_id,flight_id,rating,review_text,review_date)
VALUES
(1,1,1,1,5,'Amazing trip to Delhi!','2025-10-06'),
(2,2,2,2,4,'Great experience in Mumbai.','2025-10-11'),
(3,3,3,3,5,'Loved New York tour.','2025-10-16'),
(4,4,4,4,5,'DC tour was informative.','2025-10-21'),
(5,5,5,5,5,'Paris is magical!','2025-10-26'),
(6,6,6,6,4,'Beautiful Mount Fuji.','2025-10-31'),
(7,7,7,7,5,'Sydney was wonderful.','2025-11-05'),
(8,8,8,8,3,'Canberra was peaceful.','2025-11-10'),
(9,9,9,9,5,'Rio is full of life!','2025-11-15'),
(10,10,10,10,4,'Brasilia was unique.','2025-11-20'),
(11,11,11,11,5,'Toronto was fantastic.','2025-11-25'),
(12,12,12,12,4,'Ottawa was calm.','2025-11-30'),
(13,13,13,13,5,'Berlin is historical.','2025-12-05'),
(14,14,14,14,5,'Loved Cape Town.','2025-12-10'),
(15,15,15,15,3,'Pretoria is average.','2025-12-15'),
(16,16,16,16,5,'Rome was extraordinary.','2025-12-20'),
(17,17,17,17,5,'Great Wall is breathtaking.','2025-12-25'),
(18,18,18,18,5,'London is always amazing.','2025-12-30'),
(19,19,19,19,4,'Teotihuacan was mysterious.','2026-01-05'),
(20,20,20,20,5,'Moscow was impressive.','2026-01-10');

-- SELECT Queries 
-- View all reviews
SELECT * FROM Reviews;

-- Show reviews with customer details
SELECT r.review_id, c.first_name, c.last_name, r.rating, r.review_text, r.review_date
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id;

-- Show only 5-star reviews
SELECT * FROM Reviews WHERE rating = 5;


-- Count reviews per hotel
SELECT h.hotel_name, COUNT(r.review_id) AS total_reviews
FROM Reviews r
JOIN Hotels h ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_name;

-- Latest 5 reviews
SELECT * FROM Reviews ORDER BY review_date DESC LIMIT 5;

-- TRUNCATE TABLE
TRUNCATE TABLE Reviews;

-- DROP TABLE
DROP TABLE Reviews;

-- Add a column for review title
ALTER TABLE Reviews ADD review_title VARCHAR(100);

-- Modify status default value
ALTER TABLE Reviews MODIFY status VARCHAR(20) DEFAULT 'Pending';

-- Drop a column
ALTER TABLE Reviews DROP COLUMN review_title;

-- Update status for a review
UPDATE Reviews
SET status = 'Hidden'
WHERE review_id = 15;

-- Reviews for a specific hotel
SELECT review_id, hotel_id, review_text
FROM Reviews
WHERE hotel_id = 10;

-- Count reviews per customer
SELECT customer_id, COUNT(*) AS total_reviews
FROM Reviews
GROUP BY customer_id;

-- Operators
-- Comparison Operators
SELECT * FROM Reviews WHERE rating = 5;	
SELECT * FROM Reviews WHERE rating <> 5;

-- BETWEEN Operator
SELECT * FROM Reviews WHERE rating BETWEEN 3 AND 5;

-- LIKE Operator
SELECT * FROM Reviews WHERE review_text LIKE '%amazing%';

-- Clauses

-- WHERE Clauses
SELECT * FROM Reviews WHERE rating = 5;	

-- ORDER BY Clauses
SELECT * FROM Reviews ORDER BY review_date DESC;	

-- GROUP BY Clauses
SELECT rating, COUNT(*) AS total_reviews FROM Reviews GROUP BY rating;	

-- HAVING Clauses
SELECT rating, COUNT(*) AS total_reviews FROM Reviews GROUP BY rating HAVING COUNT(*) > 3;

-- Alias 
-- Column Alias
SELECT review_id AS ID, rating AS Stars FROM Reviews;	

-- Table Alias
SELECT r.review_id, r.rating, c.first_name FROM Reviews AS r JOIN Customers AS c ON r.customer_id=c.customer_id;

-- ON DELETE CASCADE / ON UPDATE CASCADE

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    destination_id INT,
    hotel_id INT,
    flight_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Published',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- JOINS
-- INNER JOIN
SELECT r.review_id, c.first_name, c.last_name, d.name AS destination, r.rating, r.review_text FROM Reviews r
INNER JOIN Customers c ON r.customer_id = c.customer_id
INNER JOIN Destinations d ON r.destination_id = d.destination_id;

-- LEFT JOIN
SELECT r.review_id, c.first_name, h.hotel_name, r.rating FROM Reviews r
LEFT JOIN Customers c ON r.customer_id = c.customer_id
LEFT JOIN Hotels h ON r.hotel_id = h.hotel_id;

-- RIGHT JOIN
SELECT h.hotel_id, h.hotel_name, r.review_text FROM Hotels h
RIGHT JOIN Reviews r ON r.hotel_id = h.hotel_id;

-- FULL OUTER JOIN
SELECT r.review_id, h.hotel_name, r.review_text FROM Reviews r
LEFT JOIN Hotels h ON r.hotel_id = h.hotel_id
UNION
SELECT r.review_id, h.hotel_name, r.review_text FROM Reviews r
RIGHT JOIN Hotels h ON r.hotel_id = h.hotel_id;

-- SELF JOIN
SELECT r1.review_id AS Review1, r2.review_id AS Review2, r1.rating FROM Reviews r1
JOIN Reviews r2 ON r1.rating = r2.rating AND r1.review_id <> r2.review_id;

-- CROSS JOIN
SELECT r.review_id, f.flight_number FROM Reviews r
CROSS JOIN Flights f;

-- SUBQUERIES
-- Scalar Subquery
SELECT r.review_id, r.rating,
       (SELECT AVG(rating) FROM Reviews) AS avg_rating
FROM Reviews r;

-- Correlated Subquery
SELECT r.review_id, r.rating, r.hotel_id
FROM Reviews r
WHERE r.rating > (
    SELECT AVG(r2.rating) 
    FROM Reviews r2 
    WHERE r2.hotel_id = r.hotel_id
);

-- IN Subquery
SELECT * FROM Reviews
WHERE customer_id IN (
    SELECT customer_id FROM Customers WHERE country_id = 1
);

-- EXISTS Subquery
SELECT * FROM Destinations d
WHERE EXISTS (
    SELECT 1 FROM Reviews r WHERE r.destination_id = d.destination_id
);

-- ANY Subquery
SELECT * FROM Reviews
WHERE rating > ANY (
    SELECT rating FROM Reviews r
    JOIN Destinations d ON r.destination_id = d.destination_id
    WHERE d.name = 'Paris'
);

-- Subquery in FROM Clause
SELECT hotel_id, avg_rating
FROM (
    SELECT hotel_id, AVG(rating) AS avg_rating
    FROM Reviews
    GROUP BY hotel_id
) AS sub
WHERE avg_rating > 4;

-- STRING FUNCTIONS
SELECT 
    review_id,
    UPPER(review_text) AS upper_text,
    LOWER(review_text) AS lower_text,
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(review_text,1,20) AS short_review
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id;

-- NUMERIC FUNCTIONS
SELECT 
    review_id,
    rating,
    ROUND(rating, 0) AS rounded_rating,
    FLOOR(rating) AS floor_rating,
    CEIL(rating) AS ceil_rating
FROM Reviews;

-- DATE,TIME FUNCTIONS
SELECT 
    review_id,
    review_date,
    NOW() AS current_time,
    CURDATE() AS today,
    DATEDIFF(CURDATE(), review_date) AS days_since_review,
    YEAR(review_date) AS review_year,
    MONTH(review_date) AS review_month
FROM Reviews;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(review_id) AS total_reviews,
    AVG(rating) AS avg_rating,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating
FROM Reviews;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION ReviewCategory(r INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF r >= 4 THEN
        SET category = 'Positive';
    ELSEIF r = 3 THEN
        SET category = 'Neutral';
    ELSE
        SET category = 'Negative';
    END IF;
    RETURN category;
END//

DELIMITER ;


-- Usage:
SELECT review_id, rating, ReviewCategory(rating) AS category
FROM Reviews;

-- SIMPLE VIEW
CREATE VIEW view_simple_reviews AS
SELECT review_id,customer_id,rating,review_text,review_date,status
FROM Reviews;

-- COMPLEX VIEW
CREATE VIEW view_detailed_reviews AS
SELECT R.review_id,C.first_name,C.last_name,D.destination_name,R.rating,R.review_text,R.review_date,R.status
FROM Reviews R
JOIN Customers C ON R.customer_id = C.customer_id
JOIN Destinations D ON R.destination_id = D.destination_id
WHERE R.rating >= 4;

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE get_reviews_by_destination(IN p_destination_id INT)
BEGIN
    SELECT R.review_id,C.first_name,C.last_name,R.rating,R.review_text,R.review_date
    FROM Reviews R
    JOIN Customers C ON R.customer_id = C.customer_id
    WHERE R.destination_id = p_destination_id;
END //
DELIMITER ;

-- WINDOW FUNCTIONS
-- Rank destinations by average rating
SELECT destination_id,AVG(rating) AS avg_rating,
RANK() OVER (ORDER BY AVG(rating) DESC) AS rating_rank
FROM Reviews
GROUP BY destination_id;

-- DCL 
CREATE USER 'reviews_user'@'localhost' IDENTIFIED BY 'review123';

GRANT SELECT, INSERT, UPDATE ON Reviews TO 'reviews_user'@'localhost';

FLUSH PRIVILEGES;

-- TCL 
-- COMMIT 
START TRANSACTION;

UPDATE Reviews
SET status = 'Hidden'
WHERE review_id = 5;

INSERT INTO Reviews (customer_id, destination_id, hotel_id, flight_id, rating, review_text, review_date)
VALUES (1, 1, 1, 1, 5, 'Auto review', CURDATE());

COMMIT;

-- ROLLBACK 
START TRANSACTION;

UPDATE Reviews SET rating = 10 WHERE review_id = 3; -- invalid value

ROLLBACK;

-- Trigger 
-- Prevent invalid rating
DELIMITER //

CREATE TRIGGER trg_validate_rating
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 5';
    END IF;
END //

DELIMITER ;


-- -------------------------------------------------
-- Table 11: Packages
-- -------------------------------------------------
CREATE TABLE Packages (
    package_id INT PRIMARY KEY AUTO_INCREMENT,
    package_name VARCHAR(150) NOT NULL,
    agent_name VARCHAR(100) NOT NULL,
    description TEXT,
    start_city_id INT NOT NULL,
    end_city_id INT NOT NULL,
    duration_days INT CHECK (duration_days > 0),
    max_people INT CHECK (max_people > 0),
    price_per_person DECIMAL(10,2) CHECK (price_per_person >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (start_city_id) REFERENCES Cities(city_id),
    FOREIGN KEY (end_city_id) REFERENCES Cities(city_id)
);

INSERT INTO Packages (package_name, agent_name, description, start_city_id, end_city_id, duration_days, max_people, price_per_person)
VALUES
('Discover Delhi & Agra','Heritage Travels','Delhi city tour + Taj Mahal',1,1,3,20,150.00),
('Mumbai Weekend Getaway','Coastal Tours','Relaxing stay at Marine Drive',2,2,2,15,120.00),
('NYC Highlights','Metro Travel','Explore Manhattan & Brooklyn',3,3,4,25,300.00),
('Washington Monuments','Capital Trips','Museums + monuments',4,4,3,15,250.00),
('Paris Romantic','EuroTrips','Eiffel + Seine cruise',5,5,4,12,400.00),
('Tokyo Explorer','Nippon Tours','City + Mt Fuji day trip',6,6,5,18,380.00),
('Sydney Essentials','DownUnder Travel','Opera House + Harbor',7,7,3,20,320.00),
('Canberra Cultural','Capital Tours','Museums and galleries',8,8,2,10,180.00),
('Rio Carnival Special','Samba Travels','Carnival season package',9,9,6,30,350.00),
('Brasilia Architecture','Design Tours','Modernist architecture tour',10,10,3,12,200.00),
('Toronto City Break','Maple Escape','CN Tower + city tours',11,11,3,20,210.00),
('Berlin History Walk','Prussian Tours','WW2 & Cold War sites',13,13,4,18,220.00),
('Cape Town Adventure','Safari & Sea','Table Mountain + beaches',14,14,5,20,270.00),
('Rome Antiquity','LaBella Tours','Colosseum & Vatican',16,16,4,25,330.00),
('Beijing Heritage','GreatWall Trips','Forbidden City + Great Wall',17,17,5,25,310.00),
('London Classic','Royal Tours','Palaces + Thames cruise',18,18,4,30,360.00),
('Mexico City Culture','Aztec Tours','Museums + Teotihuacan',19,19,4,20,240.00),
('Moscow Imperial','Tsar Excursions','Kremlin & Red Square',20,20,3,15,260.00),
('Bangkok Temples','Thai Smile Tours','Grand Palace and temples',17,17,3,18,190.00),
('Dubai Luxury','Desert Dreams','Burj Khalifa + desert safari',20,20,3,25,420.00);

-- SELECT Queries 
-- View all Packages
SELECT * FROM Packages;

-- Packages under 4 days
SELECT package_name, duration_days, price_per_person
FROM Packages
WHERE duration_days < 4;

-- Packages by a specific agent
SELECT package_name, agent_name, price_per_person
FROM Packages
WHERE agent_name = 'EuroTrips';

-- Most expensive packages
SELECT package_name, price_per_person
FROM Packages
ORDER BY price_per_person DESC
LIMIT 5;

-- Packages available for more than 20 people
SELECT package_name, max_people, price_per_person
FROM Packages
WHERE max_people > 20;

-- TRUNCATE TABLE 
TRUNCATE TABLE Packages;

-- DROP TABLE 
DROP TABLE Packages;

-- Modify price_per_person to allow NULL
ALTER TABLE Packages MODIFY price_per_person DECIMAL(10,2) NULL;

-- Update price per person for a package
UPDATE Packages
SET price_per_person = 180.00
WHERE package_id = 2;

-- Update max people for a package
UPDATE Packages
SET max_people = 22
WHERE package_id = 1;

-- Sort by duration descending
SELECT package_name, duration_days
FROM Packages
ORDER BY duration_days DESC;

-- Average price per person
SELECT AVG(price_per_person) AS avg_price
FROM Packages;

-- Count of packages per agent
SELECT agent_name, COUNT(*) AS total_packages
FROM Packages
GROUP BY agent_name;

-- Operators

-- Comparison Operator 
SELECT * FROM Packages WHERE price_per_person > 300;	

-- BETWEEN Operator 
SELECT * FROM Packages WHERE duration_days BETWEEN 3 AND 5;	

-- IN Operator 
SELECT * FROM Packages WHERE agent_name IN ('EuroTrips','Royal Tours');	

-- LIKE Operator 
SELECT * FROM Packages WHERE package_name LIKE '%Delhi%';	

-- AND Operators
SELECT * FROM Packages WHERE price_per_person > 200 AND duration_days <= 4;	

-- NOT Operator 
SELECT * FROM Packages WHERE NOT agent_name = 'Coastal Tours';

-- Clauses

-- WHERE Clause
SELECT * FROM Packages WHERE max_people > 20;	

-- ORDER BY Clause
SELECT * FROM Packages ORDER BY price_per_person DESC;	

-- GROUP BY Clause
SELECT agent_name, COUNT(package_id) FROM Packages GROUP BY agent_name;

-- HAVING Clause
SELECT agent_name, COUNT(package_id) FROM Packages GROUP BY agent_name HAVING COUNT(package_id) > 1;	

-- LIMIT Clause
SELECT * FROM Packages LIMIT 5;	

-- DISTINCT Clause
SELECT DISTINCT agent_name FROM Packages;

-- Aliases

-- Column Alias	
SELECT package_name AS "Package", price_per_person AS "Price (₹)" FROM Packages;	

-- Table Alias	
SELECT p.package_name, c.city_name FROM Packages AS p JOIN Cities AS c ON p.start_city_id = c.city_id;

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE Packages (
    package_id INT PRIMARY KEY AUTO_INCREMENT,
    package_name VARCHAR(150) NOT NULL,
    agent_name VARCHAR(100) NOT NULL,
    description TEXT,
    start_city_id INT NOT NULL,
    end_city_id INT NOT NULL,
    duration_days INT CHECK (duration_days > 0),
    max_people INT CHECK (max_people > 0),
    price_per_person DECIMAL(10,2) CHECK (price_per_person >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (start_city_id) REFERENCES Cities(city_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (end_city_id) REFERENCES Cities(city_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- JOINS
-- INNER JOIN
SELECT p.package_name, c1.city_name AS start_city, c2.city_name AS end_city, p.agent_name, p.price_per_person
FROM Packages p
INNER JOIN Cities c1 ON p.start_city_id = c1.city_id
INNER JOIN Cities c2 ON p.end_city_id = c2.city_id;

-- LEFT JOIN
SELECT p.package_name, d.name AS destination_name FROM Packages p
LEFT JOIN Destinations d ON p.end_city_id = d.city_id;

-- RIGHT JOIN
SELECT d.name AS destination_name, p.package_name FROM Destinations d
RIGHT JOIN Packages p ON p.end_city_id = d.city_id;

-- FULL OUTER JOIN
SELECT p.package_name, d.name AS destination_name FROM Packages p
LEFT JOIN Destinations d ON p.end_city_id = d.city_id
UNION
SELECT p.package_name, d.name AS destination_name FROM Packages p
RIGHT JOIN Destinations d ON p.end_city_id = d.city_id;

-- SELF JOIN
SELECT p1.package_name AS Package1, p2.package_name AS Package2, c.city_name AS start_city
FROM Packages p1
JOIN Packages p2 ON p1.start_city_id = p2.start_city_id AND p1.package_id <> p2.package_id
JOIN Cities c ON p1.start_city_id = c.city_id;

-- CROSS JOIN
SELECT p.package_name, c.city_name FROM Packages p
CROSS JOIN Cities c;

-- SUBQUERIES
-- Scalar Subquery
SELECT package_name, price_per_person,
       (SELECT AVG(price_per_person) FROM Packages) AS avg_price
FROM Packages;

-- Correlated Subquery
SELECT p.package_name, p.price_per_person, p.start_city_id
FROM Packages p
WHERE p.price_per_person > (
    SELECT AVG(p2.price_per_person)
    FROM Packages p2
    WHERE p2.start_city_id = p.start_city_id
);

-- IN Subquery
SELECT * FROM Packages
WHERE start_city_id IN (
    SELECT city_id FROM Cities WHERE city_name IN ('New Delhi','Mumbai')
);

-- EXISTS Subquery
SELECT * FROM Cities c
WHERE EXISTS (
    SELECT 1 FROM Packages p WHERE p.start_city_id = c.city_id
);

-- ANY Subquery
SELECT * FROM Packages
WHERE price_per_person > ANY (
    SELECT price_per_person FROM Packages p
    JOIN Cities c ON p.start_city_id = c.city_id
    WHERE c.city_name = 'Paris'
);

-- Subquery in FROM Clause
SELECT agent_name, avg_price
FROM (
    SELECT agent_name, AVG(price_per_person) AS avg_price
    FROM Packages
    GROUP BY agent_name
) AS sub
WHERE avg_price > 200;

-- STRING FUNCTIONS
SELECT package_name,
       UPPER(package_name) AS upper_name,
       LOWER(package_name) AS lower_name,
       CONCAT(package_name, ' by ', agent_name) AS package_info,
       SUBSTRING(description,1,30) AS short_desc
FROM Packages;

-- NUMERIC FUNCTIONS
SELECT package_name,
       ROUND(price_per_person, 0) AS rounded_price,
       FLOOR(price_per_person) AS floor_price,
       CEIL(price_per_person) AS ceil_price
FROM Packages;

-- DATE,TIME FUNCTIONS
SELECT package_name,
       created_at,
       NOW() AS current_time,
       CURDATE() AS today,
       DATEDIFF(NOW(), created_at) AS days_since_created,
       YEAR(created_at) AS created_year,
       MONTH(created_at) AS created_month
FROM Packages;

-- AGGREGATE FUNCTIONS
SELECT COUNT(package_id) AS total_packages,
       AVG(price_per_person) AS avg_price,
       MIN(price_per_person) AS min_price,
       MAX(price_per_person) AS max_price,
       SUM(max_people) AS total_capacity
FROM Packages;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION PackageAffordability(price DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF price >= 400 THEN
        SET category = 'Expensive';
    ELSEIF price >= 200 THEN
        SET category = 'Moderate';
    ELSE
        SET category = 'Budget';
    END IF;
    RETURN category;
END//

DELIMITER ;


-- Usage:

SELECT package_name, price_per_person, PackageAffordability(price_per_person) AS affordability
FROM Packages;

-- SIMPLE VIEWS
CREATE VIEW v_basic_packages AS
SELECT package_id, package_name, agent_name, duration_days, price_per_person
FROM Packages;

-- COMPLEX VIEWS 
CREATE VIEW v_package_with_cities AS
SELECT p.package_id, p.package_name, c1.city_name AS start_city, c2.city_name AS end_city,p.duration_days, p.price_per_person
FROM Packages p
JOIN Cities c1 ON p.start_city_id = c1.city_id
JOIN Cities c2 ON p.end_city_id = c2.city_id;

-- WINDOW FUNCTION QUERIES
SELECT package_id, package_name, price_per_person,
       RANK() OVER(ORDER BY price_per_person DESC) AS price_rank
FROM Packages;

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE get_packages_above_price(IN min_price DECIMAL(10,2))
BEGIN
    SELECT package_id, package_name, price_per_person
    FROM Packages
    WHERE price_per_person >= min_price;
END //

DELIMITER ;

-- Run it
CALL get_packages_above_price(300);

-- DCL 
-- Create User
CREATE USER 'travel_user'@'localhost' IDENTIFIED BY 'pass123';

-- Give SELECT Permission
GRANT SELECT ON Packages TO 'travel_user'@'localhost';

-- Revoke Permission
REVOKE SELECT ON Packages FROM 'travel_user'@'localhost';

-- Apply Privileges
FLUSH PRIVILEGES;

-- TCL 
-- Start a transaction
START TRANSACTION;

-- Insert,update and commit
INSERT INTO Packages (package_name, agent_name, description, start_city_id, end_city_id, duration_days, max_people, price_per_person)
VALUES ('Test Package','Test Agent','Testing',1,1,3,10,100);

UPDATE Packages
SET price_per_person = 500
WHERE package_name = 'Test Package';

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE Packages SET price_per_person = 1 WHERE package_id = 3;

ROLLBACK;

-- TRIGGERS
-- To prevent negative price
DELIMITER //
CREATE TRIGGER trg_no_negative_price
BEFORE INSERT ON Packages
FOR EACH ROW
BEGIN
    IF NEW.price_per_person < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END //
DELIMITER ;

-- Trigger to auto-uppercase package name
DELIMITER //
CREATE TRIGGER trg_uppercase_package_name
BEFORE INSERT ON Packages
FOR EACH ROW
BEGIN
    SET NEW.package_name = UPPER(NEW.package_name);
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 12: PackageItems
-- -------------------------------------------------
CREATE TABLE PackageItems (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    package_id INT NOT NULL,
    item_type VARCHAR(20) NOT NULL,
    ref_id INT NOT NULL,
    day_no INT CHECK (day_no > 0),
    sequence_no INT DEFAULT 1,
    notes VARCHAR(255),
    included BOOLEAN DEFAULT TRUE,
    price_addon DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (package_id) REFERENCES Packages(package_id),
    CHECK (item_type IN ('Destination','Hotel','Flight','Activity','Transport'))
);

-- 20 items for various packages (ref_id references Destinations.destination_id, Hotels.hotel_id, Flights.flight_id, Activities.activity_id)
INSERT INTO PackageItems 
(package_id, item_type, ref_id, day_no, sequence_no, notes, included, price_addon) 
VALUES
(1,'Destination',1,1,1,'Visit Red Fort',TRUE,0),
(1,'Transport',1,1,2,'Private coach to Agra',TRUE,25.00),
(1,'Destination',17,2,1,'Taj Mahal visit',TRUE,0),
(2,'Hotel',2,1,1,'Sea View Hotel stay',TRUE,0),
(2,'Activity',2,1,2,'Evening promenade',TRUE,0),
(3,'Destination',3,1,1,'Statue of Liberty cruise',TRUE,0),
(3,'Hotel',3,2,1,'NYC Grand stay',TRUE,0),
(4,'Destination',4,1,1,'Lincoln Memorial tour',TRUE,0),
(5,'Destination',5,1,1,'Eiffel Tower visit',TRUE,0),
(5,'Activity',5,2,1,'Seine river cruise',TRUE,30.00),
(6,'Destination',6,1,1,'Mt Fuji day trip',TRUE,0),
(6,'Hotel',6,2,1,'Fuji Resort stay',TRUE,0),
(7,'Destination',7,1,1,'Sydney Opera House tour',TRUE,0),
(8,'Destination',8,1,1,'Parliament House visit',TRUE,0),
(9,'Activity',9,1,1,'Carnival parade seats',TRUE,50.00),
(10,'Destination',10,1,1,'Cathedral visit',TRUE,0),
(11,'Activity',11,1,1,'CN Tower observation',TRUE,15.00),
(12,'Destination',13,1,1,'Brandenburg Gate walk',TRUE,0),
(13,'Activity',14,1,1,'Table Mountain cable car',TRUE,20.00),
(14,'Destination',16,1,1,'Colosseum tour',TRUE,0);


-- SELECT Queries 
-- View all Packages
SELECT * FROM Packages;
-- All activities in packages with price_addon > 20
SELECT p.package_name, pi.item_type, pi.notes, pi.price_addon
FROM PackageItems pi
JOIN Packages p ON pi.package_id = p.package_id
WHERE pi.item_type = 'Activity' AND pi.price_addon > 20;

-- Items included in package_id = 1
SELECT item_type, notes, included, price_addon
FROM PackageItems
WHERE package_id = 1;

-- Count of items per package
SELECT package_id, COUNT(*) AS total_items
FROM PackageItems
GROUP BY package_id;

-- All transport items
SELECT pi.item_id, p.package_name, pi.notes, pi.price_addon
FROM PackageItems pi
JOIN Packages p ON pi.package_id = p.package_id
WHERE pi.item_type = 'Transport';

-- TRUNCATE TABLE 
TRUNCATE TABLE PackageItems;

-- DROP TABLE 
DROP TABLE PackageItems;

-- Add a new column for item duration
ALTER TABLE PackageItems ADD item_duration_hours INT DEFAULT 0;

-- Modify price_addon to allow NULL
ALTER TABLE PackageItems MODIFY price_addon DECIMAL(10,2) NULL;

-- Drop a column
ALTER TABLE PackageItems DROP COLUMN item_duration_hours;

-- Change notes for an item
UPDATE PackageItems
SET notes = 'Private guide included'
WHERE item_id = 1;

-- Sort by day_no and sequence_no
SELECT * 
FROM PackageItems
ORDER BY day_no ASC, sequence_no ASC;

-- Sort by price_addon descending
SELECT * 
FROM PackageItems
ORDER BY price_addon DESC;

-- Total additional price per package
SELECT package_id, SUM(price_addon) AS total_addon
FROM PackageItems
GROUP BY package_id;

-- Operators 

-- Comparison Operator	
SELECT * FROM PackageItems WHERE day_no > 1;	

-- BETWEEN Operator
SELECT * FROM PackageItems WHERE price_addon BETWEEN 10 AND 30;	

-- IN Operator	
SELECT * FROM PackageItems WHERE item_type IN ('Activity','Hotel');

-- LIKE Operator	
SELECT * FROM PackageItems WHERE notes LIKE '%tour%';	

-- AND Operator
SELECT * FROM PackageItems WHERE included = TRUE AND price_addon > 0;	

-- NOT Operator	
SELECT * FROM PackageItems WHERE NOT item_type = 'Transport';

-- Clauses

-- WHERE Clause	
SELECT * FROM PackageItems WHERE included = TRUE;	

-- ORDER BY Clause	
SELECT * FROM PackageItems ORDER BY day_no ASC;	

-- GROUP BY Clause	
SELECT package_id, COUNT(item_id) FROM PackageItems GROUP BY package_id;

-- HAVING Clause	
SELECT package_id, COUNT(item_id) FROM PackageItems GROUP BY package_id HAVING COUNT(item_id) > 2;
	
-- LIMIT Clause
SELECT * FROM PackageItems LIMIT 5;

-- DISTINCT Clause
SELECT DISTINCT item_type FROM PackageItems;

-- Alias 

-- Column Alias	
SELECT item_type AS Type, price_addon AS ExtraCost FROM PackageItems;	

-- Table Alias	
SELECT p.package_name, pi.item_type, pi.notes FROM Packages AS p JOIN PackageItems AS pi ON p.package_id = pi.package_id;

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE PackageItems (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    package_id INT NOT NULL,
    item_type VARCHAR(20) NOT NULL,
    ref_id INT NOT NULL,
    day_no INT CHECK (day_no > 0),
    sequence_no INT DEFAULT 1,
    notes VARCHAR(255),
    included BOOLEAN DEFAULT TRUE,
    price_addon DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (package_id) REFERENCES Packages(package_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CHECK (item_type IN ('Destination','Hotel','Flight','Activity','Transport'))
);


-- JOINS
-- INNER JOIN
SELECT pi.item_id, pi.item_type, pi.day_no, pi.sequence_no, pi.notes, pi.price_addon,p.package_name,d.name AS destination_name,h.hotel_name,f.flight_number
FROM PackageItems pi
INNER JOIN Packages p ON pi.package_id = p.package_id
LEFT JOIN Destinations d ON pi.item_type='Destination' AND pi.ref_id = d.destination_id
LEFT JOIN Hotels h ON pi.item_type='Hotel' AND pi.ref_id = h.hotel_id
LEFT JOIN Flights f ON pi.item_type='Flight' AND pi.ref_id = f.flight_id;

-- LEFT JOIN
SELECT pi.*, p.package_name FROM PackageItems pi
LEFT JOIN Packages p ON pi.package_id = p.package_id;

-- RIGHT JOIN
SELECT p.package_name, pi.item_type, pi.notes FROM PackageItems pi
RIGHT JOIN Packages p ON pi.package_id = p.package_id;

-- FULL OUTER JOIN
SELECT p.package_name, pi.item_type FROM Packages p
LEFT JOIN PackageItems pi ON p.package_id = pi.package_id
UNION
SELECT p.package_name, pi.item_type FROM Packages p
RIGHT JOIN PackageItems pi ON p.package_id = pi.package_id;

-- SELF JOIN
SELECT pi1.package_id, pi1.notes AS item1, pi2.notes AS item2 FROM PackageItems pi1
JOIN PackageItems pi2 
  ON pi1.package_id = pi2.package_id 
 AND pi1.sequence_no < pi2.sequence_no;

-- CROSS JOIN
SELECT pi.notes, p.package_name FROM PackageItems pi
CROSS JOIN Packages p;

-- SUBQUERIES
-- Scalar Subquery
SELECT pi.item_id, pi.package_id, pi.notes,
       (SELECT COUNT(*) FROM PackageItems WHERE package_id = pi.package_id) AS total_items
FROM PackageItems pi;

-- Correlated Subquery
SELECT pi.*
FROM PackageItems pi
WHERE pi.price_addon > (
    SELECT AVG(pi2.price_addon)
    FROM PackageItems pi2
    WHERE pi2.package_id = pi.package_id
);

-- IN Subquery
SELECT * FROM PackageItems
WHERE package_id IN (
    SELECT package_id FROM Packages WHERE price_per_person > 300
);

-- EXISTS Subquery
SELECT * FROM Packages p
WHERE EXISTS (
    SELECT 1 FROM PackageItems pi
    WHERE pi.package_id = p.package_id AND pi.item_type='Transport'
);

-- ANY Subquery
SELECT * FROM PackageItems
WHERE price_addon > ANY (
    SELECT price_addon FROM PackageItems WHERE package_id = 1
);

-- Subquery in FROM Clause
SELECT package_id, avg_addon
FROM (
    SELECT package_id, AVG(price_addon) AS avg_addon
    FROM PackageItems
    GROUP BY package_id
) AS sub
WHERE avg_addon > 10;

-- STRING FUNCTIONS
SELECT notes,
       UPPER(notes) AS upper_notes,
       LOWER(notes) AS lower_notes,
       CONCAT('Package ID: ', package_id, ' - ', notes) AS item_info,
       SUBSTRING(notes,1,20) AS short_notes
FROM PackageItems;

-- NUMERIC FUNCTIONS
SELECT notes, price_addon,
       ROUND(price_addon,0) AS rounded_price,
       FLOOR(price_addon) AS floor_price,
       CEIL(price_addon) AS ceil_price
FROM PackageItems;

-- DATE,TIME FUNCTIONS
SELECT notes, created_at,
       NOW() AS current_time,
       CURDATE() AS today,
       DATEDIFF(NOW(), created_at) AS days_since_created,
       YEAR(created_at) AS created_year,
       MONTH(created_at) AS created_month
FROM PackageItems;

-- AGGREGATE FUNCTIONS
SELECT COUNT(item_id) AS total_items,
       SUM(price_addon) AS total_addon_cost,
       AVG(price_addon) AS avg_addon_price,
       MIN(price_addon) AS min_addon_price,
       MAX(price_addon) AS max_addon_price
FROM PackageItems;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION ItemPriceCategory(price DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF price >= 50 THEN
        SET category = 'Expensive';
    ELSEIF price >= 20 THEN
        SET category = 'Moderate';
    ELSE
        SET category = 'Budget';
    END IF;
    RETURN category;
END//

DELIMITER ;

-- Usage:

SELECT notes, price_addon, ItemPriceCategory(price_addon) AS price_category
FROM PackageItems;


-- SIMPLE VIEWS
CREATE VIEW v_basic_package_items AS
SELECT item_id, package_id, item_type, day_no, sequence_no, included
FROM PackageItems;

-- COMPLEX VIEWS
CREATE VIEW v_package_items_with_package AS
SELECT pi.item_id, p.package_name, pi.item_type, pi.day_no, pi.sequence_no, pi.notes
FROM PackageItems pi
JOIN Packages p ON pi.package_id = p.package_id;

-- WINDOW FUNCTION QUERIES
-- Rank items inside each package by sequence number
SELECT 
    item_id, package_id, day_no, sequence_no,
    RANK() OVER(PARTITION BY package_id ORDER BY day_no, sequence_no) AS item_rank
FROM PackageItems;

-- STORED PROCEDURES
DELIMITER //
CREATE PROCEDURE get_package_items(IN pkg_id INT)
BEGIN
    SELECT item_id, item_type, ref_id, day_no, sequence_no, notes, included, price_addon
    FROM PackageItems
    WHERE package_id = pkg_id;
END //
DELIMITER ;

CALL get_package_items(1);

-- DCL 
CREATE USER 'pkg_user'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT, INSERT ON PackageItems TO 'pkg_user'@'localhost';

REVOKE INSERT ON PackageItems FROM 'pkg_user'@'localhost';

FLUSH PRIVILEGES;

-- TCL 
START TRANSACTION;

INSERT INTO PackageItems (package_id, item_type, ref_id, day_no, sequence_no)
VALUES (1, 'Activity', 9, 3, 1);

UPDATE PackageItems
SET price_addon = 100
WHERE item_id = 5;

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE PackageItems SET included = FALSE WHERE item_id = 3;

ROLLBACK;

-- TRIGGERS
-- Prevent negative addon prices
DELIMITER //
CREATE TRIGGER trg_no_negative_addon
BEFORE INSERT ON PackageItems
FOR EACH ROW
BEGIN
    IF NEW.price_addon < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Addon price cannot be negative';
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 13: HotelRooms
-- -------------------------------------------------
CREATE TABLE HotelRooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(30) CHECK (room_type IN ('Single','Double','Twin','Suite','Deluxe','Family')),
    price_per_night DECIMAL(10,2) CHECK (price_per_night >= 0),
    max_occupancy INT CHECK (max_occupancy > 0),
    refundable BOOLEAN DEFAULT TRUE,
    status VARCHAR(20) DEFAULT 'Available',
    floor_no INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id),
    UNIQUE (hotel_id, room_number)
);

-- 20 rooms across hotels (hotel_id 1..20 exist)
INSERT INTO HotelRooms (hotel_id, room_number, room_type, price_per_night, max_occupancy, refundable, status, floor_no)
VALUES
(1,'101','Double',8000,2,TRUE,'Available',1),
(1,'102','Suite',15000,4,TRUE,'Booked',2),
(2,'201','Double',6000,2,TRUE,'Available',2),
(2,'202','Deluxe',8500,3,TRUE,'Available',3),
(3,'301','Suite',20000,4,TRUE,'Available',4),
(3,'302','Single',12000,1,FALSE,'Available',3),
(4,'401','Double',18000,2,TRUE,'Booked',4),
(5,'501','Suite',22000,4,TRUE,'Available',5),
(6,'601','Double',12000,2,TRUE,'Available',2),
(7,'701','Double',15000,2,TRUE,'Available',3),
(8,'801','Single',7000,1,TRUE,'Available',1),
(9,'901','Deluxe',9000,3,TRUE,'Available',2),
(10,'1001','Double',8000,2,TRUE,'Available',1),
(11,'1101','Suite',14000,3,TRUE,'Booked',7),
(12,'1201','Single',5000,1,TRUE,'Available',2),
(13,'1301','Double',10000,2,TRUE,'Available',3),
(14,'1401','Family',8500,4,TRUE,'Available',2),
(15,'1501','Single',4000,1,FALSE,'Available',1),
(16,'1601','Suite',16000,4,TRUE,'Available',5),
(17,'1701','Double',11000,2,TRUE,'Available',3);

-- SELECT Queries 
-- View all HotelRooms
SELECT * FROM HotelRooms;

-- Available rooms only
SELECT hotel_id, room_number, room_type, price_per_night
FROM HotelRooms
WHERE status = 'Available';

-- Rooms with price > 15000
SELECT hotel_id, room_number, room_type, price_per_night
FROM HotelRooms
WHERE price_per_night > 15000;

-- Count rooms per hotel
SELECT hotel_id, COUNT(*) AS total_rooms
FROM HotelRooms
GROUP BY hotel_id;

-- Suites across all hotels
SELECT hr.room_id, h.hotel_name, hr.room_number, hr.price_per_night
FROM HotelRooms hr
JOIN Hotels h ON hr.hotel_id = h.hotel_id
WHERE hr.room_type = 'Suite';

-- TRUNCATE TABLE
TRUNCATE TABLE HotelRooms;

-- DROP TABLE 
DROP TABLE HotelRooms;

-- Add a column for room view
ALTER TABLE HotelRooms ADD room_view VARCHAR(50);

-- Modify price_per_night to allow higher precision
ALTER TABLE HotelRooms MODIFY price_per_night DECIMAL(12,2) NOT NULL;

-- Drop a column
ALTER TABLE HotelRooms DROP COLUMN room_view;

-- Change price for a room
UPDATE HotelRooms
SET price_per_night = 9000
WHERE room_id = 9;

-- Sort by price descending
SELECT * 
FROM HotelRooms
ORDER BY price_per_night DESC;

-- Average price per hotel
SELECT hotel_id, AVG(price_per_night) AS avg_price
FROM HotelRooms
GROUP BY hotel_id;

-- Operators 

-- Comparison Operator	
SELECT * FROM HotelRooms WHERE price_per_night > 10000;	

-- BETWEEN Operator
SELECT * FROM HotelRooms WHERE floor_no BETWEEN 1 AND 3;

-- IN Operator	
SELECT * FROM HotelRooms WHERE room_type IN ('Suite','Deluxe');	

-- LIKE Operator	
SELECT * FROM HotelRooms WHERE status LIKE 'Avail%';

-- AND Operator	
SELECT * FROM HotelRooms WHERE refundable = TRUE AND max_occupancy = 2;	

-- Clauses 

-- WHERE Clause
SELECT * FROM HotelRooms WHERE status='Booked';

-- ORDER BY Clause
SELECT * FROM HotelRooms ORDER BY price_per_night DESC;	

-- GROUP BY	Clause
SELECT hotel_id, COUNT(room_id) FROM HotelRooms GROUP BY hotel_id;	

-- HAVING Clause	
SELECT hotel_id, COUNT(room_id) FROM HotelRooms GROUP BY hotel_id HAVING COUNT(room_id) > 5;	

-- LIMIT Clause	
SELECT * FROM HotelRooms LIMIT 10;

-- DISTINCT	Clause
SELECT DISTINCT room_type FROM HotelRooms;

-- Alias Queries

-- Column Alias	
SELECT room_number AS RoomNo, price_per_night AS Price FROM HotelRooms;	

-- Table Alias	
SELECT h.hotel_name, r.room_number, r.price_per_night FROM Hotels AS h JOIN HotelRooms AS r ON h.hotel_id = r.hotel_id;

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE HotelRooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(30) CHECK (room_type IN ('Single','Double','Twin','Suite','Deluxe','Family')),
    price_per_night DECIMAL(10,2) CHECK (price_per_night >= 0),
    max_occupancy INT CHECK (max_occupancy > 0),
    refundable BOOLEAN DEFAULT TRUE,
    status VARCHAR(20) DEFAULT 'Available',
    floor_no INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (hotel_id, room_number)
);

-- JOINS
-- INNER JOIN
SELECT hr.room_id, hr.room_number, hr.room_type, hr.price_per_night, hr.status,
       h.hotel_name, h.address
FROM HotelRooms hr
INNER JOIN Hotels h ON hr.hotel_id = h.hotel_id;

-- LEFT JOIN
SELECT hr.*, h.hotel_name FROM HotelRooms hr
LEFT JOIN Hotels h ON hr.hotel_id = h.hotel_id;

-- RIGHT JOIN
SELECT h.hotel_name, hr.room_number, hr.room_type FROM HotelRooms hr
RIGHT JOIN Hotels h ON hr.hotel_id = h.hotel_id;

-- FULL OUTER JOIN
SELECT hr.room_number, h.hotel_name FROM HotelRooms hr
LEFT JOIN Hotels h ON hr.hotel_id = h.hotel_id
UNION
SELECT hr.room_number, h.hotel_name FROM HotelRooms hr
RIGHT JOIN Hotels h ON hr.hotel_id = h.hotel_id;

-- SELF JOIN
SELECT hr1.hotel_id, hr1.room_number AS room1, hr2.room_number AS room2, hr1.floor_no
FROM HotelRooms hr1
JOIN HotelRooms hr2 
  ON hr1.hotel_id = hr2.hotel_id 
 AND hr1.floor_no = hr2.floor_no
 AND hr1.room_id < hr2.room_id;

-- CROSS JOIN
SELECT hr.room_number, h.hotel_name FROM HotelRooms hr
CROSS JOIN Hotels h;

-- SUBQUERIES
-- Scalar Subquery
SELECT hr.room_id, hr.room_number, hr.hotel_id,
       (SELECT COUNT(*) FROM HotelRooms WHERE hotel_id = hr.hotel_id) AS total_rooms
FROM HotelRooms hr;

-- Correlated Subquery
SELECT hr.*
FROM HotelRooms hr
WHERE hr.price_per_night > (
    SELECT AVG(hr2.price_per_night)
    FROM HotelRooms hr2
    WHERE hr2.hotel_id = hr.hotel_id
);

-- IN Subquery
SELECT * FROM HotelRooms
WHERE hotel_id IN (
    SELECT hotel_id FROM Hotels WHERE star_rating = 5
);

-- EXISTS Subquery
SELECT * FROM Hotels h
WHERE EXISTS (
    SELECT 1 FROM HotelRooms hr
    WHERE hr.hotel_id = h.hotel_id AND hr.room_type='Suite'
);

-- ANY Subquery
SELECT * FROM HotelRooms
WHERE price_per_night > ANY (
    SELECT price_per_night FROM HotelRooms WHERE hotel_id = 1
);

-- Subquery in FROM Clause
SELECT hotel_id, avg_price
FROM (
    SELECT hotel_id, AVG(price_per_night) AS avg_price
    FROM HotelRooms
    GROUP BY hotel_id
) AS sub
WHERE avg_price > 10000;

-- STRING FUNCTIONS
SELECT room_number,
       UPPER(room_type) AS upper_type,
       LOWER(room_type) AS lower_type,
       CONCAT('Hotel ID ', hotel_id, ' - ', room_type) AS room_info,
       SUBSTRING(room_type,1,3) AS short_type
FROM HotelRooms;

-- NUMERIC FUNCTIONS
SELECT room_number, price_per_night,
       ROUND(price_per_night,0) AS rounded_price,
       FLOOR(price_per_night) AS floor_price,
       CEIL(price_per_night) AS ceil_price
FROM HotelRooms;

-- DATE/TIME FUNCTIONS
SELECT room_number, created_at,
       NOW() AS current_time,
       CURDATE() AS today,
       DATEDIFF(NOW(), created_at) AS days_since_created,
       YEAR(created_at) AS created_year,
       MONTH(created_at) AS created_month
FROM HotelRooms;

-- AGGREGATE FUNCTIONS
SELECT COUNT(room_id) AS total_rooms,
       SUM(price_per_night) AS total_price,
       AVG(price_per_night) AS avg_price,
       MIN(price_per_night) AS min_price,
       MAX(price_per_night) AS max_price
FROM HotelRooms;

-- USER-DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION RoomPriceCategory(price DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF price >= 15000 THEN
        SET category = 'Luxury';
    ELSEIF price >= 8000 THEN
        SET category = 'Premium';
    ELSE
        SET category = 'Economy';
    END IF;
    RETURN category;
END//

DELIMITER ;


-- Usage:
SELECT room_number, price_per_night, RoomPriceCategory(price_per_night) AS price_category
FROM HotelRooms;

-- SIMPLE VIEWS
CREATE VIEW v_hotel_rooms_basic AS
SELECT room_id, hotel_id, room_number, room_type, price_per_night, status
FROM HotelRooms;

-- COMPLEX VIEWS 
-- Rooms with Hotel Name
CREATE VIEW v_rooms_with_hotel AS
SELECT hr.room_id, h.hotel_name, hr.room_number, hr.room_type, hr.price_per_night, hr.status
FROM HotelRooms hr
JOIN Hotels h ON hr.hotel_id = h.hotel_id;

-- WINDOW FUNCTION QUERIES
SELECT room_id, hotel_id, room_number, price_per_night,
       RANK() OVER(PARTITION BY hotel_id ORDER BY price_per_night DESC) AS price_rank
FROM HotelRooms;

-- STORED PROCEDURES
DELIMITER //
CREATE PROCEDURE get_hotel_rooms(IN h_id INT)
BEGIN
    SELECT room_id, room_number, room_type, price_per_night, status
    FROM HotelRooms
    WHERE hotel_id = h_id;
END //
DELIMITER ;

-- Usage
CALL get_hotel_rooms(1);

-- DCL 
CREATE USER 'hotel_user'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT, INSERT, UPDATE ON HotelRooms TO 'hotel_user'@'localhost';

REVOKE DELETE ON HotelRooms FROM 'hotel_user'@'localhost';

FLUSH PRIVILEGES;

-- TCL 
-- Book a Room Transaction
START TRANSACTION;

UPDATE HotelRooms
SET status = 'Booked'
WHERE room_id = 101;

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE HotelRooms
SET status = 'Available'
WHERE room_id = 102;

ROLLBACK;

-- TRIGGERS
-- Prevent Negative Price
DELIMITER //
CREATE TRIGGER trg_no_negative_price
BEFORE INSERT ON HotelRooms
FOR EACH ROW
BEGIN
    IF NEW.price_per_night < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Room price cannot be negative';
    END IF;
END //
DELIMITER ;

-- Uppercase Room Type
DELIMITER //
CREATE TRIGGER trg_uppercase_room_type
BEFORE INSERT ON HotelRooms
FOR EACH ROW
BEGIN
    IF NEW.room_type IS NOT NULL THEN
        SET NEW.room_type = UPPER(NEW.room_type);
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 14: FlightSeats
-- -------------------------------------------------
CREATE TABLE FlightSeats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    seat_number VARCHAR(6) NOT NULL,
    seat_class VARCHAR(20) CHECK (seat_class IN ('Economy','Premium Economy','Business','First')),
    is_window BOOLEAN DEFAULT FALSE,
    is_aisle BOOLEAN DEFAULT FALSE,
    seat_price DECIMAL(10,2) CHECK (seat_price >= 0),
    status VARCHAR(20) DEFAULT 'Available',
    booked_by_customer INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (booked_by_customer) REFERENCES Customers(customer_id),
    UNIQUE(flight_id, seat_number)
);

-- 20 seats across flights 1..20 (some booked_by_customer reference existing customers 1..20)
INSERT INTO FlightSeats (flight_id, seat_number, seat_class, is_window, is_aisle, seat_price, status, booked_by_customer)
VALUES
(1,'1A','Business',TRUE,FALSE,15000,'Available',NULL),
(1,'1B','Business',FALSE,TRUE,15000,'Booked',1),
(2,'10C','Economy',FALSE,TRUE,5000,'Booked',2),
(2,'10D','Economy',TRUE,FALSE,5000,'Available',NULL),
(3,'2A','Business',TRUE,FALSE,14000,'Available',NULL),
(3,'20A','Economy',TRUE,FALSE,4800,'Booked',3),
(4,'3C','Business',FALSE,TRUE,14500,'Available',NULL),
(4,'3D','Business',FALSE,TRUE,14500,'Booked',4),
(5,'4A','First',TRUE,FALSE,30000,'Available',NULL),
(6,'15B','Economy',FALSE,TRUE,7000,'Booked',5),
(7,'5A','Business',TRUE,FALSE,13500,'Available',NULL),
(8,'6B','Premium Economy',FALSE,TRUE,9000,'Booked',6),
(9,'7C','Economy',FALSE,TRUE,5200,'Available',NULL),
(10,'8D','Economy',TRUE,FALSE,5200,'Booked',7),
(11,'9A','Business',TRUE,FALSE,16000,'Available',NULL),
(12,'11B','Economy',FALSE,TRUE,6000,'Booked',8),
(13,'12C','Economy',FALSE,TRUE,6100,'Available',NULL),
(14,'13D','Business',TRUE,FALSE,15500,'Booked',9),
(15,'14A','Premium Economy',TRUE,FALSE,9500,'Available',NULL),
(16,'16B','Economy',FALSE,TRUE,7200,'Booked',10);

-- SELECT Queries 
-- View all FlightSeats
SELECT * FROM FlightSeats;

-- Available seats only
SELECT flight_id, seat_number, seat_class, seat_price
FROM FlightSeats
WHERE status = 'Available';

-- Seats booked by a specific customer (e.g., customer_id = 2)
SELECT flight_id, seat_number, seat_class, status
FROM FlightSeats
WHERE booked_by_customer = 2;

-- Count of seats per class for each flight
SELECT flight_id, seat_class, COUNT(*) AS total_seats
FROM FlightSeats
GROUP BY flight_id, seat_class;

-- Window seats available
SELECT flight_id, seat_number, seat_class, seat_price
FROM FlightSeats
WHERE is_window = TRUE AND status = 'Available';

-- TRUNCATE TABLE 
TRUNCATE TABLE FlightSeats;

-- DROP TABLE 
DROP TABLE FlightSeats;

-- Add a column for seat extra legroom
ALTER TABLE FlightSeats ADD extra_legroom BOOLEAN DEFAULT FALSE;

-- Modify seat_price precision
ALTER TABLE FlightSeats MODIFY seat_price DECIMAL(12,2) NOT NULL;

-- Update seat status to Booked
UPDATE FlightSeats
SET status = 'Booked', booked_by_customer = 11
WHERE flight_id = 5 AND seat_number = '4A';

-- Change seat price for a specific seat
UPDATE FlightSeats
SET seat_price = 16000
WHERE flight_id = 7 AND seat_number = '5A';

-- Available seats only
SELECT * 
FROM FlightSeats
WHERE status = 'Available';

-- Sort by price descending
SELECT * 
FROM FlightSeats
ORDER BY seat_price DESC;

-- Average seat price by class
SELECT seat_class, AVG(seat_price) AS avg_price
FROM FlightSeats
GROUP BY seat_class;

-- Operators

-- Comparison Operator
SELECT * FROM FlightSeats WHERE seat_price > 10000;	

-- BETWEEN Operator
SELECT * FROM FlightSeats WHERE seat_price BETWEEN 5000 AND 15000;	

-- IN Operator
SELECT * FROM FlightSeats WHERE seat_class IN ('Business','First');	

-- LIKE Operator	
SELECT * FROM FlightSeats WHERE seat_number LIKE '1%';	

-- IS NULL Operator
SELECT * FROM FlightSeats WHERE booked_by_customer IS NOT NULL;	

-- AND Operator
SELECT * FROM FlightSeats WHERE seat_class='Economy' AND status='Available';	

-- Clauses 

-- WHEREClause
SELECT * FROM FlightSeats WHERE status='Booked';	

-- ORDER BY Clause	
SELECT * FROM FlightSeats ORDER BY seat_price DESC;	

-- GROUP BY	Clause
SELECT seat_class, COUNT(seat_id) FROM FlightSeats GROUP BY seat_class;	

-- HAVING Clause	
SELECT seat_class, COUNT(*) FROM FlightSeats GROUP BY seat_class HAVING COUNT(*) > 4;

-- LIMIT Clause	
SELECT * FROM FlightSeats LIMIT 5;	

-- DISTINCT Clause	
SELECT DISTINCT seat_class FROM FlightSeats;	

-- Alias

-- Column Alias	
SELECT seat_number AS Seat, seat_class AS Class, seat_price AS Price FROM FlightSeats;	

-- Table Alias
SELECT f.flight_number, s.seat_number, s.seat_price FROM Flights AS f JOIN FlightSeats AS s ON f.flight_id = s.flight_id;

-- ON DELETE CASCADE & ON UPDATE CASCADE
CREATE TABLE FlightSeats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    seat_number VARCHAR(6) NOT NULL,
    seat_class VARCHAR(20) CHECK (seat_class IN ('Economy','Premium Economy','Business','First')),
    is_window BOOLEAN DEFAULT FALSE,
    is_aisle BOOLEAN DEFAULT FALSE,
    seat_price DECIMAL(10,2) CHECK (seat_price >= 0),
    status VARCHAR(20) DEFAULT 'Available',
    booked_by_customer INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (booked_by_customer) REFERENCES Customers(customer_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    UNIQUE(flight_id, seat_number)
);

-- JOINS
-- INNER JOIN 
SELECT fs.seat_id, fs.seat_number, fs.seat_class, fs.status,c.customer_name, f.flight_name
FROM FlightSeats fs
INNER JOIN Customers c ON fs.booked_by_customer = c.customer_id
INNER JOIN Flights f ON fs.flight_id = f.flight_id
WHERE fs.status = 'Booked';

-- LEFT JOIN
SELECT fs.seat_number, fs.status, c.customer_name FROM FlightSeats fs
LEFT JOIN Customers c ON fs.booked_by_customer = c.customer_id;

-- RIGHT JOIN
SELECT c.customer_name, fs.seat_number, fs.seat_class FROM FlightSeats fs
RIGHT JOIN Customers c ON fs.booked_by_customer = c.customer_id;

-- FULL OUTER JOIN 
SELECT fs.seat_number, c.customer_name FROM FlightSeats fs
LEFT JOIN Customers c ON fs.booked_by_customer = c.customer_id
UNION
SELECT fs.seat_number, c.customer_name FROM FlightSeats fs
RIGHT JOIN Customers c ON fs.booked_by_customer = c.customer_id;

-- SELF JOIN
SELECT f1.flight_id, f1.seat_number AS seat1, f2.seat_number AS seat2 FROM FlightSeats f1
JOIN FlightSeats f2 
  ON f1.flight_id = f2.flight_id AND f1.seat_id < f2.seat_id;

-- CROSS JOIN
SELECT fs.seat_number, c.customer_name FROM FlightSeats fs
CROSS JOIN Customers c;

-- SUBQUERIES
-- Scalar Subquery
SELECT fs.flight_id, fs.seat_number,
       (SELECT COUNT(*) FROM FlightSeats WHERE flight_id = fs.flight_id) AS total_seats
FROM FlightSeats fs;

-- Correlated Subquery 
SELECT fs.* FROM FlightSeats fs
WHERE fs.seat_price > (
    SELECT AVG(fs2.seat_price)
    FROM FlightSeats fs2
    WHERE fs2.flight_id = fs.flight_id
);

-- IN Subquery
SELECT * FROM FlightSeats
WHERE flight_id IN (
    SELECT flight_id FROM Flights WHERE base_fare > 10000
);

-- EXISTS Subquery 
SELECT f.flight_id, f.flight_name FROM Flights f
WHERE EXISTS (
    SELECT 1 FROM FlightSeats fs
    WHERE fs.flight_id = f.flight_id AND fs.seat_class = 'Business'
);

-- ANY Subquery
SELECT * FROM FlightSeats
WHERE seat_price > ANY (
    SELECT seat_price FROM FlightSeats WHERE seat_class = 'Economy'
);

-- Subquery in FROM Clause
SELECT seat_class, avg_price
FROM (
    SELECT seat_class, AVG(seat_price) AS avg_price
    FROM FlightSeats
    GROUP BY seat_class
) AS price_data
WHERE avg_price > 8000;

-- STRING FUNCTIONS
SELECT seat_number,
       UPPER(seat_class) AS upper_class,
       LOWER(seat_class) AS lower_class,
       CONCAT('Seat ', seat_number, ' - ', seat_class) AS seat_info,
       SUBSTRING(seat_number,1,2) AS seat_prefix
FROM FlightSeats;

-- NUMERIC FUNCTIONS
SELECT seat_number, seat_price,
       ROUND(seat_price,0) AS rounded_price,
       FLOOR(seat_price) AS floor_price,
       CEIL(seat_price) AS ceil_price
FROM FlightSeats;

-- DATE/TIME FUNCTIONS
SELECT seat_number, created_at,
       NOW() AS current_time,
       CURDATE() AS today,
       DATEDIFF(NOW(), created_at) AS days_since_created,
       YEAR(created_at) AS created_year,
       MONTH(created_at) AS created_month
FROM FlightSeats;

-- AGGREGATE FUNCTIONS
SELECT COUNT(seat_id) AS total_seats,
       SUM(seat_price) AS total_revenue_potential,
       AVG(seat_price) AS avg_price,
       MIN(seat_price) AS min_price,
       MAX(seat_price) AS max_price
FROM FlightSeats;

-- USER-DEFINED FUNCTION (UDF)
DELIMITER //

CREATE FUNCTION SeatCategory(price DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF price >= 15000 THEN
        SET category = 'Luxury';
    ELSEIF price >= 8000 THEN
        SET category = 'Premium';
    ELSE
        SET category = 'Budget';
    END IF;
    RETURN category;
END//

DELIMITER ;


-- Usage:
SELECT seat_number, seat_price, SeatCategory(seat_price) AS category
FROM FlightSeats;

-- SIMPLE VIEWS
CREATE VIEW v_flight_seats_basic AS
SELECT seat_id, flight_id, seat_number, seat_class, seat_price, status
FROM FlightSeats;

-- COMPLEX VIEWS
-- Seats with Flight Number and Customer
CREATE VIEW v_seats_flight_customer AS
SELECT fs.seat_id, f.flight_number, fs.seat_number, fs.seat_class, fs.status,
       c.first_name, c.last_name
FROM FlightSeats fs
JOIN Flights f ON fs.flight_id = f.flight_id
LEFT JOIN Customers c ON fs.booked_by_customer = c.customer_id;

-- STORED PROCEDURES
-- Get All Seats of a Flight
DELIMITER //
CREATE PROCEDURE get_flight_seats(IN f_id INT)
BEGIN
    SELECT seat_id, seat_number, seat_class, seat_price, status
    FROM FlightSeats
    WHERE flight_id = f_id;
END //
DELIMITER ;

-- Usage:
CALL get_flight_seats(1);

-- WINDOW FUNCTIONS
-- Running Total of Seat Prices per Flight
SELECT seat_id, flight_id, seat_number, seat_price,
       SUM(seat_price) OVER(PARTITION BY flight_id ORDER BY seat_id) AS running_total
FROM FlightSeats;

-- Rank Seats by Price in Each Flight
SELECT seat_id, flight_id, seat_number, seat_class, seat_price,
       RANK() OVER(PARTITION BY flight_id ORDER BY seat_price DESC) AS rank_price
FROM FlightSeats;

-- DCL 
-- Create user
CREATE USER 'flight_user'@'localhost' IDENTIFIED BY 'secure123';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE ON FlightSeats TO 'flight_user'@'localhost';

-- Revoke privilege
REVOKE DELETE ON FlightSeats FROM 'flight_user'@'localhost';

-- Apply privileges
FLUSH PRIVILEGES;

-- TCL 
-- Book a Seat Transaction
START TRANSACTION;

UPDATE FlightSeats
SET status = 'Booked', booked_by_customer = 11
WHERE seat_id = 1;

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE FlightSeats
SET status = 'Available', booked_by_customer = NULL
WHERE seat_id = 2;

ROLLBACK;

-- TRIGGERS
-- Prevent Negative Seat Price
DELIMITER //

CREATE TRIGGER trg_no_negative_seat_price
BEFORE INSERT ON FlightSeats
FOR EACH ROW
BEGIN
    IF NEW.seat_price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Seat price cannot be negative';
    END IF;
END //

DELIMITER ;


-- -------------------------------------------------
-- Table 15: Activities
-- -------------------------------------------------
CREATE TABLE Activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT NOT NULL,
    activity_name VARCHAR(150) NOT NULL,
    activity_type VARCHAR(50),
    duration_minutes INT CHECK (duration_minutes >= 0),
    price DECIMAL(10,2) CHECK (price >= 0),
    min_age INT DEFAULT 0,
    max_participants INT DEFAULT 20,
    operator_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

-- 20 activities tied to destinations 1..20
INSERT INTO Activities (destination_id, activity_name, activity_type, duration_minutes, price, min_age, max_participants, operator_name)
VALUES
(1,'Red Fort Guided Tour','Sightseeing',90,500,0,30,'Heritage Guides'),
(2,'Marine Drive Sunset Walk','Leisure',60,0,0,50,'City Walks Co.'),
(3,'Statue of Liberty Cruise','Sightseeing',120,2000,5,100,'Liberty Cruises'),
(4,'White House Exterior Tour','Sightseeing',60,0,0,30,'Capital Tours'),
(5,'Eiffel Tower Summit Access','Sightseeing',90,2500,5,200,'Paris Tours'),
(6,'Mt Fuji Hike','Adventure',360,0,12,20,'Nippon Adventures'),
(7,'Sydney Opera House Backstage','Cultural',60,1500,10,50,'Opera Experiences'),
(8,'Parliament Guided Walk','Cultural',75,0,8,25,'Canberra Guides'),
(9,'Christ the Redeemer Cable Car','Sightseeing',45,800,0,40,'Rio Cable Co.'),
(10,'Cathedral Guided Visit','Cultural',60,0,0,20,'Sacred Tours'),
(11,'CN Tower Edge Walk','Adventure',60,1200,12,10,'Edge Walk Co.'),
(12,'Rideau Canal Boat Ride','Leisure',45,0,0,30,'Canal Tours'),
(13,'Brandenburg Gate Night Walk','Sightseeing',60,0,0,40,'Berlin Nights'),
(14,'Table Mountain Cable Car','Adventure',30,600,0,60,'Table Tours'),
(15,'Union Buildings Guided Tour','Cultural',45,0,0,25,'Govt Tours'),
(16,'Colosseum Underground Tour','Historical',120,1500,6,30,'Roma Heritage'),
(17,'Great Wall Section Hike','Adventure',240,300,10,40,'Wall Treks'),
(18,'Big Ben Photo Walk','Sightseeing',45,0,0,50,'London Walks'),
(19,'Teotihuacan Pyramid Climb','Historical',90,500,8,30,'Aztec Guides'),
(20,'Kremlin Armoury Visit','Historical',90,1000,6,25,'Moscow Tours');

-- SELECT Queries 
-- View all Activities
SELECT * FROM Activities;

-- Activities costing more than 1000
SELECT activity_name, destination_id, price
FROM Activities
WHERE price > 1000;

-- Adventure activities only
SELECT activity_name, destination_id, duration_minutes
FROM Activities
WHERE activity_type = 'Adventure';

-- Count of activities per destination
SELECT destination_id, COUNT(*) AS total_activities
FROM Activities
GROUP BY destination_id;

-- Activities suitable for children under 10
SELECT activity_name, min_age, max_participants
FROM Activities
WHERE min_age <= 10;

-- TRUNCATE TABLE 
TRUNCATE TABLE Activities;

-- DROP TABLE 
DROP TABLE Activities;

-- Add a column for activity rating
ALTER TABLE Activities ADD rating DECIMAL(3,2) DEFAULT 0;

-- Modify price column precision
ALTER TABLE Activities MODIFY price DECIMAL(12,2) NOT NULL;

-- Drop a column
ALTER TABLE Activities DROP COLUMN rating;

-- Change activity price
UPDATE Activities
SET price = 600
WHERE activity_name = 'Mt Fuji Hike';

-- Activities for specific destination
SELECT * 
FROM Activities
WHERE destination_id = 5;

-- Sort by price ascending
SELECT * 
FROM Activities
ORDER BY price ASC;

-- Average price by activity type
SELECT activity_type, AVG(price) AS avg_price
FROM Activities
GROUP BY activity_type;

-- OPERATORS 

-- Comparison Operator
SELECT * FROM Activities WHERE price > 1000;	

-- BETWEEN Operator
SELECT * FROM Activities WHERE duration_minutes BETWEEN 30 AND 90;	

-- IN Operator	
SELECT * FROM Activities WHERE activity_type IN ('Adventure','Cultural');	

-- LIKE Operator	
SELECT * FROM Activities WHERE activity_name LIKE '%Tour%';	

-- IS NULL Operator
SELECT * FROM Activities WHERE operator_name IS NOT NULL;	

-- CLAUSES 

-- WHERE Clause	
SELECT * FROM Activities WHERE activity_type='Adventure';	

-- ORDER BY Clause	
SELECT * FROM Activities ORDER BY price DESC;	

-- GROUP BY Clause
SELECT activity_type, COUNT(*) FROM Activities GROUP BY activity_type;	

-- HAVING Clause
SELECT activity_type, COUNT(*) FROM Activities GROUP BY activity_type HAVING COUNT(*) > 3;	

-- LIMIT Clause	
SELECT * FROM Activities LIMIT 5;

-- DISTINCT Clause	
SELECT DISTINCT activity_type FROM Activities;

-- ALIASES 

-- Column Alias	
SELECT activity_name AS Name, price AS Cost, duration_minutes AS Duration FROM Activities;	

-- Table Alias	
SELECT a.activity_name, d.destination_name FROM Activities AS a JOIN Destinations AS d ON a.destination_id = d.destination_id;

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE Activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT NOT NULL,
    activity_name VARCHAR(150) NOT NULL,
    activity_type VARCHAR(50),
    duration_minutes INT CHECK (duration_minutes >= 0),
    price DECIMAL(10,2) CHECK (price >= 0),
    min_age INT DEFAULT 0,
    max_participants INT DEFAULT 20,
    operator_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT a.activity_name, d.name AS destination_name, a.price FROM Activities a
INNER JOIN Destinations d ON a.destination_id = d.destination_id;

-- LEFT JOIN
SELECT d.name AS destination_name, a.activity_name FROM Destinations d
LEFT JOIN Activities a ON d.destination_id = a.destination_id;

-- RIGHT JOIN
SELECT a.activity_name, d.name AS destination_name FROM Activities a
RIGHT JOIN Destinations d ON a.destination_id = d.destination_id;

-- FULL OUTER JOIN
SELECT d.name AS destination_name, a.activity_name FROM Destinations d
LEFT JOIN Activities a ON d.destination_id = a.destination_id
UNION
SELECT d.name AS destination_name, a.activity_name FROM Destinations d
RIGHT JOIN Activities a ON d.destination_id = a.destination_id;

-- SELF JOIN
SELECT a1.activity_name AS Activity1, a2.activity_name AS Activity2, a1.operator_name
FROM Activities a1
JOIN Activities a2 ON a1.operator_name = a2.operator_name
WHERE a1.activity_id <> a2.activity_id;

-- CROSS JOIN
SELECT a.activity_name, d.name AS destination_name FROM Activities a
CROSS JOIN Destinations d;

-- Scalar Subquery
SELECT activity_name, price,
       (SELECT AVG(price) FROM Activities) AS avg_activity_price
FROM Activities;

-- Correlated Subquery
SELECT activity_name, price
FROM Activities a
WHERE price > (
    SELECT AVG(price)
    FROM Activities b
    WHERE a.destination_id = b.destination_id
);

-- IN Subquery
SELECT activity_name, price
FROM Activities
WHERE destination_id IN (
    SELECT destination_id
    FROM Activities
    WHERE activity_type = 'Adventure'
);

-- EXISTS Subquery
SELECT d.name
FROM Destinations d
WHERE EXISTS (
    SELECT 1 FROM Activities a
    WHERE a.destination_id = d.destination_id AND a.price > 0
);

-- ANY Subquery
SELECT activity_name, price FROM Activities
WHERE price > ANY (
    SELECT price FROM Activities WHERE activity_type = 'Sightseeing'
);


-- ALL Subquery
SELECT activity_name, price
FROM Activities
WHERE price > ALL (
    SELECT price FROM Activities WHERE activity_type = 'Cultural'
);

-- Subquery in FROM clause
SELECT t.activity_type, t.avg_price
FROM (
    SELECT activity_type, AVG(price) AS avg_price
    FROM Activities
    GROUP BY activity_type
) AS t;

-- String Functions
SELECT 
    UPPER(activity_name) AS upper_name,
    LOWER(operator_name) AS lower_operator,
    CONCAT(activity_type, ' - ', operator_name) AS combined_info,
    SUBSTRING(activity_name, 1, 10) AS short_name
FROM Activities;

-- Numeric Functions
SELECT 
    activity_name,
    ROUND(price, 0) AS rounded_price,
    FLOOR(price) AS floor_price,
    CEIL(price) AS ceil_price
FROM Activities;

-- Date/Time Functions
SELECT 
    activity_name,
    created_at,
    NOW() AS current_time,
    CURDATE() AS today,
    DATEDIFF(NOW(), created_at) AS days_since_created,
    YEAR(created_at) AS created_year,
    MONTH(created_at) AS created_month
FROM Activities;

-- Aggregate Functions

SELECT 
    COUNT(*) AS total_activities,
    SUM(price) AS total_revenue,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM Activities;

-- User-Defined Function 
DELIMITER //
CREATE FUNCTION GetDiscountedPrice(original DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN original * 0.9;
END //
DELIMITER ;

-- Use the function:
SELECT activity_name, price, GetDiscountedPrice(price) AS discounted_price
FROM Activities;

-- SIMPLE VIEWS
CREATE VIEW v_activities_basic AS
SELECT activity_id, destination_id, activity_name, activity_type, price
FROM Activities;

-- COMPLEX VIEWS 
-- Join with Destinations
CREATE VIEW v_activity_with_destination AS
SELECT a.activity_id, a.activity_name, a.activity_type, a.price,d.destination_name, d.country, d.city
FROM Activities a
JOIN Destinations d ON a.destination_id = d.destination_id;

-- STORED PROCEDURES
-- Get All Activities for a Destination
DELIMITER //
CREATE PROCEDURE get_activities_by_destination(IN dest_id INT)
BEGIN
    SELECT * 
    FROM Activities
    WHERE destination_id = dest_id;
END //
DELIMITER ;
-- Usage:
CALL get_activities_by_destination(5);

-- WINDOW FUNCTIONS
-- Rank Activities by Price 
SELECT activity_id, activity_name, price,
       RANK() OVER (ORDER BY price DESC) AS price_rank
FROM Activities;

-- Running Total of Activity Prices by Destination
SELECT activity_id, destination_id, activity_name, price,
       SUM(price) OVER(PARTITION BY destination_id ORDER BY activity_id) AS running_total
FROM Activities;

-- DCL 
-- Create User & Grant Permissions
CREATE USER 'activity_user'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT, INSERT, UPDATE ON Activities TO 'activity_user'@'localhost';

FLUSH PRIVILEGES;

-- Revoke
REVOKE UPDATE ON Activities FROM 'activity_user'@'localhost';

-- TCL 
-- Insert an Activity With COMMIT
START TRANSACTION;

INSERT INTO Activities (destination_id, activity_name, activity_type, duration_minutes, price)
VALUES (5, 'Paris Walking Tour', 'Sightseeing', 120, 1200);

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE Activities
SET price = 9999
WHERE activity_id = 1;

ROLLBACK;

-- TRIGGERS
-- Prevent Negative Price
DELIMITER //
CREATE TRIGGER trg_no_negative_price
BEFORE INSERT ON Activities
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END //
DELIMITER ;

-- Auto-capitalize Activity Type
DELIMITER //
CREATE TRIGGER trg_uppercase_activity_type
BEFORE INSERT ON Activities
FOR EACH ROW
BEGIN
    IF NEW.activity_type IS NOT NULL THEN
        SET NEW.activity_type = UPPER(NEW.activity_type);
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 16: ActivityBookings
-- -------------------------------------------------
CREATE TABLE ActivityBookings (
    act_booking_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_id INT NOT NULL,
    customer_id INT NOT NULL,
    booking_date DATE NOT NULL,
    participants INT CHECK (participants > 0),
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    status VARCHAR(20) DEFAULT 'Confirmed',
    payment_id INT,
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (activity_id) REFERENCES Activities(activity_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO ActivityBookings (activity_id, customer_id, booking_date, participants, total_amount, status, payment_id, notes)
VALUES
(1,1,'2025-09-01',2,1000,'Confirmed',1,'Morning slot'),
(2,2,'2025-09-02',4,0,'Confirmed',2,'Evening walk'),
(3,3,'2025-09-03',3,6000,'Cancelled',3,'Bad weather'),
(4,4,'2025-09-04',2,0,'Confirmed',4,''),
(5,5,'2025-09-05',5,12500,'Confirmed',5,'Summit access'),
(6,6,'2025-09-06',2,0,'Confirmed',6,'Group hike'),
(7,7,'2025-09-07',3,4500,'Confirmed',7,'Backstage tour'),
(8,8,'2025-09-08',1,0,'Confirmed',8,''),
(9,9,'2025-09-09',4,3200,'Confirmed',9,'Family trip'),
(10,10,'2025-09-10',2,0,'Confirmed',10,''),
(11,11,'2025-09-11',2,2400,'Confirmed',11,'Edge Walk thrill'),
(12,12,'2025-09-12',3,0,'Confirmed',12,'Boat ride'),
(13,13,'2025-09-13',2,0,'Cancelled',13,'Raining'),
(14,14,'2025-09-14',5,3000,'Confirmed',14,'Cable car'),
(15,15,'2025-09-15',3,0,'Confirmed',15,'Guided tour'),
(16,16,'2025-09-16',4,6000,'Confirmed',16,'Underground'),
(17,17,'2025-09-17',6,1800,'Confirmed',17,'Hike'),
(18,18,'2025-09-18',2,0,'Confirmed',18,'Photo walk'),
(19,19,'2025-09-19',3,1500,'Confirmed',19,'Pyramid'),
(20,20,'2025-09-20',2,2000,'Confirmed',20,'Kremlin visit');

-- SELECT QUERY
-- Select all records
SELECT * FROM ActivityBookings;

-- Select only confirmed bookings
SELECT * FROM ActivityBookings WHERE status = 'Confirmed';

-- TRUNCATE TABLE
TRUNCATE TABLE ActivityBookings;

-- DROP TABLE
DROP TABLE ActivityBookings;

-- Add a column for booking rating
ALTER TABLE ActivityBookings ADD feedback_rating INT DEFAULT 0;

-- Modify total_amount to allow decimals with higher precision
ALTER TABLE ActivityBookings MODIFY total_amount DECIMAL(12,2);

-- Drop column
ALTER TABLE ActivityBookings DROP COLUMN feedback_rating;

-- Update total_amount for a specific booking
UPDATE ActivityBookings
SET total_amount = 3500
WHERE act_booking_id = 8;

-- Confirmed bookings only
SELECT * 
FROM ActivityBookings
WHERE status = 'Confirmed';

-- Sort by total_amount descending
SELECT * 
FROM ActivityBookings
ORDER BY total_amount DESC;

-- Total participants booked per activity
SELECT activity_id, SUM(participants) AS total_participants
FROM ActivityBookings
GROUP BY activity_id;

-- OPERATORS 

-- Comparison Operator	
SELECT * FROM ActivityBookings WHERE total_amount > 2000;

-- BETWEEN Operator	
SELECT * FROM ActivityBookings WHERE booking_date BETWEEN '2025-09-05' AND '2025-09-10';	

-- IN Operator	
SELECT * FROM ActivityBookings WHERE status IN ('Confirmed','Cancelled');	

-- LIKE Operator	
SELECT * FROM ActivityBookings WHERE notes LIKE '%tour%';	

-- IS NULL Operator	
SELECT * FROM ActivityBookings WHERE notes IS NOT NULL;	

-- AND Operator
SELECT * FROM ActivityBookings WHERE total_amount > 1000 AND participants >= 3;	

-- CLAUSES

-- WHERE Clause	
SELECT * FROM ActivityBookings WHERE status='Confirmed';	

-- ORDER BY Clause	
SELECT * FROM ActivityBookings ORDER BY total_amount DESC;	

-- GROUP BY Clause	
SELECT status, COUNT(*) FROM ActivityBookings GROUP BY status;	

-- HAVING Clause	
SELECT status, COUNT(*) FROM ActivityBookings GROUP BY status HAVING COUNT(*) > 5;	

-- LIMIT Clause	
SELECT * FROM ActivityBookings LIMIT 5;

-- DISTINCT Clause	
SELECT DISTINCT status FROM ActivityBookings;

-- ALIASES 

-- Column Alias	
SELECT act_booking_id AS BookingID, total_amount AS Amount, status AS Status FROM ActivityBookings;	

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE ActivityBookings (
    act_booking_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_id INT NOT NULL,
    customer_id INT NOT NULL,
    booking_date DATE NOT NULL,
    participants INT CHECK (participants > 0),
    total_amount DECIMAL(10 , 2 ) CHECK (total_amount >= 0),
    status VARCHAR(20) DEFAULT 'Confirmed',
    payment_id INT,
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (activity_id)
        REFERENCES Activities (activity_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (customer_id)
        REFERENCES Customers (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT ab.act_booking_id, a.activity_name, c.customer_name, ab.booking_date, ab.total_amount
FROM ActivityBookings ab
INNER JOIN Activities a ON ab.activity_id = a.activity_id
INNER JOIN Customers c ON ab.customer_id = c.customer_id;

-- LEFT JOIN
SELECT ab.act_booking_id, a.activity_name, ab.total_amount
FROM ActivityBookings ab
LEFT JOIN Activities a ON ab.activity_id = a.activity_id;

-- RIGHT JOIN
SELECT a.activity_name, ab.booking_date, ab.total_amount
FROM ActivityBookings ab
RIGHT JOIN Activities a ON ab.activity_id = a.activity_id;

-- FULL OUTER JOIN
SELECT a.activity_name, ab.booking_date, ab.total_amount FROM Activities a
LEFT JOIN ActivityBookings ab ON a.activity_id = ab.activity_id
UNION
SELECT a.activity_name, ab.booking_date, ab.total_amount FROM Activities a
RIGHT JOIN ActivityBookings ab ON a.activity_id = ab.activity_id;

-- SELF JOIN
SELECT a1.act_booking_id AS Booking1, a2.act_booking_id AS Booking2, a1.booking_date
FROM ActivityBookings a1
JOIN ActivityBookings a2 ON a1.booking_date = a2.booking_date
WHERE a1.act_booking_id <> a2.act_booking_id;

-- CROSS JOIN
SELECT ab.act_booking_id, a.activity_name
FROM ActivityBookings ab
CROSS JOIN Activities a;

-- Scalar Subquery
SELECT act_booking_id, total_amount,
       (SELECT SUM(total_amount) FROM ActivityBookings) AS total_revenue
FROM ActivityBookings;

-- Correlated Subquery
SELECT act_booking_id, activity_id, total_amount
FROM ActivityBookings ab
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM ActivityBookings ab2
    WHERE ab.activity_id = ab2.activity_id
);

-- IN Subquery
SELECT act_booking_id, total_amount
FROM ActivityBookings
WHERE activity_id IN (
    SELECT activity_id FROM Activities WHERE activity_type = 'Adventure'
);

-- EXISTS Subquery
SELECT c.customer_name
FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM ActivityBookings ab
    WHERE ab.customer_id = c.customer_id AND ab.total_amount > 0
);

-- ANY Subquery

SELECT act_booking_id, total_amount
FROM ActivityBookings
WHERE total_amount > ANY (
    SELECT total_amount
    FROM ActivityBookings ab
    JOIN Activities a ON ab.activity_id = a.activity_id
    WHERE a.activity_type = 'Sightseeing'
);


-- ALL Subquery
SELECT act_booking_id, total_amount
FROM ActivityBookings
WHERE total_amount > ALL (
    SELECT total_amount
    FROM ActivityBookings ab
    JOIN Activities a ON ab.activity_id = a.activity_id
    WHERE a.activity_type = 'Cultural'
);

-- Subquery in FROM Clause

SELECT t.status, t.avg_amount
FROM (
    SELECT status, AVG(total_amount) AS avg_amount
    FROM ActivityBookings
    GROUP BY status
) AS t;

-- String Functions

SELECT 
    UPPER(status) AS upper_status,
    LOWER(notes) AS lower_notes,
    CONCAT('Booking-', act_booking_id, ': ', status) AS booking_info,
    SUBSTRING(notes, 1, 10) AS short_note
FROM ActivityBookings;

-- Numeric Functions
SELECT 
    act_booking_id,
    ROUND(total_amount, 0) AS rounded_amount,
    FLOOR(total_amount) AS floor_amount,
    CEIL(total_amount) AS ceil_amount
FROM ActivityBookings;

-- Date/Time Functions
SELECT 
    act_booking_id,
    booking_date,
    NOW() AS current_time,
    CURDATE() AS today,
    DATEDIFF(CURDATE(), booking_date) AS days_since_booking,
    YEAR(booking_date) AS booking_year,
    MONTH(booking_date) AS booking_month
FROM ActivityBookings;

-- Aggregate Functions
SELECT 
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_booking_value,
    MIN(total_amount) AS min_amount,
    MAX(total_amount) AS max_amount
FROM ActivityBookings;

-- User-Defined Function
DELIMITER //
CREATE FUNCTION AddTax(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN amount * 1.18;
END //
DELIMITER ;

-- Use it:
SELECT act_booking_id, total_amount, AddTax(total_amount) AS total_with_tax
FROM ActivityBookings;

-- SIMPLE VIEWS
CREATE VIEW v_activity_bookings_basic AS
SELECT act_booking_id, activity_id, customer_id, booking_date, status
FROM ActivityBookings;

-- COMPLEX VIEWS 
-- Booking Details With Activity & Customer Names
CREATE VIEW v_booking_full_details AS
SELECT ab.act_booking_id, ab.booking_date, ab.participants, ab.total_amount, ab.status, a.activity_name, a.activity_type, c.customer_name, c.email
FROM ActivityBookings ab
JOIN Activities a ON ab.activity_id = a.activity_id
JOIN Customers c ON ab.customer_id = c.customer_id;

-- STORED PROCEDURES
-- Get All Bookings for a Customer
DELIMITER //
CREATE PROCEDURE get_bookings_by_customer(IN cust_id INT)
BEGIN
    SELECT *
    FROM ActivityBookings
    WHERE customer_id = cust_id;
END //
DELIMITER ;

-- WINDOW FUNCTIONS
-- Rank Bookings by Total Amount
SELECT act_booking_id, customer_id, total_amount,
       RANK() OVER (ORDER BY total_amount DESC) AS amount_rank
FROM ActivityBookings;

-- Running Total of Revenue by Date
SELECT booking_date, total_amount,
       SUM(total_amount) OVER (ORDER BY booking_date) AS running_total_revenue
FROM ActivityBookings;

-- DCL 
-- Create User & Give Permissions
CREATE USER 'booking_user'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT, INSERT, UPDATE ON ActivityBookings TO 'booking_user'@'localhost';

FLUSH PRIVILEGES;

-- Revoke Permission
REVOKE UPDATE ON ActivityBookings FROM 'booking_user'@'localhost';

-- TCL
-- Commit Transaction
START TRANSACTION;

UPDATE ActivityBookings
SET status = 'Cancelled'
WHERE act_booking_id = 3;

COMMIT;

-- Rollback Transaction
START TRANSACTION;

DELETE FROM ActivityBookings
WHERE act_booking_id = 2;

ROLLBACK;

-- TRIGGERS
-- Prevent Negative Total Amount
DELIMITER //
CREATE TRIGGER trg_no_negative_total
BEFORE INSERT ON ActivityBookings
FOR EACH ROW
BEGIN
    IF NEW.total_amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Total amount cannot be negative';
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 17: CarRentals
-- -------------------------------------------------
CREATE TABLE CarRentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    vehicle_type VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    pickup_city_id INT NOT NULL,
    dropoff_city_id INT NOT NULL,
    total_cost DECIMAL(10,2) CHECK (total_cost >= 0),
    status VARCHAR(20) DEFAULT 'Booked',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (pickup_city_id) REFERENCES Cities(city_id),
    FOREIGN KEY (dropoff_city_id) REFERENCES Cities(city_id)
);

INSERT INTO CarRentals (customer_id, vehicle_type, start_date, end_date, pickup_city_id, dropoff_city_id, total_cost, status)
VALUES
(1,'Sedan','2025-09-01','2025-09-03',1,1,5000,'Booked'),
(2,'SUV','2025-09-02','2025-09-05',2,2,12000,'Completed'),
(3,'Compact','2025-09-03','2025-09-04',3,3,3000,'Booked'),
(4,'Luxury','2025-09-04','2025-09-07',4,4,20000,'Cancelled'),
(5,'SUV','2025-09-05','2025-09-08',5,5,13000,'Booked'),
(6,'Van','2025-09-06','2025-09-10',6,6,15000,'Completed'),
(7,'Sedan','2025-09-07','2025-09-09',7,7,6000,'Booked'),
(8,'SUV','2025-09-08','2025-09-12',8,8,14000,'Completed'),
(9,'Luxury','2025-09-09','2025-09-11',9,9,18000,'Booked'),
(10,'Compact','2025-09-10','2025-09-11',10,10,2500,'Completed'),
(11,'SUV','2025-09-11','2025-09-15',11,11,12000,'Booked'),
(12,'Sedan','2025-09-12','2025-09-13',12,12,4000,'Booked'),
(13,'Luxury','2025-09-13','2025-09-16',13,13,22000,'Cancelled'),
(14,'Van','2025-09-14','2025-09-18',14,14,15500,'Booked'),
(15,'SUV','2025-09-15','2025-09-17',15,15,11000,'Completed'),
(16,'Compact','2025-09-16','2025-09-17',16,16,3500,'Booked'),
(17,'Luxury','2025-09-17','2025-09-20',17,17,24000,'Booked'),
(18,'SUV','2025-09-18','2025-09-21',18,18,12500,'Completed'),
(19,'Van','2025-09-19','2025-09-22',19,19,14500,'Booked'),
(20,'Sedan','2025-09-20','2025-09-23',20,20,5500,'Booked');

-- SELECT QUERY
-- Select all records
SELECT * FROM CarRentals;

-- Select only "Booked" rentals
SELECT * FROM CarRentals WHERE status = 'Booked';

-- Select completed rentals with cost > 10000
SELECT * FROM CarRentals WHERE status = 'Completed' AND total_cost > 10000;

-- TRUNCATE TABLE
TRUNCATE TABLE CarRentals;

-- DROP TABLE
DROP TABLE CarRentals;

-- Add a column for driver name
ALTER TABLE CarRentals ADD driver_name VARCHAR(100);

-- Modify total_cost to allow higher precision
ALTER TABLE CarRentals MODIFY total_cost DECIMAL(12,2);

-- Drop column
ALTER TABLE CarRentals DROP COLUMN driver_name;

-- Update rental status
UPDATE CarRentals
SET status = 'Completed'
WHERE rental_id = 1;

-- Rentals with total_cost > 10000
SELECT * 
FROM CarRentals
WHERE total_cost > 10000;

-- Total cost per vehicle type
SELECT vehicle_type, SUM(total_cost) AS total_revenue
FROM CarRentals
GROUP BY vehicle_type;

-- OPERATORS 

-- Comparison Operator	
SELECT * FROM CarRentals WHERE total_cost > 10000;	

-- BETWEEN Operator	
SELECT * FROM CarRentals WHERE total_cost BETWEEN 5000 AND 15000;

-- IN Operator	
SELECT * FROM CarRentals WHERE status IN ('Booked','Completed');	

-- LIKE Operator	
SELECT * FROM CarRentals WHERE vehicle_type LIKE '%SUV%';	

-- IS NULL Operator
SELECT * FROM CarRentals WHERE total_cost IS NOT NULL;

-- AND Operator	
SELECT * FROM CarRentals WHERE status='Booked' AND total_cost > 8000;	

-- CLAUSES 

-- WHERE Clause	
SELECT * FROM CarRentals WHERE status='Completed';	

-- ORDER BY	Clause
SELECT * FROM CarRentals ORDER BY total_cost DESC;	

-- GROUP BY	
SELECT vehicle_type, COUNT(*) FROM CarRentals GROUP BY vehicle_type;	

-- HAVING Clause	
SELECT status, COUNT(*) FROM CarRentals GROUP BY status HAVING COUNT(*) > 5;

-- LIMIT Clause	
SELECT * FROM CarRentals LIMIT 5;	

-- DISTINCT Clause	
SELECT DISTINCT status FROM CarRentals;

-- ALIASES 

-- Column Alias	
SELECT rental_id AS ID, total_cost AS Cost, status AS BookingStatus FROM CarRentals;	

-- Table Alias	
SELECT cr.rental_id, c.customer_name, ci.city_name AS PickupCity FROM CarRentals AS cr JOIN Customers AS c ON cr.customer_id = c.customer_id JOIN Cities AS ci ON cr.pickup_city_id = ci.city_id;

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE CarRentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    vehicle_type VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    pickup_city_id INT NOT NULL,
    dropoff_city_id INT NOT NULL,
    total_cost DECIMAL(10,2) CHECK (total_cost >= 0),
    status VARCHAR(20) DEFAULT 'Booked',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (pickup_city_id) REFERENCES Cities(city_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (dropoff_city_id) REFERENCES Cities(city_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT cr.rental_id, c.customer_name, cr.vehicle_type, cr.start_date, cr.total_cost
FROM CarRentals cr
INNER JOIN Customers c ON cr.customer_id = c.customer_id;

-- LEFT JOIN
SELECT cr.rental_id, cr.vehicle_type, ct.city_name AS pickup_city
FROM CarRentals cr
LEFT JOIN Cities ct ON cr.pickup_city_id = ct.city_id;

-- RIGHT JOIN
SELECT ct.city_name, cr.vehicle_type, cr.status
FROM CarRentals cr
RIGHT JOIN Cities ct ON cr.pickup_city_id = ct.city_id;

-- FULL OUTER JOIN 
SELECT ct.city_name, cr.vehicle_type, cr.status FROM CarRentals cr
LEFT JOIN Cities ct ON cr.pickup_city_id = ct.city_id
UNION
SELECT ct.city_name, cr.vehicle_type, cr.status FROM CarRentals cr
RIGHT JOIN Cities ct ON cr.pickup_city_id = ct.city_id;

-- SELF JOIN
SELECT a.rental_id AS rental1, b.rental_id AS rental2, a.customer_id FROM CarRentals a
JOIN CarRentals b ON a.customer_id = b.customer_id
WHERE a.rental_id <> b.rental_id;

-- CROSS JOIN
SELECT cr.rental_id, cr.vehicle_type, ct.city_name FROM CarRentals cr
CROSS JOIN Cities ct;

-- Scalar Subquery
SELECT rental_id, total_cost,
       (SELECT SUM(total_cost) FROM CarRentals) AS total_revenue
FROM CarRentals;

-- Correlated Subquery
SELECT rental_id, vehicle_type, total_cost
FROM CarRentals cr
WHERE total_cost > (
    SELECT AVG(total_cost)
    FROM CarRentals cr2
    WHERE cr.vehicle_type = cr2.vehicle_type
);

-- IN Subquery
SELECT rental_id, vehicle_type, total_cost FROM CarRentals
WHERE pickup_city_id IN (SELECT city_id FROM Cities WHERE city_id <= 5);

-- EXISTS Subquery
SELECT c.customer_name
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM CarRentals cr
    WHERE cr.customer_id = c.customer_id
      AND cr.status = 'Completed'
);

-- ANY Subquery
SELECT rental_id, total_cost
FROM CarRentals
WHERE total_cost > ANY (
    SELECT total_cost FROM CarRentals WHERE status = 'Completed'
);


-- ALL Subquery
SELECT rental_id, total_cost
FROM CarRentals
WHERE total_cost > ALL (
    SELECT total_cost FROM CarRentals WHERE status = 'Cancelled'
);

-- Subquery in FROM Clause
SELECT t.vehicle_type, t.avg_cost
FROM (
    SELECT vehicle_type, AVG(total_cost) AS avg_cost
    FROM CarRentals
    GROUP BY vehicle_type
) AS t;

-- String Functions
SELECT 
    rental_id,
    UPPER(vehicle_type) AS upper_vehicle,
    LOWER(status) AS lower_status,
    CONCAT('Rental-', rental_id, ': ', vehicle_type) AS rental_info,
    SUBSTRING(vehicle_type, 1, 3) AS short_type
FROM CarRentals;

-- Numeric Functions
SELECT 
    rental_id,
    total_cost,
    ROUND(total_cost, 0) AS rounded_cost,
    FLOOR(total_cost) AS floor_cost,
    CEIL(total_cost) AS ceil_cost
FROM CarRentals;

-- Date/Time Functions
SELECT 
    rental_id,
    start_date,
    end_date,
    NOW() AS current_time,
    CURDATE() AS today,
    DATEDIFF(end_date, start_date) AS rental_days,
    YEAR(start_date) AS rental_year,
    MONTH(start_date) AS rental_month
FROM CarRentals;

-- Aggregate Functions
SELECT 
    COUNT(*) AS total_rentals,
    SUM(total_cost) AS total_revenue,
    AVG(total_cost) AS avg_cost,
    MIN(total_cost) AS min_cost,
    MAX(total_cost) AS max_cost
FROM CarRentals;

-- User-Defined Function

Example: Function to calculate tax-inclusive total (GST 18%):

DELIMITER //
CREATE FUNCTION AddTax(cost DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cost * 1.18;
END //
DELIMITER ;

-- Use it
SELECT rental_id, total_cost, AddTax(total_cost) AS total_with_tax
FROM CarRentals;

-- SIMPLE VIEWS
CREATE VIEW v_basic_rentals AS
SELECT rental_id, customer_id, vehicle_type, start_date, end_date, status
FROM CarRentals;

-- COMPLEX VIEWS (JOINS + FILTERS + AGGREGATES)
-- Rental details with customer + city names
CREATE VIEW v_rental_full_details AS
SELECT 
    cr.rental_id,c.customer_name,cr.vehicle_type,cr.start_date,cr.end_date,pc.city_name AS pickup_city,dc.city_name AS dropoff_city,cr.total_cost,
    cr.status
FROM CarRentals cr
JOIN Customers c ON cr.customer_id = c.customer_id
JOIN Cities pc ON cr.pickup_city_id = pc.city_id
JOIN Cities dc ON cr.dropoff_city_id = dc.city_id;

-- STORED PROCEDURES
-- Get rentals by status
DELIMITER //
CREATE PROCEDURE getRentalsByStatus(IN rentalStatus VARCHAR(20))
BEGIN
    SELECT * FROM CarRentals
    WHERE status = rentalStatus;
END//
DELIMITER ;

-- Call it
CALL getRentalsByStatus('Booked');

-- WINDOW FUNCTIONS
-- Rank rentals by total cost
SELECT 
    rental_id,customer_id,vehicle_type,total_cost,
    RANK() OVER (ORDER BY total_cost DESC) AS cost_rank
FROM CarRentals;

-- DCL 
-- Create user
CREATE USER 'rentalUser'@'localhost' IDENTIFIED BY 'pass123';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE ON CarRentals TO 'rentalUser'@'localhost';

-- Revoke privilege
REVOKE UPDATE ON CarRentals FROM 'rentalUser'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- TRIGGERS
-- Prevent end_date < start_date
DELIMITER //
CREATE TRIGGER trg_validate_dates
BEFORE INSERT ON CarRentals
FOR EACH ROW
BEGIN
    IF NEW.end_date < NEW.start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'End date cannot be earlier than start date';
    END IF;
END//
DELIMITER ;


-- -------------------------------------------------
-- Table 18: RentalVehicles
-- -------------------------------------------------
CREATE TABLE RentalVehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    rental_id INT NOT NULL,
    license_plate VARCHAR(15) NOT NULL UNIQUE,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT CHECK (year >= 2000),
    mileage INT,
    fuel_type VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rental_id) REFERENCES CarRentals(rental_id)
);

INSERT INTO RentalVehicles (rental_id, license_plate, brand, model, year, mileage, fuel_type, status)
VALUES
(1,'DL01AB1234','Toyota','Corolla',2021,25000,'Petrol','Active'),
(2,'MH02XY5678','Hyundai','Creta',2022,18000,'Diesel','Active'),
(3,'NYC345','Honda','Civic',2020,30000,'Petrol','Inactive'),
(4,'DC7890','BMW','5 Series',2023,12000,'Petrol','Active'),
(5,'PARIS321','Renault','Duster',2021,22000,'Diesel','Active'),
(6,'TOKYO777','Nissan','Serena',2020,40000,'Hybrid','Active'),
(7,'SYD444','Mazda','6',2019,35000,'Petrol','Inactive'),
(8,'CAN333','Kia','Seltos',2022,15000,'Diesel','Active'),
(9,'RIO222','Chevrolet','Tahoe',2021,28000,'Petrol','Active'),
(10,'BRA111','Ford','Fiesta',2020,32000,'Petrol','Active'),
(11,'TOR123','Toyota','Camry',2022,10000,'Hybrid','Active'),
(12,'OTT234','Honda','City',2019,38000,'Petrol','Inactive'),
(13,'BER567','Mercedes','C-Class',2021,22000,'Diesel','Active'),
(14,'CPT890','VW','Touran',2019,36000,'Diesel','Active'),
(15,'ROM741','Fiat','Panda',2020,28000,'Petrol','Active'),
(16,'BJ852','BYD','Tang',2022,12000,'Electric','Active'),
(17,'LDN963','Jaguar','XE',2021,25000,'Petrol','Active'),
(18,'MEX159','Nissan','Altima',2019,40000,'Petrol','Inactive'),
(19,'MOS357','Lada','Vesta',2020,30000,'Petrol','Active'),
(20,'BKK468','Toyota','Fortuner',2021,21000,'Diesel','Active');

-- SELECT QUERY
-- Select all records
SELECT * FROM RentalVehicles;

-- Select only "Active" vehicles
SELECT * FROM RentalVehicles WHERE status = 'Active';

-- Select vehicles with mileage greater than 30,000
SELECT * FROM RentalVehicles WHERE mileage > 30000;

-- Example: Join with CarRentals to get rental + vehicle details
SELECT rv.vehicle_id, rv.license_plate, rv.brand, rv.model, cr.vehicle_type, cr.status AS rental_status
FROM RentalVehicles rv
JOIN CarRentals cr ON rv.rental_id = cr.rental_id;

-- TRUNCATE TABLE
TRUNCATE TABLE RentalVehicles;

-- DROP TABLE
DROP TABLE RentalVehicles;

-- Add a column for vehicle color
ALTER TABLE RentalVehicles ADD color VARCHAR(30);

-- Modify mileage to not allow negative values
ALTER TABLE RentalVehicles MODIFY mileage INT CHECK (mileage >= 0);

-- Drop column
ALTER TABLE RentalVehicles DROP COLUMN color;

-- Update vehicle status to inactive
UPDATE RentalVehicles
SET status = 'Inactive'
WHERE vehicle_id = 1;

-- Vehicles of brand Toyota
SELECT * 
FROM RentalVehicles
WHERE brand = 'Toyota';

-- Sort vehicles by year descending
SELECT * 
FROM RentalVehicles
ORDER BY year DESC;

-- Count of vehicles by status
SELECT status, COUNT(*) AS total_vehicles
FROM RentalVehicles
GROUP BY status;

-- OPERATORS 

-- Comparison Operator	
SELECT * FROM RentalVehicles WHERE year >= 2021;	

-- BETWEEN Operator	
SELECT * FROM RentalVehicles WHERE mileage BETWEEN 20000 AND 40000;

-- IN Operator	
SELECT * FROM RentalVehicles WHERE fuel_type IN ('Petrol','Diesel');	

-- LIKE Operator	
SELECT * FROM RentalVehicles WHERE brand LIKE 'T%';	

-- IS NULL Operator	
SELECT * FROM RentalVehicles WHERE model IS NOT NULL;	

-- AND Operator	
SELECT * FROM RentalVehicles WHERE fuel_type='Diesel' AND year>2020;	

-- CLAUSES 

-- WHERE Clause	
SELECT * FROM RentalVehicles WHERE fuel_type='Hybrid';	

-- ORDER Clause 	
SELECT * FROM RentalVehicles ORDER BY year DESC;	

-- GROUP Clause BY	
SELECT fuel_type, COUNT(*) FROM RentalVehicles GROUP BY fuel_type;	

-- HAVING Clause	
SELECT fuel_type, COUNT(*) FROM RentalVehicles GROUP BY fuel_type HAVING COUNT(*) > 3;	

-- LIMIT Clause	
SELECT * FROM RentalVehicles LIMIT 5;	

-- ALIASES

-- Column Alias	
SELECT vehicle_id AS ID, brand AS BrandName, model AS ModelName FROM RentalVehicles;	

-- Table Alias	 
SELECT rv.vehicle_id, rv.brand, cr.vehicle_type, cr.status FROM RentalVehicles AS rv JOIN CarRentals AS cr ON rv.rental_id = cr.rental_id;

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE RentalVehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    rental_id INT NOT NULL,
    license_plate VARCHAR(15) NOT NULL UNIQUE,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT CHECK (year >= 2000),
    mileage INT,
    fuel_type VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rental_id) REFERENCES CarRentals(rental_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT rv.vehicle_id, rv.brand, rv.model, cr.vehicle_type, cr.total_cost
FROM RentalVehicles rv
INNER JOIN CarRentals cr ON rv.rental_id = cr.rental_id;

-- LEFT JOIN
SELECT rv.license_plate, rv.brand, cr.status AS rental_status FROM RentalVehicles rv
LEFT JOIN CarRentals cr ON rv.rental_id = cr.rental_id;

-- RIGHT JOIN
SELECT cr.rental_id, cr.vehicle_type, rv.brand, rv.model FROM RentalVehicles rv
RIGHT JOIN CarRentals cr ON rv.rental_id = cr.rental_id;

-- FULL OUTER JOIN
SELECT rv.vehicle_id, rv.brand, cr.vehicle_type FROM RentalVehicles rv
LEFT JOIN CarRentals cr ON rv.rental_id = cr.rental_id
UNION
SELECT rv.vehicle_id, rv.brand, cr.vehicle_type FROM RentalVehicles rv
RIGHT JOIN CarRentals cr ON rv.rental_id = cr.rental_id;

-- SELF JOIN
SELECT a.brand AS Brand, a.model AS Model1, b.model AS Model2
FROM RentalVehicles a
JOIN RentalVehicles b ON a.brand = b.brand AND a.vehicle_id <> b.vehicle_id;

-- CROSS JOIN
SELECT rv.brand, cr.vehicle_type FROM RentalVehicles rv
CROSS JOIN CarRentals cr;

-- Scalar Subquery
SELECT brand, model,
       (SELECT total_cost FROM CarRentals WHERE rental_id = rv.rental_id) AS RentalCost
FROM RentalVehicles rv;

-- Correlated Subquery
SELECT brand, model, fuel_type, mileage
FROM RentalVehicles rv1
WHERE mileage > (
    SELECT AVG(mileage) FROM RentalVehicles rv2
    WHERE rv2.fuel_type = rv1.fuel_type
);

-- IN Subquery
SELECT brand, model FROM RentalVehicles
WHERE rental_id IN (SELECT rental_id FROM CarRentals WHERE status = 'Completed');

-- EXISTS Subquery
SELECT DISTINCT brand
FROM RentalVehicles rv
WHERE EXISTS (
    SELECT 1 FROM CarRentals cr
    WHERE cr.rental_id = rv.rental_id AND cr.status = 'Completed'
);

-- ALL Subquery
SELECT brand, model, mileage
FROM RentalVehicles
WHERE mileage > ANY (SELECT mileage FROM RentalVehicles WHERE brand = 'BMW');


-- ALL Subquery
SELECT brand, model, mileage
FROM RentalVehicles
WHERE mileage > ALL (SELECT mileage FROM RentalVehicles WHERE brand = 'BMW');

-- Subquery in FROM Clause
SELECT brand, avg_mileage
FROM (
    SELECT brand, AVG(mileage) AS avg_mileage
    FROM RentalVehicles
    GROUP BY brand
) AS temp
WHERE avg_mileage > 25000;

-- String Functions
-- Convert to uppercase
SELECT UPPER(brand) AS Brand_Upper FROM RentalVehicles;

-- Convert to lowercase
SELECT LOWER(model) AS Model_Lower FROM RentalVehicles;

-- Concatenate
SELECT CONCAT(brand, ' ', model) AS VehicleName FROM RentalVehicles;

-- Substring (first 3 chars of brand)
SELECT SUBSTRING(brand, 1, 3) AS ShortBrand FROM RentalVehicles;

-- Numeric Functions
SELECT brand, ROUND(mileage/1000,1) AS Mileage_in_Thousands,
       FLOOR(mileage/10000) AS TensOfThousands,
       CEIL(mileage/5000) AS CeilDivision
FROM RentalVehicles;

-- Date / Time Functions
SELECT NOW() AS CurrentDateTime,
       CURDATE() AS CurrentDate,
       DATEDIFF(CURDATE(), created_at) AS DaysSinceAdded,
       YEAR(created_at) AS YearAdded,
       MONTH(created_at) AS MonthAdded
FROM RentalVehicles;

-- Aggregate Functions
SELECT COUNT(*) AS TotalVehicles,
       SUM(mileage) AS TotalMileage,
       AVG(mileage) AS AvgMileage,
       MIN(year) AS OldestVehicle,
       MAX(year) AS NewestVehicle
FROM RentalVehicles;

-- User-Defined Function 

DELIMITER //

CREATE FUNCTION GetVehicleAge(vehicleYear INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN YEAR(CURDATE()) - vehicleYear;
END //

DELIMITER ;

-- Usage:
SELECT brand, model, GetVehicleAge(year) AS VehicleAge
FROM RentalVehicles;

-- SIMPLE VIEWS
-- Basic vehicle info
CREATE VIEW v_basic_vehicle_info AS
SELECT vehicle_id, license_plate, brand, model, year, status
FROM RentalVehicles;

-- COMPLEX VIEWS 
-- Vehicle with rental details
CREATE VIEW v_vehicle_rental_details AS
SELECT 
    rv.vehicle_id,rv.license_plate,rv.brand,rv.model,rv.year,rv.status AS vehicle_status,cr.start_date,cr.end_date,cr.vehicle_type,cr.total_cost,
    cr.status AS rental_status
FROM RentalVehicles rv
JOIN CarRentals cr ON rv.rental_id = cr.rental_id;

-- STORED PROCEDURE
-- Get vehicles based on fuel type
DELIMITER //
CREATE PROCEDURE getVehiclesByFuel(IN ftype VARCHAR(20))
BEGIN
    SELECT *
    FROM RentalVehicles
    WHERE fuel_type = ftype;
END//
DELIMITER ;

-- Call it:
CALL getVehiclesByFuel('Diesel');

-- WINDOW FUNCTIONS
-- Rank vehicles by mileage
SELECT 
    vehicle_id,brand,model,mileage,
    RANK() OVER (ORDER BY mileage DESC) AS mileage_rank
FROM RentalVehicles;

-- DCL 
-- Create user
CREATE USER 'vehicleUser'@'localhost' IDENTIFIED BY 'pass123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON RentalVehicles TO 'vehicleUser'@'localhost';

-- Revoke permission
REVOKE UPDATE ON RentalVehicles FROM 'vehicleUser'@'localhost';

-- Apply
FLUSH PRIVILEGES;

-- TCL
-- Update vehicle mileage with transaction
START TRANSACTION;

UPDATE RentalVehicles
SET mileage = mileage + 500
WHERE vehicle_id = 10;

 ROLLBACK;  

COMMIT;

-- TRIGGERS
-- Prevent year older than 2000
DELIMITER //
CREATE TRIGGER trg_check_year
BEFORE INSERT ON RentalVehicles
FOR EACH ROW
BEGIN
    IF NEW.year < 2000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Year must be 2000 or newer';
    END IF;
END//
DELIMITER ;


-- -------------------------------------------------
-- Table 19: TourGuides
-- -------------------------------------------------
CREATE TABLE TourGuides (
    guide_id INT PRIMARY KEY AUTO_INCREMENT,
    guide_name VARCHAR(100) NOT NULL,
    language VARCHAR(50),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    years_experience INT CHECK (years_experience >= 0),
    specialization VARCHAR(100),
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5),
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO TourGuides (guide_name, language, phone, email, years_experience, specialization, rating, status)
VALUES
('Amit Sharma','Hindi','911234567890','amit@tours.com',5,'Historical',4.6,'Active'),
('John Doe','English','120255501','john@tours.com',8,'City Tours',4.8,'Active'),
('Claire Dupont','French','331234567','claire@tours.com',6,'Romantic',4.7,'Active'),
('Yuki Tanaka','Japanese','811234567','yuki@tours.com',4,'Mountain',4.5,'Active'),
('Liam Brown','English','441234567','liam@tours.com',10,'Culture',4.9,'Active'),
('Carlos Silva','Portuguese','551234567','carlos@tours.com',7,'Carnival',4.6,'Active'),
('Anna Schmidt','German','491234567','anna@tours.com',5,'History',4.4,'Active'),
('Thabo Nkosi','Zulu','271234567','thabo@tours.com',6,'Adventure',4.3,'Active'),
('Maria Rossi','Italian','391234567','maria@tours.com',9,'Heritage',4.8,'Active'),
('Zhang Wei','Mandarin','861234567','zhang@tours.com',3,'Great Wall',4.2,'Active'),
('Oliver Smith','English','441111111','oliver@tours.com',7,'Museums',4.5,'Active'),
('Sophia Lee','English','121212121','sophia@tours.com',6,'Night Tours',4.4,'Active'),
('Rajesh Kumar','Hindi','919191919','rajesh@tours.com',8,'Temples',4.6,'Active'),
('Peter Ivanov','Russian','701234567','peter@tours.com',12,'Architecture',4.7,'Active'),
('Fatima Zahra','Arabic','201234567','fatima@tours.com',9,'Desert',4.8,'Active'),
('David Wilson','English','441234111','david@tours.com',10,'Royal Tours',4.9,'Active'),
('Akira Sato','Japanese','811111111','akira@tours.com',5,'Cultural',4.5,'Active'),
('Diego Martinez','Spanish','341234567','diego@tours.com',6,'Historical',4.6,'Active'),
('George Brown','English','441234222','george@tours.com',15,'City & History',5.0,'Active'),
('Ali Khan','Urdu','921234567','ali@tours.com',7,'Heritage',4.7,'Active');

-- SELECT QUERY
-- Select all records
SELECT * FROM TourGuides;

-- Select guides with more than 10 years of experience
SELECT * FROM TourGuides WHERE years_experience > 10;

-- Select top-rated guides 
SELECT * FROM TourGuides WHERE rating >= 4.8;

-- Select all English-speaking guides
SELECT * FROM TourGuides WHERE language = 'English';

-- TRUNCATE TABLE
TRUNCATE TABLE TourGuides;

-- DROP TABLE
DROP TABLE TourGuides;

-- Add a column for city
ALTER TABLE TourGuides ADD city VARCHAR(50);

-- Update default status
ALTER TABLE TourGuides ALTER COLUMN status SET DEFAULT 'Available';

-- Drop column
ALTER TABLE TourGuides DROP COLUMN city;

-- Change status of a guide
UPDATE TourGuides
SET status = 'Inactive'
WHERE guide_id = 7;

-- Guides who speak English
SELECT * 
FROM TourGuides
WHERE language = 'English';

-- Sort by rating descending
SELECT * 
FROM TourGuides
ORDER BY rating DESC;

-- Count of guides per language
SELECT language, COUNT(*) AS total_guides
FROM TourGuides
GROUP BY language;

-- Average rating of all guides
SELECT AVG(rating) AS avg_rating
FROM TourGuides;

-- OPERATORS 
-- Comparison Operator	
SELECT * FROM TourGuides WHERE language = 'English';	

-- BETWEEN Operator	
SELECT * FROM TourGuides WHERE rating BETWEEN 4.5 AND 4.8;	

-- IN Operator	
SELECT * FROM TourGuides WHERE language IN ('English','Hindi','French');	

-- LIKE	Operator
SELECT * FROM TourGuides WHERE guide_name LIKE 'A%';	

-- IS NULL Operator	
SELECT * FROM TourGuides WHERE specialization IS NOT NULL;	

-- AND Operator	
SELECT * FROM TourGuides WHERE language='English' AND years_experience>5;

-- CLAUSES

-- WHERE Clause	
SELECT * FROM TourGuides WHERE rating > 4.5;	

-- ORDER BY	Clause
SELECT * FROM TourGuides ORDER BY years_experience DESC;	

-- GROUP BY Clause	
SELECT language, COUNT(*) FROM TourGuides GROUP BY language;	

-- HAVING Clause	
SELECT language, AVG(rating) AS avg_rating FROM TourGuides GROUP BY language HAVING avg_rating > 4.6;

-- LIMIT Clause	
SELECT * FROM TourGuides LIMIT 5;	

-- DISTINCT Clause	
SELECT DISTINCT language FROM TourGuides;

-- ALIASES 

-- Column Alias	
SELECT guide_name AS Name, language AS LanguageSpoken, rating AS GuideRating FROM TourGuides;	

-- Table Alias	
SELECT tg.guide_name, tg.language, tg.rating FROM TourGuides AS tg WHERE tg.rating >= 4.8;

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE GuideAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    guide_id INT,
    activity_id INT,
    assigned_date DATE,
    FOREIGN KEY (guide_id) REFERENCES TourGuides(guide_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT tg.guide_name, tg.language, t.tour_name, t.location FROM TourGuides tg
INNER JOIN Tours t ON tg.guide_id = t.guide_id;

-- LEFT JOIN
SELECT tg.guide_name, t.tour_name FROM TourGuides tg
LEFT JOIN Tours t ON tg.guide_id = t.guide_id;

-- RIGHT JOIN
SELECT t.tour_name, tg.guide_name FROM TourGuides tg
RIGHT JOIN Tours t ON tg.guide_id = t.guide_id;

-- FULL OUTER JOIN 
SELECT tg.guide_name, t.tour_name FROM TourGuides tg
LEFT JOIN Tours t ON tg.guide_id = t.guide_id
UNION
SELECT tg.guide_name, t.tour_name FROM TourGuides tg
RIGHT JOIN Tours t ON tg.guide_id = t.guide_id;

-- SELF JOIN
SELECT a.guide_name AS Guide1, b.guide_name AS Guide2, a.language FROM TourGuides a
JOIN TourGuides b ON a.language = b.language AND a.guide_id <> b.guide_id;

-- CROSS JOIN
SELECT a.guide_name AS Guide1, b.guide_name AS Guide2 FROM TourGuides a
CROSS JOIN TourGuides b;

-- Scalar Subquery
SELECT guide_name, rating,
       (SELECT AVG(rating) FROM TourGuides) AS avg_rating
FROM TourGuides;

-- Correlated Subquery
SELECT guide_name, language, rating
FROM TourGuides tg1
WHERE rating > (
    SELECT AVG(rating) FROM TourGuides tg2
    WHERE tg2.language = tg1.language
);

-- IN Subquery
SELECT guide_name, specialization FROM TourGuides
WHERE specialization IN (
    SELECT specialization FROM TourGuides WHERE rating > 4.8
);

-- EXISTS Subquery
SELECT DISTINCT language
FROM TourGuides t1
WHERE EXISTS (
    SELECT 1 FROM TourGuides t2
    WHERE t2.language = t1.language AND t2.rating > 4.8
);

-- ANY Subquery
SELECT guide_name, rating
FROM TourGuides
WHERE rating > ANY (SELECT rating FROM TourGuides WHERE language = 'Hindi');


-- ALL Subquery
SELECT guide_name, rating
FROM TourGuides
WHERE rating > ALL (SELECT rating FROM TourGuides WHERE language = 'Hindi');

-- Subquery in FROM Clause
SELECT specialization, avg_rating
FROM (
    SELECT specialization, AVG(rating) AS avg_rating
    FROM TourGuides
    GROUP BY specialization
) AS t
WHERE avg_rating > 4.5;

-- String Functions
SELECT UPPER(guide_name) AS UpperCaseName FROM TourGuides;

SELECT LOWER(language) AS LowerCaseLang FROM TourGuides;

SELECT CONCAT(guide_name, ' - ', specialization) AS GuideDetails FROM TourGuides;

SELECT SUBSTRING(language, 1, 3) AS ShortLang FROM TourGuides;

-- Numeric Functions
SELECT guide_name,
       ROUND(rating, 0) AS RoundedRating,
       FLOOR(rating) AS FloorRating,
       CEIL(rating) AS CeilRating
FROM TourGuides;

-- Date / Time Functions
SELECT guide_name,
       NOW() AS CurrentDateTime,
       CURDATE() AS CurrentDate,
       DATEDIFF(CURDATE(), created_at) AS DaysSinceAdded,
       YEAR(created_at) AS YearAdded,
       MONTH(created_at) AS MonthAdded
FROM TourGuides;

-- Aggregate Functions
SELECT COUNT(*) AS TotalGuides,
       AVG(rating) AS AvgRating,
       MIN(years_experience) AS LeastExperience,
       MAX(years_experience) AS MostExperience,
       SUM(years_experience) AS TotalExperience
FROM TourGuides;

-- User-Defined Function 

DELIMITER //

CREATE FUNCTION GetGuideLevel(exp INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE level_name VARCHAR(20);
    IF exp < 5 THEN
        SET level_name = 'Beginner';
    ELSEIF exp BETWEEN 5 AND 10 THEN
        SET level_name = 'Intermediate';
    ELSE
        SET level_name = 'Expert';
    END IF;
    RETURN level_name;
END //

DELIMITER ;

-- Usage:
SELECT guide_name, years_experience, GetGuideLevel(years_experience) AS GuideLevel
FROM TourGuides;

-- SIMPLE VIEWS
CREATE VIEW v_basic_guides AS
SELECT guide_id, guide_name, language, status
FROM TourGuides;

-- COMPLEX VIEWS 
-- Guides grouped by language (aggregate)
CREATE VIEW v_language_stats AS
SELECT language,
    COUNT(*) AS total_guides,
    AVG(rating) AS avg_rating
FROM TourGuides
GROUP BY language;

-- STORED PROCEDURES
-- Get guides by language
DELIMITER //
CREATE PROCEDURE getGuidesByLanguage(IN lang VARCHAR(50))
BEGIN
    SELECT * FROM TourGuides
    WHERE language = lang;
END//
DELIMITER ;

-- Call:
CALL getGuidesByLanguage('English');

-- WINDOW FUNCTIONS
-- Rank guides by experience
SELECT guide_id,guide_name,years_experience,
    RANK() OVER (ORDER BY years_experience DESC) AS exp_rank
FROM TourGuides;

-- DCL
-- Create user
CREATE USER 'guideUser'@'localhost' IDENTIFIED BY 'pass123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON TourGuides TO 'guideUser'@'localhost';

-- Revoke 
REVOKE INSERT ON TourGuides FROM 'guideUser'@'localhost';

-- Apply
FLUSH PRIVILEGES;

-- TCL
-- Update rating inside transaction
START TRANSACTION;

UPDATE TourGuides 
SET rating = 5.0
WHERE guide_id = 19;

ROLLBACK;  

COMMIT;

-- TRIGGERS
-- Ensure rating always between 0 and 5
DELIMITER //
CREATE TRIGGER trg_rating_check
BEFORE INSERT ON TourGuides
FOR EACH ROW
BEGIN
    IF NEW.rating < 0 OR NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 0 and 5';
    END IF;
END//
DELIMITER ;

-- Auto-inactive guides with rating < 3.0
DELIMITER //
CREATE TRIGGER trg_auto_inactive
BEFORE UPDATE ON TourGuides
FOR EACH ROW
BEGIN
    IF NEW.rating < 3.0 THEN
        SET NEW.status = 'Inactive';
    END IF;
END//
DELIMITER ;


-- -------------------------------------------------
-- Table 20: GuideAssignments
-- -------------------------------------------------
CREATE TABLE GuideAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    guide_id INT NOT NULL,
    booking_id INT NOT NULL,
    activity_id INT,
    start_time DATETIME,
    end_time DATETIME,
    role VARCHAR(50) DEFAULT 'Lead',
    status VARCHAR(20) DEFAULT 'Assigned',
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guide_id) REFERENCES TourGuides(guide_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (activity_id) REFERENCES Activities(activity_id)
);

INSERT INTO GuideAssignments (guide_id, booking_id, activity_id, start_time, end_time, role, status, notes)
VALUES
(1,1,1,'2025-09-01 09:00:00','2025-09-01 11:00:00','Lead','Assigned','Morning tour'),
(2,2,2,'2025-09-02 18:00:00','2025-09-02 19:00:00','Assistant','Assigned','Evening walk'),
(3,3,3,'2025-09-03 10:00:00','2025-09-03 12:00:00','Lead','Cancelled','Rain'),
(4,4,4,'2025-09-04 14:00:00','2025-09-04 15:00:00','Lead','Assigned',''),
(5,5,5,'2025-09-05 09:00:00','2025-09-05 11:00:00','Lead','Assigned','Romantic tour'),
(6,6,6,'2025-09-06 08:00:00','2025-09-06 14:00:00','Lead','Assigned','Fuji hike'),
(7,7,7,'2025-09-07 10:00:00','2025-09-07 11:00:00','Lead','Assigned','Opera tour'),
(8,8,8,'2025-09-08 13:00:00','2025-09-08 14:00:00','Assistant','Assigned','Parliament walk'),
(9,9,9,'2025-09-09 15:00:00','2025-09-09 16:00:00','Lead','Assigned','Cable car'),
(10,10,10,'2025-09-10 09:00:00','2025-09-10 10:00:00','Lead','Assigned','Cathedral'),
(11,11,11,'2025-09-11 12:00:00','2025-09-11 13:00:00','Lead','Assigned','Edge Walk'),
(12,12,12,'2025-09-12 14:00:00','2025-09-12 15:00:00','Assistant','Assigned','Boat ride'),
(13,13,13,'2025-09-13 18:00:00','2025-09-13 19:00:00','Lead','Cancelled','Bad weather'),
(14,14,14,'2025-09-14 09:00:00','2025-09-14 09:30:00','Lead','Assigned','Cable car'),
(15,15,15,'2025-09-15 10:00:00','2025-09-15 10:45:00','Lead','Assigned','Union Buildings'),
(16,16,16,'2025-09-16 11:00:00','2025-09-16 13:00:00','Lead','Assigned','Colosseum'),
(17,17,17,'2025-09-17 08:00:00','2025-09-17 12:00:00','Lead','Assigned','Great Wall'),
(18,18,18,'2025-09-18 09:30:00','2025-09-18 10:15:00','Assistant','Assigned','Big Ben'),
(19,19,19,'2025-09-19 07:45:00','2025-09-19 09:00:00','Lead','Assigned','Teotihuacan'),
(20,20,20,'2025-09-20 10:00:00','2025-09-20 11:30:00','Lead','Assigned','Kremlin Armoury');

-- SELECT QUERY
-- Select all records
SELECT * FROM GuideAssignments;

-- Select only "Assigned" roles
SELECT * FROM GuideAssignments WHERE status = 'Assigned';

-- Select cancelled assignments
SELECT * FROM GuideAssignments WHERE status = 'Cancelled';

-- TRUNCATE TABLE
TRUNCATE TABLE GuideAssignments;

-- DROP TABLE
DROP TABLE GuideAssignments;

-- Add a column for vehicle assigned
ALTER TABLE GuideAssignments ADD vehicle_assigned VARCHAR(50);

-- Change default role
ALTER TABLE GuideAssignments ALTER COLUMN role SET DEFAULT 'Assistant';

-- Change status to Completed
UPDATE GuideAssignments
SET status = 'Completed'
WHERE assignment_id = 6;

-- All assignments for a specific guide
SELECT * FROM GuideAssignments
WHERE guide_id = 1;

-- All assignments with status 'Assigned'
SELECT * FROM GuideAssignments
WHERE status = 'Assigned';

-- Upcoming assignments sorted by start_time
SELECT * FROM GuideAssignments
ORDER BY start_time ASC;

-- Count assignments per guide
SELECT guide_id, COUNT(*) AS total_assignments
FROM GuideAssignments
GROUP BY guide_id;

-- OPERATORS

-- Comparison operator
SELECT * FROM GuideAssignments WHERE start_time >= '2025-09-10';	

-- BETWEEN operator	
SELECT * FROM GuideAssignments WHERE start_time BETWEEN '2025-09-05' AND '2025-09-10';	

-- IN operator	
SELECT * FROM GuideAssignments WHERE role IN ('Lead','Assistant');	

-- LIKE	operator
SELECT * FROM GuideAssignments WHERE notes LIKE '%tour%';	

-- IS NULL operator	
SELECT * FROM GuideAssignments WHERE notes IS NOT NULL;	

-- AND operator	
SELECT * FROM GuideAssignments WHERE role='Lead' AND status='Assigned';	

-- CLAUSES

-- WHERE Clause	
SELECT * FROM GuideAssignments WHERE status='Assigned';	

-- ORDER BY Clause	
SELECT * FROM GuideAssignments ORDER BY start_time ASC;	

-- GROUP BY	
SELECT role, COUNT(*) FROM GuideAssignments GROUP BY role;	

-- HAVING Clause	
SELECT status, COUNT(*) FROM GuideAssignments GROUP BY status HAVING COUNT(*) > 5;	

-- LIMIT Clause	
SELECT * FROM GuideAssignments LIMIT 5;	

-- ALIASES 

-- Column Alias	
SELECT assignment_id AS ID, role AS GuideRole, status AS AssignmentStatus FROM GuideAssignments;	

-- Table Alias	
SELECT ga.assignment_id, tg.guide_name, ga.role, ga.status FROM GuideAssignments AS ga JOIN TourGuides AS tg ON ga.guide_id = tg.guide_id;

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE GuideAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    guide_id INT NOT NULL,
    booking_id INT NOT NULL,
    activity_id INT,
    start_time DATETIME,
    end_time DATETIME,
    role VARCHAR(50) DEFAULT 'Lead',
    status VARCHAR(20) DEFAULT 'Assigned',
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guide_id) REFERENCES TourGuides(guide_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (activity_id) REFERENCES Activities(activity_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT ga.assignment_id, tg.guide_name, a.activity_name, ga.role, ga.status FROM GuideAssignments ga
INNER JOIN TourGuides tg ON ga.guide_id = tg.guide_id
INNER JOIN Activities a ON ga.activity_id = a.activity_id;

-- LEFT JOIN
SELECT tg.guide_name, ga.assignment_id, ga.status FROM TourGuides tg
LEFT JOIN GuideAssignments ga ON tg.guide_id = ga.guide_id;

-- RIGHT JOIN
SELECT tg.guide_name, ga.assignment_id, ga.status FROM TourGuides tg
RIGHT JOIN GuideAssignments ga ON tg.guide_id = ga.guide_id;

-- FULL OUTER JOIN 
SELECT tg.guide_name, ga.assignment_id, ga.status FROM TourGuides tg
LEFT JOIN GuideAssignments ga ON tg.guide_id = ga.guide_id
UNION
SELECT tg.guide_name, ga.assignment_id, ga.status FROM TourGuides tg
RIGHT JOIN GuideAssignments ga ON tg.guide_id = ga.guide_id;

-- SELF JOIN
SELECT a1.assignment_id AS Assign1, a2.assignment_id AS Assign2, a1.role
FROM GuideAssignments a1
JOIN GuideAssignments a2 
ON a1.role = a2.role AND a1.assignment_id <> a2.assignment_id;

-- CROSS JOIN
SELECT tg.guide_name, ga.assignment_id FROM TourGuides tg
CROSS JOIN GuideAssignments ga;

-- Scalar Subquery
SELECT assignment_id,
       TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration,
       (SELECT AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) FROM GuideAssignments) AS avg_duration
FROM GuideAssignments;

-- Correlated Subquery
SELECT ga.assignment_id, ga.guide_id, TIMESTAMPDIFF(MINUTE, ga.start_time, ga.end_time) AS duration
FROM GuideAssignments ga
WHERE TIMESTAMPDIFF(MINUTE, ga.start_time, ga.end_time) >
      (SELECT AVG(TIMESTAMPDIFF(MINUTE, g2.start_time, g2.end_time))
       FROM GuideAssignments g2
       WHERE g2.guide_id = ga.guide_id);

-- IN Subquery
SELECT guide_id, role, status
FROM GuideAssignments
WHERE activity_id IN (
    SELECT activity_id FROM Activities WHERE activity_type = 'Adventure'
);

-- EXISTS Subquery
SELECT guide_name
FROM TourGuides tg
WHERE EXISTS (
    SELECT 1 FROM GuideAssignments ga
    WHERE ga.guide_id = tg.guide_id AND ga.status = 'Cancelled'
);

-- ANY Subquery
SELECT guide_id, assignment_id
FROM GuideAssignments
WHERE TIMESTAMPDIFF(MINUTE, start_time, end_time) > ANY (
    SELECT TIMESTAMPDIFF(MINUTE, start_time, end_time)
    FROM GuideAssignments WHERE guide_id = 1
);


-- ALL Subquery
SELECT guide_id, assignment_id
FROM GuideAssignments
WHERE TIMESTAMPDIFF(MINUTE, start_time, end_time) > ALL (
    SELECT TIMESTAMPDIFF(MINUTE, start_time, end_time)
    FROM GuideAssignments WHERE guide_id = 1
);

-- Subquery in FROM Clause
SELECT role, AVG(duration) AS avg_duration
FROM (
    SELECT role, TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration
    FROM GuideAssignments
) AS temp
GROUP BY role;

-- String Functions
SELECT UPPER(role) AS RoleUpper FROM GuideAssignments;

SELECT LOWER(status) AS StatusLower FROM GuideAssignments;

SELECT CONCAT('Guide-', guide_id, ' (', role, ')') AS GuideRole FROM GuideAssignments;

SELECT SUBSTRING(notes, 1, 10) AS ShortNote FROM GuideAssignments;

-- Numeric Functions
SELECT assignment_id,
       ROUND(TIMESTAMPDIFF(MINUTE, start_time, end_time)/60, 1) AS Hours,
       FLOOR(TIMESTAMPDIFF(MINUTE, start_time, end_time)/60) AS FloorHours,
       CEIL(TIMESTAMPDIFF(MINUTE, start_time, end_time)/60) AS CeilHours
FROM GuideAssignments;

-- Date / Time Functions
SELECT assignment_id,
       NOW() AS CurrentDateTime,
       CURDATE() AS CurrentDate,
       DATEDIFF(CURDATE(), DATE(start_time)) AS DaysAgo,
       YEAR(start_time) AS YearAssigned,
       MONTH(start_time) AS MonthAssigned
FROM GuideAssignments;

-- Aggregate Functions
SELECT COUNT(*) AS TotalAssignments,
       AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS AvgDuration,
       MIN(start_time) AS EarliestStart,
       MAX(end_time) AS LatestEnd
FROM GuideAssignments;

-- User-Defined Function 

DELIMITER //

CREATE FUNCTION GetAssignmentLength(start_dt DATETIME, end_dt DATETIME)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE dur INT;
    DECLARE length_cat VARCHAR(20);
    SET dur = TIMESTAMPDIFF(MINUTE, start_dt, end_dt);
    
    IF dur < 60 THEN
        SET length_cat = 'Short';
    ELSEIF dur BETWEEN 60 AND 120 THEN
        SET length_cat = 'Medium';
    ELSE
        SET length_cat = 'Long';
    END IF;
    
    RETURN length_cat;
END //

DELIMITER ;

-- Usage
SELECT assignment_id,
       GetAssignmentLength(start_time, end_time) AS AssignmentLength
FROM GuideAssignments;

-- SIMPLE VIEWS
-- Basic Guide Assignment Info
CREATE VIEW v_basic_guide_assignments AS
SELECT assignment_id,guide_id,booking_id,activity_id,start_time,end_time,
    status
FROM GuideAssignments;

-- COMPLEX VIEWS 
-- Details of Assignments
CREATE VIEW v_assignment_details AS
SELECT ga.assignment_id,tg.guide_name,b.customer_id,a.activity_name,ga.start_time,ga.end_time,ga.role,ga.status
FROM GuideAssignments ga
JOIN TourGuides tg ON ga.guide_id = tg.guide_id
JOIN Bookings b ON ga.booking_id = b.booking_id
JOIN Activities a ON ga.activity_id = a.activity_id;

-- STORED PROCEDURE
-- Assign a New Guide to Booking
DELIMITER //
CREATE PROCEDURE sp_assign_guide (
    IN p_guide_id INT,
    IN p_booking_id INT,
    IN p_activity_id INT,
    IN p_start DATETIME,
    IN p_end DATETIME,
    IN p_role VARCHAR(50)
)
BEGIN
    INSERT INTO GuideAssignments 
    (guide_id, booking_id, activity_id, start_time, end_time, role, status)
    VALUES (p_guide_id, p_booking_id, p_activity_id, p_start, p_end, p_role, 'Assigned');
END //

DELIMITER ;

-- Call:
CALL sp_assign_guide(5, 8, 3, '2025-10-01 09:00:00', '2025-10-01 11:00:00', 'Lead');

-- WINDOW FUNCTIONS
-- Rank Guides by Total Assigned Hours
SELECT guide_id,
SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS total_hours,
RANK() OVER (ORDER BY SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) DESC) AS guide_rank
FROM GuideAssignments
WHERE status = 'Assigned'
GROUP BY guide_id;

-- DCL
-- Create User
CREATE USER 'tour_manager'@'%' IDENTIFIED BY 'StrongPass123';

-- Grant Permissions
GRANT SELECT, INSERT, UPDATE ON GuideAssignments TO 'tour_manager'@'%';

-- Revoke Permissions
REVOKE UPDATE ON GuideAssignments FROM 'tour_manager'@'%';

-- TCL 
-- COMMIT / ROLLBACK 
START TRANSACTION;

UPDATE GuideAssignments
SET status = 'Cancelled'
WHERE assignment_id = 5;

 ROLLBACK;

COMMIT;

-- TRIGGERS
-- Prevent Overlapping Assignments for Same Guide
DELIMITER //
CREATE TRIGGER trg_no_double_booking
BEFORE INSERT ON GuideAssignments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM GuideAssignments
        WHERE guide_id = NEW.guide_id
        AND status = 'Assigned'
        AND NEW.start_time < end_time
        AND NEW.end_time > start_time
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Guide already assigned during this time';
    END IF;
END //
DELIMITER ;



-- -------------------------------------------------
-- Table 21: Reviews
-- -------------------------------------------------
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    booking_id INT,
    destination_id INT,
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5),
    comments VARCHAR(255),
    review_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'Published',
    likes INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

INSERT INTO Reviews (customer_id, booking_id, destination_id, rating, comments, status, likes)
VALUES
(1,1,1,4.5,'Amazing experience!','Published',12),
(2,2,2,4.7,'Loved it!','Published',18),
(3,3,3,3.9,'Too crowded','Published',5),
(4,4,4,4.8,'Beautiful views','Published',20),
(5,5,5,4.2,'Nice experience','Published',10),
(6,6,6,4.6,'Well organized','Published',14),
(7,7,7,4.9,'Fantastic show','Published',22),
(8,8,8,4.4,'Good guide','Published',9),
(9,9,9,4.7,'Breathtaking','Published',16),
(10,10,10,4.3,'Worth visiting','Published',11),
(11,11,11,4.6,'Thrilling adventure','Published',19),
(12,12,12,4.1,'Good trip','Published',7),
(13,13,13,3.8,'Weather issue','Published',4),
(14,14,14,4.9,'Must visit','Published',25),
(15,15,15,4.5,'Nice atmosphere','Published',13),
(16,16,16,4.8,'Very informative','Published',17),
(17,17,17,4.2,'Good hike','Published',8),
(18,18,18,4.4,'Nice walk','Published',12),
(19,19,19,4.6,'Awesome pyramids','Published',21),
(20,20,20,4.7,'Historic place','Published',23);

-- SELECT QUERIES
-- Select all reviews
SELECT * FROM Reviews;

-- Select only reviews with rating >= 4.5
SELECT * FROM Reviews WHERE rating >= 4.5;

-- Select reviews with most likes 
SELECT * FROM Reviews ORDER BY likes DESC LIMIT 5;

-- Join with Customers to show reviewer names
SELECT r.review_id, c.customer_name, r.rating, r.comments, r.likes
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id;

-- TRUNCATE TABLE
TRUNCATE TABLE Reviews;

-- DROP TABLE
DROP TABLE Reviews;

-- Add a column for review title
ALTER TABLE Reviews ADD review_title VARCHAR(100);

-- Change default status
ALTER TABLE Reviews ALTER COLUMN status SET DEFAULT 'Pending';

-- Drop column
ALTER TABLE Reviews DROP COLUMN review_title;

-- Change status of a review
UPDATE Reviews
SET status = 'Hidden'
WHERE review_id = 3;

-- Reviews for a specific destination
SELECT * FROM Reviews
WHERE destination_id = 5;

-- Reviews with more than 20 likes
SELECT * FROM Reviews
WHERE likes > 20;

-- Reviews sorted by rating descending
SELECT * FROM Reviews
ORDER BY rating DESC;

-- Reviews sorted by likes descending
SELECT * FROM Reviews
ORDER BY likes DESC;

-- Average rating for all reviews
SELECT AVG(rating) AS avg_rating
FROM Reviews;

-- OPERATORS

-- Comparison Operator
SELECT * FROM Reviews WHERE rating >= 4.5;

-- BETWEEN Operator
SELECT * FROM Reviews WHERE rating BETWEEN 4.0 AND 4.8;

-- IN Operator
SELECT * FROM Reviews WHERE rating IN (4.3,4.5,4.7);

-- LIKE Operator
SELECT * FROM Reviews WHERE comments LIKE '%beautiful%';

-- AND Operator	
SELECT * FROM Reviews WHERE rating >= 4.5 AND likes > 15;	

-- NOT Operator	
SELECT * FROM Reviews WHERE NOT status='Published';

-- CLAUSES

-- WHERE Clause	
SELECT * FROM Reviews WHERE rating > 4.5;	

-- ORDER BY	
SELECT * FROM Reviews ORDER BY likes DESC;	

-- GROUP BY	
SELECT destination_id, AVG(rating) FROM Reviews GROUP BY destination_id;	

-- HAVING	
SELECT destination_id, AVG(rating) AS avg_rating FROM Reviews GROUP BY destination_id HAVING avg_rating > 4.5;	

-- LIMIT Clause	
SELECT * FROM Reviews ORDER BY rating DESC LIMIT 5;

-- ALIASES 

-- Column Alias	
SELECT review_id AS ID, rating AS Stars, likes AS TotalLikes FROM Reviews;	

-- Table Alias	
SELECT r.review_id, c.customer_name, r.rating, r.comments FROM Reviews AS r JOIN Customers AS c ON r.customer_id = c.customer_id;

-- ON DELETE CASCADE & ON UPDATE CASCADE

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    booking_id INT,
    destination_id INT,
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5),
    comments VARCHAR(255),
    review_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'Published',
    likes INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT r.review_id, c.customer_name, d.destination_name, r.rating, r.comments FROM Reviews r
INNER JOIN Customers c ON r.customer_id = c.customer_id
INNER JOIN Destinations d ON r.destination_id = d.destination_id;

-- LEFT JOIN
SELECT c.customer_name, r.review_id, r.rating FROM Customers c
LEFT JOIN Reviews r ON c.customer_id = r.customer_id;

-- RIGHT JOIN
SELECT c.customer_name, r.review_id, r.rating FROM Customers c
RIGHT JOIN Reviews r ON c.customer_id = r.customer_id;

-- FULL OUTER JOIN 
SELECT c.customer_name, r.review_id, r.rating FROM Customers c
LEFT JOIN Reviews r ON c.customer_id = r.customer_id
UNION
SELECT c.customer_name, r.review_id, r.rating FROM Customers c
RIGHT JOIN Reviews r ON c.customer_id = r.customer_id;

-- SELF JOIN
SELECT r1.review_id AS Review1, r2.review_id AS Review2, r1.rating
FROM Reviews r1
JOIN Reviews r2
ON r1.rating = r2.rating AND r1.review_id <> r2.review_id;

-- CROSS JOIN
SELECT c.customer_name, d.destination_name FROM Customers c
CROSS JOIN Destinations d;

-- Scalar Subquery
SELECT review_id, rating,
       (SELECT AVG(rating) FROM Reviews) AS avg_rating
FROM Reviews;

-- Correlated Subquery
SELECT r.review_id, r.customer_id, r.rating FROM Reviews r
WHERE r.rating >
      (SELECT AVG(r2.rating)
       FROM Reviews r2
       WHERE r2.customer_id = r.customer_id);

-- IN Subquery
SELECT review_id, rating, comments FROM Reviews
WHERE destination_id IN (
    SELECT destination_id FROM Destinations WHERE continent = 'Europe'
);

-- EXISTS Subquery
SELECT c.customer_name
FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Reviews r
    WHERE r.customer_id = c.customer_id AND r.rating = 5.0
);

-- ANY Subquery
SELECT review_id, destination_id, rating
FROM Reviews
WHERE rating > ANY (
    SELECT rating FROM Reviews WHERE destination_id = 1
);


-- ALL Subquery
SELECT review_id, destination_id, rating
FROM Reviews
WHERE rating > ALL (
    SELECT rating FROM Reviews WHERE destination_id = 1
);

-- Subquery in FROM Clause
SELECT destination_id, AVG(avg_rating) AS overall_avg
FROM (
    SELECT destination_id, AVG(rating) AS avg_rating
    FROM Reviews
    GROUP BY destination_id
) AS sub
GROUP BY destination_id;

-- STRING FUNCTIONS
SELECT UPPER(comments) AS UpperComments FROM Reviews;

SELECT LOWER(status) AS LowerStatus FROM Reviews;

SELECT CONCAT('Customer-', customer_id, ': ', rating) AS ReviewSummary FROM Reviews;

SELECT SUBSTRING(comments, 1, 10) AS ShortComment FROM Reviews;

-- NUMERIC FUNCTIONS
SELECT review_id,
       rating,
       ROUND(rating, 0) AS Rounded,
       FLOOR(rating) AS FloorValue,
       CEIL(rating) AS CeilValue
FROM Reviews;

-- DATE/TIME FUNCTIONS
SELECT review_id,
       review_date,
       NOW() AS CurrentTime,
       CURDATE() AS CurrentDate,
       DATEDIFF(CURDATE(), review_date) AS DaysSinceReview,
       YEAR(review_date) AS ReviewYear,
       MONTH(review_date) AS ReviewMonth
FROM Reviews;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(*) AS TotalReviews,
    AVG(rating) AS AvgRating,
    MIN(rating) AS MinRating,
    MAX(rating) AS MaxRating,
    SUM(likes) AS TotalLikes
FROM Reviews;

-- USER-DEFINED FUNCTION 
DELIMITER //

CREATE FUNCTION GetReviewCategory(r DECIMAL(2,1))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE cat VARCHAR(20);
    IF r >= 4.5 THEN
        SET cat = 'Excellent';
    ELSEIF r >= 4.0 THEN
        SET cat = 'Good';
    ELSEIF r >= 3.5 THEN
        SET cat = 'Average';
    ELSE
        SET cat = 'Poor';
    END IF;
    RETURN cat;
END //

DELIMITER ;

-- Usage
SELECT review_id, rating, GetReviewCategory(rating) AS ReviewCategory
FROM Reviews;

-- SIMPLE VIEWS
-- Basic Reviews View
CREATE VIEW v_basic_reviews AS
SELECT review_id,customer_id,destination_id,rating,status,likes
FROM Reviews;

-- COMPLEX VIEWS 
-- Detailed Reviews with Customer, Booking, Destination Info
CREATE VIEW v_review_details AS
SELECT r.review_id,c.customer_name,d.destination_name,r.rating,r.comments,r.likes,r.review_date
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id
LEFT JOIN Destinations d ON r.destination_id = d.destination_id;

-- STORED PROCEDURE
-- Add a Review
DELIMITER //
CREATE PROCEDURE sp_add_review (
    IN p_customer_id INT,
    IN p_booking_id INT,
    IN p_destination_id INT,
    IN p_rating DECIMAL(2,1),
    IN p_comments VARCHAR(255)
)
BEGIN
    INSERT INTO Reviews (customer_id, booking_id, destination_id, rating, comments)
    VALUES (p_customer_id, p_booking_id, p_destination_id, p_rating, p_comments);
END //
DELIMITER ;

-- Call Example
CALL sp_add_review(5, 5, 5, 4.8, 'Excellent place!');

-- WINDOW FUNCTIONS
-- Rank Destinations by Average Rating
SELECT destination_id,
AVG(rating) AS avg_rating,
RANK() OVER (ORDER BY AVG(rating) DESC) AS rating_rank
FROM Reviews
GROUP BY destination_id;

-- DCL
-- Create a User for Review Management
CREATE USER 'review_manager'@'%' IDENTIFIED BY 'Review@123';

-- Grant 
GRANT SELECT, INSERT, UPDATE ON Reviews TO 'review_manager'@'%';

-- Revoke 
REVOKE UPDATE ON Reviews FROM 'review_manager'@'%';

-- TCL 
-- Edit Review With Commit & Rollback
START TRANSACTION;

UPDATE Reviews
SET likes = likes + 1
WHERE review_id = 4;

ROLLBACK;

COMMIT;

-- TRIGGERS
DELIMITER //
CREATE TRIGGER trg_flag_low_rating
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
    IF NEW.rating < 3 THEN
        SET NEW.status = 'Flagged';
    END IF;
END //
DELIMITER ;

-- Prevent Rating Over 5 or Below 0
DELIMITER //

CREATE TRIGGER trg_check_rating
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
    IF NEW.rating > 5 OR NEW.rating < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 0 and 5';
    END IF;
END //

DELIMITER ;



-- -------------------------------------------------
-- Table 22: Payments
-- -------------------------------------------------
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) CHECK (amount >= 0),
    payment_date DATE NOT NULL,
    method VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Pending',
    transaction_ref VARCHAR(100) UNIQUE,
    currency VARCHAR(10) DEFAULT 'INR',
    remarks VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Payments (booking_id, amount, payment_date, method, status, transaction_ref, currency, remarks)
VALUES
(1,50000,'2025-09-01','Credit Card','Paid','TXN001','INR','Full payment'),
(2,30000,'2025-09-02','UPI','Paid','TXN002','INR',''),
(3,45000,'2025-09-03','Debit Card','Paid','TXN003','INR','Advance'),
(4,20000,'2025-09-04','Net Banking','Paid','TXN004','INR',''),
(5,35000,'2025-09-05','Credit Card','Paid','TXN005','INR',''),
(6,15000,'2025-09-06','Cash','Paid','TXN006','INR','On arrival'),
(7,60000,'2025-09-07','Credit Card','Paid','TXN007','INR',''),
(8,40000,'2025-09-08','UPI','Paid','TXN008','INR',''),
(9,25000,'2025-09-09','Debit Card','Paid','TXN009','INR','Advance'),
(10,20000,'2025-09-10','Credit Card','Paid','TXN010','INR',''),
(11,55000,'2025-09-11','UPI','Paid','TXN011','INR',''),
(12,30000,'2025-09-12','Cash','Paid','TXN012','INR','On arrival'),
(13,22000,'2025-09-13','Debit Card','Paid','TXN013','INR',''),
(14,27000,'2025-09-14','UPI','Paid','TXN014','INR',''),
(15,48000,'2025-09-15','Credit Card','Paid','TXN015','INR',''),
(16,33000,'2025-09-16','Net Banking','Paid','TXN016','INR',''),
(17,26000,'2025-09-17','Credit Card','Paid','TXN017','INR',''),
(18,19000,'2025-09-18','UPI','Paid','TXN018','INR',''),
(19,37000,'2025-09-19','Debit Card','Paid','TXN019','INR',''),
(20,41000,'2025-09-20','Credit Card','Paid','TXN020','INR','');

-- SELECT QUERIES
-- Select all payment records
SELECT * FROM Payments;

-- Select payments greater than 40,000
SELECT * FROM Payments WHERE amount > 40000;

-- Get latest 5 payments
SELECT * FROM Payments ORDER BY payment_date DESC LIMIT 5;

-- TRUNCATE TABLE
TRUNCATE TABLE Payments;

-- DROP TABLE
DROP TABLE Payments;

-- Add a column for payment_mode details
ALTER TABLE Payments ADD payment_mode_details VARCHAR(100);

-- Change default status
ALTER TABLE Payments ALTER COLUMN status SET DEFAULT 'Processing';

-- Drop a column
ALTER TABLE Payments DROP COLUMN payment_mode_details;

-- Update payment status
UPDATE Payments
SET status = 'Refunded'
WHERE payment_id = 6;

-- Payments made by Credit Card
SELECT * FROM Payments
WHERE method = 'Credit Card';

-- Sort by amount descending
SELECT * FROM Payments
ORDER BY amount DESC;

-- Average payment amount
SELECT AVG(amount) AS avg_payment
FROM Payments;

-- OPERATORS

-- Comparison Operator
SELECT * FROM Payments WHERE amount > 30000;

-- BETWEEN Operator
SELECT * FROM Payments WHERE amount BETWEEN 20000 AND 40000;

-- IN Operator
SELECT * FROM Payments WHERE method IN ('UPI','Cash','Credit Card');

-- LIKE
SELECT * FROM Payments WHERE remarks LIKE '%advance%';

-- AND Operator
SELECT * FROM Payments WHERE status='Paid' AND amount>25000;

-- CLAUSES

-- WHERE Clause	
SELECT * FROM Payments WHERE method='Credit Card';	

-- ORDER BY	
SELECT * FROM Payments ORDER BY amount DESC;	

-- GROUP BY	
SELECT method, COUNT(*) AS total_txn FROM Payments GROUP BY method;

-- HAVING Clause	
SELECT method, SUM(amount) AS total_amt FROM Payments GROUP BY method HAVING total_amt > 100000;

-- LIMIT Clause	
SELECT * FROM Payments ORDER BY amount DESC LIMIT 5;	

-- DISTINCT Clause	
SELECT DISTINCT method FROM Payments;

-- ALIASES 

-- Column Alias	
SELECT payment_id AS ID, amount AS Payment_Amount, method AS Mode FROM Payments;	

-- Table Alias	
SELECT p.payment_id, b.booking_date, p.amount FROM Payments AS p JOIN Bookings AS b ON p.booking_id = b.booking_id;

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) CHECK (amount >= 0),
    payment_date DATE NOT NULL,
    method VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Pending',
    transaction_ref VARCHAR(100) UNIQUE,
    currency VARCHAR(10) DEFAULT 'INR',
    remarks VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT p.payment_id, b.booking_id, b.customer_id, p.amount, p.method, p.status
FROM Payments p
INNER JOIN Bookings b ON p.booking_id = b.booking_id;

-- LEFT JOIN
SELECT b.booking_id, p.payment_id, p.amount, p.status FROM Bookings b
LEFT JOIN Payments p ON b.booking_id = p.booking_id;

-- RIGHT JOIN
SELECT p.payment_id, b.booking_id, p.amount, p.status FROM Bookings b
RIGHT JOIN Payments p ON b.booking_id = p.booking_id;

-- FULL OUTER JOIN 
SELECT b.booking_id, p.payment_id, p.amount, p.status FROM Bookings b
LEFT JOIN Payments p ON b.booking_id = p.booking_id
UNION
SELECT b.booking_id, p.payment_id, p.amount, p.status FROM Bookings b
RIGHT JOIN Payments p ON b.booking_id = p.booking_id;

-- SELF JOIN
SELECT p1.payment_id AS Payment1, p2.payment_id AS Payment2, p1.method FROM Payments p1
JOIN Payments p2
ON p1.method = p2.method AND p1.payment_id <> p2.payment_id;

-- CROSS JOIN
SELECT DISTINCT p1.method, p2.status FROM Payments p1
CROSS JOIN Payments p2;

-- Scalar Subquery
SELECT payment_id, amount,
       (SELECT AVG(amount) FROM Payments) AS avg_payment
FROM Payments;

-- Correlated Subquery
SELECT p1.payment_id, p1.method, p1.amount
FROM Payments p1
WHERE p1.amount > (
    SELECT AVG(p2.amount)
    FROM Payments p2
    WHERE p2.method = p1.method
);

-- IN Subquery
SELECT p.payment_id, p.amount, p.method
FROM Payments p
WHERE booking_id IN (
    SELECT booking_id
    FROM Bookings b
    JOIN Customers c ON b.customer_id = c.customer_id
    WHERE c.country = 'India'
);

-- EXISTS Subquery
SELECT b.booking_id, b.customer_id
FROM Bookings b
WHERE EXISTS (
    SELECT 1 FROM Payments p
    WHERE p.booking_id = b.booking_id AND p.status = 'Paid'
);

-- ANY Subquery

SELECT payment_id, amount, method
FROM Payments
WHERE amount > ANY (
    SELECT amount FROM Payments WHERE method = 'UPI'
);


-- ALL Subquery
SELECT payment_id, amount, method
FROM Payments
WHERE amount > ALL (
    SELECT amount FROM Payments WHERE method = 'UPI'
);

-- Subquery in FROM Clause
SELECT method, ROUND(AVG(amount),2) AS AvgPerMethod
FROM (
    SELECT method, amount
    FROM Payments
) AS sub
GROUP BY method;

-- STRING FUNCTIONS
SELECT UPPER(method) AS UpperMethod FROM Payments;

SELECT LOWER(status) AS LowerStatus FROM Payments;

SELECT CONCAT(transaction_ref, ' - ', method) AS PaymentDetails FROM Payments;

SELECT SUBSTRING(transaction_ref, 1, 5) AS ShortTxn FROM Payments;

-- NUMERIC FUNCTIONS
SELECT payment_id,
       amount,
       ROUND(amount, -3) AS RoundedToThousand,
       FLOOR(amount/1000) AS FloorThousands,
       CEIL(amount/1000) AS CeilThousands
FROM Payments;

-- DATE/TIME FUNCTIONS
SELECT payment_id,
       payment_date,
       NOW() AS CurrentTime,
       CURDATE() AS CurrentDate,
       DATEDIFF(CURDATE(), payment_date) AS DaysSincePayment,
       YEAR(payment_date) AS PaymentYear,
       MONTH(payment_date) AS PaymentMonth
FROM Payments;

-- AGGREGATE FUNCTIONS
SELECT 
    COUNT(*) AS TotalPayments,
    SUM(amount) AS TotalAmount,
    AVG(amount) AS AverageAmount,
    MIN(amount) AS SmallestPayment,
    MAX(amount) AS LargestPayment
FROM Payments;

-- USER-DEFINED FUNCTION 
DELIMITER //

CREATE FUNCTION PaymentLevel(amt DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE level VARCHAR(20);
    IF amt >= 50000 THEN
        SET level = 'High Value';
    ELSEIF amt >= 30000 THEN
        SET level = 'Medium Value';
    ELSE
        SET level = 'Low Value';
    END IF;
    RETURN level;
END //

DELIMITER ;

-- Usage:
SELECT payment_id, amount, PaymentLevel(amount) AS PaymentCategory
FROM Payments;

-- SIMPLE VIEWS
CREATE VIEW v_basic_payments AS
SELECT payment_id,booking_id,amount,payment_date,method,status
FROM Payments;

-- COMPLEX VIEWS 
-- Payment Details with Booking Info
CREATE VIEW v_payment_details AS
SELECT p.payment_id,b.customer_id,p.booking_id,p.amount,p.method,p.status,p.transaction_ref,p.payment_date
FROM Payments p
JOIN Bookings b ON p.booking_id = b.booking_id;

-- STORED PROCEDURES
-- Insert New Payment
DELIMITER //
CREATE PROCEDURE sp_add_payment(
    IN p_booking_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_date DATE,
    IN p_method VARCHAR(50),
    IN p_status VARCHAR(20),
    IN p_transaction_ref VARCHAR(100)
)
BEGIN
    INSERT INTO Payments (booking_id, amount, payment_date, method, status, transaction_ref)
    VALUES (p_booking_id, p_amount, p_date, p_method, p_status, p_transaction_ref);
END //
DELIMITER ;

-- Call 
CALL sp_add_payment(21, 30000, '2025-09-21', 'UPI', 'Paid', 'TXN021');

-- WINDOW FUNCTIONS
-- Running Total of Payments (Ordered by Date)
SELECT payment_id,amount,payment_date,
SUM(amount) OVER (ORDER BY payment_date) AS running_total
FROM Payments;

-- DCL 
-- Create User
CREATE USER 'payment_user'@'%' IDENTIFIED BY 'Pay@123';

-- Grant Permissions
GRANT SELECT, INSERT, UPDATE ON Payments TO 'payment_user'@'%';

-- Revoke Permission
REVOKE UPDATE ON Payments FROM 'payment_user'@'%';

-- TCL
START TRANSACTION;

UPDATE Payments
SET amount = amount + 1000
WHERE payment_id = 5;

ROLLBACK;

COMMIT;

-- TRIGGERS
-- Automatically Mark High Payments as “Verified”
DELIMITER //
CREATE TRIGGER trg_auto_verify_high_payment
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.amount > 50000 THEN
        SET NEW.status = 'Verified';
    END IF;
END //
DELIMITER ;

-- Trigger to Prevent Negative Amount
DELIMITER //
CREATE TRIGGER trg_check_payment_amount
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Amount must be non-negative';
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 23: Complaints
-- -------------------------------------------------
CREATE TABLE Complaints (
    complaint_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    booking_id INT,
    complaint_date DATE NOT NULL,
    subject VARCHAR(100),
    description VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Open',
    resolution VARCHAR(255),
    priority VARCHAR(20) DEFAULT 'Medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Complaints (customer_id, booking_id, complaint_date, subject, description, status, resolution, priority)
VALUES
(1,1,'2025-09-02','Delay','Flight delayed','Resolved','Compensation given','High'),
(2,2,'2025-09-03','Hotel','Room not clean','Resolved','Changed room','Medium'),
(3,3,'2025-09-04','Guide','Guide late','Open',NULL,'Low'),
(4,4,'2025-09-05','Transport','Car issue','Resolved','Replacement given','High'),
(5,5,'2025-09-06','Food','Poor quality','Open',NULL,'Medium'),
(6,6,'2025-09-07','Activity','Cancelled suddenly','Resolved','Refund issued','High'),
(7,7,'2025-09-08','Payment','Double charge','Resolved','Refunded','High'),
(8,8,'2025-09-09','Staff','Rude behavior','Open',NULL,'Medium'),
(9,9,'2025-09-10','Service','Slow response','Resolved','Apology','Low'),
(10,10,'2025-09-11','Booking','Wrong date','Resolved','Corrected','High'),
(11,11,'2025-09-12','Guide','Not professional','Open',NULL,'Medium'),
(12,12,'2025-09-13','Transport','Late pickup','Resolved','Compensation','Low'),
(13,13,'2025-09-14','Food','Cold meals','Open',NULL,'Low'),
(14,14,'2025-09-15','Hotel','Overcharged','Resolved','Adjusted bill','High'),
(15,15,'2025-09-16','Service','Slow check-in','Open',NULL,'Medium'),
(16,16,'2025-09-17','Guide','Unhelpful','Resolved','Replaced guide','High'),
(17,17,'2025-09-18','Transport','Driver rude','Open',NULL,'Medium'),
(18,18,'2025-09-19','Activity','Unsafe','Resolved','Refund issued','High'),
(19,19,'2025-09-20','Hotel','Facilities poor','Open',NULL,'Medium'),
(20,20,'2025-09-21','Food','Bad taste','Resolved','Apology','Low');

-- SELECT QUERIES
-- Get all complaints
SELECT * FROM Complaints;

-- Get only open complaints
SELECT * FROM Complaints WHERE status = 'Open';

-- Find complaints resolved with compensation
SELECT * FROM Complaints WHERE resolution LIKE '%Compensation%';

-- TRUNCATE TABLE
TRUNCATE TABLE Complaints;

-- DROP TABLE
DROP TABLE Complaints;

-- Add a column for complaint type
ALTER TABLE Complaints ADD complaint_type VARCHAR(50);

-- Modify default priority
ALTER TABLE Complaints ALTER COLUMN priority SET DEFAULT 'High';

-- Drop a column
ALTER TABLE Complaints DROP COLUMN complaint_type;

-- Add a column for complaint type
ALTER TABLE Complaints ADD complaint_type VARCHAR(50);

-- Modify default priority
ALTER TABLE Complaints ALTER COLUMN priority SET DEFAULT 'High';

-- Update status of a complaint
UPDATE Complaints
SET status = 'Resolved', resolution = 'Compensation issued'
WHERE complaint_id = 3;

-- Complaints for a specific booking
SELECT * FROM Complaints
WHERE booking_id = 1;

-- Sort by complaint date descending
SELECT * FROM Complaints
ORDER BY complaint_date DESC;

-- Count complaints by status
SELECT status, COUNT(*) AS total_complaints
FROM Complaints
GROUP BY status;


-- Operators
-- Arithmetic Operators
SELECT complaint_id, LENGTH(description) + 5 AS new_length FROM Complaints;

-- Comparison Operators
SELECT * FROM Complaints WHERE priority = 'High' AND status <> 'Resolved';

-- Logical Operators
SELECT * FROM Complaints WHERE (priority = 'High' OR priority = 'Medium') AND status = 'Open';

-- BETWEEN Operator
SELECT * FROM Complaints WHERE complaint_date BETWEEN '2025-09-05' AND '2025-09-15';

-- LIKE Operator
SELECT * FROM Complaints WHERE description LIKE '%refund%';

-- IN Operator
SELECT * FROM Complaints WHERE priority IN ('High', 'Low');

-- Clauses
-- WHERE Clause
SELECT * FROM Complaints WHERE status = 'Open';

-- ORDER BY Clause
SELECT complaint_id, subject, priority FROM Complaints ORDER BY priority DESC;

-- GROUP BY Clause
SELECT status, COUNT(*) AS total_complaints FROM Complaints GROUP BY status;

-- HAVING Clause
SELECT priority, COUNT(*) AS total_complaints FROM Complaints GROUP BY priority HAVING COUNT(*) > 3;

-- DISTINCT Clause
SELECT DISTINCT priority FROM Complaints;

-- LIMIT Clause
SELECT *  FROM Complaints LIMIT 5;

-- Alias

-- Column Alias
SELECT complaint_id AS ID, subject AS Issue, priority AS Level
FROM Complaints;


-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE Complaints (
    complaint_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    booking_id INT,
    complaint_date DATE NOT NULL,
    subject VARCHAR(100),
    description VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Open',
    resolution VARCHAR(255),
    priority VARCHAR(20) DEFAULT 'Medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT c.complaint_id, cu.name AS customer_name, c.subject, c.status FROM Complaints c
INNER JOIN Customers cu ON c.customer_id = cu.customer_id;

-- LEFT JOIN
SELECT cu.name, c.subject, c.status
FROM Customers cu
LEFT JOIN Complaints c ON cu.customer_id = c.customer_id;

-- RIGHT JOIN
SELECT cu.name, c.subject, c.status
FROM Customers cu
RIGHT JOIN Complaints c ON cu.customer_id = c.customer_id;

-- FULL OUTER JOIN
SELECT cu.name, c.subject, c.status FROM Customers cu
LEFT JOIN Complaints c ON cu.customer_id = c.customer_id
UNION
SELECT cu.name, c.subject, c.status FROM Customers cu
RIGHT JOIN Complaints c ON cu.customer_id = c.customer_id;

-- SELF JOIN
SELECT A.complaint_id AS complaint1, B.complaint_id AS complaint2, A.priority FROM Complaints A
JOIN Complaints B ON A.priority = B.priority AND A.complaint_id <> B.complaint_id;

-- CROSS JOIN
SELECT cu.name, c.subject FROM Customers cu
CROSS JOIN Complaints c;

-- Scalar Subquery
SELECT complaint_id, subject, priority FROM Complaints
WHERE priority = (SELECT priority FROM Complaints WHERE complaint_id = 1);

-- Correlated Subquery
SELECT c1.complaint_id, c1.subject
FROM Complaints c1
WHERE EXISTS (
  SELECT 1 FROM Complaints c2
  WHERE c2.customer_id = c1.customer_id
  AND c2.status = c1.status
  AND c2.complaint_id <> c1.complaint_id
);

-- IN Subquery
SELECT complaint_id, subject, priority FROM Complaints
WHERE customer_id IN (
  SELECT customer_id FROM Complaints WHERE priority = 'High'
);

-- EXISTS Subquery
SELECT cu.name FROM Customers cu
WHERE EXISTS (
  SELECT 1 FROM Complaints c WHERE c.customer_id = cu.customer_id
);

-- ANY Subquery
SELECT complaint_id, subject, complaint_date
FROM Complaints
WHERE complaint_date > ANY (
  SELECT complaint_date FROM Complaints WHERE status = 'Resolved'
);

-- Subquery in FROM Clause
SELECT priority, AVG(cnt) AS avg_complaints
FROM (
  SELECT priority, COUNT(*) AS cnt
  FROM Complaints
  GROUP BY priority
) AS priority_counts
GROUP BY priority;

-- String Functions
SELECT
    complaint_id,
    UPPER(subject) AS upper_subject,
    LOWER(description) AS lower_description,
    CONCAT(subject, ' - ', status) AS full_info,
    SUBSTRING(description, 1, 10) AS short_desc
FROM Complaints;

-- Numeric Functions
SELECT
    complaint_id,
    ROUND(LENGTH(description)/5, 2) AS rounded_len,
    FLOOR(LENGTH(subject)/3) AS floor_val,
    CEIL(LENGTH(subject)/4) AS ceil_val
FROM Complaints;

-- Date/Time Functions
SELECT
    complaint_id,
    complaint_date,
    NOW() AS current_time,
    CURDATE() AS current_date,
    DATEDIFF(CURDATE(), complaint_date) AS days_passed,
    YEAR(complaint_date) AS complaint_year,
    MONTH(complaint_date) AS complaint_month
FROM Complaints;

-- Aggregate Functions
SELECT
    COUNT(*) AS total_complaints,
    SUM(CASE WHEN status='Resolved' THEN 1 ELSE 0 END) AS resolved_count,
    AVG(DATEDIFF(CURDATE(), complaint_date)) AS avg_days_passed,
    MIN(complaint_date) AS earliest_complaint,
    MAX(complaint_date) AS latest_complaint
FROM Complaints;

-- User-Defined Function

DELIMITER //
CREATE FUNCTION ComplaintAge(c_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN DATEDIFF(CURDATE(), c_date);
END//
DELIMITER ;

-- Usage:
SELECT complaint_id, subject, ComplaintAge(complaint_date) AS days_since_complaint
FROM Complaints;

-- SIMPLE VIEW
CREATE VIEW View_OpenComplaints AS
SELECT complaint_id, customer_id, subject, status, priority
FROM Complaints
WHERE status = 'Open';

-- COMPLEX VIEW 
CREATE VIEW View_ComplaintDetails AS
SELECT c.complaint_id,cu.customer_name,b.booking_date,c.subject,c.status,c.priority
FROM Complaints c
JOIN Customers cu ON c.customer_id = cu.customer_id
JOIN Bookings b ON c.booking_id = b.booking_id
WHERE c.priority = 'High';

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE GetComplaintsByPriority(IN p_priority VARCHAR(20))
BEGIN
    SELECT complaint_id, subject, status, priority
    FROM Complaints
    WHERE priority = p_priority;
END//
DELIMITER ;


-- Call it:
CALL GetComplaintsByPriority('High');

-- WINDOW FUNCTIONS
SELECT complaint_id,subject,priority,
    RANK() OVER (ORDER BY 
        CASE priority
            WHEN 'High' THEN 1
            WHEN 'Medium' THEN 2
            WHEN 'Low' THEN 3
        END
    ) AS priority_rank
FROM Complaints;

-- DCL 
CREATE USER 'audit_user'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT ON Complaints TO 'audit_user'@'localhost';

REVOKE INSERT ON Complaints FROM 'audit_user'@'localhost';

FLUSH PRIVILEGES;

-- TCL 
START TRANSACTION;

INSERT INTO Complaints (customer_id, booking_id, complaint_date, subject, description)
VALUES (1, 1, '2025-10-01', 'Test', 'Testing transaction');

COMMIT;

-- Rollback 
START TRANSACTION;

UPDATE Complaints SET status = 'Resolved' WHERE complaint_id = 5;

ROLLBACK;  

-- TRIGGERS
-- Auto-update status to "Open" if it is NULL during insert
DELIMITER //
CREATE TRIGGER trg_default_status
BEFORE INSERT ON Complaints
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL THEN
        SET NEW.status = 'Open';
    END IF;
END//
DELIMITER ;

-- Prevent deletion of resolved complaints
DELIMITER //
CREATE TRIGGER trg_block_resolved_delete
BEFORE DELETE ON Complaints
FOR EACH ROW
BEGIN
    IF OLD.status = 'Resolved' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete resolved complaints!';
    END IF;
END//
DELIMITER ;


-- -------------------------------------------------
-- Table 24: Staff
-- -------------------------------------------------
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    department VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Staff (name, role, phone, email, hire_date, salary, department, status)
VALUES
('Ravi Kumar','Manager','911111111','ravi@travel.com','2020-01-01',60000,'Operations','Active'),
('Priya Singh','Executive','922222222','priya@travel.com','2021-03-12',40000,'Sales','Active'),
('John Mathew','Accountant','933333333','john@travel.com','2019-05-20',45000,'Finance','Active'),
('Asha Patel','Coordinator','944444444','asha@travel.com','2021-07-10',38000,'Tours','Active'),
('Rahul Verma','Driver','955555555','rahul@travel.com','2018-09-15',30000,'Transport','Active'),
('Anita Rao','Receptionist','966666666','anita@travel.com','2022-01-05',28000,'Front Desk','Active'),
('Suresh Nair','Guide','977777777','suresh@travel.com','2017-11-25',35000,'Guides','Active'),
('Sneha Joshi','HR','988888888','sneha@travel.com','2020-06-30',42000,'HR','Active'),
('Amit Desai','Executive','999999999','amit@travel.com','2021-04-22',40000,'Sales','Active'),
('Neha Shah','Manager','900000000','neha@travel.com','2016-02-18',65000,'Marketing','Active'),
('Arun Gupta','Driver','911122233','arun@travel.com','2019-08-12',32000,'Transport','Active'),
('Deepa Mehra','Coordinator','922233344','deepa@travel.com','2020-11-10',39000,'Tours','Active'),
('Kiran Kumar','Executive','933344455','kiran@travel.com','2022-03-01',41000,'Sales','Active'),
('Meena Iyer','Receptionist','944455566','meena@travel.com','2021-09-20',29000,'Front Desk','Active'),
('Rakesh Yadav','Accountant','955566677','rakesh@travel.com','2018-12-05',47000,'Finance','Active'),
('Anjali Jain','HR','966677788','anjali@travel.com','2020-10-25',43000,'HR','Active'),
('Vivek Sharma','Guide','977788899','vivek@travel.com','2019-06-14',36000,'Guides','Active'),
('Komal Kapoor','Executive','988899900','komal@travel.com','2021-02-17',40000,'Sales','Active'),
('Nikhil Bhat','Manager','999000111','nikhil@travel.com','2017-05-09',67000,'Operations','Active'),
('Pooja Rani','Coordinator','900111222','pooja@travel.com','2022-04-11',37000,'Tours','Active');

-- SELECT QUERIES
-- Get all staff
SELECT * FROM Staff;

-- Find all managers
SELECT * FROM Staff WHERE role = 'Manager';

-- List staff with salary above 50,000
SELECT name, role, salary FROM Staff WHERE salary > 50000;

-- TRUNCATE TABLE
TRUNCATE TABLE Staff;

-- DROP TABLE
DROP TABLE Staff;

-- Add a new column for shift timing
ALTER TABLE Staff ADD shift_time VARCHAR(50);

-- Drop a column
ALTER TABLE Staff DROP COLUMN shift_time;

-- Promote a staff member
UPDATE Staff
SET role = 'Senior Manager', salary = 75000
WHERE name = 'Ravi Kumar';

-- All active staff
SELECT * FROM Staff
WHERE status = 'Active';

-- Order by salary descending
SELECT * FROM Staff
ORDER BY salary DESC;

-- Average salary by department
SELECT department, AVG(salary) AS avg_salary
FROM Staff
GROUP BY department;

-- Operators
-- Comparison Operators
SELECT * FROM Staff WHERE department = 'Sales';

SELECT * FROM Staff WHERE salary > 40000;

SELECT * FROM Staff WHERE salary <= 30000;

-- Logical Operators
-- AND Operator 
SELECT * FROM Staff WHERE department = 'Sales' AND salary > 38000; 

-- OR Operator 
SELECT * FROM Staff WHERE department = 'Sales' OR department = 'HR'; 

-- NOT Operator 
SELECT * FROM Staff WHERE NOT department = 'Finance'; 

-- Matching Operators 
-- LIKE operator 
SELECT * FROM Staff WHERE name LIKE 'A%'; 

-- LIKE operator 
SELECT * FROM Staff WHERE email LIKE '%@travel.com';

-- Null Checking Operators 
--  IS NULL  
SELECT * FROM Staff WHERE email IS NULL; 

-- IS NOT NULL 
SELECT * FROM Staff WHERE phone IS NOT NULL;

-- CLAUSES 
-- WHERE Clause
SELECT * FROM Staff WHERE salary > 40000;

-- ORDER BY Clause
SELECT name, department, salary FROM Staff ORDER BY salary DESC;

-- GROUP BY Clause
SELECT department, COUNT(*) AS total_staff FROM Staff GROUP BY department;

-- HAVING Clause
SELECT department, COUNT(*) AS total_staff FROM Staff GROUP BY department
HAVING COUNT(*) > 2;

-- DISTINCT Clause
SELECT DISTINCT department FROM Staff;

-- IN Clause
SELECT * FROM Staff WHERE role IN ('Manager','Executive');

-- ALIAS 
-- Column Alias
SELECT name AS Staff_Name, salary AS Monthly_Salary FROM Staff;

-- Table Alias
SELECT s.name, s.department, s.salary FROM Staff AS s WHERE s.department = 'HR';

-- ON DELETE CASCADE and ON UPDATE CASCADE

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT,
    attendance_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT s.name, s.role, d.manager_name FROM Staff s
INNER JOIN Departments d
ON s.department = d.department_name;

-- LEFT JOIN
SELECT s.name, s.department, d.manager_name FROM Staff s
LEFT JOIN Departments d
ON s.department = d.department_name;

-- RIGHT JOIN
SELECT s.name, d.department_name FROM Staff s
RIGHT JOIN Departments d
ON s.department = d.department_name;

-- FULL OUTER JOIN
SELECT s.name, s.department, d.manager_name FROM Staff s
LEFT JOIN Departments d ON s.department = d.department_name
UNION
SELECT s.name, s.department, d.manager_name FROM Staff s
RIGHT JOIN Departments d ON s.department = d.department_name;

-- SELF JOIN
SELECT A.name AS Staff1, B.name AS Staff2, A.department FROM Staff A
JOIN Staff B ON A.department = B.department AND A.staff_id <> B.staff_id;

-- CROSS JOIN
SELECT s.name, d.department_name FROM Staff s
CROSS JOIN Departments d;

-- Scalar Subquery
SELECT name, salary FROM Staff
WHERE salary = (SELECT MAX(salary) FROM Staff);

-- Correlated Subquery
SELECT s1.name, s1.salary, s1.department FROM Staff s1
WHERE s1.salary > (
    SELECT AVG(s2.salary)
    FROM Staff s2
    WHERE s2.department = s1.department
);

-- IN Subquery
SELECT name, department, salary FROM Staff
WHERE department IN (
    SELECT department
    FROM Staff
    GROUP BY department
    HAVING AVG(salary) > 45000
);

-- EXISTS Subquery
SELECT DISTINCT department FROM Staff s1
WHERE EXISTS (
    SELECT 1 FROM Staff s2 WHERE s2.department = s1.department AND s2.status = 'Active'
);

-- ANY Subquery
SELECT name, role, salary
FROM Staff
WHERE salary > ANY (SELECT salary FROM Staff WHERE role = 'Manager');

-- ALL Subquery
SELECT name, role, salary
FROM Staff
WHERE salary > ALL (SELECT salary FROM Staff WHERE role = 'Executive');

-- Subquery in FROM Clause
SELECT department, ROUND(avg_salary,2) AS avg_salary
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM Staff
    GROUP BY department
) AS dept_avg;

-- String Functions
SELECT
    staff_id,
    UPPER(name) AS upper_name,
    LOWER(role) AS lower_role,
    CONCAT(name, ' - ', department) AS full_info,
    SUBSTRING(email, 1, 10) AS email_short
FROM Staff;

-- Numeric Functions
SELECT
    staff_id,
    salary,
    ROUND(salary/1000, 1) AS rounded_salary,
    FLOOR(salary/10000) AS floor_value,
    CEIL(salary/10000) AS ceil_value
FROM Staff;

-- Date/Time Functions
SELECT
    staff_id,
    name,
    hire_date,
    NOW() AS current_time,
    CURDATE() AS current_date,
    DATEDIFF(CURDATE(), hire_date) AS days_worked,
    YEAR(hire_date) AS hire_year,
    MONTH(hire_date) AS hire_month
FROM Staff;

-- Aggregate Functions
SELECT
    COUNT(*) AS total_staff,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM Staff;

-- User-Defined Function
DELIMITER //
CREATE FUNCTION YearsOfExperience(h_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN FLOOR(DATEDIFF(CURDATE(), h_date) / 365);
END//
DELIMITER ;

-- Usage
SELECT name, department, YearsOfExperience(hire_date) AS experience_years
FROM Staff;

-- SIMPLE VIEW
CREATE VIEW View_StaffBasic AS
SELECT staff_id, name, role, department, status
FROM Staff
WHERE status = 'Active';

-- COMPLEX VIEW
CREATE VIEW View_StaffDeptDetails AS
SELECT s.staff_id,s.name,s.role,s.salary,d.head_name AS department_head
FROM Staff s
JOIN Departments d ON s.department = d.department
WHERE s.salary > 40000;

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE GetStaffByDept(IN dept_name VARCHAR(50))
BEGIN
    SELECT staff_id, name, role, salary, department
    FROM Staff
    WHERE department = dept_name;
END //
DELIMITER ;

-- Call:
CALL GetStaffByDept('Sales');

-- WINDOW FUNCTIONS
SELECT staff_id,name,department,salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM Staff;

-- DCL 
CREATE USER 'staff_viewer'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT ON Staff TO 'staff_viewer'@'localhost';

REVOKE INSERT, UPDATE, DELETE ON Staff FROM 'staff_viewer'@'localhost';

FLUSH PRIVILEGES;

-- TCL 
START TRANSACTION;

UPDATE Staff SET salary = salary + 2000 WHERE department = 'Sales';

SAVEPOINT sp1;

UPDATE Staff SET salary = salary + 5000 WHERE role = 'Manager';

ROLLBACK TO sp1;

COMMIT;

-- TRIGGERS
-- Prevent salary below minimum 25000
DELIMITER //
CREATE TRIGGER trg_check_salary
BEFORE INSERT ON Staff
FOR EACH ROW
BEGIN
    IF NEW.salary < 25000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be below 25000';
    END IF;
END //
DELIMITER ;


-- -------------------------------------------------
-- Table 25: StaffAssignments
-- -------------------------------------------------
CREATE TABLE StaffAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    booking_id INT,
    role VARCHAR(50),
    shift_date DATE,
    start_time TIME,
    end_time TIME,
    status VARCHAR(20) DEFAULT 'Assigned',
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO StaffAssignments (staff_id, booking_id, role, shift_date, start_time, end_time, status, notes)
VALUES
(1,1,'Manager','2025-09-01','09:00:00','17:00:00','Assigned','Oversee operations'),
(2,2,'Executive','2025-09-02','10:00:00','18:00:00','Assigned','Sales support'),
(3,3,'Accountant','2025-09-03','09:30:00','16:30:00','Assigned','Check payments'),
(4,4,'Coordinator','2025-09-04','08:00:00','16:00:00','Assigned','Tour arrangement'),
(5,5,'Driver','2025-09-05','07:00:00','15:00:00','Assigned','Pickup clients'),
(6,6,'Receptionist','2025-09-06','09:00:00','17:00:00','Assigned','Front desk'),
(7,7,'Guide','2025-09-07','10:00:00','14:00:00','Assigned','Lead group'),
(8,8,'HR','2025-09-08','09:00:00','17:00:00','Assigned','Staff coordination'),
(9,9,'Executive','2025-09-09','10:00:00','18:00:00','Assigned','Client handling'),
(10,10,'Manager','2025-09-10','09:00:00','17:00:00','Assigned','Oversee tour'),
(11,11,'Driver','2025-09-11','07:30:00','15:30:00','Assigned','Airport transfer'),
(12,12,'Coordinator','2025-09-12','08:30:00','16:30:00','Assigned','Activity setup'),
(13,13,'Executive','2025-09-13','10:00:00','18:00:00','Assigned','Booking follow-up'),
(14,14,'Receptionist','2025-09-14','09:00:00','17:00:00','Assigned','Front desk'),
(15,15,'Accountant','2025-09-15','09:30:00','16:30:00','Assigned','Invoice check'),
(16,16,'HR','2025-09-16','09:00:00','17:00:00','Assigned','Resolve issues'),
(17,17,'Guide','2025-09-17','10:00:00','14:00:00','Assigned','Cultural tour'),
(18,18,'Executive','2025-09-18','10:00:00','18:00:00','Assigned','Promotions'),
(19,19,'Manager','2025-09-19','09:00:00','17:00:00','Assigned','Supervise operations'),
(20,20,'Coordinator','2025-09-20','08:00:00','16:00:00','Assigned','Client support');

-- SELECT QUERIES
-- Get all staff assignments
SELECT * FROM StaffAssignments;

-- Find all assignments for Managers
SELECT * FROM StaffAssignments WHERE role = 'Manager';

-- List assignments with notes included
SELECT assignment_id, staff_id, role, shift_date, notes FROM StaffAssignments;

-- Show assignments scheduled after 2025-09-10
SELECT * FROM StaffAssignments WHERE shift_date > '2025-09-10';

-- TRUNCATE TABLE
TRUNCATE TABLE StaffAssignments;

-- DROP TABLE
DROP TABLE StaffAssignments;

-- Add a column for location of shift
ALTER TABLE StaffAssignments ADD location VARCHAR(100);

-- Change default status
ALTER TABLE StaffAssignments ALTER COLUMN status SET DEFAULT 'Pending';

-- Drop the notes column
ALTER TABLE StaffAssignments DROP COLUMN notes;

-- Change default status
ALTER TABLE StaffAssignments ALTER COLUMN status SET DEFAULT 'Pending';

-- Update role for a staff member
UPDATE StaffAssignments
SET role = 'Senior Manager'
WHERE staff_id = 1;

-- Assignments on a specific date
SELECT * FROM StaffAssignments
WHERE shift_date = '2025-09-05';

-- Order by shift date
SELECT * FROM StaffAssignments
ORDER BY shift_date ASC;

-- Count assignments per role
SELECT role, COUNT(*) AS total_assignments
FROM StaffAssignments
GROUP BY role;

-- Count assignments per staff
SELECT staff_id, COUNT(*) AS assignments_count
FROM StaffAssignments
GROUP BY staff_id;


-- Operators Queries
-- Comparison Operators
SELECT * FROM StaffAssignments WHERE role = 'Manager';
SELECT * FROM StaffAssignments WHERE role != 'Executive';
SELECT * FROM StaffAssignments WHERE assignment_id > 10;

-- Logical Operators

SELECT * FROM StaffAssignments WHERE role = 'Executive' AND status = 'Assigned';

SELECT * FROM StaffAssignments WHERE role = 'Manager' OR role = 'HR';

SELECT * FROM StaffAssignments WHERE NOT role = 'Driver';

- -- BETWEEN Operators
SELECT * FROM StaffAssignments WHERE assignment_id BETWEEN 5 AND 10;

-- IN Operators
SELECT * FROM StaffAssignments WHERE role IN ('Manager','HR','Executive');

-- NULL Operators
-- IS NULL
SELECT * FROM StaffAssignments WHERE notes IS NULL;

-- IS NOT NULL
SELECT * FROM StaffAssignments WHERE notes IS NOT NULL;

-- Clauses 
-- WHERE Clause
SELECT * FROM StaffAssignments WHERE role = 'Guide';

-- ORDER BY Clause
SELECT * FROM StaffAssignments ORDER BY shift_date ASC; 

-- GROUP BY Clause
SELECT role, COUNT(*) AS Total_Assignments FROM StaffAssignments
GROUP BY role;

-- LIMIT Clause
SELECT * FROM StaffAssignments LIMIT 5; 

-- DISTINCT Clause
SELECT DISTINCT role FROM StaffAssignments;

-- Aliases 

-- Column Alias	
SELECT role AS Job_Role, shift_date AS Date FROM StaffAssignments;	

-- Table Alias	
SELECT s.name, a.role FROM Staff s JOIN StaffAssignments a ON s.staff_id = a.staff_id;

-- ON DELETE CASCADE and ON UPDATE CASCADE 

CREATE TABLE StaffAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    booking_id INT,
    role VARCHAR(50),
    shift_date DATE,
    start_time TIME,
    end_time TIME,
    status VARCHAR(20) DEFAULT 'Assigned',
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- JOINS
-- INNER JOIN
SELECT s.name, s.role, sa.shift_date, sa.start_time, sa.end_time FROM Staff s
INNER JOIN StaffAssignments sa
ON s.staff_id = sa.staff_id;

-- LEFT JOIN
SELECT s.name, s.role, sa.shift_date, sa.status FROM Staff s
LEFT JOIN StaffAssignments sa
ON s.staff_id = sa.staff_id;

-- RIGHT JOIN
SELECT s.name, sa.role, sa.shift_date FROM Staff s
RIGHT JOIN StaffAssignments sa
ON s.staff_id = sa.staff_id;

-- FULL OUTER JOIN
SELECT s.name, s.role, sa.shift_date FROM Staff s
LEFT JOIN StaffAssignments sa ON s.staff_id = sa.staff_id
UNION
SELECT s.name, s.role, sa.shift_date FROM Staff s
RIGHT JOIN StaffAssignments sa ON s.staff_id = sa.staff_id;

-- SELF JOIN
SELECT A.name AS Staff1, B.name AS Staff2, A.role FROM Staff A
JOIN Staff B
ON A.role = B.role AND A.staff_id <> B.staff_id;

-- CROSS JOIN
SELECT s.name, sa.shift_date FROM Staff s
CROSS JOIN StaffAssignments sa;

-- Scalar Subquery
SELECT * FROM StaffAssignments
WHERE shift_date = (SELECT MIN(shift_date) FROM StaffAssignments);

-- Correlated Subquery
SELECT s.name, s.staff_id FROM Staff s
WHERE (
  SELECT COUNT(*) FROM StaffAssignments sa
  WHERE sa.staff_id = s.staff_id
) > 1;

-- IN Subquery
SELECT assignment_id, role, shift_date FROM StaffAssignments
WHERE staff_id IN (
    SELECT staff_id FROM Staff WHERE role IN ('Manager','Executive')
);

-- EXISTS Subquery
SELECT name FROM Staff s
WHERE EXISTS (
  SELECT 1 FROM StaffAssignments sa
  WHERE sa.staff_id = s.staff_id
  AND MONTH(sa.shift_date) = 9
  AND YEAR(sa.shift_date) = 2025
);

-- ANY Subquery
SELECT s.name, sa.role
FROM Staff s
JOIN StaffAssignments sa ON s.staff_id = sa.staff_id
WHERE TIMEDIFF(sa.end_time, sa.start_time) >
ANY (
    SELECT TIMEDIFF(end_time, start_time)
    FROM StaffAssignments WHERE role = 'Executive'
);

-- ALL Subquery
SELECT s.name, sa.role
FROM Staff s
JOIN StaffAssignments sa ON s.staff_id = sa.staff_id
WHERE TIMEDIFF(sa.end_time, sa.start_time) >
ALL (
    SELECT TIMEDIFF(end_time, start_time)
    FROM StaffAssignments WHERE role = 'Executive'
);

-- Subquery in FROM Clause
SELECT role, total_assignments
FROM (
  SELECT role, COUNT(*) AS total_assignments
  FROM StaffAssignments
  GROUP BY role
) AS sub;

-- String Functions
SELECT
    staff_id,
    UPPER(role) AS upper_role,
    LOWER(status) AS lower_status,
    CONCAT(role, ' - ', status) AS role_status,
    SUBSTRING(notes, 1, 15) AS short_notes
FROM StaffAssignments;

-- Numeric Functions
SELECT
    assignment_id,
    ROUND(TIME_TO_SEC(TIMEDIFF(end_time, start_time)) / 3600, 1) AS shift_hours,
    FLOOR(TIME_TO_SEC(TIMEDIFF(end_time, start_time)) / 3600) AS floor_hours,
    CEIL(TIME_TO_SEC(TIMEDIFF(end_time, start_time)) / 3600) AS ceil_hours
FROM StaffAssignments;

-- Date/Time Functions
SELECT
    assignment_id,
    shift_date,
    NOW() AS current_time,
    CURDATE() AS current_date,
    DATEDIFF(CURDATE(), shift_date) AS days_since_shift,
    YEAR(shift_date) AS shift_year,
    MONTH(shift_date) AS shift_month
FROM StaffAssignments;

-- Aggregate Functions
SELECT
    COUNT(*) AS total_assignments,
    MIN(shift_date) AS first_shift,
    MAX(shift_date) AS last_shift
FROM StaffAssignments;


SELECT staff_id, COUNT(*) AS total_shifts
FROM StaffAssignments
GROUP BY staff_id;

-- User-Defined Function 
DELIMITER //
CREATE FUNCTION CalculateShiftHours(start_t TIME, end_t TIME)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
  RETURN ROUND(TIME_TO_SEC(TIMEDIFF(end_t, start_t)) / 3600, 2);
END//
DELIMITER ;

-- Usage
SELECT assignment_id, role, CalculateShiftHours(start_time, end_time) AS hours_worked
FROM StaffAssignments;

-- SIMPLE VIEWS
CREATE VIEW View_AssignmentBasic AS
SELECT assignment_id,staff_id,role,shift_date,start_time,end_time,status
FROM StaffAssignments;

-- COMPLEX VIEWS 
CREATE VIEW View_StaffAssignmentDetails AS
SELECT sa.assignment_id,s.name AS staff_name,sa.role,sa.shift_date,sa.start_time,sa.end_time,s.department
FROM StaffAssignments sa
JOIN Staff s ON sa.staff_id = s.staff_id
WHERE sa.status = 'Assigned';

-- STORED PROCEDURES
DELIMITER //
CREATE PROCEDURE GetAssignmentsByStaff(IN p_staff_id INT)
BEGIN
    SELECT * FROM StaffAssignments
    WHERE staff_id = p_staff_id;
END //
DELIMITER ;

-- WINDOW FUNCTIONS
SELECT staff_id,
COUNT(*) AS total_shifts,
RANK() OVER (ORDER BY COUNT(*) DESC) AS shift_rank
FROM StaffAssignments
GROUP BY staff_id;

-- DCL COMMANDS
-- Create user & give read permissions
CREATE USER 'assignment_user'@'localhost' IDENTIFIED BY 'pass123';

GRANT SELECT ON StaffAssignments TO 'assignment_user'@'localhost';

FLUSH PRIVILEGES;

-- Revoke permissions
REVOKE INSERT, UPDATE, DELETE ON StaffAssignments FROM 'assignment_user'@'localhost';

-- TCL COMMANDS
START TRANSACTION;

UPDATE StaffAssignments
SET status = 'Completed'
WHERE assignment_id = 5;

SAVEPOINT sp1;

UPDATE StaffAssignments
SET notes = 'Shift extended'
WHERE assignment_id = 6;

ROLLBACK TO sp1;

COMMIT;

-- Trigger to Automatically Add Note When Status Becomes Completed
DELIMITER //

CREATE TRIGGER trg_auto_note_completed
BEFORE UPDATE ON StaffAssignments
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' AND OLD.status <> 'Completed' THEN
        SET NEW.notes = 'Shift marked as completed.';
    END IF;
END //

DELIMITER ;

-- Trigger to Set Default Note If NULL on Insert
DELIMITER //

CREATE TRIGGER trg_set_default_note
BEFORE INSERT ON StaffAssignments
FOR EACH ROW
BEGIN
    IF NEW.notes IS NULL OR NEW.notes = '' THEN
        SET NEW.notes = 'No special notes.';
    END IF;
END //

DELIMITER ;
