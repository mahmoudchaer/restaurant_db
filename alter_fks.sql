-- Add Foreign Key to Payment_Method for Customer_ID
ALTER TABLE Payment_Method 
ADD CONSTRAINT fk_payment_customer 
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE;

-- Add Foreign Key to Review for Customer_ID
ALTER TABLE Review 
ADD CONSTRAINT fk_review_customer 
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE;

-- Add Foreign Key to Image_Review for Review_Number and Customer_ID
ALTER TABLE Image_Review 
ADD CONSTRAINT fk_image_review 
FOREIGN KEY (Review_Number, Customer_ID) REFERENCES Review(Review_ID, Customer_ID) ON DELETE CASCADE;

-- Add Foreign Key to Image_Meal for Meal_Name
ALTER TABLE image_meal 
ADD CONSTRAINT fk_image_meal 
FOREIGN KEY (meal_name) REFERENCES meal(meal_name);

-- Add Foreign Key to Menu_Day for Menu_ID
ALTER TABLE menu_day 
ADD CONSTRAINT fk_menu_day 
FOREIGN KEY (menu_ID) REFERENCES menu(menu_ID) ON DELETE CASCADE;

-- Add Foreign Key to Orders for Customer_ID
ALTER TABLE orders 
ADD CONSTRAINT fk_orders_customer 
FOREIGN KEY (customer_id) REFERENCES Customer(Customer_ID);

-- Add Foreign Key to Orders for Delivery_Driver_ID
ALTER TABLE orders 
ADD CONSTRAINT fk_orders_driver 
FOREIGN KEY (delivery_driver_id) REFERENCES delivery_driver(delivery_driver_id);

-- Add Foreign Key to Tables for Waiter_ID
ALTER TABLE tables 
ADD CONSTRAINT fk_tables_waiter 
FOREIGN KEY (waiter_id) REFERENCES waiter(waiter_id);

-- Add Foreign Key to Chef for Supervisor_ID
ALTER TABLE chef 
ADD CONSTRAINT fk_chef_supervisor 
FOREIGN KEY (supervisor_id) REFERENCES chef(employee_id) ON DELETE SET NULL;

-- Add Foreign Key to Chef for Works_In
ALTER TABLE chef 
ADD CONSTRAINT fk_chef_kitchen 
FOREIGN KEY (works_in) REFERENCES kitchen_station(kitchen_station_id);
