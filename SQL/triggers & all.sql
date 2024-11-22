--Triggers (6)
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



CREATE OR REPLACE FUNCTION calculate_ingredient_price(ingredient_id INTEGER)
RETURNS money_type AS $$
DECLARE
    derived_price money_type;
BEGIN
    SELECT MIN(supp_cost)
    INTO derived_price
    FROM supplies
    WHERE ingredient = ingredient_id;

    RETURN derived_price;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_ingredient_price()
RETURNS TRIGGER AS $$
BEGIN
    -- Update the price in the ingredient table for the related ingredient
    UPDATE ingredient
    SET price = calculate_ingredient_price(NEW.ingredient)
    WHERE inventory_id = NEW.ingredient;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_ingredient_price
AFTER INSERT OR UPDATE OR DELETE
ON supplies
FOR EACH ROW
EXECUTE FUNCTION update_ingredient_price();

UPDATE ingredient
SET price = calculate_ingredient_price(inventory_id);





-- Sets total cost to make a meal in the meal table based on the costs of ingredients in the is_made_of table
CREATE OR REPLACE FUNCTION update_meal_cost()
RETURNS TRIGGER AS $$
BEGIN
    -- Update the cost_meal in the meal table
    UPDATE meal
    SET cost_meal = (
        SELECT SUM(cost)
        FROM is_made_of
        WHERE meal_id = NEW.meal_id
    )
    WHERE meal_name = NEW.meal_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER recalculate_meal_cost
AFTER INSERT OR UPDATE OR DELETE
ON is_made_of
FOR EACH ROW
EXECUTE FUNCTION update_meal_cost();




--Calculates price of a meal based on it's total cost to make
CREATE OR REPLACE FUNCTION update_meal_price()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculate and update the price as cost_meal + 20%
    NEW.price := NEW.cost_meal * 1.20;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calculate_price_on_cost_change
BEFORE INSERT OR UPDATE
ON meal
FOR EACH ROW
EXECUTE FUNCTION update_meal_price();


--contract with a supplier must end in the future
CREATE OR REPLACE FUNCTION check_contract_date()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.contract_until < CURRENT_DATE THEN
    RAISE EXCEPTION 'Contract end date must be in the future.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_contract_date
BEFORE INSERT OR UPDATE ON supplies
FOR EACH ROW
EXECUTE FUNCTION check_contract_date();

-- makes order date only a current or future date, not past
CREATE OR REPLACE FUNCTION check_order_time()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.date < CURRENT_DATE THEN
    RAISE EXCEPTION 'Order must be for now or later, not before.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_time
BEFORE INSERT OR UPDATE ON customer_order
FOR EACH ROW
EXECUTE FUNCTION check_order_time();


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



-----------------------------------------------------------------------------------------------------

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
















