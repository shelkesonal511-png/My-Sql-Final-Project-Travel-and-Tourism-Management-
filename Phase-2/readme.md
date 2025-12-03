# 🌍 Travel & Tourism Management Database (Phase-2 SQL Project)
## 📘 Overview

This project demonstrates SQL mastery through the design and implementation of a comprehensive Travel & Tourism Management Database System.
It includes database creation, normalization, DDL/DML/DQL operations, constraints, clauses, joins, operators, and cascade rules.

### 🧩 Project Objective

To build a relational database for managing information related to:

Countries and Cities

Destinations and Hotels

Airlines and Flights

Customers, Bookings, and Payments

Reviews and Travel Packages

Each table is designed to maintain data integrity using Primary Keys, Foreign Keys, Constraints, and Cascading Rules (ON DELETE/UPDATE CASCADE).

## 📊Highlights of Implemented Queries

The **TravelTourismDB** script includes dedicated query sections covering essential travel-industry business areas:

| **Table / Area** | **Query Focus** | **Example Capabilities** |
|------------------|------------------|---------------------------|
| **Countries (T1)** | Global Geography & Analytics | Retrieve top populated countries, list countries by continent, and show countries with the highest number of tourist destinations. |
| **Cities (T2)** | City Insights | Count cities per country, identify major travel hubs, and list cities connected through flight routes. |
| **Destinations (T3)** | Tourism & Attractions | Count destinations by category, filter attractions by entry fees, and identify popular or high-rated destinations. |
| **Hotels (T4)** | Accommodation & Pricing | Retrieve 5-star hotels, calculate average hotel price per city, and list top-rated hotels based on customer reviews. |
| **Airlines (T5)** | Aviation Operations | View airlines by country, identify airlines with large fleets, and retrieve airlines operating international or domestic flights. |
| **Flights (T6)** | Flight Routes & Schedules | Find flights by departure/arrival city, check cheapest routes, and track fully booked or delayed flights. |
| **Customers (T7)** | Traveller Insights | List customers by region, identify repeat travelers, and check customers with pending or failed payments. |
| **Bookings (T8)** | Booking Management | Join bookings with customer details, calculate total booking amount, analyze booking status (confirmed/cancelled), and view monthly booking trends. |
| **Payments (T9)** | Finance & Transactions | Track payment status, calculate total revenue, view payments by method, and list failed or pending transactions. |
| **Reviews (T10)** | Customer Feedback | Calculate average ratings, track low-rated hotels/airlines/destinations, and identify customers who submitted multiple reviews. |
| **Packages (T11)** | Travel Package Insights | View package details, filter by duration or price, identify best-selling packages, and list packages targeting specific destinations. |
| **PackageItems (T12)** | Activities & Inclusions | Count activities per package, list included destinations/activities, and identify package combinations with highest value. |
| **Complex Joins** | Cross-Domain Travel Intelligence | Build full customer itineraries, identify high-value customers, analyse best-performing destinations, and evaluate most profitable packages and routes. |



### 🧰 Tools Used

Database System: MySQL 8.0+

Editor: MySQL Workbench / VS Code

File: SonalShelke_Travel&Tourism Management.sql


### 🚀 How to Run

Open MySQL Workbench or any SQL editor.

Execute the SQL file:

SOURCE SonalShelke_Travel&Tourism\ Management.sql;


Verify using:

SHOW DATABASES;
USE TravelTourismDB;
SHOW TABLES;


Run any query block to explore data or test cascade operations.



### 🧑‍💻 Author

Name: Sonal Shelke
Project Phase: 2 – SQL Query Implementation
Submission: Travel & Tourism Management Database
Year: 2025

### 🏁 Conclusion

This project successfully demonstrates comprehensive SQL knowledge, covering database creation, manipulation, querying, and optimization — structured to reflect a real-life Travel & Tourism Management System.
