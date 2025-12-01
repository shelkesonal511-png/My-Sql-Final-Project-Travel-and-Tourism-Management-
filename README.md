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

## 🌐 2. Architecture and Scope  

The system is built on a normalized SQL schema covering major functional areas of the travel and tourism business.

### **Domain Coverage**

| Domain | Key Data Managed |
|--------|------------------|
| Tour Packages | Destinations, packages, pricing, itineraries |
| Bookings | Customer bookings, payments, cancellations |
| Travel Operations | Hotels, transport services, vendors, tour guides |
| Marketing & Engagement | Leads, customer feedback, travel history |

### **Integration Point**

| Integration Area | Description |
|------------------|-------------|
| Bookings ↔ Payments | Ensures accurate transaction tracking |
| Packages ↔ Operations | Aligns tour availability with hotel/transport vendors |
| Customer Data ↔ Feedback | Enables personalized recommendations |



---

## ✨ 3. Key Features and Business Value  

| Feature Category | Technical Implementation | Business Insight |
|------------------|--------------------------|------------------|
| Customer Personalization | Complex SQL JOIN queries across Customer, Booking, Package tables | Enables personalized travel recommendations and targeted offers |
| Automation | CREATE VIEW, Stored Procedures, Triggers | Auto-updates availability, generates booking reports, reduces manual workload |
| Financial Accuracy | TCL (START TRANSACTION, COMMIT, ROLLBACK) | Prevents partial payments or incomplete bookings ensuring financial reliability |
| Analytics & Insights | Window Functions (RANK(), PARTITION BY, OVER()) | Identifies top-selling packages, peak seasons, and high-performing agents |
| Security | DCL commands (GRANT, REVOKE) | Protects sensitive customer and payment information |
| Operational Efficiency | Normalized schema with indexed tables | Faster queries and optimized backend travel operations |


---

## 🛠️ 4. Technologies Used

Database: MySQL / MariaDB / PostgreSQL

Core SQL Concepts Applied:

• DDL, DML, DQL

• Views

• Stored Procedures & Triggers

• User-Defined Functions (UDFs)

• Window Functions

• Transaction Control (TCL)

• Access Control (DCL)

• Normalization (1NF → 3NF)

---

## 🚀 5. Project Impact & Future Scope
Impact:

• 100% Centralized Data: All customer, booking, and vendor details stored in one database.

• Operational Excellence: Reduces manual work with automated SQL routines.

• Enhanced Decision Making: Real-time insights into customer behavior & seasonal demand.

• Accuracy & Speed: Faster booking confirmations and problem resolution.

Future Scope:

• BI Dashboard Integration: Power BI / Tableau for interactive analytics.

• AI-Based Recommendation System: Suggests trips based on user interests & budget.

• Automated Notification System: Email/SMS triggers for booking confirmations, reminders.

• Mobile App/Website Backend: Use this database as the foundation for an online travel booking platform.

---

### Prerequisites

- MySQL Server (8.0 or later recommended)
- MySQL Workbench or any SQL client

