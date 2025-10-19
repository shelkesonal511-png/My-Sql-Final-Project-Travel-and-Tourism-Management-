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
DELETE FROM Countries WHERE country_id = 1; -- Mumbai will also be deleted automatically

-- ON UPDATE CASCADE:
UPDATE Countries SET country_id = 50 WHERE country_name = 'Japan'; -- Tokyo’s country_id in Cities also becomes 50

---------------------------------------------------
-- Table 2: Cities
---------------------------------------------------
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
DELETE FROM Countries WHERE country_id = 1;  -- Deletes India, and automatically deletes New Delhi & Mumbai

-- Applying ON UPDATE CASCADE
UPDATE Countries SET country_id = 30 WHERE country_id = 2;  -- Updates all cities linked to USA (New York, Washington DC)


---------------------------------------------------
-- Table 3: Destinations
---------------------------------------------------
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



---------------------------------------------------
-- Table 4: Hotels
---------------------------------------------------
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



---------------------------------------------------
-- Table 5: Flights
---------------------------------------------------
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



---------------------------------------------------
-- Table 6: Airlines
---------------------------------------------------
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
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

-- ON DELETE CASCADE and ON UPDATE CASCADE
ALTER TABLE Airlines
DROP FOREIGN KEY Airlines_ibfk_1;

ALTER TABLE Airlines
ADD CONSTRAINT fk_country
FOREIGN KEY (country_id) REFERENCES Countries(country_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


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


---------------------------------------------------
-- Table 8: Bookings
---------------------------------------------------
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



---------------------------------------------------
-- Table 9: Payments
---------------------------------------------------
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



---------------------------------------------------
-- Table 10: Reviews
---------------------------------------------------
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

-- Average rating per destination
SELECT d.destination_name, AVG(r.rating) AS avg_rating
FROM Reviews r
JOIN Destinations d ON r.destination_id = d.destination_id
GROUP BY d.destination_name;

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


---------------------------------------------------
-- Table 11: Packages
---------------------------------------------------
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


---------------------------------------------------
-- Table 12: PackageItems
---------------------------------------------------
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


---------------------------------------------------
-- Table 13: HotelRooms
---------------------------------------------------
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


---------------------------------------------------
-- Table 14: FlightSeats
---------------------------------------------------
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


---------------------------------------------------
-- Table 15: Activities
---------------------------------------------------
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


---------------------------------------------------
-- Table 16: ActivityBookings
---------------------------------------------------
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
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    status VARCHAR(20) DEFAULT 'Confirmed',
    payment_id INT,
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (activity_id) REFERENCES Activities(activity_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


---------------------------------------------------
-- Table 17: CarRentals
---------------------------------------------------
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



---------------------------------------------------
-- Table 18: RentalVehicles
---------------------------------------------------
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


---------------------------------------------------
-- Table 19: TourGuides
---------------------------------------------------
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


---------------------------------------------------
-- Table 20: GuideAssignments
---------------------------------------------------
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


---------------------------------------------------
-- Table 21: Reviews
---------------------------------------------------
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


---------------------------------------------------
-- Table 22: Payments
---------------------------------------------------
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


---------------------------------------------------
-- Table 23: Complaints
---------------------------------------------------
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


---------------------------------------------------
-- Table 24: Staff
---------------------------------------------------
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


---------------------------------------------------
-- Table 25: StaffAssignments
---------------------------------------------------
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