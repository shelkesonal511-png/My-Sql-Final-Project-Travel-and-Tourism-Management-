# My-SQL-Final-Project-Travel-and-Tourism-Management
<img width="700" height="700" alt="image" src="https://github.com/user-attachments/assets/1e72720a-7c12-4aa3-bf13-1d655edb3ea8" />

> Final SQL project focused on Travel and Tourism Management. This project demonstrates database design, normalization, and SQL queries for managing bookings, customers, destinations, and tour packages. Ideal for academic or learning purposes in database management systems.

---

## ## 👤 Presenter & Mentor  
| Role | Name | Specialization |
|------|------|----------------|
| Created By | Sonal Shelke | Data Analytics |
| Academic Mentor | Shalini Verma | Tourism Management |


---

## 🎯 1. Project Objective & Main Purpose

The primary objective is to eliminate fragmented travel agency systems (separate booking sheets, manual itineraries, vendor Excel files) and replace them with a centralized SQL-based RDBMS.

Main Purpose: Enable Data-Driven Tourism Operations

Focused on achieving:

• Customer Satisfaction: Personalized recommendations & faster service.

• Operational Efficiency: Automated booking workflows and itinerary validation.

• Revenue Maximization: Transparent tracking of package sales, profits, and demand trends.
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

