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



--PROCEDURES

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


