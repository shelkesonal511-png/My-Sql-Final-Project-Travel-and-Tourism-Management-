# 🧳 Travel & Tourism Management System (TTMS) – Advanced Analytics

This repository contains a comprehensive set of **25 advanced SQL queries** designed for a **Travel & Tourism relational database schema**. The queries leverage advanced SQL features including **Window Functions (Rolling Averages, Ranking), Common Table Expressions (CTEs), Recursive CTEs (hierarchical data), and complex JOIN operations**.

These queries are intended to provide actionable business intelligence and operational insights covering **tour bookings, sales, package performance, agent efficiency, customer management, and financial analytics**.

---

## ✨ Features

The **PHASE 5.SQL** file provides solutions for 25 distinct business intelligence questions, including:

### Financial & Sales Analysis

* Calculate the 90-day rolling average of total daily booking revenue, partitioned by package type.
* Identify tour packages where total revenue from all bookings exceeds the planned package budget.
* Calculate Budget Variance Percentage (Actual Cost vs. Budget) for each tour package and rank them from worst to best.
* Determine year-over-year growth rate in total revenue for "Premium" travel packages.

### Operational & Resource Management

* Find the top 3 best-rated travel agents by average customer feedback rating in the last 6 months.
* Retrieve all materials/resources (e.g., amenities, vehicles) with stock quantity below 10% of total ordered quantity.
* Determine the average lead conversion rate (Converted Leads / Total Leads) per month for the last 6 months.

### Hierarchical & HR Reporting

* List all employees, their direct manager's name, and total count of subordinates (direct and indirect) using Recursive CTEs.
* Generate the full management chain (from CEO down to each employee) for organizational reporting.

---

## 🛠️ Prerequisites

To run these queries, you will need:

* **MySQL** or **MariaDB** (or any compatible SQL environment).
* A database named **Travel_Tourism** (or update script to match your database name).
* All relevant tables (e.g., Bookings, Packages, Customers, Agents, Employees, Resources) populated with appropriate data.

---

## 🚀 Usage

### Clone the Repository

```bash
git clone https://github.com/YourUsername/YourRepoName.git
cd YourRepoName
```

### Run the Script

You can execute the script from your SQL client (MySQL Workbench, DBeaver) or via command line.

**Using MySQL Command Line:**

```bash
mysql -u [your_username] -p Travel_Tourism < "PHASE 5.SQL"
```

*(Replace `[your_username]` with your MySQL username.)*

### Review the Output

The queries produce reporting-style result sets directly in your SQL client, providing insights for financial analysis, operational efficiency, and HR reporting.

---

## ✍️ Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE.md file for details.

---

### ✈️ TTMS – Transforming Travel Data into Actionable Insights

