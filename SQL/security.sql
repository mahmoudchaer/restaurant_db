
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

-- Customer role
CREATE ROLE customer_role NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD 'cust123';



GRANT SELECT ON menu TO customer_role;
GRANT SELECT ON composed_of TO customer_role;
GRANT SELECT ON image_meal TO customer_role;
GRANT SELECT ON review TO customer_role;



CREATE USER customer_user WITH PASSWORD 'cust123';
GRANT customer_role TO customer_user;

-- --------------------------------------------------------------------------

-- Staff role
CREATE ROLE Staff_role NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD 'staff123';



GRANT SELECT ON menu TO staff_role;
GRANT SELECT ON composed_of TO staff_role;
GRANT SELECT ON delivery_driver TO staff_role;
GRANT SELECT, INSERT ON meal TO staff_role;
GRANT SELECT, INSERT ON contain TO staff_role;
GRANT SELECT, INSERT ON customer_order TO staff_role;
GRANT SELECT, INSERT ON places TO staff_role;


CREATE USER staff_user WITH PASSWORD 'staff123';
GRANT staff_role TO staff_user;

