#🌍 Travel & Tourism Management Database (Phase-2 SQL Project)
##📘 Overview

This project demonstrates SQL mastery through the design and implementation of a comprehensive Travel & Tourism Management Database System.
It includes database creation, normalization, DDL/DML/DQL operations, constraints, clauses, joins, operators, and cascade rules.

###🧩 Project Objective

To build a relational database for managing information related to:

Countries and Cities

Destinations and Hotels

Airlines and Flights

Customers, Bookings, and Payments

Reviews and Travel Packages

Each table is designed to maintain data integrity using Primary Keys, Foreign Keys, Constraints, and Cascading Rules (ON DELETE/UPDATE CASCADE).

###🏗️ Database Details

######Database Name: TravelTourismDB

Total Tables: 12

Countries – Stores global country details

Cities – City-wise details linked to countries

Destinations – Tourist attractions and landmarks

Hotels – Accommodation details for each destination

Flights – Flight information between cities

Airlines – Airline details with fleet and country info

Customers – Traveller personal and contact information

Bookings – Flight and hotel bookings by customers

Payments – Payment details and methods

Reviews – Customer feedback on destinations, hotels, and flights

Packages – Predefined travel packages

PackageItems – Activities, destinations, and inclusions within packages

#####⚙️ SQL Concepts Covered

This project showcases all key SQL components, including:

###🏗️ DDL (Data Definition Language)

CREATE, ALTER, DROP, TRUNCATE statements

PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT, UNIQUE constraints

Cascading rules using ON DELETE CASCADE, ON UPDATE CASCADE

###💾 DML (Data Manipulation Language)

INSERT INTO, UPDATE, DELETE

###🔍 DQL (Data Query Language)

SELECT, JOIN, GROUP BY, HAVING, ORDER BY, LIMIT, DISTINCT, ALIAS

###🔢 SQL Operators

Comparison: =, <, >, <>

Logical: AND, OR, NOT

Range: BETWEEN, IN

Pattern Matching: LIKE

Aggregate Functions: SUM(), AVG(), COUNT(), MAX(), MIN()

###🧠 Example Queries
#####1️⃣ Retrieve all 5-star hotels:
SELECT hotel_name, address, price_per_night
FROM Hotels
WHERE star_rating = 5;

#####2️⃣ Show top 5 populated countries:
SELECT country_name, population
FROM Countries
ORDER BY population DESC
LIMIT 5;

#####3️⃣ Join bookings with customer details:
SELECT b.booking_id, c.first_name, c.last_name, b.total_amount, b.payment_status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id;

#####4️⃣ Count destinations by category:
SELECT category, COUNT(*) AS total_destinations
FROM Destinations
GROUP BY category;

###🔄 Relationships (Cascading Rules)

Countries → Cities → Destinations → Hotels

Customers → Bookings → Payments & Reviews

Cities ↔ Flights (departure & arrival)

Packages → PackageItems (activities & inclusions)

Cascading ensures automatic updates/deletes across related records for database consistency.

###🧰 Tools Used

Database System: MySQL 8.0+

Editor: MySQL Workbench / VS Code

File: SonalShelke_Travel&Tourism Management.sql

###📊 Project Highlights

12 fully normalized tables

20+ sample queries for each SQL operation

Use of JOINs, Constraints, Operators, and Clauses

Demonstrates real-world database modeling for the tourism industry

###🚀 How to Run

Open MySQL Workbench or any SQL editor.

Execute the SQL file:

SOURCE SonalShelke_Travel&Tourism\ Management.sql;


Verify using:

SHOW DATABASES;
USE TravelTourismDB;
SHOW TABLES;


Run any query block to explore data or test cascade operations.

###

###🧑‍💻 Author

Name: Sonal Shelke
Project Phase: 2 – SQL Query Implementation
Submission: Travel & Tourism Management Database
Year: 2025

###🏁 Conclusion

This project successfully demonstrates comprehensive SQL knowledge, covering database creation, manipulation, querying, and optimization — structured to reflect a real-life Travel & Tourism Management System.
