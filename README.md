# Postgres_Roles_Permission_Lab
This project demonstrates Role-Based Access Control (RBAC) in PostgreSQL 18 using pgAdmin 4
The lab simulates a small HR system where different users have different levels of access:

Read-only access

Read-write access

Controlled privilege revocation

Default privilege configuration for future tables

This project showcases foundational PostgreSQL DBA skills related to security and access management.

🛠 Technologies Used

PostgreSQL 18

pgAdmin 4

SQL

🗂 Project Structure
postgresql-role-permissions-lab/
│
├── rbac_lab.sql
└── README.md

🧱 Database Setup
Create Schema
CREATE SCHEMA hr;

Create Employees Table
CREATE TABLE hr.employees(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	salary NUMERIC(10,2),
	department VARCHAR(50)
);

Insert Sample Data
INSERT INTO hr.employees (first_name, last_name, salary, department)
VALUES
('John', 'Doe', 75000, 'IT'),
('Jane', 'Smith', 68000, 'HR'),
('Mike', 'Brown', 82000, 'Finance');

Test Data
SELECT *
FROM hr.employees;

👥 Role Creation
Create Group Roles
CREATE ROLE hr_readonly;
CREATE ROLE hr_readwrite;

Create Login Users
CREATE ROLE jane LOGIN PASSWORD 'jane123';
CREATE ROLE john LOGIN PASSWORD 'john123';

Assign Users to Roles
GRANT hr_readonly TO jane;
GRANT hr_readwrite TO john;

🔐 Permission Management
Grant Schema Usage
GRANT USAGE ON SCHEMA hr TO hr_readonly;
GRANT USAGE ON SCHEMA hr TO hr_readwrite;

Grant Table Privileges

Read-Only Role

GRANT SELECT ON ALL TABLES IN SCHEMA hr TO hr_readonly;


Read-Write Role

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA hr
TO hr_readwrite;

🔁 Revoking Privileges

To remove John’s DELETE permission:

REVOKE DELETE ON ALL TABLES IN SCHEMA hr 
FROM hr_readwrite;


This demonstrates granular privilege control.

🔄 Default Privileges

To ensure future tables inherit permissions automatically:

ALTER DEFAULT PRIVILEGES IN SCHEMA hr
GRANT SELECT ON TABLES TO hr_readonly;

ALTER DEFAULT PRIVILEGES IN SCHEMA hr
GRANT SELECT, INSERT, UPDATE ON TABLES TO hr_readwrite;


This prevents permission issues when new tables are created.

🔎 Role Verification

Check available roles:

SELECT rolname
FROM pg_roles;

🧪 Testing Access in pgAdmin 4

To validate permissions:

Register a new server in pgAdmin

Login as:

jane → read-only access

john → read-write access (no DELETE after revoke)

Verify active user:

SELECT current_user;

🎯 Skills Demonstrated

  -PostgreSQL Role Management

  -Grant & Revoke Privileges

  -Schema-Level Security

  -Default Privileges Configuration

  -Principle of Least Privilege

  -Multi-user Access Testing

  -Basic Security Hardening
