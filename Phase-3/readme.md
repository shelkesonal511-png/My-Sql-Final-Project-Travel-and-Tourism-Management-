#🧳 Travel and Tourism Management System 

This repository tracks the development of a comprehensive Travel and Tourism Management System is designed to manage tour packages, bookings, customers, agents, payments, and post-trip feedback.

The project focuses on building a robust database-driven system that supports real-world travel business operations such as package management, reservations, pricing, and reporting.

##⚙️ Phase 3: Advanced SQL Functions and Data Automation

Phase 3 transitions from basic query development to implementing advanced SQL features that enhance data manipulation, automate business workflows, and improve database efficiency. This phase is critical for preparing the database for seamless integration with the application layer.

##🎯 Objectives of Phase 3

Implement Complex Joins
Enable detailed reporting across multiple domain tables (e.g., Bookings, Packages, Agents, Customers).

Advanced Query Techniques
Utilize Subqueries, Correlated Subqueries, and Window Functions for meaningful business insights (e.g., top destinations, agent performance).

Enhance Automation
Develop User-Defined Functions (UDFs) and Stored Procedures to encapsulate business rules and reduce application-side complexity.

Data Integrity Enforcement
Introduce Triggers to ensure critical business constraints are enforced directly at the database level.

##📁 Phase 3 SQL File Structure
| Feature Category | Description | Example Queries / Logic |
|-----------------|------------|-------------------------|
| Complex Joins | Combining data from multiple tables to generate detailed reports. | Listing all customers who booked a tour package for an "Upcoming" destination through a specific travel agent. |
| Subqueries | Using results of one query inside another query for filtering or calculations. | Finding tour packages with prices higher than the average package cost. |
| Correlated Subqueries | Executing subqueries that depend on values from the outer query. | Identifying the most recent payment made for each booking ID. |
| Window Functions | Performing analytical calculations across related rows without grouping data. | Ranking tour packages by popularity within each destination using RANK(). |
| User-Defined Functions (UDFs) | Creating reusable functions to apply business rules and validations. | IsPremiumCustomer(total_amount): Checks if a customer qualifies as premium based on total spending. |
| Stored Procedures | Encapsulating complex business logic into reusable database procedures. | Procedure to create a new booking and automatically update package availability. |
| Triggers | Automating database actions on INSERT, UPDATE, or DELETE events. | BEFORE INSERT trigger to automatically standardize destination names to uppercase. |


###🛠️ Next Steps

With Phase 3 completed, the database layer is optimized and ready for full-scale application development:

API Development (Phase 4)
Build a backend API using technologies such as Python (Django/Flask), Node.js (Express), or Java (Spring Boot) to interact with stored procedures and database views.

Frontend Integration
Connect a responsive frontend (Web or Mobile) to the API to allow users to browse packages, make bookings, and manage travel data.

ORM Configuration
Leverage defined keys, constraints, and advanced SQL logic to configure an Object-Relational Mapper (ORM) for scalable and maintainable application development.

##📌 Project Status

✅ Database Design Completed
✅ Advanced SQL Implementation (Phase 3)
🚧 API & Application Layer (Upcoming)

###📄 License

This project is developed for educational and learning purposes. You are free to modify and extend it for academic or personal use.

The file PHASE 3.sql is the core focus of this phase and contains a wide range of advanced SQL implementations, organized by feature type for clarity and maintainability.
