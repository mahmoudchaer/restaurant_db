
CREATE OR REPLACE FUNCTION calculate_avg_rating(customer_id_input id_type)
RETURNS void AS $$
BEGIN
    UPDATE customer
    SET avg_rating = (
        SELECT COALESCE(AVG(r.rating), 0)
        FROM review r
        WHERE r.customer_id = customer_id_input
    )
    WHERE customer_id = customer_id_input;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION trigger_update_avg_rating()
RETURNS TRIGGER AS $$
BEGIN
    -- Call the function to update the avg_rating
    PERFORM calculate_avg_rating(NEW.customer_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_avg_rating_on_insert
AFTER INSERT ON review
FOR EACH ROW
EXECUTE FUNCTION trigger_update_avg_rating();
