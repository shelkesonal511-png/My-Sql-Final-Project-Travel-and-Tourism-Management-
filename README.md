# My-SQL-Final-Project-Travel-and-Tourism-Management

> Final SQL project focused on Travel and Tourism Management. This project demonstrates database design, normalization, and SQL queries for managing bookings, customers, destinations, and tour packages. Ideal for academic or learning purposes in database management systems.

---

## 📌 Table of Contents

- [📖 Overview](#-overview)
- [🧱 Database Schema](#-database-schema)
- [🛠 Features Implemented](#-features-implemented)
- [📝 SQL Queries](#-sql-queries)
- [📊 Sample Data](#-sample-data)
- [📦 Installation](#-installation)
- [🧪 How to Use](#-how-to-use)
- [📁 Project Structure](#-project-structure)
- [🎯 Future Improvements](#-future-improvements)
- [🧑‍💻 Author](#-author)
- [📄 License](#-license)

---

## 📖 Overview

This project is a **final SQL-based academic project** for managing operations in a **Travel and Tourism Management System**. It involves designing and implementing a relational database with normalized tables, relationships, and operations to manage:

- Customer details
- Tour packages
- Bookings and payments
- Destination information
- Travel schedules

It serves as a practical demonstration of **DBMS concepts**, including ER modeling, normalization, primary & foreign keys, and structured SQL querying.

---

## 🧱 Database Schema

The project includes the following tables (example):

1. **Customers**
   - customer_id (PK)
   - name
   - email
   - phone
   - address

2. **Destinations**
   - destination_id (PK)
   - name
   - country
   - description

3. **Packages**
   - package_id (PK)
   - destination_id (FK)
   - title
   - price
   - duration_days

4. **Bookings**
   - booking_id (PK)
   - customer_id (FK)
   - package_id (FK)
   - booking_date
   - number_of_people
   - total_amount

5. **Payments**
   - payment_id (PK)
   - booking_id (FK)
   - payment_date
   - amount
   - payment_method

> All relationships are normalized to 3NF for data integrity.

---

## 🛠 Features Implemented

- 🔍 View all available tour packages and destinations
- 📋 Register customers and manage customer data
- 🧾 Book tour packages for customers
- 💳 Manage payments and calculate total cost
- 📈 Run analytical queries on bookings and revenue

---

## 📝 SQL Queries

The project includes various SQL scripts for:

- Creating tables and defining constraints
- Inserting sample data
- Joining multiple tables
- Filtering and sorting results
- Aggregation (SUM, COUNT, AVG)
- Grouping (GROUP BY, HAVING)
- Subqueries and nested queries
- Views and stored procedures *(if applicable)*

---

## 📊 Sample Data

Sample data is provided in the `sample_data.sql` file to demonstrate the working of the database. You can import this into your MySQL instance to get started quickly.

---

## 📦 Installation

### Prerequisites

- MySQL Server (8.0 or later recommended)
- MySQL Workbench or any SQL client

