
CREATE ROLE hr_role NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD 'hr123';

-- Grant HR access only to Chefs, Waiters, and Drivers
GRANT SELECT, INSERT, UPDATE, DELETE ON Chefs TO hr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Waiters TO hr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Drivers TO hr_role;

-- Deny HR access to Meals and Menus
REVOKE ALL ON Meals FROM hr_role;
REVOKE ALL ON Menus FROM hr_role;


-- Create specific users and assign them roles
CREATE USER hr_user WITH PASSWORD 'hr123';
GRANT hr_role TO hr_user;


