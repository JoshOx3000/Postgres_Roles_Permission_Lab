-- Create Schema
CREATE SCHEMA hr;

-- Create employees table
CREATE TABLE hr.employees(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	salary NUMERIC(10,2),
	department VARCHAR(50)
);


-- Insert sample data
INSERT INTO hr.employees (first_name, last_name, salary, department)
VALUES
('John', 'Doe', 75000, 'IT'),
('Jane', 'Smith', 68000, 'HR'),
('Mike', 'Brown', 82000, 'Finance');


-- Test
SELECT *
FROM hr.employees;

-- Create Roles

-- Create Read only role
CREATE ROLE hr_readonly;

-- Create Read-Write Role
CREATE ROLE hr_readwrite;


-- Create Users
CREATE ROLE jane LOGIN PASSWORD 'jane123';

CREATE ROLE john LOGIN PASSWORD 'john123';


-- Assign Users to Group Roles
GRANT hr_readonly TO jane;

GRANT hr_readwrite to john;


-- Grant Permissions to Roles
GRANT USAGE ON SCHEMA hr to hr_readonly;

GRANT USAGE ON Schema hr to hr_readwrite;

-- Grant Table Permissions

-- Read-Only role
GRANT SELECT ON ALL TABLES IN SCHEMA hr TO hr_readonly;

-- Read-Write Role:
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA hr
TO hr_readwrite;


-- Revoke Permissions

-- remove John's delete ability:
REVOKE DELETE ON ALL TABLES IN SCHEMA hr 
FROM hr_readwrite;

-- Set up of Default Privileges
-- use case: if you create new tables later, roles won't automatically get access
-- unless you set default privileges.

ALTER DEFAULT PRIVILEGES IN SCHEMA hr
GRANT SELECT ON TABLES TO hr_readonly;

ALTER DEFAULT PRIVILEGES IN SCHEMA hr
GRANT SELECT, INSERT, UPDATE ON TABLES to hr_readwrite;


SELECT rolname
FROM pg_roles;



