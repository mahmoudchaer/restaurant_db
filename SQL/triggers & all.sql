

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



