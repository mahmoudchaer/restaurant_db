
-- HR role
CREATE ROLE hr_role NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD 'hr123';


-- Grant HR access only to Chefs, Waiters, and Drivers
GRANT SELECT, INSERT, UPDATE, DELETE ON chef TO hr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON waiter TO hr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON delivery_driver TO hr_role;


-- Create specific users and assign them roles
CREATE USER hr_user WITH PASSWORD 'hr123';
GRANT hr_role TO hr_user;

-- --------------------------------------------------------------------------

-- Admin role
CREATE ROLE manager_role NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD 'mng123';

-- Grant Manager access to all tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO manager_role;


CREATE USER manager_user WITH PASSWORD 'mng123';
GRANT manager_role TO manager_user;

-- --------------------------------------------------------------------------



