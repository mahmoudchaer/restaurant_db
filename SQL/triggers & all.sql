

--employee base

CREATE OR REPLACE FUNCTION insert_into_employee_base_for_chef()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_base (employee_id, employee_type, chef_id)
    VALUES (NEW.employee_id, 'chef', NEW.employee_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_chef_insert
AFTER INSERT ON chef
FOR EACH ROW
EXECUTE FUNCTION insert_into_employee_base_for_chef();


CREATE OR REPLACE FUNCTION insert_into_employee_base_for_driver()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_base (employee_id, employee_type, delivery_driver_id)
    VALUES (NEW.employee_id, 'delivery driver', NEW.employee_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_driver_insert
AFTER INSERT ON delivery_driver
FOR EACH ROW
EXECUTE FUNCTION insert_into_employee_base_for_driver();


CREATE OR REPLACE FUNCTION insert_into_employee_base_for_waiter()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_base (employee_id, employee_type, waiter_id)
    VALUES (NEW.employee_id, 'waiter', NEW.employee_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_waiter_insert
AFTER INSERT ON waiter
FOR EACH ROW
EXECUTE FUNCTION insert_into_employee_base_for_waiter();



--Increment number of chefs by one each time a chef is added to a station
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








