
INSERT INTO customer (customer_id, address, points, cust_name, phone_number, email, table_id)
VALUES (1, 'Beirut, Hamra Street, Building 23', 1000, 'Emily Carter', 70123456, 'emily.carter123@gmail.com', NULL),
       (2, 'Tripoli, Mina Road, Building 45', 1150, 'Jackson Rivera', 3456789, 'jackson.rivera88@yahoo.com', NULL),
       (3, 'Sidon, Sea Side Avenue, Apt 12', 1300, 'Mia Thompson', 71987654, 'mia.thompson56@outlook.com', NULL),
       (4, 'Jounieh, Old Souk, House 67', 1450, 'Noah Bennett', 76234567, 'noahbennett42@gmail.com', NULL),
       (5, 'Zahle, Main Square, Floor 3', 1600, 'Olivia Patel', 78543210, 'olivia.patel91@yahoo.com', NULL),
       (6, 'Byblos, Roman Road, Office 10', 1750, 'Ethan Coleman', 81678901, 'ethan.coleman27@hotmail.com', NULL),
       (7, 'Tyre, Coastal Road, Building 88', 1900, 'Sophia Reyes', 3876543, 'sophia.reyes74@gmail.com', NULL),
       (8, 'Baalbek, Temple Street, Villa 4', 2050, 'Liam Johnson', 70345678, 'liam.johnson81@outlook.com', NULL),
       (9, 'Batroun, Fisherman’s Cove, Unit 9', 2200, 'Ava Brooks', 76901234, 'ava.brooks34@yahoo.com', NULL),
       (10, 'Aley, Pine Forest Road, Apt 101', 2350, 'Mason Turner', 81432109, 'mason.turner65@gmail.com', NULL);



INSERT INTO hr (employee_id, address, hr_name, salary, hr_role, email, phone_number)
VALUES 
    (1, 'Beirut, Hamra Street, Building 12', 'Nadine Khalil', 4500.00, 'HR Manager', 'nadine.khalil@company.com', 70123456),
    (2, 'Tripoli, Mina Road, Apt 45', 'Ali Mansour', 4200.00, 'Recruitment Specialist', 'ali.mansour@company.com', 71234567),
    (3, 'Sidon, Coastal Avenue, Building 7', 'Samar Darwish', 3900.00, 'Compensation Analyst', 'samar.darwish@company.com', 76234567),
    (4, 'Jounieh, City Center, Office 23', 'Rami Haddad', 4700.00, 'HR Director', 'rami.haddad@company.com', 78123456),
    (5, 'Zahle, Main Street, House 89', 'Maya Fares', 4300.00, 'HR Assistant', 'maya.fares@company.com', 81678901),
    (6, 'Byblos, Roman Square, Building 5', 'Omar Choueiri', 4100.00, 'Training Manager', 'omar.choueiri@company.com', 70345678),
    (7, 'Tyre, Market Street, Building 3', 'Rita Saade', 4000.00, 'HR Coordinator', 'rita.saade@company.com', 71239876),
    (8, 'Baalbek, Temple Road, Office 14', 'Hassan Kassem', 4500.00, 'Employee Relations Specialist', 'hassan.kassem@company.com', 76901234),
    (9, 'Batroun, Old Fishermen’s Lane, Unit 9', 'Jad Aoun', 3800.00, 'Benefits Specialist', 'jad.aoun@company.com', 81432109),
    (10, 'Aley, Pine Forest Road, Villa 101', 'Lina Nassar', 4600.00, 'HR Business Partner', 'lina.nassar@company.com', 70198765);



INSERT INTO payment_method (payment_id, payment_type, customer_id)
VALUES 
    (1, 'Credit Card', 1),
    (2, 'Debit Card', 2),
    (3, 'PayPal', 3),
    (4, 'Bank Transfer', 4),
    (5, 'Cash', 5),
    (6, 'Mobile Payment', 6),
    (7, 'Cheque', 7),
    (8, 'Cryptocurrency', 8),
    (9, 'Credit Card', 9),
    (10, 'Direct Debit', 10);


INSERT INTO review (review_id, customer_id, rating, description)
VALUES 
    (1, 1, 5, 'Excellent service and very helpful staff. Highly recommended!'),
    (2, 2, 3, 'The product was okay but the delivery was delayed.'),
    (3, 3, 4, 'Good experience overall, but could use better customer support.'),
    (4, 4, 1, 'Terrible service, rude staff and poor quality product.'),
    (5, 5, 5, 'Amazing experience, I am extremely satisfied with my purchase!'),
    (6, 6, 2, 'The item was not as described, disappointing experience.'),
    (7, 7, 4, 'Great value for money. Will definitely shop here again.'),
    (8, 8, 1, 'Very bad experience, would not recommend to anyone.'),
    (9, 9, 3, 'Average experience. Somewhat satisfied but room for improvement.'),
    (10, 10, 5, 'Fantastic customer service and fast shipping. Very pleased!');


INSERT INTO image_review (image, review_number)
VALUES 
    (decode('89504e470d0a1a0a0000000d49484452', 'hex'), 1),
    (decode('89504e470d0a1a0a0000000d49484453', 'hex'), 2),
    (decode('89504e470d0a1a0a0000000d49484454', 'hex'), 3),
    (decode('89504e470d0a1a0a0000000d49484455', 'hex'), 4),
    (decode('89504e470d0a1a0a0000000d49484456', 'hex'), 5),
    (decode('89504e470d0a1a0a0000000d49484457', 'hex'), 6),
    (decode('89504e470d0a1a0a0000000d49484458', 'hex'), 7),
    (decode('89504e470d0a1a0a0000000d49484459', 'hex'), 8),
    (decode('89504e470d0a1a0a0000000d4948445A', 'hex'), 9),
    (decode('89504e470d0a1a0a0000000d4948445B', 'hex'), 10);


    
INSERT INTO ingredient (inventory_id, minimum_quantity, stock_qty, ingr_name)
VALUES 
    (1, 10, 50, 'Flour'),
    (2, 20, 100, 'Sugar'),
    (3, 5, 30, 'Salt'),
    (4, 15, 20, 'Butter'),
    (5, 25, 80, 'Milk'),
    (6, 10, 40, 'Eggs'),
    (7, 8, 15, 'Vanilla Extract'),
    (8, 12, 60, 'Yeast'),
    (9, 6, 25, 'Baking Powder'),
    (10, 18, 90, 'Cocoa Powder');


INSERT INTO meal (meal_name, cost_meal, recipe, price, category, description)
VALUES 
    ('Spaghetti Bolognese', 8.50, 'Pasta with a rich tomato and meat sauce', 12.00, 'Main Course', 'Classic Italian pasta dish with beef sauce'),
    ('Caesar Salad', 3.00, 'Romaine lettuce, croutons, Caesar dressing', 7.50, 'Appetizer', 'Fresh salad with Caesar dressing and croutons'),
    ('Grilled Chicken Sandwich', 4.50, 'Grilled chicken, lettuce, tomato, mayonnaise', 10.00, 'Main Course', 'Juicy grilled chicken served on a toasted bun'),
    ('Chocolate Cake', 5.00, 'Rich chocolate sponge with chocolate icing', 9.00, 'Dessert', 'Delicious and moist chocolate dessert'),
    ('Margarita Pizza', 6.00, 'Thin crust pizza with tomato, mozzarella, basil', 11.00, 'Main Course', 'Classic Italian pizza with fresh ingredients'),
    ('Lentil Soup', 2.50, 'Lentils cooked with spices and vegetables', 6.50, 'Appetizer', 'Hearty and flavorful vegetarian soup'),
    ('Beef Burger', 4.00, 'Grilled beef patty, lettuce, tomato, cheese', 9.50, 'Main Course', 'Classic beef burger served with cheese and fresh toppings'),
    ('Tiramisu', 4.75, 'Coffee-soaked ladyfingers layered with mascarpone', 8.00, 'Dessert', 'Traditional Italian coffee-flavored dessert'),
    ('Chicken Alfredo', 7.00, 'Pasta tossed in creamy Alfredo sauce with chicken', 13.00, 'Main Course', 'Creamy pasta with tender chicken pieces'),
    ('Greek Salad', 3.50, 'Tomatoes, cucumber, olives, feta cheese', 7.00, 'Appetizer', 'Traditional salad with fresh Mediterranean flavors');





INSERT INTO image_meal (image, meal_name)
VALUES 
    (decode('89504e470d0a1a0a0000000d49484452', 'hex'), 'Spaghetti Bolognese'),
    (decode('89504e470d0a1a0a0000000d49484453', 'hex'), 'Caesar Salad'),
    (decode('89504e470d0a1a0a0000000d49484454', 'hex'), 'Grilled Chicken Sandwich'),
    (decode('89504e470d0a1a0a0000000d49484455', 'hex'), 'Chocolate Cake'),
    (decode('89504e470d0a1a0a0000000d49484456', 'hex'), 'Margarita Pizza'),
    (decode('89504e470d0a1a0a0000000d49484457', 'hex'), 'Lentil Soup'),
    (decode('89504e470d0a1a0a0000000d49484458', 'hex'), 'Beef Burger'),
    (decode('89504e470d0a1a0a0000000d49484459', 'hex'), 'Tiramisu'),
    (decode('89504e470d0a1a0a0000000d4948445A', 'hex'), 'Chicken Alfredo'),
    (decode('89504e470d0a1a0a0000000d4948445B', 'hex'), 'Greek Salad');




INSERT INTO waiter (employee_id, waiter_role, waiter_name, cv, salary, hire_date, supervisor_id)
VALUES 
    (1, 'Head Waiter', 'Ahmad Khalil', 'Experienced head waiter with 10 years in the hospitality industry.', 2500.00, '2020-05-10', NULL),
    (2, 'Waiter', 'Sara Mansour', 'Professional waiter with a focus on excellent customer service.', 1800.00, '2021-03-15', 1),
    (3, 'Waiter', 'Jad Saad', 'Waiter with expertise in serving large parties and special events.', 1700.00, '2019-07-22', 1),
    (4, 'Waiter', 'Maya Aoun', 'Enthusiastic waiter known for attention to detail.', 1750.00, '2022-01-10', 1),
    (5, 'Assistant Waiter', 'Nour Rami', 'Assistant waiter with 2 years of experience.', 1500.00, '2023-02-14', 2),
    (6, 'Waiter', 'Hassan Chahine', 'Skilled waiter with a focus on customer satisfaction.', 1800.00, '2018-11-05', 1),
    (7, 'Head Waiter', 'Rita Kassem', 'Highly skilled head waiter specializing in fine dining.', 2600.00, '2017-08-19', NULL),
    (8, 'Waiter', 'Omar Hamed', 'Reliable waiter with 3 years of experience.', 1700.00, '2020-10-05', 7),
    (9, 'Waiter', 'Lina Fares', 'Passionate waiter with great customer service skills.', 1650.00, '2021-06-30', 7),
    (10, 'Assistant Waiter', 'Karim Habib', 'Motivated assistant waiter.', 1400.00, '2022-04-01', 2);



INSERT INTO tables (table_id, seat_capacity, availability, waiter_id)
VALUES 
    (1, 4, TRUE, 1),
    (2, 2, FALSE, 2),
    (3, 6, TRUE, 3),
    (4, 8, FALSE, 4),
    (5, 10, TRUE, 5),
    (6, 3, TRUE, 6),
    (7, 5, FALSE, 7),
    (8, 4, TRUE, 8),
    (9, 2, FALSE, 9),
    (10, 6, TRUE, 10);


INSERT INTO menu (menu_id, start_time, end_time, category, image)
VALUES 
    (1, '07:00:00', '10:30:00', 'Breakfast', decode('89504e470d0a1a0a0000000d49484452', 'hex')),
    (2, '11:00:00', '15:00:00', 'Lunch', decode('89504e470d0a1a0a0000000d49484453', 'hex')),
    (3, '18:00:00', '22:00:00', 'Dinner', decode('89504e470d0a1a0a0000000d49484454', 'hex')),
    (4, '10:00:00', '14:00:00', 'Brunch', decode('89504e470d0a1a0a0000000d49484455', 'hex')),
    (5, '15:00:00', '18:00:00', 'Afternoon Tea', decode('89504e470d0a1a0a0000000d49484456', 'hex')),
    (6, '09:00:00', '12:00:00', 'Morning Specials', decode('89504e470d0a1a0a0000000d49484457', 'hex')),
    (7, '12:00:00', '16:00:00', 'Special Lunch', decode('89504e470d0a1a0a0000000d49484458', 'hex')),
    (8, '20:00:00', '23:59:00', 'Late Night Snacks', decode('89504e470d0a1a0a0000000d49484459', 'hex')),
    (9, '08:00:00', '11:00:00', 'Continental Breakfast', decode('89504e470d0a1a0a0000000d4948445A', 'hex')),
    (10, '16:00:00', '20:00:00', 'Happy Hour', decode('89504e470d0a1a0a0000000d4948445B', 'hex'));



INSERT INTO menu_day (menu_id, day_of_week)
VALUES 
    (1, 'Monday'),
    (2, 'Tuesday'),
    (3, 'Wednesday'),
    (4, 'Thursday'),
    (5, 'Friday'),
    (6, 'Saturday'),
    (7, 'Sunday'),
    (8, 'Monday'),
    (9, 'Tuesday'),
    (10, 'Wednesday');



INSERT INTO kitchen_station (station_name, number_of_chefs, specialization, manager_id)
VALUES 
    ('Grill Station', 3, 'Grilling', NULL),
    ('Pastry Station', 3, 'Baking & Pastry', NULL),
    ('Sauce Station', 3, 'Sauce Preparation', NULL),
    ('Fry Station', 2, 'Frying', NULL),
    ('Garde Manger', 2, 'Cold Dishes', NULL),
    ('Butchery Station', 2, 'Meat Preparation', NULL),
    ('Fish Station', 1, 'Seafood Preparation', NULL),
    ('Soup Station', 1, 'Soups & Stews', NULL),
    ('Vegetable Station', 1, 'Vegetable Preparation', NULL),
    ('Dessert Station', 2, 'Desserts', NULL);



INSERT INTO chef (employee_id, chef_name, chef_role, salary, hire_date, cv, supervisor_id, works_in)
VALUES 
    (1, 'Ahmad Khalil', 'Head Chef', 3000.00, '2018-05-10', 'Experienced chef specializing in grilling.', NULL, 'Grill Station'),
    (2, 'Sara Mansour', 'Sous Chef', 2500.00, '2019-07-15', 'Sous chef focused on pastry and desserts.', 1, 'Pastry Station'),
    (3, 'Jad Saad', 'Chef de Partie', 2000.00, '2020-01-22', 'Sous chef focused on pastry and desserts.', 1, 'Pastry Station'),
    (4, 'Maya Aoun', 'Chef de Partie', 2200.00, '2021-03-10', 'Expert in frying techniques.', 1, 'Fry Station'),
    (5, 'Nour Rami', 'Sous Chef', 2300.00, '2017-08-14', 'Specialist in cold dishes.', 2, 'Garde Manger'),
    (6, 'Hassan Chahine', 'Line Cook', 1900.00, '2022-09-05', 'Specialist in cold dishes.', 5, 'Garde Manger'),
    (7, 'Rita Kassem', 'Head Chef', 3100.00, '2015-06-19', 'Head chef with expertise in seafood.', NULL, 'Fish Station'),
    (8, 'Omar Hamed', 'Chef de Partie', 2200.00, '2020-11-25', 'Specializes in soups and stews.', 7, 'Soup Station'),
    (9, 'Lina Fares', 'Line Cook', 1800.00, '2021-02-10', 'Prepares a variety of vegetable dishes.', 7, 'Vegetable Station'),
    (10, 'Karim Habib', 'Pastry Chef', 2500.00, '2018-07-01', 'Creates desserts and pastries.', 2, 'Dessert Station'),
    (11, 'Youssef Hariri', 'Sous Chef', 2600.00, '2022-01-10', 'Handles complex grilling techniques.', 1, 'Grill Station'),
    (12, 'Nadia Sleiman', 'Chef de Partie', 2400.00, '2019-03-12', 'Sous chef focused on pastry and desserts.', 2, 'Pastry Station'),
    (13, 'Firas Abdallah', 'Line Cook', 2000.00, '2020-12-08', 'Prepares sauces and condiments.', 3, 'Sauce Station'),
    (14, 'Layla Nader', 'Chef de Partie', 2150.00, '2021-05-15', 'Specializes in fried dishes.', 4, 'Fry Station'),
    (15, 'Hadi Youssef', 'Line Cook', 1950.00, '2019-11-23', 'Prepares sauces and condiments.', 5, 'Sauce Station'),
    (16, 'Samir Nassar', 'Line Cook', 1900.00, '2022-07-10', 'Handles meat preparation for all cuts.', 6, 'Butchery Station'),
    (17, 'Salma Rizk', 'Sous Chef', 2800.00, '2016-09-19', 'Handles meat preparation for all cuts.', 7, 'Butchery Station'),
    (18, 'Nour El Din', 'Chef de Partie', 2100.00, '2021-04-15', 'Prepares sauces and condiments.', 8, 'Sauce Station'),
    (19, 'Amira Jaber', 'Chef de Partie', 2050.00, '2020-10-20', 'Creates desserts and pastries.', 9, 'Dessert Station'),
    (20, 'Bassem Chidiac', 'Pastry Chef', 2600.00, '2017-02-28', 'Handles complex grilling techniques.', 10, 'Grill Station');



INSERT INTO supplier (supplier_id, name_supp, address, phone_number, email)
VALUES 
    (1, 'Fresh Foods Ltd.', 'Beirut, Hamra Street, Building 5', 70123456, 'contact@freshfoods.com'),
    (2, 'Daily Dairy Co.', 'Tripoli, Mina Road, Office 12', 71123456, 'info@dailydairy.com'),
    (3, 'Bake Essentials', 'Sidon, Main Avenue, Suite 10', 76123456, 'sales@bakeessentials.com'),
    (4, 'Green Veggies', 'Zahle, Green Street, Building 3', 78123456, 'support@greenveggies.com'),
    (5, 'Meat Master', 'Jounieh, Meat Market, Floor 1', 81123456, 'orders@meatmaster.com'),
    (6, 'Seafood Delights', 'Byblos, Fisherman’s Wharf, Dock 2', 70123457, 'info@seafooddelights.com'),
    (7, 'Spice Hub', 'Tyre, Spice Lane, Building 9', 71123457, 'contact@spicehub.com'),
    (8, 'Sweet Treats', 'Aley, Dessert Plaza, Shop 8', 76123457, 'info@sweettreats.com'),
    (9, 'Grain Suppliers', 'Baalbek, Grain Market, Unit 11', 78123457, 'sales@grainsuppliers.com'),
    (10, 'Dairy Delight', 'Batroun, Dairy Avenue, Block 7', 81123457, 'orders@dairydelight.com');



INSERT INTO product (product_name, supplier_id)
VALUES 
    ('Flour', 1),
    ('Milk', 2),
    ('Eggs', 3),
    ('Carrots', 4),
    ('Beef', 5),
    ('Salmon', 6),
    ('Cinnamon', 7),
    ('Chocolate', 8),
    ('Wheat Grain', 9),
    ('Cheese', 10);



INSERT INTO delivery_driver (employee_id, driver_name, contact_info, vehicle_type, waiter_contact)
VALUES 
    (1, 'Ali Mansour', 70111222, 'Car', 1),
    (2, 'Jana Saad', 71122334, 'Motorbike', 2),
    (3, 'Nour Haddad', 76133445, 'Van', 3),
    (4, 'Rami Farah', 78144556, 'Truck', 4),
    (5, 'Lina Khalil', 81155667, 'Car', 5),
    (6, 'Hassan Youssef', 70166778, 'Motorbike', 6),
    (7, 'Amira Chidiac', 71177889, 'Van', 7),
    (8, 'Youssef Rami', 76188990, 'Car', 8),
    (9, 'Maya Saab', 78199012, 'Truck', 9),
    (10, 'Samer Khoury', 81100123, 'Motorbike', 10);


INSERT INTO assigned_locations (del_location, delivery_employee_id)
VALUES 
    ('Beirut Downtown', 1),
    ('Tripoli Main Street', 2),
    ('Sidon Coastal Road', 3),
    ('Zahle Market Square', 4),
    ('Jounieh Old Souk', 9), 
    ('Byblos Roman Road', 5),
    ('Tyre Fisherman’s Wharf', 10),  
    ('Baalbek Temple Street', 6),
    ('Batroun Sea View', 7),
    ('Aley Pine Forest Road', 8);


INSERT INTO customer_order (order_id, date, status, priority, customer_id, delivery_driver_id)
VALUES 
    (1, '2024-11-18 09:30:00', 'Pending', 5, 1, 1),
    (2, '2024-11-18 11:00:00', 'Completed', 8, 2, 2),
    (3, '2024-11-17 14:45:00', 'In Progress', 7, 3, 3),
    (4, '2024-11-17 17:00:00', 'Cancelled', 4, 4, 4),
    (5, '2024-11-16 08:15:00', 'Pending', 6, 5, 5),
    (6, '2024-11-16 13:00:00', 'Completed', 9, 6, 6),
    (7, '2024-11-15 15:30:00', 'In Progress', 3, 7, 7),
    (8, '2024-11-15 19:00:00', 'Pending', 2, 8, 8),
    (9, '2024-11-14 10:30:00', 'Completed', 10, 9, 9),
    (10, '2024-11-14 12:45:00', 'Cancelled', 1, 10, 10);


INSERT INTO administration (employee_id, adm_name, adm_role, salary, address, phone_number, email)
VALUES 
    (1, 'Nour Jaber', 'HR Manager', 4000.00, 'Beirut, Central District, Building 1', 70123456, 'nour.jaber@company.com'),
    (2, 'Ahmad Rami', NULL, NULL, 'Tripoli, Coastal Avenue, Apt 15', 71123456, 'ahmad.rami@company.com'),
    (3, 'Layla Hariri', 'Finance Officer', 3700.00, 'Sidon, Main Street, Floor 3', 76123456, 'layla.hariri@company.com'),
    (4, 'Omar Nassar', 'IT Specialist', 3900.00, 'Zahle, Market Square, Suite 10', 78123456, 'omar.nassar@company.com'),
    (5, 'Rita Chidiac', NULL, NULL, 'Jounieh, Beachfront Road, Building 4', 81123456, 'rita.chidiac@company.com'),
    (6, 'Samer Haddad', 'Operations Manager', 4200.00, 'Byblos, Roman Plaza, Unit 2', 70123457, 'samer.haddad@company.com'),
    (7, 'Hala Saade', 'Legal Advisor', 4500.00, 'Tyre, Heritage Street, House 12', 71123457, 'hala.saade@company.com'),
    (8, 'Jad Youssef', NULL, NULL, 'Baalbek, Temple Road, Villa 9', 76123457, 'jad.youssef@company.com'),
    (9, 'Nadia Fares', 'Administrative Assistant', 3200.00, 'Batroun, Old Souk, Shop 7', 78123457, 'nadia.fares@company.com'),
    (10, 'Khaled Naim', 'Communications Officer', 3800.00, 'Aley, Pine Forest Drive, Building 8', 81123457, 'khaled.naim@company.com');



INSERT INTO emergency_contact_waiter (contact_name, relation, priority, phone_number, waiter_id)
VALUES 
    -- Waiters (IDs 1 to 10)
    ('Amira Mansour', 'Spouse', 1, 70098765, 1),
    ('Fadi Hariri', 'Sibling', 2, 71187654, 2),
    ('Leila Chidiac', 'Parent', 3, 76176543, 3),
    ('Nour Saade', 'Friend', 4, 78165432, 4),
    ('Omar Khalil', 'Parent', 1, 81154321, 5),
    ('Rita Fares', 'Spouse', 2, 70143210, 6),
    ('Hassan Mansour', 'Sibling', 3, 71132109, 7),
    ('Layla Haddad', 'Friend', 4, 76121098, 8),
    ('Ahmad Saad', 'Parent', 1, 78110987, 9),
    ('Kareem Rami', 'Spouse', 2, 81109876, 10);


INSERT INTO emergency_contact_chef (contact_name, relation, priority, phone_number, chef_id)
VALUES 
    -- Chefs (IDs 1 to 20)
    ('Mona Khalil', 'Spouse', 1, 70012345, 1),
    ('Fadi Mansour', 'Parent', 2, 71123456, 2),
    ('Sara Nassar', 'Sibling', 3, 76134567, 3),
    ('Ali Chidiac', 'Friend', 4, 78145678, 4),
    ('Nour Hariri', 'Parent', 1, 81156789, 5),
    ('Rita Saad', 'Spouse', 2, 70167890, 6),
    ('Hassan Jaber', 'Sibling', 3, 71178901, 7),
    ('Layla Fares', 'Friend', 4, 76189012, 8),
    ('Ahmad Youssef', 'Parent', 1, 78190123, 9),
    ('Omar Rami', 'Spouse', 2, 81101234, 10),
    ('Kareem Haddad', 'Parent', 3, 70112345, 11),
    ('Lina Khalil', 'Sibling', 4, 71123456, 12),
    ('Sami Jaber', 'Friend', 1, 76134567, 13),
    ('Nada Fares', 'Spouse', 2, 78145678, 14),
    ('Hala Chidiac', 'Parent', 3, 81156789, 15),
    ('Rami Saade', 'Sibling', 4, 70167890, 16),
    ('Nour El Din', 'Friend', 1, 71178901, 17),
    ('Maya Youssef', 'Spouse', 2, 76189012, 18),
    ('Jad Fares', 'Parent', 3, 78190123, 19),
    ('Samer Haddad', 'Friend', 4, 81101234, 20);


INSERT INTO emergency_contact_delivery_driver (contact_name, relation, priority, phone_number, delivery_driver_id)
VALUES 

    -- Delivery Drivers (IDs 1 to 10)
    ('Rami Nassar', 'Parent', 1, 70098754, 1),
    ('Sara Chidiac', 'Friend', 2, 71187643, 2),
    ('Ali Hariri', 'Sibling', 3, 76176532, 3),
    ('Nour Fares', 'Parent', 4, 78165421, 4),
    ('Jad Khalil', 'Spouse', 1, 81154320, 5),
    ('Rita Mansour', 'Sibling', 2, 70143209, 6),
    ('Sami Youssef', 'Friend', 3, 71132108, 7),
    ('Mona Rami', 'Parent', 4, 76121097, 8),
    ('Omar Saade', 'Spouse', 1, 78110986, 9),
    ('Hala Fares', 'Parent', 2, 81109865, 10);


INSERT INTO creates (menu_id, chef_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);



INSERT INTO cooks (chef, time_to_make, meal)
VALUES 
    (1, '00:45:00', 'Spaghetti Bolognese'),
    (2, '00:30:00', 'Caesar Salad'),
    (3, '01:00:00', 'Grilled Chicken Sandwich'),
    (4, '00:40:00', 'Chocolate Cake'),
    (5, '00:50:00', 'Margarita Pizza'),
    (6, '00:25:00', 'Lentil Soup'),
    (7, '00:35:00', 'Beef Burger'),
    (8, '00:50:00', 'Tiramisu'),
    (9, '01:10:00', 'Chicken Alfredo'),
    (10, '00:30:00', 'Greek Salad');


INSERT INTO composed_of (menu_id, meal_name)
VALUES 
    (1, 'Spaghetti Bolognese'),
    (2, 'Caesar Salad'),
    (3, 'Grilled Chicken Sandwich'),
    (4, 'Chocolate Cake'),
    (5, 'Margarita Pizza'),
    (6, 'Lentil Soup'),
    (7, 'Beef Burger'),
    (8, 'Tiramisu'),
    (9, 'Chicken Alfredo'),
    (10, 'Greek Salad');


INSERT INTO supplies (ingredient, supplier, supp_cost, delivery_time, contract_until)
VALUES 
    (1, 1, 50.00, '12:00:00', '2025-12-31'),
    (2, 2, 30.00, '08:30:00', '2026-06-30'),
    (3, 3, 20.00, '10:00:00', '2025-03-15'),
    (4, 4, 40.00, '14:00:00', '2025-09-01'),
    (5, 5, 35.00, '09:45:00', '2026-02-28'),
    (6, 6, 25.00, '11:30:00', '2025-08-20'),
    (7, 7, 45.00, '15:00:00', '2025-07-15'),
    (8, 8, 28.00, '13:30:00', '2026-01-05'),
    (9, 9, 22.00, '10:15:00', '2025-11-11'),
    (10, 10, 55.00, '16:00:00', '2026-04-25');


INSERT INTO chef_shift (administration_id, chef_id, start_time, end_time)
VALUES 
    (1, 1, '08:00:00', '16:00:00'),
    (2, 2, '09:00:00', '17:00:00'),
    (3, 3, '07:30:00', '15:30:00'),
    (4, 4, '10:00:00', '18:00:00'),
    (5, 5, '06:00:00', '14:00:00'),
    (6, 6, '11:00:00', '19:00:00'),
    (7, 7, '12:00:00', '20:00:00'),
    (8, 8, '08:30:00', '16:30:00'),
    (9, 9, '09:30:00', '17:30:00'),
    (1, 10, '10:30:00', '18:30:00'),
    (1, 11, '07:00:00', '15:00:00'),
    (2, 12, '06:30:00', '14:30:00'),
    (3, 13, '08:45:00', '16:45:00'),
    (4, 14, '09:15:00', '17:15:00'),
    (5, 15, '11:30:00', '19:30:00'),
    (6, 16, '13:00:00', '21:00:00'),
    (7, 17, '07:15:00', '15:15:00'),
    (8, 18, '09:45:00', '17:45:00'),
    (9, 19, '10:00:00', '18:00:00'),
    (2, 20, '08:00:00', '16:00:00');


INSERT INTO waiter_shift (administration_id, waiter_id, start_time, end_time)
VALUES 
    (1, 1, '08:00:00', '16:00:00'),  -- Administration supervising a waiter during this shift
    (2, 2, '09:00:00', '17:00:00'),
    (3, 3, '07:30:00', '15:30:00'),
    (4, 4, '10:00:00', '18:00:00'),
    (5, 5, '06:00:00', '14:00:00'),
    (6, 6, '11:00:00', '19:00:00'),
    (7, 7, '12:00:00', '20:00:00'),
    (8, 8, '08:30:00', '16:30:00'),
    (9, 9, '09:30:00', '17:30:00'),
    (10, 10, '10:30:00', '18:30:00');


INSERT INTO hires_waiter (hr_id, waiter_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);


INSERT INTO hires_chef (hr_id, chef_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (1, 11),
    (2, 12),
    (3, 13),
    (4, 14),
    (5, 15),
    (6, 16),
    (7, 17),
    (8, 18),
    (9, 19),
    (10, 20);


INSERT INTO hires_driver (hr_id, delivery_driver_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);


INSERT INTO contacts (admin_id, supplier_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);


INSERT INTO contain (order_id, meal_name, quantity)
VALUES 
    (1, 'Spaghetti Bolognese', 2),
    (2, 'Caesar Salad', 1),
    (3, 'Grilled Chicken Sandwich', 3),
    (4, 'Chocolate Cake', 2),
    (5, 'Margarita Pizza', 4),
    (6, 'Lentil Soup', 1),
    (7, 'Beef Burger', 2),
    (8, 'Tiramisu', 3),
    (9, 'Chicken Alfredo', 1),
    (10, 'Greek Salad', 2);


INSERT INTO places (order_id, customer_id, waiter_id)
VALUES 
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10);

