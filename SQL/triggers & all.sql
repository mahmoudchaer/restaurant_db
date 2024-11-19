--TRIGGERS & FUNCTIONS

--Increment number of chefs in the appropritate station by one each time a chef is added to a station
CREATE OR REPLACE FUNCTION increment_chef_count_function()
RETURNS TRIGGER AS $$
BEGIN
  -- Increment the number of chefs for the specified kitchen station based on station_name
  UPDATE kitchen_station
  SET number_of_chefs = number_of_chefs + 1
  WHERE station_name = NEW.works_in;  -- Referring to the works_in attribute from the inserted row in chef table
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increment_chef_count
AFTER INSERT ON chef
FOR EACH ROW
EXECUTE FUNCTION increment_chef_count_function();


-- Decrement chef count in the appropriate station whenever a chef is deleted
CREATE OR REPLACE FUNCTION decrement_chef_count_function()
RETURNS TRIGGER AS $$
BEGIN
  -- Decrement the number of chefs for the specified kitchen station based on station_name
  UPDATE kitchen_station
  SET number_of_chefs = number_of_chefs - 1
  WHERE station_name = OLD.works_in;  -- Referring to the works_in attribute from the deleted row in chef table
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER decrement_chef_count
AFTER DELETE ON chef
FOR EACH ROW
EXECUTE FUNCTION decrement_chef_count_function();



-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

--Procedures

CREATE PROCEDURE UpdateChefSalary(
    IN p_employee_id id_type ,
    IN new_salary DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE chef 
    SET salary = new_salary
    WHERE chef.employee_id = p_employee_id;
END;
$$;

CALL UpdateChefSalary('C13', 5.00);

CREATE PROCEDURE UpdateWaiterSalary(
    IN p_employee_id id_type ,
    IN new_salary DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE waiter 
    SET salary = new_salary
    WHERE waiter.employee_id = p_employee_id;
END;
$$;

CALL UpdateWaiterSalary('W5', 25.00);

CREATE or replace PROCEDURE raise_chef_salary(
    station_name VARCHAR,
    percentage_increase DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update salaries for chefs in the given kitchen station
    UPDATE Chef
    SET Salary = Salary + (Salary * (percentage_increase / 100))
    WHERE works_in = station_name;

    -- Notify about the success
    RAISE NOTICE 'Salary updated for chefs in station: %', station_name;
END;
$$;
CALL raise_chef_salary('Dessert Station', 1000.00);



--Triggers
-- Increment chef count
CREATE OR REPLACE FUNCTION increment_chef_count_function()
RETURNS TRIGGER AS $$
BEGIN
  -- Increment the number of chefs for the specified kitchen station based on station_name
  UPDATE kitchen_station
  SET number_of_chefs = number_of_chefs + 1
  WHERE station_name = NEW.works_in;  -- Referring to the works_in attribute from the inserted row in chef table
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increment_chef_count
AFTER INSERT ON chef
FOR EACH ROW
EXECUTE FUNCTION increment_chef_count_function();

-- ---------------------------------------------------------------------------------------

-- Decrement chef count
CREATE OR REPLACE FUNCTION decrement_chef_count_function()
RETURNS TRIGGER AS $$
BEGIN
  -- Decrement the number of chefs for the specified kitchen station based on station_name
  UPDATE kitchen_station
  SET number_of_chefs = number_of_chefs - 1
  WHERE station_name = OLD.works_in;  -- Referring to the works_in attribute from the deleted row in chef table
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER decrement_chef_count
AFTER DELETE ON chef
FOR EACH ROW
EXECUTE FUNCTION decrement_chef_count_function();


CREATE PROCEDURE ApplyRaiseIndividualChefSalary(
    IN p_employee_id id_type,
    IN raisevalue DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Employee ID: %, Raise Value: %', p_employee_id, raisevalue;
    
    UPDATE chef
    SET salary = salary * raisevalue
    WHERE chef.employee_id = p_employee_id;
END;
$$;

CALL ApplyRaiseIndividualChefSalary('C13', 1.1);


-- ---------------------------------------------------------

CREATE PROCEDURE ApplyRaiseIndividualWaiterSalary(
    IN p_employee_id id_type,
    IN raisevalue DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Employee ID: %, Raise Value: %', p_employee_id, raisevalue;
    
    UPDATE waiter
    SET salary = salary * raisevalue
    WHERE waiter.employee_id = p_employee_id;
END;
$$;

CALL ApplyRaiseIndividualwaiterSalary('W1', 1.22);


-- ----------------------------------------------------------


CREATE PROCEDURE ApplyRaiseGeneralWaiterSalary(
    IN raisevalue DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Correct the RAISE NOTICE syntax
    RAISE NOTICE 'Waiter salary raised by: %', raisevalue;
    
    -- Update all waiter salaries by multiplying with the raise factor
    UPDATE waiter
    SET salary = salary * raisevalue;
END;
$$;

CALL ApplyRaiseGeneralWaiterSalary(1.22);

-- ----------------------------------------------------------



CREATE PROCEDURE ApplyRaiseGeneralChefSalary(
    IN raisevalue DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Correct the RAISE NOTICE syntax
    RAISE NOTICE 'Chef salary raised by: %', raisevalue;
    
    -- Update all waiter salaries by multiplying with the raise factor
    UPDATE chef
    SET salary = salary * raisevalue;
END;
$$;

CALL ApplyRaiseGeneralChefSalary(1.22);



-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

-- VIEWS

CREATE OR REPLACE VIEW employees AS
SELECT 
    employee_id,
    chef_Name,
    'Chef' AS Role,
    Salary
FROM chef

UNION ALL

SELECT 
    employee_id,
    waiter_Name,
    'Waiter' AS Role,
    Salary
FROM Waiter

UNION ALL

SELECT 
    employee_id,
    driver_Name,
    'Delivery Driver' AS Role,
    0 Salary
FROM Delivery_Driver;

select *
from employees




















