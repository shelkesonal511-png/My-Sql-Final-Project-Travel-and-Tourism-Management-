-- ------------------------------------------- 1st Database --------------------------------------------
/*
Analysis
-- Scientists (FirstName, LastName, Gender, DepartmentID)
-- Projects (ProjectName, StartDate, EndDate, DepartmentID)
-- Departments (DepartmentID , DepartmentName,HeadName, Location,ContactNo)
-- Laboratories (LabName, City, HeadScientist, ContactNo)
-- Experiments (ProjectID, LabID, ExperimentDate, Status)
-- Equipment (Name, LabID, PurchaseDate, Status)
*/

-- Create DRDO Database
CREATE DATABASE IF NOT EXISTS DRDODB;
USE DRDODB;


-- 1. Scientists Table
CREATE TABLE Scientists (
    ScientistID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DepartmentID INT
);

-- insert value in a table
INSERT INTO Scientists (FirstName, LastName, Gender, DepartmentID) VALUES
('Rajesh', 'Verma', 'Male', 1),
('Anita', 'Desai', 'Female', 2),
('Vikram', 'Rao', 'Male', 3),
('Sunita', 'Joshi', 'Female', 4),
('Amit', 'Sharma', 'Male', 5),
('Kavita', 'Nair', 'Female', 6),
('Suresh', 'Iyer', 'Male', 7),
('Pooja', 'Reddy', 'Female', 8),
('Nikhil', 'Patel', 'Male', 9),
('Meena', 'Gupta', 'Female', 10);

-- display table
select * from Scientists;

-- to remove complete data from table
truncate table Scientists;

-- to delete complete attributes and records 
drop table Scientists; 

-- 2. Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT
);

-- insert value in a table
INSERT INTO Projects (ProjectName, StartDate, EndDate, DepartmentID) VALUES
('Agni Missile', '2022-01-01', '2025-01-01', 1),
('Astra Air-to-Air', '2023-03-01', '2026-03-01', 2),
('Arjun Tank Upgrade', '2021-07-15', '2024-07-15', 3),
('Radar System X', '2022-09-10', '2025-09-10', 4),
('Netra UAV', '2023-01-20', '2026-01-20', 5),
('Tejas Mk-II', '2020-06-05', '2025-06-05', 6),
('KALI Laser', '2021-02-02', '2024-02-02', 7),
('Nirbhay Cruise', '2023-04-25', '2026-04-25', 8),
('SWATI Radar', '2022-11-11', '2025-11-11', 9),
('Ballistic Defense', '2021-12-01', '2024-12-01', 10);

-- display table
select * from Projects;

-- to remove complete data from table
truncate table Projects;

-- to delete complete attributes and records 
drop table Projects;

-- 3. Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    HeadName VARCHAR(50),
    Location VARCHAR(50),
    ContactNo VARCHAR(15)
);

-- insert value in a table
INSERT INTO Departments VALUES
(1, 'Missile Tech', 'Dr. A. Menon', 'Delhi', '0112345678'),
(2, 'Aero Systems', 'Dr. B. Rao', 'Bangalore', '0801234567'),
(3, 'Armor Systems', 'Dr. C. Iyer', 'Chennai', '0448765432'),
(4, 'Radar R&D', 'Dr. D. Joshi', 'Hyderabad', '0405678901'),
(5, 'UAV Systems', 'Dr. E. Gupta', 'Pune', '0201234567'),
(6, 'Fighter Jets', 'Dr. F. Reddy', 'Bangalore', '0807654321'),
(7, 'Laser R&D', 'Dr. G. Mehta', 'Ahmedabad', '0791234567'),
(8, 'Cruise Systems', 'Dr. H. Sharma', 'Trivandrum', '0471234567'),
(9, 'Radar Testing', 'Dr. I. Desai', 'Jodhpur', '0291123456'),
(10, 'Missile Defense', 'Dr. J. Khan', 'Delhi', '0118765432');

-- display table
select * from Departments;

-- to remove complete data from table
truncate table Departments;

-- to delete complete attributes and records 
drop table Departments;

-- 4. Laboratories Table
CREATE TABLE Laboratories (
    LabID INT PRIMARY KEY AUTO_INCREMENT,
    LabName VARCHAR(100),
    City VARCHAR(50),
    HeadScientist VARCHAR(50),
    ContactNo VARCHAR(15)
);

-- insert value in a table
INSERT INTO Laboratories (LabName, City, HeadScientist, ContactNo) VALUES
('DRDL', 'Hyderabad', 'Rajesh Verma', '0402345678'),
('ADA', 'Bangalore', 'Anita Desai', '0802345678'),
('CVRDE', 'Chennai', 'Vikram Rao', '0442345678'),
('LRDE', 'Bangalore', 'Sunita Joshi', '0803456789'),
('RDE', 'Pune', 'Amit Sharma', '0202345678'),
('GTRE', 'Bangalore', 'Kavita Nair', '0804567890'),
('LASTEC', 'Delhi', 'Suresh Iyer', '0113456789'),
('ADE', 'Bangalore', 'Pooja Reddy', '0805678901'),
('DTRL', 'Delhi', 'Nikhil Patel', '0114567890'),
('ASL', 'Hyderabad', 'Meena Gupta', '0405678901');

-- display table
select * from Laboratories;

-- to remove complete data from table
truncate table Laboratories;

-- to delete complete attributes and records 
drop table Laboratories;

-- 5. Experiments Table
CREATE TABLE Experiments (
    ExperimentID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectID INT,
    LabID INT,
    ExperimentDate DATE,
    Status VARCHAR(20)
);

-- insert value in a table
INSERT INTO Experiments (ProjectID, LabID, ExperimentDate, Status) VALUES
(1, 1, '2023-01-15', 'Success'),
(2, 2, '2023-02-20', 'Success'),
(3, 3, '2023-03-10', 'Failure'),
(4, 4, '2023-04-05', 'Pending'),
(5, 5, '2023-05-12', 'Success'),
(6, 6, '2023-06-18', 'Success'),
(7, 7, '2023-07-01', 'Success'),
(8, 8, '2023-08-25', 'Pending'),
(9, 9, '2023-09-14', 'Failure'),
(10, 10, '2023-10-10', 'Success');
 
 -- display table
select * from Experiments;

-- to remove complete data from table
truncate table Experiments;

-- to delete complete attributes and records 
drop table Experiments;

-- 6. Equipment Table
CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    LabID INT,
    PurchaseDate DATE,
    Status VARCHAR(20)
);

-- insert value in a table
INSERT INTO Equipment (Name, LabID, PurchaseDate, Status) VALUES
('Wind Tunnel', 1, '2021-01-01', 'Operational'),
('Thermal Chamber', 2, '2022-02-15', 'Operational'),
('Radar Simulator', 3, '2023-03-20', 'Maintenance'),
('Flight Control System', 4, '2021-04-25', 'Operational'),
('Drone Prototype', 5, '2022-05-30', 'In Use'),
('Engine Test Bench', 6, '2023-06-05', 'Operational'),
('Laser Chamber', 7, '2021-07-10', 'Operational'),
('Target Tracker', 8, '2022-08-18', 'In Use'),
('Signal Analyzer', 9, '2023-09-22', 'Operational'),
('Missile Tracker', 10, '2021-10-10', 'Operational');

-- display table
select * from Equipment;

-- to remove complete data from table
truncate table Equipment;

-- to delete complete attributes and records 
drop table Equipment;


-- ----------------------------------------- 2nd Database ----------------------------------------------
-- Create Database
CREATE DATABASE PetAdoptionDB;

-- to work  on this database , you need to use it first
USE PetAdoptionDB;


-- Table 1: Pets
CREATE TABLE Pets (
    PetID INT PRIMARY KEY,
    PetName VARCHAR(50),
    Species VARCHAR(50),
    Age INT,
    Gender VARCHAR(10)
);

-- insert value in a table
INSERT INTO Pets VALUES
(1, 'Simba', 'Dog', 2, 'Male'),
(2, 'Moti', 'Dog', 3, 'Male'),
(3, 'Luna', 'Cat', 1, 'Female'),
(4, 'Sheru', 'Dog', 4, 'Male'),
(5, 'Minnie', 'Cat', 2, 'Female'),
(6, 'Raja', 'Rabbit', 1, 'Male'),
(7, 'Golu', 'Dog', 5, 'Male'),
(8, 'Meenu', 'Cat', 3, 'Female'),
(9, 'Chiku', 'Parrot', 2, 'Male'),
(10, 'Kiki', 'Rabbit', 1, 'Female');

 -- display table
select * from Pets;

-- to remove complete data from table
truncate table Pets;

-- to delete complete attributes and records 
drop table Pets;

-- Table 2: Adopters
CREATE TABLE Adopters (
    AdopterID INT PRIMARY KEY,
    FullName VARCHAR(100),
    City VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- insert value in a table
INSERT INTO Adopters VALUES
(1, 'Rahul Sharma', 'Delhi', '9876543210', 'rahul@gmail.com'),
(2, 'Sneha Patel', 'Ahmedabad', '9123456780', 'sneha.p@gmail.com'),
(3, 'Amit Verma', 'Lucknow', '9988776655', 'amitv@yahoo.com'),
(4, 'Priya Reddy', 'Hyderabad', '9665544332', 'priya.r@gmail.com'),
(5, 'Arjun Mehta', 'Mumbai', '9345612789', 'arjunmehta@outlook.com'),
(6, 'Anjali Nair', 'Kochi', '9001122334', 'anjali.n@gmail.com'),
(7, 'Ravi Kumar', 'Patna', '8999001122', 'ravikumar@gmail.com'),
(8, 'Pooja Singh', 'Jaipur', '9988771122', 'pooja.singh@gmail.com'),
(9, 'Karan Thakur', 'Bhopal', '9887766554', 'karan.t@rediffmail.com'),
(10, 'Meera Joshi', 'Pune', '9776655443', 'meera.j@live.com');

 -- display table
select * from Adopters;

-- to remove complete data from table
truncate table Adopters;

-- to delete complete attributes and records 
drop table Adopters;

-- Table 3: Adoptions
CREATE TABLE Adoptions (
    AdoptionID INT PRIMARY KEY,
    PetID INT,
    AdopterID INT,
    AdoptionDate DATE,
    Status VARCHAR(20)
);

-- insert value in a table
INSERT INTO Adoptions VALUES
(1, 1, 1, '2024-01-12', 'Completed'),
(2, 3, 2, '2024-02-15', 'Completed'),
(3, 5, 3, '2024-03-20', 'Completed'),
(4, 7, 4, '2024-03-22', 'Completed'),
(5, 9, 5, '2024-04-10', 'Pending'),
(6, 2, 6, '2024-04-18', 'Completed'),
(7, 6, 7, '2024-04-25', 'Completed'),
(8, 8, 8, '2024-05-01', 'Pending'),
(9, 4, 9, '2024-05-10', 'Completed'),
(10, 10, 10, '2024-05-20', 'Pending');

 -- display table
select * from Adoptions;

-- to remove complete data from table
truncate table Adoptions;

-- to delete complete attributes and records 
drop table Adoptions;


-- Table 4: Shelters
CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY,
    ShelterName VARCHAR(100),
    City VARCHAR(50),
    Capacity INT,
    ContactNumber VARCHAR(15)
);

-- insert value in a table
INSERT INTO Shelters VALUES
(1, 'Paws Home', 'Delhi', 50, '9811122233'),
(2, 'Happy Tails', 'Mumbai', 40, '9822233445'),
(3, 'Safe Haven', 'Hyderabad', 30, '9833344556'),
(4, 'Love n Care', 'Chennai', 35, '9844455667'),
(5, 'Animal Angels', 'Bangalore', 60, '9855566778'),
(6, 'Stray Help', 'Pune', 45, '9866677889'),
(7, 'Pet Paradise', 'Kolkata', 50, '9877788990'),
(8, 'Furry Friends', 'Ahmedabad', 55, '9888899001'),
(9, 'Hope for Paws', 'Jaipur', 25, '9899900112'),
(10, 'Healing Paws', 'Lucknow', 35, '9900011223');

 -- display table
select * from Shelters;

-- to remove complete data from table
truncate table Shelters;

-- to delete complete attributes and records 
drop table Shelters;

-- Table 5: Staff
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Role VARCHAR(50),
    ShelterID INT,
    Phone VARCHAR(15)
);

-- insert value in a table
INSERT INTO Staff VALUES
(1, 'Deepak Kumar', 'Veterinarian', 1, '9991112233'),
(2, 'Lakshmi Iyer', 'Caretaker', 2, '9988223344'),
(3, 'Rohit Jain', 'Manager', 3, '9977334455'),
(4, 'Swati Kapoor', 'Nurse', 4, '9966445566'),
(5, 'Suresh Pillai', 'Caretaker', 5, '9955556677'),
(6, 'Ankita Roy', 'Receptionist', 6, '9944667788'),
(7, 'Vikram Chauhan', 'Trainer', 7, '9933778899'),
(8, 'Neha Mishra', 'Cleaner', 8, '9922889900'),
(9, 'Rajeev Sinha', 'Manager', 9, '9911990011'),
(10, 'Pallavi Deshmukh', 'Vet Assistant', 10, '9900112233');

 -- display table
select * from Staff;

-- to remove complete data from table
truncate table Staff;

-- to delete complete attributes and records 
drop table Staff;

-- --------------------------------------------- 3rd Database ----------------------------------------------
-- create gymdb database
CREATE DATABASE GymDB;

-- use that created database
USE GymDB;


-- Table 1 : Members
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

-- insert value in a table
INSERT INTO Members VALUES
(1, 'Amit Sharma', 28, 'Male', 'Delhi'),
(2, 'Sneha Verma', 24, 'Female', 'Mumbai'),
(3, 'Rohit Yadav', 31, 'Male', 'Lucknow'),
(4, 'Pooja Nair', 26, 'Female', 'Kochi'),
(5, 'Karan Singh', 29, 'Male', 'Jaipur'),
(6, 'Meera Iyer', 27, 'Female', 'Chennai'),
(7, 'Ravi Mehta', 35, 'Male', 'Ahmedabad'),
(8, 'Neha Patel', 22, 'Female', 'Surat'),
(9, 'Arjun Desai', 33, 'Male', 'Pune'),
(10, 'Divya Reddy', 30, 'Female', 'Hyderabad');

-- display table
select * from Members;

-- to remove complete data from table
truncate table Members;

-- to delete complete attributes and records 
drop table Members;

-- Table 2: Trainers
CREATE TABLE Trainers (
    TrainerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Specialty VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

-- insert value in a table
INSERT INTO Trainers VALUES
(1, 'Raj Malhotra', 'Weight Training', '9876543210', 'Delhi'),
(2, 'Simran Kaur', 'Yoga', '9123456789', 'Mumbai'),
(3, 'Rahul Joshi', 'Cardio', '9988776655', 'Pune'),
(4, 'Anita Shetty', 'Zumba', '9876512345', 'Bangalore'),
(5, 'Manoj Rao', 'CrossFit', '9123451122', 'Hyderabad'),
(6, 'Preeti Nair', 'Pilates', '9345678912', 'Chennai'),
(7, 'Siddharth Roy', 'HIIT', '9456712390', 'Kolkata'),
(8, 'Divya Shah', 'Strength', '9321098765', 'Ahmedabad'),
(9, 'Ajay Kumar', 'Bodybuilding', '9867543210', 'Jaipur'),
(10, 'Shraddha Jain', 'Aerobics', '9745612389', 'Indore');

-- display table
select * from Trainers;

-- to remove complete data from table
truncate table Trainers;

-- to delete complete attributes and records 
drop table Trainers;

-- Table 3: Memberships
CREATE TABLE Memberships (
    MembershipID INT PRIMARY KEY,
    MemberID INT,
    StartDate DATE,
    EndDate DATE,
    Type VARCHAR(20)
);


-- insert value in a table
INSERT INTO Memberships VALUES
(1, 1, '2024-01-01', '2024-06-30', 'Gold'),
(2, 2, '2024-02-10', '2024-08-09', 'Silver'),
(3, 3, '2024-03-05', '2024-09-04', 'Platinum'),
(4, 4, '2024-01-15', '2024-07-14', 'Gold'),
(5, 5, '2024-04-01', '2024-10-01', 'Silver'),
(6, 6, '2024-05-01', '2024-11-01', 'Gold'),
(7, 7, '2024-03-20', '2024-09-19', 'Platinum'),
(8, 8, '2024-04-10', '2024-10-10', 'Silver'),
(9, 9, '2024-05-15', '2024-11-14', 'Gold'),
(10, 10, '2024-06-01', '2024-12-01', 'Platinum');

-- display table
select * from Memberships;

-- to remove complete data from table
truncate table Memberships;

-- to delete complete attributes and records 
drop table Memberships;


-- Table 4: Sessions
CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY,
    TrainerID INT,
    SessionType VARCHAR(50),
    SessionDate DATE,
    DurationMins INT
);

-- insert value in a table
INSERT INTO Sessions VALUES
(1, 1, 'Weight Training', '2024-05-01', 60),
(2, 2, 'Yoga', '2024-05-01', 45),
(3, 3, 'Cardio', '2024-05-02', 40),
(4, 4, 'Zumba', '2024-05-03', 50),
(5, 5, 'CrossFit', '2024-05-04', 55),
(6, 6, 'Pilates', '2024-05-05', 45),
(7, 7, 'HIIT', '2024-05-06', 30),
(8, 8, 'Strength', '2024-05-07', 60),
(9, 9, 'Bodybuilding', '2024-05-08', 75),
(10, 10, 'Aerobics', '2024-05-09', 50);

-- display table
select * from Sessions;

-- to remove complete data from table
truncate table Sessions;

-- to delete complete attributes and records 
drop table Sessions;


-- Table 5: Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    MemberID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Mode VARCHAR(20)
);

-- insert value in a table
INSERT INTO Payments VALUES
(1, 1, 5000.00, '2024-01-01', 'UPI'),
(2, 2, 4500.00, '2024-02-10', 'Cash'),
(3, 3, 6000.00, '2024-03-05', 'Card'),
(4, 4, 5000.00, '2024-01-15', 'UPI'),
(5, 5, 4500.00, '2024-04-01', 'Net Banking'),
(6, 6, 5000.00, '2024-05-01', 'Cash'),
(7, 7, 6000.00, '2024-03-20', 'Card'),
(8, 8, 4500.00, '2024-04-10', 'UPI'),
(9, 9, 5000.00, '2024-05-15', 'Cash'),
(10, 10, 6000.00, '2024-06-01', 'Card');

-- display table
select * from Payments;

-- to remove complete data from table
truncate table Payments;

-- to delete complete attributes and records 
drop table Payments;

-- -------------------------------------------------- 4th Database ---------------------------------------------------
-- Create the Voting System database
CREATE DATABASE VotingSystemDB;

-- use the created database
USE VotingSystemDB;

-- Table 1: Voters
CREATE TABLE Voters (
    VoterID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

-- insert value in a table
INSERT INTO Voters VALUES
(1, 'Amit Sharma', 32, 'Male', 'Delhi'),
(2, 'Sneha Iyer', 29, 'Female', 'Chennai'),
(3, 'Rahul Verma', 40, 'Male', 'Lucknow'),
(4, 'Pooja Desai', 35, 'Female', 'Ahmedabad'),
(5, 'Arjun Reddy', 28, 'Male', 'Hyderabad'),
(6, 'Meera Patel', 31, 'Female', 'Surat'),
(7, 'Ravi Yadav', 45, 'Male', 'Bhopal'),
(8, 'Neha Joshi', 27, 'Female', 'Pune'),
(9, 'Karan Mehta', 33, 'Male', 'Mumbai'),
(10, 'Divya Nair', 30, 'Female', 'Kochi');

-- display table
select * from Voters;

-- to remove complete data from table
truncate table Voters;

-- to delete complete attributes and records 
drop table Voters;

-- Table 2: Candidates
CREATE TABLE Candidates (
    CandidateID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Party VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);

-- insert value in a table
INSERT INTO Candidates VALUES
(1, 'Raj Malhotra', 'BJP', 45, 'Delhi'),
(2, 'Anita Shetty', 'INC', 39, 'Mumbai'),
(3, 'Suresh Kumar', 'AAP', 50, 'Chennai'),
(4, 'Priya Singh', 'BJP', 42, 'Lucknow'),
(5, 'Ajay Reddy', 'INC', 38, 'Hyderabad'),
(6, 'Manisha Shah', 'AAP', 37, 'Ahmedabad'),
(7, 'Vikram Deshmukh', 'BJP', 48, 'Pune'),
(8, 'Lakshmi Nair', 'INC', 41, 'Kochi'),
(9, 'Kunal Verma', 'AAP', 36, 'Bhopal'),
(10, 'Swati Gupta', 'BJP', 43, 'Surat');

-- display table
select * from Candidates;

-- to remove complete data from table
truncate table Candidates;

-- to delete complete attributes and records 
drop table Candidates;

-- Table 3: Votes

CREATE TABLE Votes (
    VoteID INT PRIMARY KEY,
    VoterID INT,
    CandidateID INT,
    VoteDate DATE,
    City VARCHAR(50)
);

-- insert value in a table
INSERT INTO Votes VALUES
(1, 1, 1, '2024-04-01', 'Delhi'),
(2, 2, 3, '2024-04-01', 'Chennai'),
(3, 3, 4, '2024-04-02', 'Lucknow'),
(4, 4, 6, '2024-04-02', 'Ahmedabad'),
(5, 5, 5, '2024-04-03', 'Hyderabad'),
(6, 6, 10, '2024-04-03', 'Surat'),
(7, 7, 9, '2024-04-04', 'Bhopal'),
(8, 8, 7, '2024-04-04', 'Pune'),
(9, 9, 2, '2024-04-05', 'Mumbai'),
(10, 10, 8, '2024-04-05', 'Kochi');

-- display table
select * from Votes;

-- to remove complete data from table
truncate table Votes;

-- to delete complete attributes and records 
drop table Votes;

-- Table 4: PollingStations

CREATE TABLE PollingStations (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(100),
    City VARCHAR(50),
    Capacity INT,
    Incharge VARCHAR(100)
);

-- insert value in a table
INSERT INTO PollingStations VALUES
(1, 'PS Gandhi Nagar', 'Delhi', 500, 'Sunil Kumar'),
(2, 'PS Anna Nagar', 'Chennai', 450, 'Latha Iyer'),
(3, 'PS Hazratganj', 'Lucknow', 400, 'Manoj Yadav'),
(4, 'PS Maninagar', 'Ahmedabad', 420, 'Neha Shah'),
(5, 'PS Banjara Hills', 'Hyderabad', 480, 'Rajesh Reddy'),
(6, 'PS City Light', 'Surat', 470, 'Divya Patel'),
(7, 'PS TT Nagar', 'Bhopal', 430, 'Ravi Shukla'),
(8, 'PS Shivajinagar', 'Pune', 460, 'Anita Deshmukh'),
(9, 'PS Andheri West', 'Mumbai', 490, 'Nikhil Mehta'),
(10, 'PS Ernakulam South', 'Kochi', 410, 'Lakshmi Pillai');

-- display table
select * from PollingStations;

-- to remove complete data from table
truncate table PollingStations;

-- to delete complete attributes and records 
drop table PollingStations;

-- Table 5: Admins

CREATE TABLE Admins (
    AdminID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    Role VARCHAR(20),
    City VARCHAR(50)
);

-- insert value in a table
INSERT INTO Admins VALUES
(1, 'admin_delhi', 'delhi123', 'Supervisor', 'Delhi'),
(2, 'admin_mumbai', 'mumbai123', 'Supervisor', 'Mumbai'),
(3, 'admin_chennai', 'chennai123', 'Officer', 'Chennai'),
(4, 'admin_lucknow', 'lucknow123', 'Officer', 'Lucknow'),
(5, 'admin_hyd', 'hyd123', 'Supervisor', 'Hyderabad'),
(6, 'admin_surat', 'surat123', 'Officer', 'Surat'),
(7, 'admin_bhopal', 'bhopal123', 'Officer', 'Bhopal'),
(8, 'admin_pune', 'pune123', 'Supervisor', 'Pune'),
(9, 'admin_kochi', 'kochi123', 'Officer', 'Kochi'),
(10, 'admin_ahm', 'ahm123', 'Supervisor', 'Ahmedabad');

-- display table
select * from Admins;

-- to remove complete data from table
truncate table Admins;

-- to delete complete attributes and records 
drop table Admins;

-- ------------------------------------------------ 5th Database --------------------------------------------------------
-- create Database
CREATE DATABASE SmartParkingDB;

-- use the created database
USE SmartParkingDB;

-- Table 1: Vehicles
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    OwnerName VARCHAR(100),
    VehicleNumber VARCHAR(20),
    VehicleType VARCHAR(20),
    ContactNumber VARCHAR(15)
);


INSERT INTO Vehicles VALUES
(1, 'Amit Sharma', 'DL01AB1234', 'Car', '9876543210'),
(2, 'Sneha Iyer', 'TN10CD4567', 'Bike', '9123456789'),
(3, 'Ravi Verma', 'MH12EF7890', 'Car', '9988776655'),
(4, 'Pooja Desai', 'GJ01GH3210', 'Scooter', '9876512345'),
(5, 'Karan Mehta', 'RJ14JK5678', 'Car', '9123451122'),
(6, 'Meera Patel', 'GJ05LM4321', 'Bike', '9345678912'),
(7, 'Rahul Reddy', 'TS07NO8765', 'SUV', '9456712390'),
(8, 'Neha Joshi', 'MH04PQ9876', 'Scooter', '9321098765'),
(9, 'Arjun Singh', 'UP16RS3456', 'Car', '9867543210'),
(10, 'Divya Nair', 'KL11TU1234', 'Bike', '9745612389');

-- Table 2: ParkingSlots
CREATE TABLE ParkingSlots (
    SlotID INT PRIMARY KEY,
    SlotNumber VARCHAR(10),
    SlotType VARCHAR(20),
    IsOccupied BOOLEAN,
    Level INT
);


INSERT INTO ParkingSlots VALUES
(1, 'S01', 'Car', FALSE, 1),
(2, 'S02', 'Bike', FALSE, 1),
(3, 'S03', 'Car', TRUE, 2),
(4, 'S04', 'Scooter', TRUE, 1),
(5, 'S05', 'Car', FALSE, 3),
(6, 'S06', 'Bike', TRUE, 2),
(7, 'S07', 'SUV', TRUE, 3),
(8, 'S08', 'Scooter', FALSE, 1),
(9, 'S09', 'Car', TRUE, 2),
(10, 'S10', 'Bike', FALSE, 3);


-- Table 3: ParkingRecords

CREATE TABLE ParkingRecords (
    RecordID INT PRIMARY KEY,
    VehicleID INT,
    SlotID INT,
    EntryTime DATETIME,
    ExitTime DATETIME
);


INSERT INTO ParkingRecords VALUES
(1, 1, 1, '2024-05-01 09:00:00', '2024-05-01 12:00:00'),
(2, 2, 2, '2024-05-01 10:30:00', '2024-05-01 11:30:00'),
(3, 3, 3, '2024-05-01 08:45:00', '2024-05-01 09:45:00'),
(4, 4, 4, '2024-05-01 11:00:00', '2024-05-01 13:00:00'),
(5, 5, 5, '2024-05-01 12:15:00', NULL),
(6, 6, 6, '2024-05-01 07:30:00', '2024-05-01 08:15:00'),
(7, 7, 7, '2024-05-01 09:20:00', '2024-05-01 10:20:00'),
(8, 8, 8, '2024-05-01 08:00:00', NULL),
(9, 9, 9, '2024-05-01 10:00:00', '2024-05-01 11:00:00'),
(10, 10, 10, '2024-05-01 11:30:00', '2024-05-01 12:30:00');

-- Table 4: Attendants

CREATE TABLE Attendants (
    AttendantID INT PRIMARY KEY,
    FullName VARCHAR(100),
    ShiftTime VARCHAR(20),
    PhoneNumber VARCHAR(15),
    AssignedLevel INT
);


INSERT INTO Attendants VALUES
(1, 'Sunil Kumar', 'Morning', '9876541230', 1),
(2, 'Priya Singh', 'Evening', '9867541230', 2),
(3, 'Manoj Yadav', 'Night', '9988771122', 3),
(4, 'Neha Shah', 'Morning', '9123456781', 1),
(5, 'Ramesh Patel', 'Evening', '9345612789', 2),
(6, 'Divya Rao', 'Night', '9212345678', 3),
(7, 'Ajay Mehta', 'Morning', '9365478910', 1),
(8, 'Pooja Iyer', 'Evening', '9645378123', 2),
(9, 'Kunal Deshmukh', 'Night', '9564738123', 3),
(10, 'Meena Pillai', 'Morning', '9898123456', 1);

-- Table 5: Payments

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    VehicleID INT,
    Amount DECIMAL(6,2),
    PaymentMode VARCHAR(20),
    PaymentTime DATETIME
);


INSERT INTO Payments VALUES
(1, 1, 50.00, 'UPI', '2024-05-01 12:05:00'),
(2, 2, 30.00, 'Cash', '2024-05-01 11:35:00'),
(3, 3, 50.00, 'Card', '2024-05-01 09:50:00'),
(4, 4, 40.00, 'UPI', '2024-05-01 13:05:00'),
(5, 5, 60.00, 'UPI', NULL),
(6, 6, 30.00, 'Cash', '2024-05-01 08:20:00'),
(7, 7, 70.00, 'Card', '2024-05-01 10:25:00'),
(8, 8, 35.00, 'UPI', NULL),
(9, 9, 50.00, 'Cash', '2024-05-01 11:05:00'),
(10, 10, 30.00, 'Card', '2024-05-01 12:35:00');


-- ------------------------------------------------ 6th Database --------------------------------------------------------
-- Create a Database
CREATE DATABASE BloodBankDB;

-- use created database
USE BloodBankDB;

-- Table 1: Donors

CREATE TABLE Donors (
    DonorID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    BloodGroup VARCHAR(5),
    City VARCHAR(50)
);


INSERT INTO Donors VALUES
(1, 'Amit Sharma', 30, 'A+', 'Delhi'),
(2, 'Sneha Iyer', 28, 'B+', 'Chennai'),
(3, 'Rahul Verma', 35, 'O+', 'Lucknow'),
(4, 'Pooja Desai', 32, 'AB+', 'Ahmedabad'),
(5, 'Karan Mehta', 29, 'A-', 'Mumbai'),
(6, 'Meera Patel', 26, 'B-', 'Surat'),
(7, 'Ravi Yadav', 38, 'O-', 'Bhopal'),
(8, 'Neha Joshi', 27, 'AB-', 'Pune'),
(9, 'Arjun Singh', 31, 'A+', 'Jaipur'),
(10, 'Divya Nair', 30, 'B+', 'Kochi');

-- Table 2: BloodBanks

CREATE TABLE BloodBanks (
    BankID INT PRIMARY KEY,
    BankName VARCHAR(100),
    City VARCHAR(50),
    ContactNumber VARCHAR(15),
    CapacityUnits INT
);


INSERT INTO BloodBanks VALUES
(1, 'RedLife Bank', 'Delhi', '9876543210', 100),
(2, 'Jeevan Raksha', 'Chennai', '9123456789', 120),
(3, 'LifeStream', 'Lucknow', '9988776655', 80),
(4, 'Sanjeevani Blood Bank', 'Ahmedabad', '9876512345', 150),
(5, 'Hope Blood Centre', 'Mumbai', '9123451122', 110),
(6, 'Care Blood Bank', 'Surat', '9345678912', 90),
(7, 'LifeDonors Bank', 'Bhopal', '9456712390', 130),
(8, 'Raktdaan Kendra', 'Pune', '9321098765', 140),
(9, 'Seva Blood Bank', 'Jaipur', '9867543210', 125),
(10, 'Navajeevan Bank', 'Kochi', '9745612389', 115);

-- Table 3: Bloodstock

CREATE TABLE BloodStock (
    StockID INT PRIMARY KEY,
    BankID INT,
    BloodGroup VARCHAR(5),
    UnitsAvailable INT,
    LastUpdated DATE,
    FOREIGN KEY (BankID) REFERENCES BloodBanks(BankID)
);


INSERT INTO BloodStock VALUES
(1, 1, 'A+', 20, '2024-05-01'),
(2, 2, 'B+', 15, '2024-05-01'),
(3, 3, 'O+', 10, '2024-05-01'),
(4, 4, 'AB+', 18, '2024-05-01'),
(5, 5, 'A-', 12, '2024-05-01'),
(6, 6, 'B-', 8, '2024-05-01'),
(7, 7, 'O-', 9, '2024-05-01'),
(8, 8, 'AB-', 6, '2024-05-01'),
(9, 9, 'A+', 22, '2024-05-01'),
(10, 10, 'B+', 16, '2024-05-01');

-- Table 4: Donations

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY,
    DonorID INT,
    BankID INT,
    DonationDate DATE,
    UnitsDonated INT,
    FOREIGN KEY (DonorID) REFERENCES Donors(DonorID),
    FOREIGN KEY (BankID) REFERENCES BloodBanks(BankID)
);


INSERT INTO Donations VALUES
(1, 1, 1, '2024-04-01', 1),
(2, 2, 2, '2024-04-02', 1),
(3, 3, 3, '2024-04-03', 1),
(4, 4, 4, '2024-04-04', 2),
(5, 5, 5, '2024-04-05', 1),
(6, 6, 6, '2024-04-06', 1),
(7, 7, 7, '2024-04-07', 1),
(8, 8, 8, '2024-04-08', 1),
(9, 9, 9, '2024-04-09', 2),
(10, 10, 10, '2024-04-10', 1);

-- Table 5: Requests

CREATE TABLE Requests (
    RequestID INT PRIMARY KEY,
    BankID INT,
    HospitalName VARCHAR(100),
    BloodGroup VARCHAR(5),
    UnitsRequested INT,
    FOREIGN KEY (BankID) REFERENCES BloodBanks(BankID)
);


INSERT INTO Requests VALUES
(1, 1, 'AIIMS Delhi', 'A+', 2),
(2, 2, 'Apollo Chennai', 'B+', 1),
(3, 3, 'SGPGI Lucknow', 'O+', 3),
(4, 4, 'Civil Hospital Ahmedabad', 'AB+', 1),
(5, 5, 'Tata Hospital Mumbai', 'A-', 2),
(6, 6, 'Surat Medical Centre', 'B-', 1),
(7, 7, 'Bhopal General Hospital', 'O-', 2),
(8, 8, 'Pune Care Hospital', 'AB-', 1),
(9, 9, 'Jaipur Heart Hospital', 'A+', 1),
(10, 10, 'Aster Kochi', 'B+', 2);



-- ------------------------------------------------ 7th Database --------------------------------------------------------
-- create a database
CREATE DATABASE VehicleRentalDB;

-- use the created database
USE VehicleRentalDB;

-- Table 1: Customers

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    City VARCHAR(50),
    ContactNumber VARCHAR(15)
);


INSERT INTO Customers VALUES
(1, 'Amit Sharma', 30, 'Delhi', '9876543210'),
(2, 'Sneha Iyer', 27, 'Chennai', '9123456789'),
(3, 'Rahul Verma', 35, 'Lucknow', '9988776655'),
(4, 'Pooja Desai', 32, 'Ahmedabad', '9876512345'),
(5, 'Karan Mehta', 29, 'Mumbai', '9123451122'),
(6, 'Meera Patel', 26, 'Surat', '9345678912'),
(7, 'Ravi Yadav', 38, 'Bhopal', '9456712390'),
(8, 'Neha Joshi', 27, 'Pune', '9321098765'),
(9, 'Arjun Singh', 31, 'Jaipur', '9867543210'),
(10, 'Divya Nair', 30, 'Kochi', '9745612389');

-- Table 2: Vehicles

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    ModelName VARCHAR(50),
    Type VARCHAR(20),
    RegistrationNumber VARCHAR(20),
    RatePerDay DECIMAL(6,2)
);


INSERT INTO Vehicles VALUES
(1, 'Maruti Swift', 'Car', 'DL01AB1234', 1200.00),
(2, 'Honda Activa', 'Scooter', 'TN10CD4567', 300.00),
(3, 'Hyundai i20', 'Car', 'MH12EF7890', 1300.00),
(4, 'Royal Enfield', 'Bike', 'GJ01GH3210', 500.00),
(5, 'Toyota Innova', 'SUV', 'RJ14JK5678', 2000.00),
(6, 'KTM Duke', 'Bike', 'GJ05LM4321', 700.00),
(7, 'Tata Nexon', 'Car', 'TS07NO8765', 1400.00),
(8, 'TVS Jupiter', 'Scooter', 'MH04PQ9876', 350.00),
(9, 'Suzuki Baleno', 'Car', 'UP16RS3456', 1250.00),
(10, 'Hero Splendor', 'Bike', 'KL11TU1234', 400.00);

-- Table 3: Rentals

CREATE TABLE Rentals (
    RentalID INT PRIMARY KEY,
    CustomerID INT,
    VehicleID INT,
    RentDate DATE,
    ReturnDate DATE
);

INSERT INTO Rentals VALUES
(1, 1, 1, '2024-05-01', '2024-05-03'),
(2, 2, 2, '2024-05-02', '2024-05-02'),
(3, 3, 3, '2024-05-03', '2024-05-06'),
(4, 4, 4, '2024-05-04', '2024-05-05'),
(5, 5, 5, '2024-05-05', '2024-05-07'),
(6, 6, 6, '2024-05-06', '2024-05-06'),
(7, 7, 7, '2024-05-07', '2024-05-09'),
(8, 8, 8, '2024-05-08', '2024-05-10'),
(9, 9, 9, '2024-05-09', '2024-05-11'),
(10, 10, 10, '2024-05-10', '2024-05-12');

-- TABLE 4: Payments

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    RentalID INT,
    AmountPaid DECIMAL(7,2),
    PaymentMode VARCHAR(20),
    PaymentDate DATE
);


INSERT INTO Payments VALUES
(1, 1, 2400.00, 'UPI', '2024-05-03'),
(2, 2, 300.00, 'Cash', '2024-05-02'),
(3, 3, 3900.00, 'Card', '2024-05-06'),
(4, 4, 1000.00, 'UPI', '2024-05-05'),
(5, 5, 4000.00, 'UPI', '2024-05-07'),
(6, 6, 700.00, 'Cash', '2024-05-06'),
(7, 7, 2800.00, 'Card', '2024-05-09'),
(8, 8, 700.00, 'UPI', '2024-05-10'),
(9, 9, 2500.00, 'Cash', '2024-05-11'),
(10, 10, 800.00, 'Card', '2024-05-12');

-- Table 5: Staff

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    ContactNumber VARCHAR(15),
    BranchLocation VARCHAR(50)
);


INSERT INTO Staff VALUES
(1, 'Sunil Kumar', 'Manager', '9876541230', 'Delhi'),
(2, 'Priya Singh', 'Executive', '9867541230', 'Chennai'),
(3, 'Manoj Yadav', 'Cleaner', '9988771122', 'Lucknow'),
(4, 'Neha Shah', 'Technician', '9123456781', 'Ahmedabad'),
(5, 'Ramesh Patel', 'Manager', '9345612789', 'Mumbai'),
(6, 'Divya Rao', 'Executive', '9212345678', 'Surat'),
(7, 'Ajay Mehta', 'Cleaner', '9365478910', 'Bhopal'),
(8, 'Pooja Iyer', 'Technician', '9645378123', 'Pune'),
(9, 'Kunal Deshmukh', 'Manager', '9564738123', 'Jaipur'),
(10, 'Meena Pillai', 'Executive', '9898123456', 'Kochi');

-- ------------------------------------------------ 8th Database --------------------------------------------------------
-- create a database
CREATE DATABASE PoliceFIRDB;

-- use the created database
USE PoliceFIRDB;

-- Table 1: Citizens
CREATE TABLE Citizens (
    CitizenID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO Citizens VALUES
(1, 'Amit Sharma', 34, 'Male', 'Delhi'),
(2, 'Sneha Iyer', 28, 'Female', 'Chennai'),
(3, 'Rahul Verma', 41, 'Male', 'Lucknow'),
(4, 'Pooja Desai', 36, 'Female', 'Ahmedabad'),
(5, 'Karan Mehta', 30, 'Male', 'Mumbai'),
(6, 'Meera Patel', 27, 'Female', 'Surat'),
(7, 'Ravi Yadav', 39, 'Male', 'Bhopal'),
(8, 'Neha Joshi', 25, 'Female', 'Pune'),
(9, 'Arjun Singh', 32, 'Male', 'Jaipur'),
(10, 'Divya Nair', 29, 'Female', 'Kochi');

-- Table 2: PoliceStations
CREATE TABLE PoliceStations (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ContactNumber VARCHAR(15)
);

INSERT INTO PoliceStations VALUES
(1, 'Connaught Place PS', 'Delhi', 'Delhi', '9876543210'),
(2, 'T Nagar PS', 'Chennai', 'Tamil Nadu', '9123456789'),
(3, 'Hazratganj PS', 'Lucknow', 'Uttar Pradesh', '9988776655'),
(4, 'Navrangpura PS', 'Ahmedabad', 'Gujarat', '9876512345'),
(5, 'Andheri PS', 'Mumbai', 'Maharashtra', '9123451122'),
(6, 'Athwalines PS', 'Surat', 'Gujarat', '9345678912'),
(7, 'MP Nagar PS', 'Bhopal', 'Madhya Pradesh', '9456712390'),
(8, 'Shivaji Nagar PS', 'Pune', 'Maharashtra', '9321098765'),
(9, 'Malviya Nagar PS', 'Jaipur', 'Rajasthan', '9867543210'),
(10, 'Marine Drive PS', 'Kochi', 'Kerala', '9745612389');


-- Table 3: FIRs
CREATE TABLE FIRs (
    FIRID INT PRIMARY KEY,
    CitizenID INT,
    StationID INT,
    DateOfReport DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CitizenID) REFERENCES Citizens(CitizenID),
    FOREIGN KEY (StationID) REFERENCES PoliceStations(StationID)
);

INSERT INTO FIRs VALUES
(1, 1, 1, '2024-05-01', 'Open'),
(2, 2, 2, '2024-05-02', 'Closed'),
(3, 3, 3, '2024-05-03', 'Open'),
(4, 4, 4, '2024-05-04', 'Investigating'),
(5, 5, 5, '2024-05-05', 'Closed'),
(6, 6, 6, '2024-05-06', 'Open'),
(7, 7, 7, '2024-05-07', 'Closed'),
(8, 8, 8, '2024-05-08', 'Open'),
(9, 9, 9, '2024-05-09', 'Investigating'),
(10, 10, 10, '2024-05-10', 'Closed');


-- Table 4: CriminalDetails
CREATE TABLE CrimeDetails (
    CrimeID INT PRIMARY KEY,
    FIRID INT,
    CrimeType VARCHAR(50),
    Location VARCHAR(100),
    Description TEXT,
    FOREIGN KEY (FIRID) REFERENCES FIRs(FIRID)
);

INSERT INTO CrimeDetails VALUES
(1, 1, 'Theft', 'Karol Bagh, Delhi', 'Mobile stolen from car.'),
(2, 2, 'Assault', 'T Nagar, Chennai', 'Street fight with injuries.'),
(3, 3, 'Burglary', 'Aliganj, Lucknow', 'Home broken into at night.'),
(4, 4, 'Fraud', 'CG Road, Ahmedabad', 'Online transaction scam.'),
(5, 5, 'Robbery', 'Andheri East, Mumbai', 'Snatching at traffic signal.'),
(6, 6, 'Cyber Crime', 'Ghod Dod Rd, Surat', 'Email account hacked.'),
(7, 7, 'Kidnapping', 'Zone 2, Bhopal', 'Minor missing from school.'),
(8, 8, 'Domestic Violence', 'Aundh, Pune', 'Complaint by wife.'),
(9, 9, 'Hit and Run', 'C-Scheme, Jaipur', 'Unknown car hit a pedestrian.'),
(10, 10, 'Stalking', 'Fort Kochi', 'Repeated following and threats.');


-- Table 5: Officers
CREATE TABLE Officers (
    OfficerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Rank VARCHAR(50),
    StationID INT,
    Phone VARCHAR(15),
    FOREIGN KEY (StationID) REFERENCES PoliceStations(StationID)
);

INSERT INTO Officers VALUES
(1, 'Rajeev Kumar', 'Inspector', 1, '9811122233'),
(2, 'Meena Iyer', 'Sub-Inspector', 2, '9822233445'),
(3, 'Suraj Mishra', 'Inspector', 3, '9833344556'),
(4, 'Anita Shah', 'Constable', 4, '9844455667'),
(5, 'Ramesh Pawar', 'Inspector', 5, '9855566778'),
(6, 'Pooja Patel', 'Sub-Inspector', 6, '9866677889'),
(7, 'Sanjay Yadav', 'Constable', 7, '9877788990'),
(8, 'Neha Kulkarni', 'Inspector', 8, '9888899001'),
(9, 'Arvind Singh', 'Sub-Inspector', 9, '9899900112'),
(10, 'Divya Menon', 'Constable', 10, '9900011223');


-- ------------------------------------------------ 9th Database --------------------------------------------------------
-- create a database
CREATE DATABASE LicensePermitDB;

-- use the created database
USE LicensePermitDB;

-- Table 1: Applicants
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO Applicants VALUES
(1, 'Amit Sharma', 30, 'Male', 'Delhi'),
(2, 'Sneha Iyer', 28, 'Female', 'Chennai'),
(3, 'Rahul Verma', 35, 'Male', 'Lucknow'),
(4, 'Pooja Desai', 32, 'Female', 'Ahmedabad'),
(5, 'Karan Mehta', 29, 'Male', 'Mumbai'),
(6, 'Meera Patel', 27, 'Female', 'Surat'),
(7, 'Ravi Yadav', 38, 'Male', 'Bhopal'),
(8, 'Neha Joshi', 26, 'Female', 'Pune'),
(9, 'Arjun Singh', 31, 'Male', 'Jaipur'),
(10, 'Divya Nair', 30, 'Female', 'Kochi');

-- Table 2: Offices
CREATE TABLE Offices (
    OfficeID INT PRIMARY KEY,
    OfficeName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ContactNumber VARCHAR(15)
);

INSERT INTO Offices VALUES
(1, 'Delhi RTO', 'Delhi', 'Delhi', '9811122233'),
(2, 'Chennai RTO', 'Chennai', 'Tamil Nadu', '9822233445'),
(3, 'Lucknow RTO', 'Lucknow', 'Uttar Pradesh', '9833344556'),
(4, 'Ahmedabad RTO', 'Ahmedabad', 'Gujarat', '9844455667'),
(5, 'Mumbai RTO', 'Mumbai', 'Maharashtra', '9855566778'),
(6, 'Surat RTO', 'Surat', 'Gujarat', '9866677889'),
(7, 'Bhopal RTO', 'Bhopal', 'Madhya Pradesh', '9877788990'),
(8, 'Pune RTO', 'Pune', 'Maharashtra', '9888899001'),
(9, 'Jaipur RTO', 'Jaipur', 'Rajasthan', '9899900112'),
(10, 'Kochi RTO', 'Kochi', 'Kerala', '9900011223');

-- Table 3: Applications
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    ApplicantID INT,
    OfficeID INT,
    ApplicationDate DATE,
    Type VARCHAR(30),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID),
    FOREIGN KEY (OfficeID) REFERENCES Offices(OfficeID)
);

INSERT INTO Applications VALUES
(1, 1, 1, '2024-05-01', 'Driving License'),
(2, 2, 2, '2024-05-02', 'Vehicle Permit'),
(3, 3, 3, '2024-05-03', 'Business License'),
(4, 4, 4, '2024-05-04', 'Driving License'),
(5, 5, 5, '2024-05-05', 'Shop Permit'),
(6, 6, 6, '2024-05-06', 'Driving License'),
(7, 7, 7, '2024-05-07', 'Vehicle Permit'),
(8, 8, 8, '2024-05-08', 'Business License'),
(9, 9, 9, '2024-05-09', 'Driving License'),
(10, 10, 10, '2024-05-10', 'Shop Permit');

-- Table 4: Licenses
CREATE TABLE Licenses (
    LicenseID INT PRIMARY KEY,
    ApplicationID INT,
    IssueDate DATE,
    ExpiryDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

INSERT INTO Licenses VALUES
(1, 1, '2024-05-05', '2029-05-05', 'Active'),
(2, 2, '2024-05-06', '2026-05-06', 'Active'),
(3, 3, '2024-05-07', '2025-05-07', 'Pending'),
(4, 4, '2024-05-08', '2029-05-08', 'Active'),
(5, 5, '2024-05-09', '2026-05-09', 'Suspended'),
(6, 6, '2024-05-10', '2029-05-10', 'Active'),
(7, 7, '2024-05-11', '2026-05-11', 'Revoked'),
(8, 8, '2024-05-12', '2025-05-12', 'Active'),
(9, 9, '2024-05-13', '2029-05-13', 'Active'),
(10, 10, '2024-05-14', '2026-05-14', 'Pending');

-- Table 5: Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    ApplicationID INT,
    Amount DECIMAL(7,2),
    PaymentDate DATE,
    PaymentMode VARCHAR(20),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

INSERT INTO Payments VALUES
(1, 1, 500.00, '2024-05-01', 'UPI'),
(2, 2, 1500.00, '2024-05-02', 'Cash'),
(3, 3, 2000.00, '2024-05-03', 'Card'),
(4, 4, 500.00, '2024-05-04', 'UPI'),
(5, 5, 1000.00, '2024-05-05', 'Card'),
(6, 6, 500.00, '2024-05-06', 'Cash'),
(7, 7, 1500.00, '2024-05-07', 'UPI'),
(8, 8, 2000.00, '2024-05-08', 'Card'),
(9, 9, 500.00, '2024-05-09', 'Cash'),
(10, 10, 1000.00, '2024-05-10', 'UPI');

-- ------------------------------------------------ 10th Database --------------------------------------------------------
-- create a database
CREATE DATABASE TrainBookingDB;

-- use the created database
USE TrainBookingDB;

-- Table 1: Passengers
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO Passengers VALUES
(1, 'Amit Sharma', 34, 'Male', 'Delhi'),
(2, 'Sneha Iyer', 28, 'Female', 'Chennai'),
(3, 'Rahul Verma', 41, 'Male', 'Lucknow'),
(4, 'Pooja Desai', 36, 'Female', 'Ahmedabad'),
(5, 'Karan Mehta', 30, 'Male', 'Mumbai'),
(6, 'Meera Patel', 27, 'Female', 'Surat'),
(7, 'Ravi Yadav', 39, 'Male', 'Bhopal'),
(8, 'Neha Joshi', 25, 'Female', 'Pune'),
(9, 'Arjun Singh', 32, 'Male', 'Jaipur'),
(10, 'Divya Nair', 29, 'Female', 'Kochi');

-- Table 2: Trains
CREATE TABLE Trains (
    TrainID INT PRIMARY KEY,
    TrainName VARCHAR(100),
    Source VARCHAR(50),
    Destination VARCHAR(50),
    Capacity INT
);

INSERT INTO Trains VALUES
(1, 'Rajdhani Express', 'Delhi', 'Mumbai', 800),
(2, 'Chennai Express', 'Chennai', 'Delhi', 750),
(3, 'Lucknow Mail', 'Lucknow', 'Kolkata', 700),
(4, 'Saurashtra Express', 'Ahmedabad', 'Mumbai', 650),
(5, 'Konkan Kanya', 'Mumbai', 'Goa', 500),
(6, 'Gujarat Mail', 'Surat', 'Delhi', 600),
(7, 'Shatabdi Express', 'Bhopal', 'Delhi', 800),
(8, 'Deccan Queen', 'Pune', 'Mumbai', 700),
(9, 'Jaipur Express', 'Jaipur', 'Chennai', 720),
(10, 'Kerala Express', 'Kochi', 'Delhi', 750);
 
 -- Table 3: Bookings
 CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    PassengerID INT,
    TrainID INT,
    BookingDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);

INSERT INTO Bookings VALUES
(1, 1, 1, '2024-05-01', 'Confirmed'),
(2, 2, 2, '2024-05-02', 'Confirmed'),
(3, 3, 3, '2024-05-03', 'Pending'),
(4, 4, 4, '2024-05-04', 'Confirmed'),
(5, 5, 5, '2024-05-05', 'Cancelled'),
(6, 6, 6, '2024-05-06', 'Confirmed'),
(7, 7, 7, '2024-05-07', 'Pending'),
(8, 8, 8, '2024-05-08', 'Confirmed'),
(9, 9, 9, '2024-05-09', 'Confirmed'),
(10, 10, 10, '2024-05-10', 'Cancelled');

-- Table 4: Schedules
CREATE TABLE Schedules (
    ScheduleID INT PRIMARY KEY,
    TrainID INT,
    DepartureTime TIME,
    ArrivalTime TIME,
    TravelDate DATE,
    FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);

INSERT INTO Schedules VALUES
(1, 1, '08:00:00', '20:00:00', '2024-06-01'),
(2, 2, '07:30:00', '22:00:00', '2024-06-02'),
(3, 3, '09:15:00', '18:30:00', '2024-06-03'),
(4, 4, '06:00:00', '15:45:00', '2024-06-04'),
(5, 5, '10:00:00', '18:00:00', '2024-06-05'),
(6, 6, '07:00:00', '21:00:00', '2024-06-06'),
(7, 7, '05:30:00', '13:30:00', '2024-06-07'),
(8, 8, '11:00:00', '15:00:00', '2024-06-08'),
(9, 9, '08:30:00', '23:00:00', '2024-06-09'),
(10, 10, '09:00:00', '22:00:00', '2024-06-10');

-- Table 5: Train_classes
CREATE TABLE Train_Classes (
    ClassID INT PRIMARY KEY,
    TrainID INT,
    ClassName VARCHAR(50),
    TotalSeats INT,
    Fare DECIMAL(7,2),
    FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);

INSERT INTO Train_Classes VALUES
(1, 1, 'AC First Class', 50, 2500.00),
(2, 1, 'Sleeper', 400, 800.00),
(3, 2, 'AC 2 Tier', 70, 1800.00),
(4, 2, 'Sleeper', 350, 750.00),
(5, 3, 'AC 3 Tier', 80, 1500.00),
(6, 4, 'AC Chair Car', 100, 1000.00),
(7, 5, 'Sleeper', 200, 650.00),
(8, 6, 'AC 2 Tier', 60, 1600.00),
(9, 7, 'AC First Class', 40, 2800.00),
(10, 8, 'Sleeper', 300, 700.00);

-- ------------------------------------------------ 11th Database --------------------------------------------------------
-- create a database
CREATE DATABASE OldAgeHomeDB;

-- use the created database
USE OldAgeHomeDB;

-- Table 1: Residents
CREATE TABLE Residents (
    ResidentID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO Residents VALUES
(1, 'Ram Kumar', 72, 'Male', 'Delhi'),
(2, 'Savita Joshi', 68, 'Female', 'Pune'),
(3, 'Harish Mehta', 75, 'Male', 'Ahmedabad'),
(4, 'Leela Nair', 70, 'Female', 'Kochi'),
(5, 'Om Prakash', 80, 'Male', 'Lucknow'),
(6, 'Radha Desai', 69, 'Female', 'Mumbai'),
(7, 'Ramesh Singh', 73, 'Male', 'Bhopal'),
(8, 'Kamala Devi', 77, 'Female', 'Chennai'),
(9, 'Bhagat Lal', 74, 'Male', 'Jaipur'),
(10, 'Sita Rani', 71, 'Female', 'Nagpur');

-- Table 2: Medical_Records
CREATE TABLE Medical_Records (
    RecordID INT PRIMARY KEY,
    ResidentID INT,
    CheckupDate DATE,
    HealthIssue VARCHAR(100),
    DoctorName VARCHAR(100),
    FOREIGN KEY (ResidentID) REFERENCES Residents(ResidentID)
);

INSERT INTO Medical_Records VALUES
(1, 1, '2024-05-01', 'Diabetes', 'Dr. Anil Kapoor'),
(2, 2, '2024-05-03', 'Blood Pressure', 'Dr. Meena Rao'),
(3, 3, '2024-05-05', 'Arthritis', 'Dr. Vivek Shah'),
(4, 4, '2024-05-07', 'Heart Issue', 'Dr. Suresh Reddy'),
(5, 5, '2024-05-09', 'Vision Loss', 'Dr. Namrata Iyer'),
(6, 6, '2024-05-11', 'Hearing Loss', 'Dr. Nikhil Jain'),
(7, 7, '2024-05-13', 'Diabetes', 'Dr. Anil Kapoor'),
(8, 8, '2024-05-15', 'Joint Pain', 'Dr. Meena Rao'),
(9, 9, '2024-05-17', 'Back Pain', 'Dr. Vivek Shah'),
(10, 10, '2024-05-19', 'Memory Loss', 'Dr. Suresh Reddy');


-- Table 3: Staffs:
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Role VARCHAR(50),
    ShiftTime VARCHAR(20),
    ContactNumber VARCHAR(15)
);

INSERT INTO Staff VALUES
(1, 'Sunita Mishra', 'Nurse', 'Morning', '9876543210'),
(2, 'Rajeev Kumar', 'Cook', 'Morning', '9898989898'),
(3, 'Neelam Shah', 'Cleaner', 'Evening', '9765432109'),
(4, 'Manoj Joshi', 'Security', 'Night', '9123456780'),
(5, 'Pallavi Rao', 'Nurse', 'Evening', '9112233445'),
(6, 'Vikram Singh', 'Manager', 'Full Day', '9001122334'),
(7, 'Geeta Patel', 'Helper', 'Morning', '9898223344'),
(8, 'Arun Bansal', 'Cook', 'Evening', '9011223344'),
(9, 'Shalini Roy', 'Cleaner', 'Morning', '9344556677'),
(10, 'Deepak Nair', 'Security', 'Night', '9654321098');
 
 -- Table 4: Rooms 
 CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomNumber VARCHAR(10),
    Floor INT,
    Capacity INT,
    Occupied INT
);

INSERT INTO Rooms VALUES
(1, 'A101', 1, 2, 2),
(2, 'A102', 1, 2, 1),
(3, 'B201', 2, 3, 2),
(4, 'B202', 2, 2, 2),
(5, 'C301', 3, 1, 1),
(6, 'C302', 3, 2, 0),
(7, 'D401', 4, 2, 1),
(8, 'D402', 4, 3, 3),
(9, 'E501', 5, 2, 2),
(10, 'E502', 5, 1, 0);

-- Table 5: Room_Assignments
CREATE TABLE Room_Assignments (
    AssignmentID INT PRIMARY KEY,
    ResidentID INT,
    RoomID INT,
    AssignedDate DATE,
    BedNumber INT,
    FOREIGN KEY (ResidentID) REFERENCES Residents(ResidentID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

INSERT INTO Room_Assignments VALUES
(1, 1, 1, '2024-04-01', 1),
(2, 2, 1, '2024-04-01', 2),
(3, 3, 2, '2024-04-05', 1),
(4, 4, 3, '2024-04-10', 1),
(5, 5, 3, '2024-04-10', 2),
(6, 6, 4, '2024-04-15', 1),
(7, 7, 4, '2024-04-15', 2),
(8, 8, 5, '2024-04-20', 1),
(9, 9, 7, '2024-04-25', 1),
(10, 10, 9, '2024-04-30', 1);

-- ------------------------------------------------ 12th Database --------------------------------------------------------
-- create a database
CREATE DATABASE ProductReviewDB;

-- use the created database
USE ProductReviewDB;

-- Table 1: Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Gender VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO Users VALUES
(1, 'Aman Singh', 'aman@gmail.com', 'Male', 'Delhi'),
(2, 'Neha Verma', 'neha@gmail.com', 'Female', 'Mumbai'),
(3, 'Ravi Kumar', 'ravi@gmail.com', 'Male', 'Patna'),
(4, 'Pooja Shah', 'pooja@gmail.com', 'Female', 'Ahmedabad'),
(5, 'Arjun Yadav', 'arjun@gmail.com', 'Male', 'Lucknow'),
(6, 'Meena Iyer', 'meena@gmail.com', 'Female', 'Chennai'),
(7, 'Sahil Jain', 'sahil@gmail.com', 'Male', 'Jaipur'),
(8, 'Ankita Rao', 'ankita@gmail.com', 'Female', 'Hyderabad'),
(9, 'Vikram Joshi', 'vikram@gmail.com', 'Male', 'Pune'),
(10, 'Divya Nair', 'divya@gmail.com', 'Female', 'Kochi');

-- Table 2: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Price DECIMAL(8,2)
);

INSERT INTO Products VALUES
(1, 'Samsung Galaxy M14', 'Mobile', 'Samsung', 13999.00),
(2, 'Redmi Note 13', 'Mobile', 'Redmi', 15999.00),
(3, 'HP Laptop 15s', 'Laptop', 'HP', 45999.00),
(4, 'Sony Headphones', 'Audio', 'Sony', 2999.00),
(5, 'boAt Smartwatch', 'Wearable', 'boAt', 1999.00),
(6, 'Canon Printer', 'Electronics', 'Canon', 7499.00),
(7, 'OnePlus Nord CE', 'Mobile', 'OnePlus', 24999.00),
(8, 'Samsung LED TV', 'TV', 'Samsung', 32999.00),
(9, 'MI Router 4A', 'Networking', 'Xiaomi', 1299.00),
(10, 'Dell Inspiron 14', 'Laptop', 'Dell', 55999.00);

-- Table 3: Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    ReviewText VARCHAR(255),
    ReviewDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Reviews VALUES
(1, 1, 1, 'Great phone at this price!', '2024-05-01'),
(2, 2, 2, 'Smooth performance and camera.', '2024-05-02'),
(3, 3, 3, 'Good for basic tasks.', '2024-05-03'),
(4, 4, 4, 'Sound quality is awesome.', '2024-05-04'),
(5, 5, 5, 'Affordable and accurate.', '2024-05-05'),
(6, 6, 6, 'Setup was easy and fast.', '2024-05-06'),
(7, 7, 7, 'Battery life is excellent.', '2024-05-07'),
(8, 8, 8, 'Crystal clear display.', '2024-05-08'),
(9, 9, 9, 'Covers large area easily.', '2024-05-09'),
(10, 10, 10, 'Perfect for office work.', '2024-05-10');

-- Table 4: Ratings
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    RatingValue INT,
    RatingDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Ratings VALUES
(1, 1, 1, 5, '2024-05-01'),
(2, 2, 2, 4, '2024-05-02'),
(3, 3, 3, 3, '2024-05-03'),
(4, 4, 4, 5, '2024-05-04'),
(5, 5, 5, 4, '2024-05-05'),
(6, 6, 6, 4, '2024-05-06'),
(7, 7, 7, 5, '2024-05-07'),
(8, 8, 8, 5, '2024-05-08'),
(9, 9, 9, 4, '2024-05-09'),
(10, 10, 10, 5, '2024-05-10');

-- Table 5: Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    Description VARCHAR(100),
    PopularityLevel VARCHAR(20),
    ProductCount INT
);

INSERT INTO Categories VALUES
(1, 'Mobile', 'Smartphones and mobiles', 'High', 3),
(2, 'Laptop', 'Computing devices', 'Medium', 2),
(3, 'Audio', 'Headphones, Speakers', 'Medium', 1),
(4, 'Wearable', 'Smart watches, Bands', 'Medium', 1),
(5, 'Electronics', 'Printers and accessories', 'Low', 1),
(6, 'TV', 'Smart LED TVs', 'Medium', 1),
(7, 'Networking', 'Routers and switches', 'Low', 1),
(8, 'Home Appliances', 'Fridges, ACs', 'Low', 0),
(9, 'Camera', 'DSLR and Mirrorless', 'Low', 0),
(10, 'Accessories', 'Cables, Power banks', 'Medium', 0);

-- ------------------------------------------------ 13th Database --------------------------------------------------------
-- create a database
CREATE DATABASE MarriageHallDB;

-- use the created database
USE MarriageHallDB;

-- Table 1: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Rajesh Sharma', 'rajesh@gmail.com', '9876543210', 'Delhi'),
(2, 'Neha Rani', 'neha@gmail.com', '9876543211', 'Patna'),
(3, 'Amit Kumar', 'amit@gmail.com', '9876543212', 'Lucknow'),
(4, 'Pooja Joshi', 'pooja@gmail.com', '9876543213', 'Indore'),
(5, 'Suresh Yadav', 'suresh@gmail.com', '9876543214', 'Kanpur'),
(6, 'Anjali Mehra', 'anjali@gmail.com', '9876543215', 'Jaipur'),
(7, 'Rohit Gupta', 'rohit@gmail.com', '9876543216', 'Bhopal'),
(8, 'Kavita Iyer', 'kavita@gmail.com', '9876543217', 'Chennai'),
(9, 'Vikas Singh', 'vikas@gmail.com', '9876543218', 'Ranchi'),
(10, 'Divya Nair', 'divya@gmail.com', '9876543219', 'Mumbai');

-- Table 2: Halls
CREATE TABLE Halls (
    HallID INT PRIMARY KEY,
    HallName VARCHAR(100),
    Location VARCHAR(100),
    Capacity INT,
    ACAvailable VARCHAR(10)
);

INSERT INTO Halls VALUES
(1, 'Shubham Hall', 'Delhi', 300, 'Yes'),
(2, 'Mangal Palace', 'Patna', 250, 'No'),
(3, 'Golden Venue', 'Lucknow', 400, 'Yes'),
(4, 'Royal Paradise', 'Indore', 350, 'Yes'),
(5, 'Sanskriti Banquet', 'Kanpur', 200, 'No'),
(6, 'Galaxy Hall', 'Jaipur', 500, 'Yes'),
(7, 'Diamond Hall', 'Bhopal', 280, 'Yes'),
(8, 'Pearl Banquet', 'Chennai', 220, 'No'),
(9, 'Sunshine Garden', 'Ranchi', 450, 'Yes'),
(10, 'Emerald Venue', 'Mumbai', 320, 'Yes');

-- Table 3: Bookings
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    HallID INT,
    BookingDate DATE,
    EventDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (HallID) REFERENCES Halls(HallID)
);

INSERT INTO Bookings VALUES
(1, 1, 1, '2024-05-01', '2024-06-10'),
(2, 2, 2, '2024-05-03', '2024-06-12'),
(3, 3, 3, '2024-05-05', '2024-06-15'),
(4, 4, 4, '2024-05-07', '2024-06-18'),
(5, 5, 5, '2024-05-09', '2024-06-20'),
(6, 6, 6, '2024-05-11', '2024-06-25'),
(7, 7, 7, '2024-05-13', '2024-06-28'),
(8, 8, 8, '2024-05-15', '2024-07-01'),
(9, 9, 9, '2024-05-17', '2024-07-03'),
(10, 10, 10, '2024-05-19', '2024-07-05');

-- Table 4: Catering
CREATE TABLE Catering (
    CateringID INT PRIMARY KEY,
    BookingID INT,
    MenuType VARCHAR(50),
    Guests INT,
    VendorName VARCHAR(100),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

INSERT INTO Catering VALUES
(1, 1, 'Vegetarian', 300, 'Sharma Caterers'),
(2, 2, 'Non-Vegetarian', 250, 'Taste Point'),
(3, 3, 'Mixed', 400, 'Royal Cuisine'),
(4, 4, 'Vegetarian', 350, 'Annapurna Services'),
(5, 5, 'Vegetarian', 200, 'Green Leaf'),
(6, 6, 'Mixed', 500, 'Food Fiesta'),
(7, 7, 'Vegetarian', 280, 'Ghar Ka Khana'),
(8, 8, 'Non-Vegetarian', 220, 'Spice Route'),
(9, 9, 'Mixed', 450, 'Swaad Caterers'),
(10, 10, 'Vegetarian', 320, 'Delight Foods');

-- Table 5: Decorations
CREATE TABLE Decoration (
    DecorID INT PRIMARY KEY,
    BookingID INT,
    Theme VARCHAR(100),
    FlowerType VARCHAR(50),
    DecoratorName VARCHAR(100),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

INSERT INTO Decoration VALUES
(1, 1, 'Royal Red', 'Roses', 'Elegant Events'),
(2, 2, 'Traditional', 'Marigold', 'Classic Decor'),
(3, 3, 'Modern Minimal', 'Orchids', 'Urban Decor'),
(4, 4, 'Floral Fusion', 'Mix', 'Rainbow Events'),
(5, 5, 'Simple South', 'Jasmine', 'Grace Decor'),
(6, 6, 'Royal Gold', 'Roses', 'Golden Hands'),
(7, 7, 'Rustic Theme', 'Tulips', 'Decorwale'),
(8, 8, 'Purple Night', 'Lavender', 'Glow Eventz'),
(9, 9, 'Bollywood Glam', 'Mix', 'Filmy Weddings'),
(10, 10, 'Pink Elegance', 'Lilies', 'Dream Decorators');

-- ------------------------------------------------ 14th Database --------------------------------------------------------
-- create a database
CREATE DATABASE LabEquipmentDB;

-- use the created database
USE LabEquipmentDB;

-- Table 1: Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Phone VARCHAR(15)
);

INSERT INTO Users VALUES
(1, 'Rohit Sharma', 'rohit.sharma@gmail.com', 'Physics', '9876543210'),
(2, 'Neha Singh', 'neha.singh@gmail.com', 'Chemistry', '9876543211'),
(3, 'Amit Kumar', 'amit.kumar@gmail.com', 'Biology', '9876543212'),
(4, 'Pooja Joshi', 'pooja.joshi@gmail.com', 'Physics', '9876543213'),
(5, 'Suresh Yadav', 'suresh.yadav@gmail.com', 'Chemistry', '9876543214'),
(6, 'Anjali Mehra', 'anjali.mehra@gmail.com', 'Biology', '9876543215'),
(7, 'Vikas Jain', 'vikas.jain@gmail.com', 'Physics', '9876543216'),
(8, 'Kavita Iyer', 'kavita.iyer@gmail.com', 'Chemistry', '9876543217'),
(9, 'Vikram Patel', 'vikram.patel@gmail.com', 'Biology', '9876543218'),
(10, 'Divya Nair', 'divya.nair@gmail.com', 'Physics', '9876543219');

-- Table 2: Equipment
CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY,
    EquipmentName VARCHAR(100),
    Department VARCHAR(50),
    Quantity INT,
    Condition VARCHAR(50)
);

INSERT INTO Equipment VALUES
(1, 'Microscope', 'Biology', 15, 'Good'),
(2, 'Bunsen Burner', 'Chemistry', 20, 'Excellent'),
(3, 'Centrifuge', 'Biology', 5, 'Good'),
(4, 'Spectrometer', 'Physics', 7, 'Fair'),
(5, 'Beaker Set', 'Chemistry', 30, 'Good'),
(6, 'Thermometer', 'Physics', 10, 'Excellent'),
(7, 'Test Tube Rack', 'Chemistry', 25, 'Good'),
(8, 'pH Meter', 'Chemistry', 8, 'Fair'),
(9, 'Petri Dish', 'Biology', 50, 'Good'),
(10, 'Voltmeter', 'Physics', 5, 'Good');

-- Table 3: Bookings
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    UserID INT,
    EquipmentID INT,
    BookingDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

INSERT INTO Bookings VALUES
(1, 1, 1, '2024-05-01', '2024-05-05'),
(2, 2, 2, '2024-05-02', '2024-05-04'),
(3, 3, 3, '2024-05-03', '2024-05-07'),
(4, 4, 4, '2024-05-04', '2024-05-06'),
(5, 5, 5, '2024-05-05', '2024-05-10'),
(6, 6, 6, '2024-05-06', '2024-05-09'),
(7, 7, 7, '2024-05-07', '2024-05-08'),
(8, 8, 8, '2024-05-08', '2024-05-12'),
(9, 9, 9, '2024-05-09', '2024-05-15'),
(10, 10, 10, '2024-05-10', '2024-05-13');

-- Table 4: Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    HeadName VARCHAR(100),
    OfficeNumber VARCHAR(20),
    ContactEmail VARCHAR(100)
);

INSERT INTO Departments VALUES
(1, 'Physics', 'Dr. Ramesh Gupta', 'Ph-101', 'physics@college.edu'),
(2, 'Chemistry', 'Dr. Sunita Sharma', 'Ch-102', 'chemistry@college.edu'),
(3, 'Biology', 'Dr. Anil Mehta', 'Bio-103', 'biology@college.edu'),
(4, 'Mathematics', 'Dr. Priya Singh', 'Math-104', 'math@college.edu'),
(5, 'Computer Science', 'Dr. Arjun Rao', 'CS-105', 'cs@college.edu'),
(6, 'English', 'Dr. Kavita Joshi', 'Eng-106', 'english@college.edu'),
(7, 'History', 'Dr. Mohan Verma', 'Hist-107', 'history@college.edu'),
(8, 'Geography', 'Dr. Suresh Patel', 'Geo-108', 'geo@college.edu'),
(9, 'Physics Lab', 'Mr. Rajesh Kumar', 'PhLab-109', 'phylab@college.edu'),
(10, 'Chemistry Lab', 'Ms. Neha Singh', 'ChLab-110', 'chemlab@college.edu');

-- Table 5: EquipmentMaintenance
CREATE TABLE EquipmentMaintenance (
    MaintenanceID INT PRIMARY KEY,
    EquipmentID INT,
    MaintenanceDate DATE,
    TechnicianName VARCHAR(100),
    Remarks VARCHAR(255),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

INSERT INTO EquipmentMaintenance VALUES
(1, 1, '2024-04-01', 'Rakesh Sharma', 'Routine checkup'),
(2, 2, '2024-03-15', 'Sunil Verma', 'Replaced burner nozzle'),
(3, 3, '2024-04-10', 'Pankaj Singh', 'Lubricated motor'),
(4, 4, '2024-04-05', 'Suresh Kumar', 'Calibrated sensors'),
(5, 5, '2024-03-20', 'Anil Jain', 'Replaced glass beakers'),
(6, 6, '2024-04-12', 'Karan Mehta', 'Thermometer repaired'),
(7, 7, '2024-04-15', 'Deepak Shah', 'Cleaned racks'),
(8, 8, '2024-03-25', 'Amit Patel', 'pH meter battery changed'),
(9, 9, '2024-04-08', 'Vikram Joshi', 'Petri dish sterilized'),
(10, 10, '2024-03-30', 'Sanjay Rao', 'Voltmeter wiring fixed');

-- ------------------------------------------------ 15th Database --------------------------------------------------------
-- create a database
CREATE DATABASE LibraryFineDB;

-- use the created database
USE LibraryFineDB;

-- Table 1: Members
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    MembershipDate DATE
);

INSERT INTO Members VALUES
(1, 'Rajesh Kumar', 'rajesh.kumar@gmail.com', '9876543210', '2023-01-15'),
(2, 'Neha Sharma', 'neha.sharma@gmail.com', '9876543211', '2023-02-20'),
(3, 'Amit Singh', 'amit.singh@gmail.com', '9876543212', '2023-03-18'),
(4, 'Pooja Joshi', 'pooja.joshi@gmail.com', '9876543213', '2023-04-12'),
(5, 'Suresh Yadav', 'suresh.yadav@gmail.com', '9876543214', '2023-05-10'),
(6, 'Anjali Mehra', 'anjali.mehra@gmail.com', '9876543215', '2023-06-25'),
(7, 'Vikas Jain', 'vikas.jain@gmail.com', '9876543216', '2023-07-30'),
(8, 'Kavita Iyer', 'kavita.iyer@gmail.com', '9876543217', '2023-08-05'),
(9, 'Vikram Patel', 'vikram.patel@gmail.com', '9876543218', '2023-09-15'),
(10, 'Divya Nair', 'divya.nair@gmail.com', '9876543219', '2023-10-22');

-- Table 2: Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150),
    Author VARCHAR(100),
    Publisher VARCHAR(100),
    Copies INT
);

INSERT INTO Books VALUES
(1, 'Introduction to Algorithms', 'Thomas H. Cormen', 'MIT Press', 5),
(2, 'Database System Concepts', 'Abraham Silberschatz', 'McGraw-Hill', 4),
(3, 'Operating System Concepts', 'Abraham Silberschatz', 'Wiley', 3),
(4, 'Computer Networks', 'Andrew S. Tanenbaum', 'Pearson', 6),
(5, 'Data Structures and Algorithms', 'Narasimha Karumanchi', 'CareerMonk', 7),
(6, 'Artificial Intelligence', 'Stuart Russell', 'Pearson', 2),
(7, 'Machine Learning', 'Tom M. Mitchell', 'McGraw-Hill', 3),
(8, 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 5),
(9, 'Java: The Complete Reference', 'Herbert Schildt', 'McGraw-Hill', 4),
(10, 'Python Programming', 'John Zelle', 'Franklin Beedle', 6);

-- Table 3: BorrowRecords
CREATE TABLE BorrowRecords (
    BorrowID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    BorrowDate DATE,
    DueDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO BorrowRecords VALUES
(1, 1, 1, '2024-04-01', '2024-04-15'),
(2, 2, 2, '2024-04-02', '2024-04-16'),
(3, 3, 3, '2024-04-03', '2024-04-17'),
(4, 4, 4, '2024-04-04', '2024-04-18'),
(5, 5, 5, '2024-04-05', '2024-04-19'),
(6, 6, 6, '2024-04-06', '2024-04-20'),
(7, 7, 7, '2024-04-07', '2024-04-21'),
(8, 8, 8, '2024-04-08', '2024-04-22'),
(9, 9, 9, '2024-04-09', '2024-04-23'),
(10, 10, 10, '2024-04-10', '2024-04-24');

-- Table 4: Returns
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    BorrowID INT,
    ReturnDate DATE,
    LateDays INT,
    FineAmount DECIMAL(6,2),
    FOREIGN KEY (BorrowID) REFERENCES BorrowRecords(BorrowID)
);

INSERT INTO Returns VALUES
(1, 1, '2024-04-16', 1, 10.00),
(2, 2, '2024-04-16', 0, 0.00),
(3, 3, '2024-04-19', 2, 20.00),
(4, 4, '2024-04-18', 0, 0.00),
(5, 5, '2024-04-21', 2, 20.00),
(6, 6, '2024-04-22', 2, 20.00),
(7, 7, '2024-04-20', 0, 0.00),
(8, 8, '2024-04-23', 1, 10.00),
(9, 9, '2024-04-25', 2, 20.00),
(10, 10, '2024-04-24', 0, 0.00);

-- Table 5: Librarians
CREATE TABLE Librarians (
    LibrarianID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Shift VARCHAR(20)
);

INSERT INTO Librarians VALUES
(1, 'Ramesh Gupta', 'ramesh.gupta@library.com', '9876543210', 'Morning'),
(2, 'Sunita Sharma', 'sunita.sharma@library.com', '9876543211', 'Evening'),
(3, 'Anil Mehta', 'anil.mehta@library.com', '9876543212', 'Morning'),
(4, 'Priya Singh', 'priya.singh@library.com', '9876543213', 'Evening'),
(5, 'Arjun Rao', 'arjun.rao@library.com', '9876543214', 'Morning'),
(6, 'Kavita Joshi', 'kavita.joshi@library.com', '9876543215', 'Evening'),
(7, 'Mohan Verma', 'mohan.verma@library.com', '9876543216', 'Morning'),
(8, 'Suresh Patel', 'suresh.patel@library.com', '9876543217', 'Evening'),
(9, 'Rajesh Kumar', 'rajesh.kumar@library.com', '9876543218', 'Morning'),
(10, 'Neha Singh', 'neha.singh@library.com', '9876543219', 'Evening');

-- ------------------------------------------------ 16th Database --------------------------------------------------------
-- create a database
CREATE DATABASE WaterSupplyDB;

-- use the created database
USE WaterSupplyDB;

-- Table 1: Residents
CREATE TABLE Residents (
    ResidentID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Address VARCHAR(150),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

INSERT INTO Residents VALUES
(1, 'Rohit Sharma', '123 MG Road, Pune', '9876543210', 'rohit.sharma@gmail.com'),
(2, 'Neha Singh', '45 Park Street, Kolkata', '9876543211', 'neha.singh@gmail.com'),
(3, 'Amit Kumar', '78 MG Road, Bangalore', '9876543212', 'amit.kumar@gmail.com'),
(4, 'Pooja Joshi', '21 MG Road, Pune', '9876543213', 'pooja.joshi@gmail.com'),
(5, 'Suresh Yadav', '9 Park Street, Kolkata', '9876543214', 'suresh.yadav@gmail.com'),
(6, 'Anjali Mehra', '56 MG Road, Bangalore', '9876543215', 'anjali.mehra@gmail.com'),
(7, 'Vikas Jain', '87 Park Street, Kolkata', '9876543216', 'vikas.jain@gmail.com'),
(8, 'Kavita Iyer', '34 MG Road, Pune', '9876543217', 'kavita.iyer@gmail.com'),
(9, 'Vikram Patel', '67 Park Street, Bangalore', '9876543218', 'vikram.patel@gmail.com'),
(10, 'Divya Nair', '12 MG Road, Pune', '9876543219', 'divya.nair@gmail.com');

-- Table 2: WaterSupplyZones
CREATE TABLE WaterSupplyZones (
    ZoneID INT PRIMARY KEY,
    ZoneName VARCHAR(100),
    SupervisorName VARCHAR(100),
    ContactNumber VARCHAR(15),
    AreaCovered VARCHAR(150)
);

INSERT INTO WaterSupplyZones VALUES
(1, 'Zone A', 'Ramesh Gupta', '9123456780', 'Pune Central'),
(2, 'Zone B', 'Sunita Sharma', '9123456781', 'Kolkata North'),
(3, 'Zone C', 'Anil Mehta', '9123456782', 'Bangalore East'),
(4, 'Zone D', 'Priya Singh', '9123456783', 'Pune West'),
(5, 'Zone E', 'Arjun Rao', '9123456784', 'Kolkata South'),
(6, 'Zone F', 'Kavita Joshi', '9123456785', 'Bangalore West'),
(7, 'Zone G', 'Mohan Verma', '9123456786', 'Pune East'),
(8, 'Zone H', 'Suresh Patel', '9123456787', 'Kolkata Central'),
(9, 'Zone I', 'Rajesh Kumar', '9123456788', 'Bangalore North'),
(10, 'Zone J', 'Neha Singh', '9123456789', 'Pune South');

-- Table 3: Complaints
CREATE TABLE Complaints (
    ComplaintID INT PRIMARY KEY,
    ResidentID INT,
    ZoneID INT,
    ComplaintDate DATE,
    Description VARCHAR(255),
    FOREIGN KEY (ResidentID) REFERENCES Residents(ResidentID),
    FOREIGN KEY (ZoneID) REFERENCES WaterSupplyZones(ZoneID)
);

INSERT INTO Complaints VALUES
(1, 1, 1, '2024-05-01', 'Low water pressure'),
(2, 2, 2, '2024-05-02', 'Water leakage in pipeline'),
(3, 3, 3, '2024-05-03', 'Water supply not available'),
(4, 4, 4, '2024-05-04', 'Dirty water supply'),
(5, 5, 5, '2024-05-05', 'Intermittent water supply'),
(6, 6, 6, '2024-05-06', 'Water contamination issue'),
(7, 7, 7, '2024-05-07', 'Meter not working'),
(8, 8, 8, '2024-05-08', 'High water bill'),
(9, 9, 9, '2024-05-09', 'Pipe burst'),
(10, 10, 10, '2024-05-10', 'Water supply schedule not followed');


-- Table 4: ComplaintStatus
CREATE TABLE ComplaintStatus (
    StatusID INT PRIMARY KEY,
    ComplaintID INT,
    Status VARCHAR(50),
    UpdatedDate DATE,
    Remarks VARCHAR(255),
    FOREIGN KEY (ComplaintID) REFERENCES Complaints(ComplaintID)
);

INSERT INTO ComplaintStatus VALUES
(1, 1, 'Resolved', '2024-05-03', 'Fixed pressure issue'),
(2, 2, 'Pending', '2024-05-04', 'Waiting for parts'),
(3, 3, 'Resolved', '2024-05-05', 'Supply restored'),
(4, 4, 'In Progress', '2024-05-06', 'Water tested'),
(5, 5, 'Resolved', '2024-05-07', 'Schedule updated'),
(6, 6, 'Pending', '2024-05-08', 'Investigating contamination'),
(7, 7, 'Resolved', '2024-05-09', 'Meter replaced'),
(8, 8, 'Resolved', '2024-05-10', 'Bill corrected'),
(9, 9, 'In Progress', '2024-05-11', 'Repair team dispatched'),
(10, 10, 'Resolved', '2024-05-12', 'Schedule adhered');

-- Table 5: WaterSupplySchedule
CREATE TABLE WaterSupplySchedule (
    ScheduleID INT PRIMARY KEY,
    ZoneID INT,
    DayOfWeek VARCHAR(20),
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (ZoneID) REFERENCES WaterSupplyZones(ZoneID)
);

INSERT INTO WaterSupplySchedule VALUES
(1, 1, 'Monday', '06:00:00', '10:00:00'),
(2, 1, 'Wednesday', '06:00:00', '10:00:00'),
(3, 2, 'Tuesday', '07:00:00', '11:00:00'),
(4, 2, 'Thursday', '07:00:00', '11:00:00'),
(5, 3, 'Monday', '08:00:00', '12:00:00'),
(6, 3, 'Friday', '08:00:00', '12:00:00'),
(7, 4, 'Wednesday', '06:00:00', '10:00:00'),
(8, 5, 'Thursday', '07:00:00', '11:00:00'),
(9, 6, 'Friday', '08:00:00', '12:00:00'),
(10, 7, 'Monday', '06:00:00', '10:00:00');

-- ------------------------------------------------ 17th Database --------------------------------------------------------
-- create a database
CREATE DATABASE StreetVendorDB;

-- use the created database
USE StreetVendorDB;

-- Table 1: Vendors
CREATE TABLE Vendors (
    VendorID INT PRIMARY KEY,
    FullName VARCHAR(100),
    ShopName VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(150)
);

INSERT INTO Vendors VALUES
(1, 'Ramesh Kumar', 'Ramesh Snacks', '9876543210', 'MG Road, Delhi'),
(2, 'Sita Sharma', 'Sita Fruits', '9876543211', 'Park Street, Kolkata'),
(3, 'Amit Singh', 'Amit Electronics', '9876543212', 'Brigade Road, Bangalore'),
(4, 'Pooja Joshi', 'Pooja Clothes', '9876543213', 'Connaught Place, Delhi'),
(5, 'Suresh Yadav', 'Suresh Vegetables', '9876543214', 'MG Road, Pune'),
(6, 'Anjali Mehra', 'Anjali Accessories', '9876543215', 'Colaba, Mumbai'),
(7, 'Vikas Jain', 'Vikas Books', '9876543216', 'MG Road, Bangalore'),
(8, 'Kavita Iyer', 'Kavita Toys', '9876543217', 'Park Street, Kolkata'),
(9, 'Vikram Patel', 'Vikram Stationery', '9876543218', 'MG Road, Pune'),
(10, 'Divya Nair', 'Divya Cosmetics', '9876543219', 'Marine Drive, Mumbai');

-- Table 2: Registrations
CREATE TABLE Registrations (
    RegistrationID INT PRIMARY KEY,
    VendorID INT,
    RegistrationDate DATE,
    ValidTill DATE,
    RegistrationStatus VARCHAR(50),
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

INSERT INTO Registrations VALUES
(1, 1, '2024-01-01', '2025-01-01', 'Active'),
(2, 2, '2024-02-15', '2025-02-15', 'Active'),
(3, 3, '2024-03-10', '2025-03-10', 'Expired'),
(4, 4, '2024-01-20', '2025-01-20', 'Active'),
(5, 5, '2024-04-05', '2025-04-05', 'Active'),
(6, 6, '2024-05-15', '2025-05-15', 'Active'),
(7, 7, '2024-06-10', '2025-06-10', 'Expired'),
(8, 8, '2024-07-01', '2025-07-01', 'Active'),
(9, 9, '2024-08-12', '2025-08-12', 'Active'),
(10, 10, '2024-09-05', '2025-09-05', 'Active');

-- Table 3: Feedbacks
CREATE TABLE Feedbacks (
    FeedbackID INT PRIMARY KEY,
    VendorID INT,
    FeedbackDate DATE,
    Rating INT,
    Comments VARCHAR(255),
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

INSERT INTO Feedbacks VALUES
(1, 1, '2024-04-01', 4, 'Good quality products'),
(2, 2, '2024-04-02', 5, 'Very polite vendor'),
(3, 3, '2024-04-03', 3, 'Needs improvement in timing'),
(4, 4, '2024-04-04', 5, 'Excellent service'),
(5, 5, '2024-04-05', 4, 'Fresh vegetables'),
(6, 6, '2024-04-06', 4, 'Nice variety'),
(7, 7, '2024-04-07', 2, 'Not very cooperative'),
(8, 8, '2024-04-08', 5, 'Good toys collection'),
(9, 9, '2024-04-09', 4, 'Affordable prices'),
(10, 10, '2024-04-10', 5, 'Very helpful vendor');

-- Table 4: VendorTypes
CREATE TABLE VendorTypes (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(50),
    Description VARCHAR(255),
    CreatedDate DATE,
    UpdatedDate DATE
);

INSERT INTO VendorTypes VALUES
(1, 'Food', 'Vendors selling food items', '2023-01-01', '2023-12-31'),
(2, 'Fruits & Vegetables', 'Vendors selling fruits and vegetables', '2023-01-01', '2023-12-31'),
(3, 'Electronics', 'Vendors selling electronic goods', '2023-01-01', '2023-12-31'),
(4, 'Clothes', 'Vendors selling clothes', '2023-01-01', '2023-12-31'),
(5, 'Accessories', 'Vendors selling accessories', '2023-01-01', '2023-12-31'),
(6, 'Books', 'Vendors selling books', '2023-01-01', '2023-12-31'),
(7, 'Toys', 'Vendors selling toys', '2023-01-01', '2023-12-31'),
(8, 'Stationery', 'Vendors selling stationery', '2023-01-01', '2023-12-31'),
(9, 'Cosmetics', 'Vendors selling cosmetics', '2023-01-01', '2023-12-31'),
(10, 'Miscellaneous', 'Other vendors', '2023-01-01', '2023-12-31');

-- Table 5: VendorTypeMapping
CREATE TABLE VendorTypeMapping (
    MappingID INT PRIMARY KEY,
    VendorID INT,
    TypeID INT,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID),
    FOREIGN KEY (TypeID) REFERENCES VendorTypes(TypeID)
);

INSERT INTO VendorTypeMapping VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 2),
(6, 6, 5),
(7, 7, 6),
(8, 8, 7),
(9, 9, 8),
(10, 10, 9);


-- ------------------------------------------------ 18th Database --------------------------------------------------------
-- create a database
CREATE DATABASE FoodWasteDB;

-- use the created database
USE FoodWasteDB;

-- Table 1: Households
CREATE TABLE Households (
    HouseholdID INT PRIMARY KEY,
    HeadName VARCHAR(100),
    Address VARCHAR(150),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

INSERT INTO Households VALUES
(1, 'Rajesh Kumar', '12 MG Road, Delhi', '9876543210', 'rajesh.kumar@gmail.com'),
(2, 'Sunita Sharma', '45 Park Street, Kolkata', '9876543211', 'sunita.sharma@gmail.com'),
(3, 'Amit Singh', '78 Brigade Road, Bangalore', '9876543212', 'amit.singh@gmail.com'),
(4, 'Pooja Joshi', '21 Connaught Place, Delhi', '9876543213', 'pooja.joshi@gmail.com'),
(5, 'Suresh Yadav', '9 MG Road, Pune', '9876543214', 'suresh.yadav@gmail.com'),
(6, 'Anjali Mehra', '56 Colaba, Mumbai', '9876543215', 'anjali.mehra@gmail.com'),
(7, 'Vikas Jain', '87 Park Street, Kolkata', '9876543216', 'vikas.jain@gmail.com'),
(8, 'Kavita Iyer', '34 MG Road, Pune', '9876543217', 'kavita.iyer@gmail.com'),
(9, 'Vikram Patel', '67 Brigade Road, Bangalore', '9876543218', 'vikram.patel@gmail.com'),
(10, 'Divya Nair', '12 Marine Drive, Mumbai', '9876543219', 'divya.nair@gmail.com');

-- Table 2: WasteTypes
CREATE TABLE WasteTypes (
    WasteTypeID INT PRIMARY KEY,
    WasteName VARCHAR(50),
    Description VARCHAR(255),
    CreatedDate DATE,
    UpdatedDate DATE
);

INSERT INTO WasteTypes VALUES
(1, 'Vegetable Waste', 'Leftover vegetable peels and scraps', '2023-01-01', '2023-12-31'),
(2, 'Fruit Waste', 'Spoiled or leftover fruits', '2023-01-01', '2023-12-31'),
(3, 'Cooked Food Waste', 'Leftover cooked food', '2023-01-01', '2023-12-31'),
(4, 'Bread Waste', 'Stale or leftover bread', '2023-01-01', '2023-12-31'),
(5, 'Dairy Waste', 'Expired or leftover dairy products', '2023-01-01', '2023-12-31'),
(6, 'Meat Waste', 'Leftover or spoiled meat', '2023-01-01', '2023-12-31'),
(7, 'Grain Waste', 'Leftover grains or cereals', '2023-01-01', '2023-12-31'),
(8, 'Beverage Waste', 'Leftover beverages', '2023-01-01', '2023-12-31'),
(9, 'Other Organic Waste', 'Other organic leftovers', '2023-01-01', '2023-12-31'),
(10, 'Non-Organic Waste', 'Non-organic food waste', '2023-01-01', '2023-12-31');

-- Table 3: WasteCollection
CREATE TABLE WasteCollection (
    CollectionID INT PRIMARY KEY,
    HouseholdID INT,
    WasteTypeID INT,
    CollectionDate DATE,
    QuantityKg FLOAT,
    FOREIGN KEY (HouseholdID) REFERENCES Households(HouseholdID),
    FOREIGN KEY (WasteTypeID) REFERENCES WasteTypes(WasteTypeID)
);

INSERT INTO WasteCollection VALUES
(1, 1, 1, '2024-05-01', 3.5),
(2, 2, 2, '2024-05-01', 2.0),
(3, 3, 3, '2024-05-02', 4.1),
(4, 4, 4, '2024-05-02', 1.2),
(5, 5, 5, '2024-05-03', 0.8),
(6, 6, 1, '2024-05-03', 2.5),
(7, 7, 2, '2024-05-04', 3.0),
(8, 8, 3, '2024-05-04', 4.0),
(9, 9, 4, '2024-05-05', 1.5),
(10, 10, 5, '2024-05-05', 2.2);

-- Table 4: CollectionCenters
CREATE TABLE CollectionCenters (
    CenterID INT PRIMARY KEY,
    CenterName VARCHAR(100),
    Address VARCHAR(150),
    ContactPerson VARCHAR(100),
    Phone VARCHAR(15)
);

INSERT INTO CollectionCenters VALUES
(1, 'Delhi Waste Center', 'Sector 10, Delhi', 'Ravi Kumar', '9123456780'),
(2, 'Kolkata Waste Center', 'Park Street, Kolkata', 'Sunita Roy', '9123456781'),
(3, 'Bangalore Waste Center', 'MG Road, Bangalore', 'Anil Mehta', '9123456782'),
(4, 'Pune Waste Center', 'Shivaji Nagar, Pune', 'Priya Singh', '9123456783'),
(5, 'Mumbai Waste Center', 'Andheri, Mumbai', 'Arjun Rao', '9123456784'),
(6, 'Chennai Waste Center', 'T Nagar, Chennai', 'Kavita Joshi', '9123456785'),
(7, 'Hyderabad Waste Center', 'Banjara Hills, Hyderabad', 'Mohan Verma', '9123456786'),
(8, 'Ahmedabad Waste Center', 'Navrangpura, Ahmedabad', 'Suresh Patel', '9123456787'),
(9, 'Chandigarh Waste Center', 'Sector 17, Chandigarh', 'Rajesh Kumar', '9123456788'),
(10, 'Lucknow Waste Center', 'Hazratganj, Lucknow', 'Neha Singh', '9123456789');

-- Table 5: CenterCollections
CREATE TABLE CenterCollections (
    CenterCollectionID INT PRIMARY KEY,
    CollectionID INT,
    CenterID INT,
    ReceivedDate DATE,
    Remarks VARCHAR(255),
    FOREIGN KEY (CollectionID) REFERENCES WasteCollection(CollectionID),
    FOREIGN KEY (CenterID) REFERENCES CollectionCenters(CenterID)
);

INSERT INTO CenterCollections VALUES
(1, 1, 1, '2024-05-02', 'All good'),
(2, 2, 2, '2024-05-02', 'Segregated well'),
(3, 3, 3, '2024-05-03', 'Needs improvement'),
(4, 4, 4, '2024-05-03', 'Satisfactory'),
(5, 5, 5, '2024-05-04', 'Good quality'),
(6, 6, 1, '2024-05-04', 'Well packed'),
(7, 7, 2, '2024-05-05', 'Mixed waste'),
(8, 8, 3, '2024-05-05', 'Excellent'),
(9, 9, 4, '2024-05-06', 'Late delivery'),
(10, 10, 5, '2024-05-06', 'Proper segregation');

-- ------------------------------------------------ 19th Database --------------------------------------------------------
-- create a database
CREATE DATABASE HandicraftsDB;

-- use the created database
USE HandicraftsDB;

-- Table 1: Artisans
CREATE TABLE Artisans (
    ArtisanID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Artisans VALUES
(1, 'Ravi Kumar', '9876543210', 'ravi.kumar@gmail.com', 'Jaipur'),
(2, 'Sunita Sharma', '9876543211', 'sunita.sharma@gmail.com', 'Delhi'),
(3, 'Amit Singh', '9876543212', 'amit.singh@gmail.com', 'Varanasi'),
(4, 'Pooja Joshi', '9876543213', 'pooja.joshi@gmail.com', 'Lucknow'),
(5, 'Suresh Yadav', '9876543214', 'suresh.yadav@gmail.com', 'Ahmedabad'),
(6, 'Anjali Mehra', '9876543215', 'anjali.mehra@gmail.com', 'Mumbai'),
(7, 'Vikas Jain', '9876543216', 'vikas.jain@gmail.com', 'Chennai'),
(8, 'Kavita Iyer', '9876543217', 'kavita.iyer@gmail.com', 'Bangalore'),
(9, 'Vikram Patel', '9876543218', 'vikram.patel@gmail.com', 'Kolkata'),
(10, 'Divya Nair', '9876543219', 'divya.nair@gmail.com', 'Hyderabad');

-- Table 2: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ArtisanID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    FOREIGN KEY (ArtisanID) REFERENCES Artisans(ArtisanID)
);

INSERT INTO Products VALUES
(1, 1, 'Blue Pottery Vase', 'Pottery', 1200.00),
(2, 2, 'Handwoven Saree', 'Textiles', 2500.00),
(3, 3, 'Brass Lamp', 'Metalwork', 1500.00),
(4, 4, 'Chikankari Kurta', 'Embroidery', 1800.00),
(5, 5, 'Terracotta Figurine', 'Pottery', 800.00),
(6, 6, 'Madhubani Painting', 'Painting', 2000.00),
(7, 7, 'Wooden Toys', 'Woodwork', 700.00),
(8, 8, 'Kalamkari Fabric', 'Textiles', 2200.00),
(9, 9, 'Handmade Jewelry', 'Jewelry', 3000.00),
(10, 10, 'Leather Bag', 'Leatherwork', 2800.00);

-- Table 3: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Rohan Gupta', '9876512340', 'rohan.gupta@gmail.com', 'Delhi'),
(2, 'Neha Verma', '9876523451', 'neha.verma@gmail.com', 'Mumbai'),
(3, 'Karan Singh', '9876534562', 'karan.singh@gmail.com', 'Bangalore'),
(4, 'Priya Kapoor', '9876545673', 'priya.kapoor@gmail.com', 'Chennai'),
(5, 'Ankit Mehta', '9876556784', 'ankit.mehta@gmail.com', 'Hyderabad'),
(6, 'Sonal Joshi', '9876567895', 'sonal.joshi@gmail.com', 'Ahmedabad'),
(7, 'Vivek Sharma', '9876578906', 'vivek.sharma@gmail.com', 'Jaipur'),
(8, 'Divya Patel', '9876589017', 'divya.patel@gmail.com', 'Lucknow'),
(9, 'Manish Kumar', '9876590128', 'manish.kumar@gmail.com', 'Kolkata'),
(10, 'Shweta Nair', '9876501239', 'shweta.nair@gmail.com', 'Pune');

-- Table 4: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders VALUES
(1, 1, '2024-05-01', 'Delivered'),
(2, 2, '2024-05-02', 'Pending'),
(3, 3, '2024-05-03', 'Delivered'),
(4, 4, '2024-05-04', 'Cancelled'),
(5, 5, '2024-05-05', 'Delivered'),
(6, 6, '2024-05-06', 'Pending'),
(7, 7, '2024-05-07', 'Delivered'),
(8, 8, '2024-05-08', 'Pending'),
(9, 9, '2024-05-09', 'Delivered'),
(10, 10, '2024-05-10', 'Delivered');

-- Table 5: OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails VALUES
(1, 1, 1, 2),
(2, 1, 5, 1),
(3, 2, 2, 1),
(4, 3, 3, 3),
(5, 4, 4, 1),
(6, 5, 6, 2),
(7, 6, 7, 1),
(8, 7, 8, 2),
(9, 8, 9, 1),
(10, 9, 10, 1);

-- ------------------------------------------------ 20th Database --------------------------------------------------------
-- create a database
CREATE DATABASE SkillSharingDB;

-- use the created database
USE SkillSharingDB;

-- Table 1: Users 
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

INSERT INTO Users VALUES
(1, 'Amit Sharma', 'amit.sharma@gmail.com', '9876543210', 'Delhi'),
(2, 'Neha Gupta', 'neha.gupta@gmail.com', '9876543211', 'Mumbai'),
(3, 'Rajesh Kumar', 'rajesh.kumar@gmail.com', '9876543212', 'Bangalore'),
(4, 'Sunita Singh', 'sunita.singh@gmail.com', '9876543213', 'Chennai'),
(5, 'Vikram Patel', 'vikram.patel@gmail.com', '9876543214', 'Ahmedabad'),
(6, 'Pooja Joshi', 'pooja.joshi@gmail.com', '9876543215', 'Pune'),
(7, 'Karan Verma', 'karan.verma@gmail.com', '9876543216', 'Hyderabad'),
(8, 'Divya Nair', 'divya.nair@gmail.com', '9876543217', 'Kolkata'),
(9, 'Suresh Yadav', 'suresh.yadav@gmail.com', '9876543218', 'Lucknow'),
(10, 'Anjali Mehra', 'anjali.mehra@gmail.com', '9876543219', 'Jaipur');

-- Table 2: Skills
CREATE TABLE Skills (
    SkillID INT PRIMARY KEY,
    SkillName VARCHAR(100),
    Description VARCHAR(255),
    Category VARCHAR(50),
    CreatedDate DATE
);

INSERT INTO Skills VALUES
(1, 'Cooking', 'Learn various Indian cuisines', 'Culinary', '2023-01-01'),
(2, 'Photography', 'Basics of photography and editing', 'Art', '2023-01-05'),
(3, 'Yoga', 'Learn different yoga postures', 'Health', '2023-01-10'),
(4, 'Coding', 'Introduction to programming', 'Technology', '2023-01-15'),
(5, 'Painting', 'Watercolor and acrylic painting', 'Art', '2023-01-20'),
(6, 'Gardening', 'Urban gardening techniques', 'Hobby', '2023-01-25'),
(7, 'Public Speaking', 'Improve communication skills', 'Personal Development', '2023-01-30'),
(8, 'Dancing', 'Learn classical and modern dance', 'Art', '2023-02-01'),
(9, 'Tailoring', 'Basic stitching and tailoring', 'Skill', '2023-02-05'),
(10, 'Music', 'Learn Indian classical music', 'Art', '2023-02-10');

-- Table 3: Sessions
CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY,
    SkillID INT,
    InstructorID INT,
    SessionDate DATE,
    Location VARCHAR(100),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID),
    FOREIGN KEY (InstructorID) REFERENCES Users(UserID)
);

INSERT INTO Sessions VALUES
(1, 1, 1, '2024-05-01', 'Community Center Delhi'),
(2, 2, 2, '2024-05-03', 'Art Gallery Mumbai'),
(3, 3, 3, '2024-05-05', 'Yoga Studio Bangalore'),
(4, 4, 4, '2024-05-07', 'Tech Park Chennai'),
(5, 5, 5, '2024-05-09', 'Art Club Ahmedabad'),
(6, 6, 6, '2024-05-11', 'Garden Area Pune'),
(7, 7, 7, '2024-05-13', 'Auditorium Hyderabad'),
(8, 8, 8, '2024-05-15', 'Dance Hall Kolkata'),
(9, 9, 9, '2024-05-17', 'Tailoring Workshop Lucknow'),
(10, 10, 10, '2024-05-19', 'Music Room Jaipur');
 
-- Table 4: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    SessionID INT,
    UserID INT,
    EnrollmentDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Enrollments VALUES
(1, 1, 2, '2024-04-25', 'Confirmed'),
(2, 1, 3, '2024-04-26', 'Confirmed'),
(3, 2, 4, '2024-04-27', 'Confirmed'),
(4, 3, 5, '2024-04-28', 'Confirmed'),
(5, 4, 6, '2024-04-29', 'Confirmed'),
(6, 5, 7, '2024-04-30', 'Confirmed'),
(7, 6, 8, '2024-05-01', 'Confirmed'),
(8, 7, 9, '2024-05-02', 'Confirmed'),
(9, 8, 10, '2024-05-03', 'Confirmed'),
(10, 9, 1, '2024-05-04', 'Confirmed');

-- Table 5: Feedback
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    EnrollmentID INT,
    Rating INT,
    Comments VARCHAR(255),
    FeedbackDate DATE,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

INSERT INTO Feedback VALUES
(1, 1, 5, 'Very helpful session', '2024-05-02'),
(2, 2, 4, 'Good explanation', '2024-05-02'),
(3, 3, 5, 'Loved it', '2024-05-04'),
(4, 4, 3, 'Could be better', '2024-05-06'),
(5, 5, 4, 'Well organized', '2024-05-10'),
(6, 6, 5, 'Excellent instructor', '2024-05-12'),
(7, 7, 4, 'Good content', '2024-05-14'),
(8, 8, 3, 'Average experience', '2024-05-16'),
(9, 9, 5, 'Highly recommend', '2024-05-18'),
(10, 10, 4, 'Good overall', '2024-05-20');

-- ------------------------------------------------ 21st Database --------------------------------------------------------
-- create a database
CREATE DATABASE CulturalFestivalDB;

-- use the created database
USE CulturalFestivalDB;

-- Table 1: Organizers
CREATE TABLE Organizers (
    OrganizerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

INSERT INTO Organizers VALUES
(1, 'Rajesh Kumar', 'rajesh.kumar@gmail.com', '9876543210', 'Delhi'),
(2, 'Sunita Verma', 'sunita.verma@gmail.com', '9876543211', 'Mumbai'),
(3, 'Vikram Singh', 'vikram.singh@gmail.com', '9876543212', 'Chennai'),
(4, 'Pooja Sharma', 'pooja.sharma@gmail.com', '9876543213', 'Bangalore'),
(5, 'Suresh Nair', 'suresh.nair@gmail.com', '9876543214', 'Hyderabad'),
(6, 'Anjali Gupta', 'anjali.gupta@gmail.com', '9876543215', 'Pune'),
(7, 'Karan Joshi', 'karan.joshi@gmail.com', '9876543216', 'Ahmedabad'),
(8, 'Divya Patel', 'divya.patel@gmail.com', '9876543217', 'Jaipur'),
(9, 'Manish Yadav', 'manish.yadav@gmail.com', '9876543218', 'Lucknow'),
(10, 'Neha Iyer', 'neha.iyer@gmail.com', '9876543219', 'Kolkata');

-- Table 2: Events
CREATE TABLE Events (
    EventID INT PRIMARY KEY,
    OrganizerID INT,
    EventName VARCHAR(100),
    EventDate DATE,
    Location VARCHAR(100),
    FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID)
);

INSERT INTO Events VALUES
(1, 1, 'Diwali Mela', '2024-11-01', 'Delhi Ground'),
(2, 2, 'Holi Utsav', '2024-03-15', 'Mumbai Hall'),
(3, 3, 'Navratri Dance', '2024-10-05', 'Chennai Arena'),
(4, 4, 'Eid Milan', '2024-04-20', 'Bangalore Community Center'),
(5, 5, 'Christmas Carnival', '2024-12-24', 'Hyderabad Park'),
(6, 6, 'Ganesh Chaturthi', '2024-09-10', 'Pune Square'),
(7, 7, 'Pongal Festival', '2024-01-15', 'Ahmedabad Grounds'),
(8, 8, 'Baisakhi Celebration', '2024-04-13', 'Jaipur Grounds'),
(9, 9, 'Onam Fest', '2024-08-30', 'Lucknow Auditorium'),
(10, 10, 'Lohri Festival', '2024-01-13', 'Kolkata Cultural Hall');

-- Table 3: Performers
CREATE TABLE Performers (
    PerformerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(15),
    Genre VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Performers VALUES
(1, 'Ravi Shankar', '9876543200', 'Classical Music', 'Delhi'),
(2, 'Sunita Reddy', '9876543201', 'Folk Dance', 'Mumbai'),
(3, 'Amitabh Singh', '9876543202', 'Drama', 'Chennai'),
(4, 'Pooja Desai', '9876543203', 'Singing', 'Bangalore'),
(5, 'Suresh Kumar', '9876543204', 'Instrumental', 'Hyderabad'),
(6, 'Anjali Rao', '9876543205', 'Classical Dance', 'Pune'),
(7, 'Karan Mehta', '9876543206', 'Folk Music', 'Ahmedabad'),
(8, 'Divya Singh', '9876543207', 'Painting', 'Jaipur'),
(9, 'Manish Shah', '9876543208', 'Poetry', 'Lucknow'),
(10, 'Neha Kapoor', '9876543209', 'Comedy', 'Kolkata');

-- Table 4: EventPerformers
CREATE TABLE EventPerformers (
    EventPerformerID INT PRIMARY KEY,
    EventID INT,
    PerformerID INT,
    Role VARCHAR(50),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (PerformerID) REFERENCES Performers(PerformerID)
);

INSERT INTO EventPerformers VALUES
(1, 1, 1, 'Lead Musician'),
(2, 1, 2, 'Dancer'),
(3, 2, 3, 'Actor'),
(4, 3, 4, 'Singer'),
(5, 4, 5, 'Instrumentalist'),
(6, 5, 6, 'Dancer'),
(7, 6, 7, 'Musician'),
(8, 7, 8, 'Painter'),
(9, 8, 9, 'Poet'),
(10, 9, 10, 'Comedian');

-- Table 5: Attendees
CREATE TABLE Attendees (
    AttendeeID INT PRIMARY KEY,
    EventID INT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

INSERT INTO Attendees VALUES
(1, 1, 'Rohan Gupta', 'rohan.gupta@gmail.com', '9876501234'),
(2, 1, 'Neha Sharma', 'neha.sharma@gmail.com', '9876501235'),
(3, 2, 'Karan Verma', 'karan.verma@gmail.com', '9876501236'),
(4, 3, 'Priya Singh', 'priya.singh@gmail.com', '9876501237'),
(5, 4, 'Ankit Mehta', 'ankit.mehta@gmail.com', '9876501238'),
(6, 5, 'Sonal Joshi', 'sonal.joshi@gmail.com', '9876501239'),
(7, 6, 'Vivek Kumar', 'vivek.kumar@gmail.com', '9876501240'),
(8, 7, 'Divya Patel', 'divya.patel@gmail.com', '9876501241'),
(9, 8, 'Manish Shah', 'manish.shah@gmail.com', '9876501242'),
(10, 9, 'Shweta Nair', 'shweta.nair@gmail.com', '9876501243');

-- ------------------------------------------------ 22nd Database --------------------------------------------------------
-- create a database
CREATE DATABASE UrbanGardenDB;

-- use the created database
USE UrbanGardenDB;

-- Table 1: 
CREATE TABLE Gardeners (
    GardenerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

INSERT INTO Gardeners VALUES
(1, 'Amit Singh', 'amit.singh@gmail.com', '9876543210', 'Delhi'),
(2, 'Neha Sharma', 'neha.sharma@gmail.com', '9876543211', 'Mumbai'),
(3, 'Ravi Patel', 'ravi.patel@gmail.com', '9876543212', 'Bangalore'),
(4, 'Pooja Mehta', 'pooja.mehta@gmail.com', '9876543213', 'Chennai'),
(5, 'Suresh Yadav', 'suresh.yadav@gmail.com', '9876543214', 'Hyderabad'),
(6, 'Anjali Joshi', 'anjali.joshi@gmail.com', '9876543215', 'Pune'),
(7, 'Karan Verma', 'karan.verma@gmail.com', '9876543216', 'Ahmedabad'),
(8, 'Divya Nair', 'divya.nair@gmail.com', '9876543217', 'Kolkata'),
(9, 'Manish Kumar', 'manish.kumar@gmail.com', '9876543218', 'Lucknow'),
(10, 'Sunita Rao', 'sunita.rao@gmail.com', '9876543219', 'Jaipur');

-- Table 2: 
CREATE TABLE Gardens (
    GardenID INT PRIMARY KEY,
    GardenerID INT,
    Location VARCHAR(100),
    Area DECIMAL(10,2),
    GardenType VARCHAR(50),
    FOREIGN KEY (GardenerID) REFERENCES Gardeners(GardenerID)
);

INSERT INTO Gardens VALUES
(1, 1, 'Delhi Central Park', 500.50, 'Vegetable'),
(2, 2, 'Mumbai Western Park', 300.00, 'Flower'),
(3, 3, 'Bangalore City Garden', 450.75, 'Herb'),
(4, 4, 'Chennai Green Park', 350.25, 'Vegetable'),
(5, 5, 'Hyderabad Community Garden', 400.60, 'Flower'),
(6, 6, 'Pune Urban Farm', 600.00, 'Vegetable'),
(7, 7, 'Ahmedabad Botanical Garden', 700.80, 'Herb'),
(8, 8, 'Kolkata Rose Garden', 250.40, 'Flower'),
(9, 9, 'Lucknow Garden Park', 550.00, 'Vegetable'),
(10, 10, 'Jaipur City Garden', 300.50, 'Herb');

-- Table 3: 
CREATE TABLE Plants (
    PlantID INT PRIMARY KEY,
    GardenID INT,
    PlantName VARCHAR(100),
    PlantType VARCHAR(50),
    DatePlanted DATE,
    FOREIGN KEY (GardenID) REFERENCES Gardens(GardenID)
);

INSERT INTO Plants VALUES
(1, 1, 'Tomato', 'Vegetable', '2024-01-10'),
(2, 1, 'Spinach', 'Vegetable', '2024-01-15'),
(3, 2, 'Rose', 'Flower', '2024-02-01'),
(4, 3, 'Basil', 'Herb', '2024-02-10'),
(5, 4, 'Carrot', 'Vegetable', '2024-03-05'),
(6, 5, 'Marigold', 'Flower', '2024-03-20'),
(7, 6, 'Cabbage', 'Vegetable', '2024-04-10'),
(8, 7, 'Mint', 'Herb', '2024-04-15'),
(9, 8, 'Jasmine', 'Flower', '2024-05-01'),
(10, 9, 'Potato', 'Vegetable', '2024-05-10');

-- Table 4:
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    GardenID INT,
    Date DATE,
    Activity VARCHAR(100),
    GardenerID INT,
    FOREIGN KEY (GardenID) REFERENCES Gardens(GardenID),
    FOREIGN KEY (GardenerID) REFERENCES Gardeners(GardenerID)
);

INSERT INTO Maintenance VALUES
(1, 1, '2024-01-20', 'Watering', 1),
(2, 2, '2024-02-05', 'Weeding', 2),
(3, 3, '2024-02-15', 'Fertilizing', 3),
(4, 4, '2024-03-10', 'Pruning', 4),
(5, 5, '2024-03-25', 'Pest Control', 5),
(6, 6, '2024-04-15', 'Watering', 6),
(7, 7, '2024-04-20', 'Weeding', 7),
(8, 8, '2024-05-05', 'Fertilizing', 8),
(9, 9, '2024-05-15', 'Pruning', 9),
(10, 10, '2024-05-20', 'Pest Control', 10);
 
-- Table 5:
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    GardenID INT,
    Date DATE,
    Activity VARCHAR(100),
    GardenerID INT,
    FOREIGN KEY (GardenID) REFERENCES Gardens(GardenID),
    FOREIGN KEY (GardenerID) REFERENCES Gardeners(GardenerID)
);

INSERT INTO Maintenance VALUES
(1, 1, '2024-01-20', 'Watering', 1),
(2, 2, '2024-02-05', 'Weeding', 2),
(3, 3, '2024-02-15', 'Fertilizing', 3),
(4, 4, '2024-03-10', 'Pruning', 4),
(5, 5, '2024-03-25', 'Pest Control', 5),
(6, 6, '2024-04-15', 'Watering', 6),
(7, 7, '2024-04-20', 'Weeding', 7),
(8, 8, '2024-05-05', 'Fertilizing', 8),
(9, 9, '2024-05-15', 'Pruning', 9),
(10, 10, '2024-05-20', 'Pest Control', 10);

-- ------------------------------------------------ 23rd Database --------------------------------------------------------
-- create a database
CREATE DATABASE RemoteWorkDB;

-- use the created database
USE RemoteWorkDB;

-- Table 1: 
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Department VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Employees VALUES
(1, 'Amit Sharma', 'amit.sharma@company.com', 'IT', 'Delhi'),
(2, 'Neha Reddy', 'neha.reddy@company.com', 'HR', 'Hyderabad'),
(3, 'Ravi Kumar', 'ravi.kumar@company.com', 'Marketing', 'Mumbai'),
(4, 'Pooja Joshi', 'pooja.joshi@company.com', 'Finance', 'Pune'),
(5, 'Suresh Patil', 'suresh.patil@company.com', 'Sales', 'Bangalore'),
(6, 'Anjali Mehra', 'anjali.mehra@company.com', 'IT', 'Chennai'),
(7, 'Karan Singh', 'karan.singh@company.com', 'HR', 'Jaipur'),
(8, 'Divya Shah', 'divya.shah@company.com', 'Marketing', 'Ahmedabad'),
(9, 'Manish Rao', 'manish.rao@company.com', 'Sales', 'Kolkata'),
(10, 'Sunita Nair', 'sunita.nair@company.com', 'Finance', 'Lucknow');

-- Table 2: 
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    Status VARCHAR(20),
    WorkHours DECIMAL(4,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Attendance VALUES
(1, 1, '2024-05-01', 'Present', 8.0),
(2, 2, '2024-05-01', 'Present', 7.5),
(3, 3, '2024-05-01', 'Absent', 0.0),
(4, 4, '2024-05-01', 'Present', 8.5),
(5, 5, '2024-05-01', 'Present', 7.0),
(6, 6, '2024-05-01', 'Present', 8.0),
(7, 7, '2024-05-01', 'Present', 6.5),
(8, 8, '2024-05-01', 'Absent', 0.0),
(9, 9, '2024-05-01', 'Present', 7.5),
(10, 10, '2024-05-01', 'Present', 8.0);

-- Table 3: 
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    EmployeeID INT,
    TaskName VARCHAR(100),
    Status VARCHAR(20),
    Deadline DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Tasks VALUES
(1, 1, 'Code Review', 'Completed', '2024-05-02'),
(2, 2, 'Employee Survey', 'Pending', '2024-05-03'),
(3, 3, 'Marketing Report', 'Not Started', '2024-05-04'),
(4, 4, 'Budget Analysis', 'Completed', '2024-05-05'),
(5, 5, 'Sales Pitch', 'Pending', '2024-05-06'),
(6, 6, 'UI Design', 'Completed', '2024-05-02'),
(7, 7, 'Policy Draft', 'In Progress', '2024-05-03'),
(8, 8, 'Ad Planning', 'Not Started', '2024-05-04'),
(9, 9, 'Client Follow-up', 'Completed', '2024-05-01'),
(10, 10, 'Invoice Report', 'Pending', '2024-05-02');

-- Table 4: 
CREATE TABLE Productivity (
    ProductivityID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    TasksCompleted INT,
    Rating INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Productivity VALUES
(1, 1, '2024-05-01', 3, 4),
(2, 2, '2024-05-01', 2, 3),
(3, 3, '2024-05-01', 0, 0),
(4, 4, '2024-05-01', 4, 5),
(5, 5, '2024-05-01', 1, 2),
(6, 6, '2024-05-01', 3, 4),
(7, 7, '2024-05-01', 2, 3),
(8, 8, '2024-05-01', 0, 0),
(9, 9, '2024-05-01', 2, 3),
(10, 10, '2024-05-01', 3, 4);

-- Table 5:
CREATE TABLE Leaves (
    LeaveID INT PRIMARY KEY,
    EmployeeID INT,
    LeaveDate DATE,
    LeaveType VARCHAR(50),
    Reason VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Leaves VALUES
(1, 3, '2024-05-01', 'Sick Leave', 'Fever'),
(2, 8, '2024-05-01', 'Casual Leave', 'Personal Work'),
(3, 5, '2024-04-30', 'Casual Leave', 'Family Function'),
(4, 2, '2024-04-28', 'Sick Leave', 'Headache'),
(5, 7, '2024-04-29', 'Casual Leave', 'Bank Work'),
(6, 1, '2024-04-25', 'Sick Leave', 'Cold'),
(7, 4, '2024-04-26', 'Casual Leave', 'Travel'),
(8, 6, '2024-04-27', 'Sick Leave', 'Back Pain'),
(9, 9, '2024-04-29', 'Casual Leave', 'Home Repair'),
(10, 10, '2024-04-30', 'Casual Leave', 'Child Care');

-- ------------------------------------------------ 24th Database --------------------------------------------------------
-- create a database
CREATE DATABASE LaundryTrackerDB;

-- use the created database
USE LaundryTrackerDB;

-- Table 1: 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Amit Verma', '9876543201', 'amit.verma@gmail.com', 'Delhi'),
(2, 'Neha Kapoor', '9876543202', 'neha.kapoor@gmail.com', 'Mumbai'),
(3, 'Ravi Desai', '9876543203', 'ravi.desai@gmail.com', 'Ahmedabad'),
(4, 'Priya Joshi', '9876543204', 'priya.joshi@gmail.com', 'Pune'),
(5, 'Suresh Iyer', '9876543205', 'suresh.iyer@gmail.com', 'Chennai'),
(6, 'Anjali Mehta', '9876543206', 'anjali.mehta@gmail.com', 'Bangalore'),
(7, 'Karan Singh', '9876543207', 'karan.singh@gmail.com', 'Kolkata'),
(8, 'Divya Rathi', '9876543208', 'divya.rathi@gmail.com', 'Hyderabad'),
(9, 'Manish Shah', '9876543209', 'manish.shah@gmail.com', 'Jaipur'),
(10, 'Sunita Rao', '9876543210', 'sunita.rao@gmail.com', 'Lucknow');

-- Table 2: 
CREATE TABLE PickupRequests (
    PickupID INT PRIMARY KEY,
    CustomerID INT,
    RequestDate DATE,
    TimeSlot VARCHAR(50),
    Address VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO PickupRequests VALUES
(1, 1, '2024-06-01', 'Morning', 'Sector 21, Delhi'),
(2, 2, '2024-06-02', 'Evening', 'Bandra West, Mumbai'),
(3, 3, '2024-06-01', 'Afternoon', 'Navrangpura, Ahmedabad'),
(4, 4, '2024-06-03', 'Morning', 'Kothrud, Pune'),
(5, 5, '2024-06-01', 'Evening', 'T. Nagar, Chennai'),
(6, 6, '2024-06-02', 'Morning', 'Indiranagar, Bangalore'),
(7, 7, '2024-06-03', 'Afternoon', 'Salt Lake, Kolkata'),
(8, 8, '2024-06-01', 'Evening', 'Banjara Hills, Hyderabad'),
(9, 9, '2024-06-04', 'Morning', 'Vaishali Nagar, Jaipur'),
(10, 10, '2024-06-05', 'Afternoon', 'Hazratganj, Lucknow');

-- Table 3: 
CREATE TABLE DeliveryStatus (
    DeliveryID INT PRIMARY KEY,
    PickupID INT,
    Status VARCHAR(50),
    DeliveryDate DATE,
    DeliveryPerson VARCHAR(100),
    FOREIGN KEY (PickupID) REFERENCES PickupRequests(PickupID)
);

INSERT INTO DeliveryStatus VALUES
(1, 1, 'Delivered', '2024-06-02', 'Rohan Singh'),
(2, 2, 'In Transit', '2024-06-03', 'Sanjay Mehta'),
(3, 3, 'Delivered', '2024-06-02', 'Ravi Pandey'),
(4, 4, 'Pending', '2024-06-04', 'Nikhil Raut'),
(5, 5, 'Delivered', '2024-06-02', 'Mahesh Shetty'),
(6, 6, 'In Transit', '2024-06-03', 'Ajay Kumar'),
(7, 7, 'Delivered', '2024-06-04', 'Deepak Yadav'),
(8, 8, 'Pending', '2024-06-02', 'Suraj Iqbal'),
(9, 9, 'Delivered', '2024-06-05', 'Ashok Singh'),
(10, 10, 'In Transit', '2024-06-06', 'Ankit Chawla');

-- Table 4: 
CREATE TABLE ClothingItems (
    ItemID INT PRIMARY KEY,
    PickupID INT,
    Type VARCHAR(50),
    Quantity INT,
    Material VARCHAR(50),
    FOREIGN KEY (PickupID) REFERENCES PickupRequests(PickupID)
);

INSERT INTO ClothingItems VALUES
(1, 1, 'Shirt', 5, 'Cotton'),
(2, 2, 'Pants', 4, 'Denim'),
(3, 3, 'Saree', 2, 'Silk'),
(4, 4, 'Bedsheet', 3, 'Linen'),
(5, 5, 'Towel', 6, 'Cotton'),
(6, 6, 'Kurta', 4, 'Linen'),
(7, 7, 'Jeans', 2, 'Denim'),
(8, 8, 'Dupatta', 3, 'Chiffon'),
(9, 9, 'Blanket', 2, 'Wool'),
(10, 10, 'Shirt', 5, 'Polyester');

-- Table 5:
CREATE TABLE LaundryStaff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Shift VARCHAR(50),
    Phone VARCHAR(15)
);

INSERT INTO LaundryStaff VALUES
(1, 'Rakesh Mehra', 'Washer', 'Morning', '9812345001'),
(2, 'Suman Joshi', 'Ironing', 'Evening', '9812345002'),
(3, 'Vikram Shah', 'Sorter', 'Afternoon', '9812345003'),
(4, 'Ritu Sharma', 'Washer', 'Morning', '9812345004'),
(5, 'Arun Iyer', 'Ironing', 'Evening', '9812345005'),
(6, 'Priya Patel', 'Washer', 'Afternoon', '9812345006'),
(7, 'Ajay Rao', 'Delivery', 'Morning', '9812345007'),
(8, 'Kavita Rani', 'Sorting', 'Evening', '9812345008'),
(9, 'Rohit Verma', 'Ironing', 'Afternoon', '9812345009'),
(10, 'Meena Gupta', 'Delivery', 'Morning', '9812345010');

-- ------------------------------------------------ 25th Database --------------------------------------------------------
-- create a database
CREATE DATABASE PhotographyBookingDB;

-- use the created database
USE PhotographyBookingDB;

-- Table 1: 
CREATE TABLE Photographers (
    PhotographerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Specialty VARCHAR(50),
    Contact VARCHAR(15)
);

INSERT INTO Photographers VALUES
(1, 'Ravi Sharma', 'Delhi', 'Wedding', '9810012345'),
(2, 'Anjali Mehta', 'Mumbai', 'Fashion', '9820012346'),
(3, 'Suresh Iyer', 'Chennai', 'Wildlife', '9830012347'),
(4, 'Neha Reddy', 'Hyderabad', 'Portrait', '9840012348'),
(5, 'Amit Verma', 'Pune', 'Event', '9850012349'),
(6, 'Divya Patel', 'Ahmedabad', 'Product', '9860012350'),
(7, 'Manish Rao', 'Bangalore', 'Wedding', '9870012351'),
(8, 'Priya Joshi', 'Kolkata', 'Newborn', '9880012352'),
(9, 'Karan Singh', 'Jaipur', 'Travel', '9890012353'),
(10, 'Pooja Shah', 'Lucknow', 'Fashion', '9900012354');

-- Table 2: 
CREATE TABLE Photographers (
    PhotographerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Specialty VARCHAR(50),
    Contact VARCHAR(15)
);

INSERT INTO Photographers VALUES
(1, 'Ravi Sharma', 'Delhi', 'Wedding', '9810012345'),
(2, 'Anjali Mehta', 'Mumbai', 'Fashion', '9820012346'),
(3, 'Suresh Iyer', 'Chennai', 'Wildlife', '9830012347'),
(4, 'Neha Reddy', 'Hyderabad', 'Portrait', '9840012348'),
(5, 'Amit Verma', 'Pune', 'Event', '9850012349'),
(6, 'Divya Patel', 'Ahmedabad', 'Product', '9860012350'),
(7, 'Manish Rao', 'Bangalore', 'Wedding', '9870012351'),
(8, 'Priya Joshi', 'Kolkata', 'Newborn', '9880012352'),
(9, 'Karan Singh', 'Jaipur', 'Travel', '9890012353'),
(10, 'Pooja Shah', 'Lucknow', 'Fashion', '9900012354');

-- Table 3: 
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    ClientID INT,
    PhotographerID INT,
    EventDate DATE,
    Location VARCHAR(100),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (PhotographerID) REFERENCES Photographers(PhotographerID)
);

INSERT INTO Bookings VALUES
(1, 1, 1, '2024-06-10', 'Connaught Place, Delhi'),
(2, 2, 2, '2024-06-15', 'Juhu Beach, Mumbai'),
(3, 3, 3, '2024-06-20', 'Marina Beach, Chennai'),
(4, 4, 4, '2024-06-22', 'Maninagar, Ahmedabad'),
(5, 5, 5, '2024-06-25', 'FC Road, Pune'),
(6, 6, 6, '2024-06-18', 'Banjara Hills, Hyderabad'),
(7, 7, 7, '2024-06-19', 'Park Street, Kolkata'),
(8, 8, 8, '2024-06-21', 'Indiranagar, Bangalore'),
(9, 9, 9, '2024-06-23', 'MI Road, Jaipur'),
(10, 10, 10, '2024-06-26', 'Hazratganj, Lucknow');

-- Table 4: 
CREATE TABLE Portfolios (
    PortfolioID INT PRIMARY KEY,
    PhotographerID INT,
    Category VARCHAR(50),
    FileName VARCHAR(100),
    UploadDate DATE,
    FOREIGN KEY (PhotographerID) REFERENCES Photographers(PhotographerID)
);

INSERT INTO Portfolios VALUES
(1, 1, 'Wedding', 'wedding1.jpg', '2024-05-01'),
(2, 2, 'Fashion', 'fashion1.jpg', '2024-05-03'),
(3, 3, 'Wildlife', 'wildlife1.jpg', '2024-05-05'),
(4, 4, 'Portrait', 'portrait1.jpg', '2024-05-07'),
(5, 5, 'Event', 'event1.jpg', '2024-05-09'),
(6, 6, 'Product', 'product1.jpg', '2024-05-11'),
(7, 7, 'Wedding', 'wedding2.jpg', '2024-05-13'),
(8, 8, 'Newborn', 'newborn1.jpg', '2024-05-15'),
(9, 9, 'Travel', 'travel1.jpg', '2024-05-17'),
(10, 10, 'Fashion', 'fashion2.jpg', '2024-05-19');

-- Table 5:
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY,
    PhotographerID INT,
    ServiceType VARCHAR(100),
    Duration VARCHAR(50),
    RatePerHour DECIMAL(8,2),
    FOREIGN KEY (PhotographerID) REFERENCES Photographers(PhotographerID)
);

INSERT INTO Services VALUES
(1, 1, 'Wedding Shoot', '6 Hours', 5000.00),
(2, 2, 'Fashion Shoot', '4 Hours', 4000.00),
(3, 3, 'Wildlife Session', '8 Hours', 7000.00),
(4, 4, 'Portrait Session', '2 Hours', 2500.00),
(5, 5, 'Event Coverage', '5 Hours', 4500.00),
(6, 6, 'Product Photography', '3 Hours', 3000.00),
(7, 7, 'Wedding Shoot', '7 Hours', 5200.00),
(8, 8, 'Newborn Shoot', '3 Hours', 3500.00),
(9, 9, 'Travel Coverage', '6 Hours', 4800.00),
(10, 10, 'Fashion Shoot', '5 Hours', 4200.00);

-- ------------------------------------------------ 26th Database --------------------------------------------------------
-- create a database
CREATE DATABASE ArtExhibitionDB;

-- use the created database
USE ArtExhibitionDB;
-- Table 1: 
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Style VARCHAR(50),
    Contact VARCHAR(15)
);

INSERT INTO Artists VALUES
(1, 'Aarav Mehta', 'Ahmedabad', 'Abstract', '9820001111'),
(2, 'Ishita Sharma', 'Delhi', 'Portrait', '9820001112'),
(3, 'Rohan Desai', 'Mumbai', 'Modern', '9820001113'),
(4, 'Sneha Nair', 'Chennai', 'Traditional', '9820001114'),
(5, 'Vikram Joshi', 'Pune', 'Landscape', '9820001115'),
(6, 'Neha Reddy', 'Hyderabad', 'Sculpture', '9820001116'),
(7, 'Manav Gupta', 'Bangalore', 'Abstract', '9820001117'),
(8, 'Pooja Iyer', 'Kolkata', 'Portrait', '9820001118'),
(9, 'Kunal Shah', 'Jaipur', 'Modern', '9820001119'),
(10, 'Divya Verma', 'Lucknow', 'Folk', '9820001120');

-- Table 2: 
CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    ArtistID INT,
    Title VARCHAR(100),
    Type VARCHAR(50),
    CreationYear INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

INSERT INTO Artworks VALUES
(1, 1, 'Rangoli Vibes', 'Painting', 2023),
(2, 2, 'Inner Soul', 'Sketch', 2022),
(3, 3, 'Chaos in Colors', 'Painting', 2024),
(4, 4, 'Divine Harmony', 'Mural', 2021),
(5, 5, 'Himalayan View', 'Painting', 2022),
(6, 6, 'Stone Whisper', 'Sculpture', 2020),
(7, 7, 'Mind Maze', 'Digital Art', 2023),
(8, 8, 'The Eyes', 'Portrait', 2022),
(9, 9, 'Fusion Festival', 'Canvas', 2024),
(10, 10, 'Folk Rhythms', 'Wall Art', 2023);

-- Table 3: 
CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Exhibitions VALUES
(1, 'Kala Utsav', 'Delhi', '2024-06-01', '2024-06-10'),
(2, 'Rang Parv', 'Mumbai', '2024-06-05', '2024-06-12'),
(3, 'Chitrakala Mela', 'Bangalore', '2024-06-10', '2024-06-15'),
(4, 'Kalangan', 'Chennai', '2024-06-03', '2024-06-08'),
(5, 'Drishti', 'Ahmedabad', '2024-06-11', '2024-06-20'),
(6, 'Srujan', 'Hyderabad', '2024-06-07', '2024-06-14'),
(7, 'Kala Ghar', 'Kolkata', '2024-06-09', '2024-06-18'),
(8, 'Art Fusion', 'Pune', '2024-06-04', '2024-06-10'),
(9, 'Kala Darshan', 'Jaipur', '2024-06-06', '2024-06-12'),
(10, 'Canvas India', 'Lucknow', '2024-06-08', '2024-06-13');

-- Table 4: 
CREATE TABLE ExhibitionArtworks (
    ID INT PRIMARY KEY,
    ExhibitionID INT,
    ArtworkID INT,
    DisplaySpot VARCHAR(50),
    Price DECIMAL(10,2),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions(ExhibitionID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks(ArtworkID)
);

INSERT INTO ExhibitionArtworks VALUES
(1, 1, 1, 'Hall A1', 15000.00),
(2, 2, 2, 'Hall B2', 12000.00),
(3, 3, 3, 'Hall C1', 18000.00),
(4, 4, 4, 'Wall D3', 10000.00),
(5, 5, 5, 'Wall E1', 11000.00),
(6, 6, 6, 'Podium F2', 20000.00),
(7, 7, 7, 'Booth G1', 9000.00),
(8, 8, 8, 'Hall H4', 13000.00),
(9, 9, 9, 'Panel I2', 16000.00),
(10, 10, 10, 'Wall J1', 9500.00);

-- Table 5:
CREATE TABLE Visitors (
    VisitorID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100),
    ExhibitionID INT,
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions(ExhibitionID)
);

INSERT INTO Visitors VALUES
(1, 'Siddharth Rao', 'Delhi', 'sid.rao@gmail.com', 1),
(2, 'Nisha Sharma', 'Mumbai', 'nisha.s@gmail.com', 2),
(3, 'Akash Patel', 'Bangalore', 'akash.p@gmail.com', 3),
(4, 'Mitali Nair', 'Chennai', 'mitali.n@gmail.com', 4),
(5, 'Ritesh Shah', 'Ahmedabad', 'ritesh.shah@gmail.com', 5),
(6, 'Aarti Reddy', 'Hyderabad', 'aarti.r@gmail.com', 6),
(7, 'Tushar Banerjee', 'Kolkata', 'tushar.b@gmail.com', 7),
(8, 'Kavita Joshi', 'Pune', 'kavita.j@gmail.com', 8),
(9, 'Naman Singh', 'Jaipur', 'naman.singh@gmail.com', 9),
(10, 'Rekha Verma', 'Lucknow', 'rekha.v@gmail.com', 10);

-- ------------------------------------------------ 27th Database --------------------------------------------------------
-- create a database
CREATE DATABASE InternshipPortalDB;

-- use the created database
USE InternshipPortalDB;

-- Table 1: 
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100),
    College VARCHAR(100)
);

INSERT INTO Students VALUES
(1, 'Riya Sharma', 'Delhi', 'riya.s@gmail.com', 'DU'),
(2, 'Aman Verma', 'Mumbai', 'aman.v@gmail.com', 'Mumbai Univ'),
(3, 'Sneha Iyer', 'Chennai', 'sneha.i@gmail.com', 'Anna Univ'),
(4, 'Rohit Patel', 'Ahmedabad', 'rohit.p@gmail.com', 'Gujarat Univ'),
(5, 'Divya Reddy', 'Hyderabad', 'divya.r@gmail.com', 'Osmania Univ'),
(6, 'Kunal Singh', 'Lucknow', 'kunal.s@gmail.com', 'LU'),
(7, 'Ishita Nair', 'Kolkata', 'ishita.n@gmail.com', 'Calcutta Univ'),
(8, 'Tushar Mehta', 'Pune', 'tushar.m@gmail.com', 'SPPU'),
(9, 'Anjali Joshi', 'Bangalore', 'anjali.j@gmail.com', 'BU'),
(10, 'Nikhil Das', 'Bhopal', 'nikhil.d@gmail.com', 'Barkatullah Univ');

-- Table 2: 
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100),
    College VARCHAR(100)
);

INSERT INTO Students VALUES
(1, 'Riya Sharma', 'Delhi', 'riya.s@gmail.com', 'DU'),
(2, 'Aman Verma', 'Mumbai', 'aman.v@gmail.com', 'Mumbai Univ'),
(3, 'Sneha Iyer', 'Chennai', 'sneha.i@gmail.com', 'Anna Univ'),
(4, 'Rohit Patel', 'Ahmedabad', 'rohit.p@gmail.com', 'Gujarat Univ'),
(5, 'Divya Reddy', 'Hyderabad', 'divya.r@gmail.com', 'Osmania Univ'),
(6, 'Kunal Singh', 'Lucknow', 'kunal.s@gmail.com', 'LU'),
(7, 'Ishita Nair', 'Kolkata', 'ishita.n@gmail.com', 'Calcutta Univ'),
(8, 'Tushar Mehta', 'Pune', 'tushar.m@gmail.com', 'SPPU'),
(9, 'Anjali Joshi', 'Bangalore', 'anjali.j@gmail.com', 'BU'),
(10, 'Nikhil Das', 'Bhopal', 'nikhil.d@gmail.com', 'Barkatullah Univ');

-- Table 3: 
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Sector VARCHAR(50),
    Contact VARCHAR(15)
);

INSERT INTO Companies VALUES
(1, 'Infosys', 'Pune', 'IT', '9820011001'),
(2, 'Wipro', 'Bangalore', 'IT', '9820011002'),
(3, 'TCS', 'Mumbai', 'IT', '9820011003'),
(4, 'Biocon', 'Bangalore', 'Biotech', '9820011004'),
(5, 'HCL', 'Noida', 'IT', '9820011005'),
(6, 'L&T', 'Chennai', 'Engineering', '9820011006'),
(7, 'Zydus', 'Ahmedabad', 'Pharma', '9820011007'),
(8, 'Tech Mahindra', 'Hyderabad', 'IT', '9820011008'),
(9, 'Accenture', 'Mumbai', 'Consulting', '9820011009'),
(10, 'Cipla', 'Goa', 'Pharma', '9820011010');

-- Table 4: 
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    StudentID INT,
    InternshipID INT,
    Status VARCHAR(20),
    ApplyDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (InternshipID) REFERENCES Internships(InternshipID)
);

INSERT INTO Applications VALUES
(1, 1, 1, 'Applied', '2024-05-01'),
(2, 2, 2, 'Selected', '2024-05-02'),
(3, 3, 3, 'Rejected', '2024-05-03'),
(4, 4, 4, 'Applied', '2024-05-04'),
(5, 5, 5, 'Selected', '2024-05-05'),
(6, 6, 6, 'Applied', '2024-05-06'),
(7, 7, 7, 'Rejected', '2024-05-07'),
(8, 8, 8, 'Applied', '2024-05-08'),
(9, 9, 9, 'Selected', '2024-05-09'),
(10, 10, 10, 'Applied', '2024-05-10');

-- Table 5:
CREATE TABLE Mentors (
    MentorID INT PRIMARY KEY,
    Name VARCHAR(100),
    InternshipID INT,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    FOREIGN KEY (InternshipID) REFERENCES Internships(InternshipID)
);

INSERT INTO Mentors VALUES
(1, 'Manish Kapoor', 1, 'manish.k@infosys.com', '9988001100'),
(2, 'Neha Gupta', 2, 'neha.g@wipro.com', '9988001101'),
(3, 'Sanjay Nair', 3, 'sanjay.n@tcs.com', '9988001102'),
(4, 'Preeti Rao', 4, 'preeti.r@biocon.com', '9988001103'),
(5, 'Rajesh Yadav', 5, 'rajesh.y@hcl.com', '9988001104'),
(6, 'Shilpa Reddy', 6, 'shilpa.r@lnt.com', '9988001105'),
(7, 'Amit Shah', 7, 'amit.s@zydus.com', '9988001106'),
(8, 'Ritika Jain', 8, 'ritika.j@techm.com', '9988001107'),
(9, 'Ankur Mishra', 9, 'ankur.m@accenture.com', '9988001108'),
(10, 'Kavita Iyer', 10, 'kavita.i@cipla.com', '9988001109');

-- ------------------------------------------------ 28th Database --------------------------------------------------------
-- create a database
CREATE DATABASE MilkGroceryDB;

-- use the created database
USE MilkGroceryDB;

-- Table 1: 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Address VARCHAR(255)
);

INSERT INTO Customers VALUES
(1, 'Anjali Mehta', '9876543210', 'Mumbai', 'Andheri West'),
(2, 'Ramesh Yadav', '9876543211', 'Delhi', 'Laxmi Nagar'),
(3, 'Sneha Iyer', '9876543212', 'Chennai', 'T. Nagar'),
(4, 'Vikram Joshi', '9876543213', 'Pune', 'Kothrud'),
(5, 'Divya Sharma', '9876543214', 'Jaipur', 'Malviya Nagar'),
(6, 'Amit Verma', '9876543215', 'Bhopal', 'MP Nagar'),
(7, 'Priya Reddy', '9876543216', 'Hyderabad', 'Kukatpally'),
(8, 'Rahul Sen', '9876543217', 'Kolkata', 'Salt Lake'),
(9, 'Neha Kapoor', '9876543218', 'Chandigarh', 'Sector 17'),
(10, 'Arjun Das', '9876543219', 'Lucknow', 'Gomti Nagar');

-- Table 2: 
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Category VARCHAR(50),
    Unit VARCHAR(20),
    Price DECIMAL(6,2)
);

INSERT INTO Products VALUES
(1, 'Cow Milk', 'Milk', 'Litre', 55.00),
(2, 'Buffalo Milk', 'Milk', 'Litre', 60.00),
(3, 'Bread', 'Grocery', 'Pack', 30.00),
(4, 'Eggs', 'Grocery', 'Dozen', 70.00),
(5, 'Butter', 'Grocery', '500g', 180.00),
(6, 'Paneer', 'Grocery', '500g', 120.00),
(7, 'Wheat Flour', 'Grocery', 'Kg', 45.00),
(8, 'Rice', 'Grocery', 'Kg', 55.00),
(9, 'Curd', 'Milk', '500g', 40.00),
(10, 'Tea Leaves', 'Grocery', '250g', 90.00);

-- Table 3: 
CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    CustomerID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Subscriptions VALUES
(1, 1, '2024-06-01', '2024-06-30', 'Active'),
(2, 2, '2024-06-05', '2024-07-05', 'Active'),
(3, 3, '2024-06-10', '2024-07-10', 'Active'),
(4, 4, '2024-06-01', '2024-06-30', 'Inactive'),
(5, 5, '2024-06-15', '2024-07-15', 'Active'),
(6, 6, '2024-06-20', '2024-07-20', 'Active'),
(7, 7, '2024-06-01', '2024-06-30', 'Active'),
(8, 8, '2024-06-03', '2024-07-03', 'Inactive'),
(9, 9, '2024-06-10', '2024-07-10', 'Active'),
(10, 10, '2024-06-12', '2024-07-12', 'Active');

-- Table 4: 
CREATE TABLE DeliveryPersons (
    DeliveryID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Area VARCHAR(100),
    VehicleType VARCHAR(50)
);

INSERT INTO DeliveryPersons VALUES
(1, 'Santosh Kumar', '9000011111', 'Andheri West', 'Scooter'),
(2, 'Ravi Singh', '9000011112', 'Laxmi Nagar', 'Bike'),
(3, 'Suresh Babu', '9000011113', 'T. Nagar', 'Cycle'),
(4, 'Ajay Patil', '9000011114', 'Kothrud', 'Scooter'),
(5, 'Sunil Jain', '9000011115', 'Malviya Nagar', 'Bike'),
(6, 'Vinod Thakur', '9000011116', 'MP Nagar', 'Scooter'),
(7, 'Mahesh Reddy', '9000011117', 'Kukatpally', 'Bike'),
(8, 'Arindam Ghosh', '9000011118', 'Salt Lake', 'Cycle'),
(9, 'Baljeet Singh', '9000011119', 'Sector 17', 'Bike'),
(10, 'Naseem Khan', '9000011120', 'Gomti Nagar', 'Scooter');

-- Table 5:
CREATE TABLE DeliveryRecords (
    RecordID INT PRIMARY KEY,
    SubscriptionID INT,
    DeliveryDate DATE,
    DeliveryID INT,
    Status VARCHAR(20),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscriptions(SubscriptionID),
    FOREIGN KEY (DeliveryID) REFERENCES DeliveryPersons(DeliveryID)
);

INSERT INTO DeliveryRecords VALUES
(1, 1, '2024-06-01', 1, 'Delivered'),
(2, 2, '2024-06-05', 2, 'Delivered'),
(3, 3, '2024-06-10', 3, 'Missed'),
(4, 4, '2024-06-01', 4, 'Delivered'),
(5, 5, '2024-06-15', 5, 'Delivered'),
(6, 6, '2024-06-20', 6, 'Delivered'),
(7, 7, '2024-06-01', 7, 'Missed'),
(8, 8, '2024-06-03', 8, 'Delivered'),
(9, 9, '2024-06-10', 9, 'Delivered'),
(10, 10, '2024-06-12', 10, 'Delivered');

-- ------------------------------------------------ 29th Database --------------------------------------------------------
-- create a database
CREATE DATABASE HomeRepairDB;

-- use the created database
USE HomeRepairDB;

-- Table 1: 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Address VARCHAR(255)
);

INSERT INTO Customers VALUES
(1, 'Pooja Sharma', '9876543001', 'Delhi', 'Lajpat Nagar'),
(2, 'Rahul Verma', '9876543002', 'Mumbai', 'Borivali'),
(3, 'Sangeeta Reddy', '9876543003', 'Hyderabad', 'Banjara Hills'),
(4, 'Anil Mehta', '9876543004', 'Jaipur', 'Vaishali Nagar'),
(5, 'Neha Joshi', '9876543005', 'Pune', 'Shivaji Nagar'),
(6, 'Vikram Rao', '9876543006', 'Bangalore', 'Indiranagar'),
(7, 'Sunita Yadav', '9876543007', 'Lucknow', 'Hazratganj'),
(8, 'Ravi Patel', '9876543008', 'Ahmedabad', 'Maninagar'),
(9, 'Divya Nair', '9876543009', 'Kochi', 'Edapally'),
(10, 'Amitabh Desai', '9876543010', 'Nagpur', 'Civil Lines');

-- Table 2: 
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Category VARCHAR(50),
    Duration VARCHAR(20),
    BaseRate DECIMAL(6,2)
);

INSERT INTO Services VALUES
(1, 'Electrician Visit', 'Electrical', '1 Hour', 300.00),
(2, 'Plumbing Fix', 'Plumbing', '1 Hour', 350.00),
(3, 'AC Repair', 'Appliances', '2 Hours', 800.00),
(4, 'Painting', 'Interior', '4 Hours', 1500.00),
(5, 'Carpentry', 'Furniture', '2 Hours', 600.00),
(6, 'Water Purifier Service', 'Appliances', '1 Hour', 500.00),
(7, 'Geyser Repair', 'Appliances', '1.5 Hours', 550.00),
(8, 'Pest Control', 'Sanitation', '2 Hours', 700.00),
(9, 'Roof Leakage Fix', 'Roofing', '3 Hours', 1000.00),
(10, 'Door Lock Fix', 'Hardware', '1 Hour', 250.00);

-- Table 3: 
CREATE TABLE Technicians (
    TechnicianID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Skill VARCHAR(50)
);

INSERT INTO Technicians VALUES
(1, 'Suraj Gupta', '9999900011', 'Delhi', 'Electrician'),
(2, 'Mohit Sinha', '9999900012', 'Mumbai', 'Plumber'),
(3, 'Ravi Teja', '9999900013', 'Hyderabad', 'AC Repair'),
(4, 'Satyam Sharma', '9999900014', 'Jaipur', 'Painter'),
(5, 'Arvind Naik', '9999900015', 'Pune', 'Carpenter'),
(6, 'Kiran Kumar', '9999900016', 'Bangalore', 'Geyser Repair'),
(7, 'Sushil Yadav', '9999900017', 'Lucknow', 'Water Purifier'),
(8, 'Anand Patel', '9999900018', 'Ahmedabad', 'Pest Control'),
(9, 'Suhas Menon', '9999900019', 'Kochi', 'Roofing'),
(10, 'Farhan Khan', '9999900020', 'Nagpur', 'Locksmith');

-- Table 4: 
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    ServiceID INT,
    TechnicianID INT,
    BookingDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
    FOREIGN KEY (TechnicianID) REFERENCES Technicians(TechnicianID)
);

INSERT INTO Bookings VALUES
(1, 1, 1, 1, '2024-06-01'),
(2, 2, 2, 2, '2024-06-02'),
(3, 3, 3, 3, '2024-06-03'),
(4, 4, 4, 4, '2024-06-04'),
(5, 5, 5, 5, '2024-06-05'),
(6, 6, 7, 6, '2024-06-06'),
(7, 7, 6, 7, '2024-06-07'),
(8, 8, 8, 8, '2024-06-08'),
(9, 9, 9, 9, '2024-06-09'),
(10, 10, 10, 10, '2024-06-10');

-- Table 5:
CREATE TABLE Feedbacks (
    FeedbackID INT PRIMARY KEY,
    BookingID INT,
    Rating INT,
    Comments VARCHAR(255),
    DateGiven DATE,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

INSERT INTO Feedbacks VALUES
(1, 1, 5, 'Bahut accha service tha', '2024-06-02'),
(2, 2, 4, 'Theek tha, samay pe aaya', '2024-06-03'),
(3, 3, 5, 'AC ab sahi kaam kar raha hai', '2024-06-04'),
(4, 4, 3, 'Paint thoda uneven tha', '2024-06-05'),
(5, 5, 5, 'Excellent carpentry work', '2024-06-06'),
(6, 6, 4, 'Geyser chal gaya', '2024-06-07'),
(7, 7, 3, 'Water purifier thoda noise kar raha hai', '2024-06-08'),
(8, 8, 4, 'Pest control acha tha', '2024-06-09'),
(9, 9, 5, 'Leakage properly fix ho gaya', '2024-06-10'),
(10, 10, 5, 'Fast and neat lock fix', '2024-06-11');

-- ------------------------------------------------ 30th Database --------------------------------------------------------
-- create a database
CREATE DATABASE DisasterReliefDB;

-- use the created database
USE DisasterReliefDB;

-- Table 1: 
CREATE TABLE ReliefCenters (
    CenterID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Address VARCHAR(255),
    Capacity INT
);

INSERT INTO ReliefCenters VALUES
(1, 'Seva Kendra', 'Delhi', 'Rohini Sector 5', 200),
(2, 'Jeevan Jyoti', 'Mumbai', 'Andheri West', 150),
(3, 'Hope Shelter', 'Chennai', 'T Nagar', 180),
(4, 'Sahara Bhawan', 'Lucknow', 'Alambagh', 220),
(5, 'Aasha Ghar', 'Kolkata', 'Salt Lake', 170),
(6, 'Nayi Disha', 'Hyderabad', 'Banjara Hills', 160),
(7, 'Umeed Center', 'Bhopal', 'MP Nagar', 140),
(8, 'Prerna House', 'Jaipur', 'Malviya Nagar', 190),
(9, 'Suraksha Sadan', 'Ahmedabad', 'Navrangpura', 210),
(10, 'Jeevan Daan', 'Patna', 'Kankarbagh', 160);

-- Table 2: 
CREATE TABLE Volunteers (
    VolunteerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    CenterID INT,
    FOREIGN KEY (CenterID) REFERENCES ReliefCenters(CenterID)
);

INSERT INTO Volunteers VALUES
(1, 'Ravi Kumar', '9876543211', 'Delhi', 1),
(2, 'Meena Joshi', '9876543212', 'Mumbai', 2),
(3, 'Amit Verma', '9876543213', 'Chennai', 3),
(4, 'Pooja Sharma', '9876543214', 'Lucknow', 4),
(5, 'Anil Mehta', '9876543215', 'Kolkata', 5),
(6, 'Sunita Yadav', '9876543216', 'Hyderabad', 6),
(7, 'Vikram Rao', '9876543217', 'Bhopal', 7),
(8, 'Divya Nair', '9876543218', 'Jaipur', 8),
(9, 'Sanjay Patel', '9876543219', 'Ahmedabad', 9),
(10, 'Neha Singh', '9876543220', 'Patna', 10);

-- Table 3: 
CREATE TABLE Supplies (
    SupplyID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    Quantity INT,
    Unit VARCHAR(20),
    CenterID INT,
    FOREIGN KEY (CenterID) REFERENCES ReliefCenters(CenterID)
);

INSERT INTO Supplies VALUES
(1, 'Rice Bags', 100, 'kg', 1),
(2, 'Bottled Water', 200, 'litre', 2),
(3, 'Blankets', 50, 'units', 3),
(4, 'Medical Kits', 30, 'units', 4),
(5, 'Biscuits Packets', 150, 'units', 5),
(6, 'Clothes', 70, 'units', 6),
(7, 'Cooking Oil', 40, 'litre', 7),
(8, 'First Aid Boxes', 25, 'units', 8),
(9, 'Toiletries', 80, 'kits', 9),
(10, 'Milk Packets', 90, 'litre', 10);

-- Table 4: 
CREATE TABLE AffectedFamilies (
    FamilyID INT PRIMARY KEY,
    HeadName VARCHAR(100),
    Members INT,
    City VARCHAR(50),
    CenterID INT,
    FOREIGN KEY (CenterID) REFERENCES ReliefCenters(CenterID)
);

INSERT INTO AffectedFamilies VALUES
(1, 'Ramesh Lal', 5, 'Delhi', 1),
(2, 'Shabana Begum', 4, 'Mumbai', 2),
(3, 'Muthu Kumar', 6, 'Chennai', 3),
(4, 'Kiran Devi', 3, 'Lucknow', 4),
(5, 'Prakash Mondal', 7, 'Kolkata', 5),
(6, 'Kavita Rao', 4, 'Hyderabad', 6),
(7, 'Manoj Jaiswal', 6, 'Bhopal', 7),
(8, 'Alka Jain', 5, 'Jaipur', 8),
(9, 'Bhavesh Shah', 4, 'Ahmedabad', 9),
(10, 'Sita Devi', 5, 'Patna', 10);

-- Table 5:
CREATE TABLE Distribution (
    DistributionID INT PRIMARY KEY,
    FamilyID INT,
    SupplyID INT,
    QuantityGiven INT,
    DateGiven DATE,
    FOREIGN KEY (FamilyID) REFERENCES AffectedFamilies(FamilyID),
    FOREIGN KEY (SupplyID) REFERENCES Supplies(SupplyID)
);

INSERT INTO Distribution VALUES
(1, 1, 1, 20, '2024-06-01'),
(2, 2, 2, 30, '2024-06-02'),
(3, 3, 3, 5, '2024-06-03'),
(4, 4, 4, 2, '2024-06-04'),
(5, 5, 5, 10, '2024-06-05'),
(6, 6, 6, 15, '2024-06-06'),
(7, 7, 7, 5, '2024-06-07'),
(8, 8, 8, 3, '2024-06-08'),
(9, 9, 9, 8, '2024-06-09'),
(10, 10, 10, 10, '2024-06-10');
