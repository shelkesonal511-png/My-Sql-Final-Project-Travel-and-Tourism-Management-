# 🧳 Travel and Tourism Management System 

This repository documents the development of a comprehensive Travel and Tourism Management System , now focused on optimizing the database layer for real-world application deployment.

The system supports core travel business operations such as destination management, tour packages, bookings, payments, agents, customers, and reporting.

## 🔒 Phase 4: Database Optimization, Application Logic, and Security

Phase 4 marks the final stage of database development, concentrating on performance optimization, simplified reporting structures, database-level automation, and security enforcement. The objective is to deliver a secure, high-performance, and application-ready database layer that can be seamlessly consumed by backend services.

## 🎯 Objectives of Phase 4

Reporting Simplification
Create permanent database Views to simplify complex queries for dashboards and APIs.

Logic Automation
Implement iteration using Cursors and ensure data consistency using Transactions (TCL).

Performance Tuning
Apply advanced Window Functions for efficient ranking and analytical queries.

Security & Access Control
Enforce controlled database access using Data Control Language (DCL) statements.

## 📁 Phase 4 SQL File Structure

The file PHASE 4.sql contains the final set of SQL objects and commands required to productionize the TTMS database. This includes Views, Stored Procedures, security rules, and transactional logic.

## ✨ Highlights of Implemented Features
| Feature Category | Description | Example Logic in PHASE 4.sql |
|-----------------|------------|-----------------------------|
| Views (Reporting) | Virtual tables created to simplify complex queries for dashboards and APIs. | UpcomingToursView shows only upcoming tour packages. AvgPackageCostByDestination provides average pricing per destination. |
| Stored Procedures | Encapsulating multi-step business workflows for backend application calls. | ShowDestinationNames() uses a cursor to iterate through destination records for logging or migration tasks. |
| Data Control Language (DCL) | Managing database user access and permissions to enforce security policies. | GRANT SELECT to viewer_user for read-only access and REVOKE DELETE to prevent unauthorized data removal. |
| Transaction Control (TCL) | Ensuring data consistency by grouping multiple SQL operations into a single atomic transaction. | START TRANSACTION; COMMIT; ensures booking confirmation and payment update succeed together. |
| Advanced Window Functions | Performing high-performance ranking and analytical operations within partitions. | RANK() tour packages by price and DENSE_RANK() by booking count within each destination. |
| Cursors and Conditional Logic | Executing iterative and condition-based updates driven by application inputs. | IncreasePackagePriceBySeason updates package prices only for a specific travel season or destination. |

## 🏁 Project Status: Database Complete

With the successful implementation of Phase 4, the TTMS Database Layer is complete, secure, and production-ready.

## 📄 License

This project is developed for educational and academic purposes. It may be freely extended or modified for learning and portfolio use.

## ✈️ TTMS — Optimized. Secure. Application‑Ready.
