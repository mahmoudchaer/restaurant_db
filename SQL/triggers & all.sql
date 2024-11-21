--Triggers (2)
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

CREATE OR REPLACE FUNCTION calculate_order_price(order_id_input INTEGER)
RETURNS money_type AS $$
DECLARE
    total_price money_type := 0;
BEGIN
    SELECT SUM(m.price * c.quantity)
    INTO total_price
    FROM contain c
    JOIN meal m ON c.meal_name = m.meal_name
    WHERE c.order_id = order_id_input;

    RETURN total_price;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_order_price()
RETURNS TRIGGER AS $$
BEGIN
   
    UPDATE customer_order
    SET price = calculate_order_price(NEW.order_id)
    WHERE order_id = NEW.order_id;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_order_price
AFTER INSERT OR UPDATE OR DELETE
ON contain
FOR EACH ROW
EXECUTE FUNCTION update_order_price();

-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------

--Procedures (5)

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


-- ----------------------------------------------------------


CREATE OR REPLACE PROCEDURE calculate_costs()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update the cost in the is_made_of table
    UPDATE is_made_of
    SET cost = is_made_of.quantity * s.supp_cost
    FROM supplies s
    WHERE is_made_of.ingredient_id = s.ingredient;

    RAISE NOTICE 'Costs updated successfully in is_made_of table.';
END;
$$;

CALL calculate_costs();




















