--meal

INSERT INTO meal (meal_name, cost_meal, recipe, price, category, description)
VALUES ('Meal_1', 5.50, 'Recipe for Meal_1', 11.00, 'Category_1', 'Description 1'),
       ('Meal_2', 6.50, 'Recipe for Meal_2', 13.00, 'Category_2', 'Description 2'),
       ('Meal_3', 7.50, 'Recipe for Meal_3', 15.00, 'Category_3', 'Description 3'),
       ('Meal_4', 8.50, 'Recipe for Meal_4', 17.00, 'Category_4', 'Description 4'),
       ('Meal_5', 9.50, 'Recipe for Meal_5', 19.00, 'Category_5', 'Description 5'),
       ('Meal_6', 10.50, 'Recipe for Meal_6', 21.00, 'Category_6', 'Description 6'),
       ('Meal_7', 11.50, 'Recipe for Meal_7', 23.00, 'Category_7', 'Description 7'),
       ('Meal_8', 12.50, 'Recipe for Meal_8', 25.00, 'Category_8', 'Description 8'),
       ('Meal_9', 13.50, 'Recipe for Meal_9', 27.00, 'Category_9', 'Description 9'),
       ('Meal_10', 14.50, 'Recipe for Meal_10', 29.00, 'Category_10', 'Description 10');


--hr
INSERT INTO hr (employee_id, address, hr_name, salary, hr_role, email, phone_number)
VALUES (1, 'HR Address 1', 'HR_1', 75000, 'HR_Role_1', 'hr1@example.com', '1111111'),
       (2, 'HR Address 2', 'HR_2', 76000, 'HR_Role_2', 'hr2@example.com', '1111112'),
       (3, 'HR Address 3', 'HR_3', 77000, 'HR_Role_3', 'hr3@example.com', '1111113'),
       (4, 'HR Address 4', 'HR_4', 78000, 'HR_Role_4', 'hr4@example.com', '1111114'),
       (5, 'HR Address 5', 'HR_5', 79000, 'HR_Role_5', 'hr5@example.com', '1111115'),
       (6, 'HR Address 6', 'HR_6', 80000, 'HR_Role_6', 'hr6@example.com', '1111116'),
       (7, 'HR Address 7', 'HR_7', 81000, 'HR_Role_7', 'hr7@example.com', '1111117'),
       (8, 'HR Address 8', 'HR_8', 82000, 'HR_Role_8', 'hr8@example.com', '1111118'),
       (9, 'HR Address 9', 'HR_9', 83000, 'HR_Role_9', 'hr9@example.com', '1111119'),
       (10, 'HR Address 10', 'HR_10', 84000, 'HR_Role_10', 'hr10@example.com', '1111120');


--customer
INSERT INTO customer (customer_id, address, points, cust_name, phone_number, email, table_id)
VALUES (1, 'Address 1', 1000, 'Customer_1', '123451', 'cust1@example.com', 1),
       (2, 'Address 2', 1150, 'Customer_2', '123452', 'cust2@example.com', 2),
       (3, 'Address 3', 1300, 'Customer_3', '123453', 'cust3@example.com', 3),
       (4, 'Address 4', 1450, 'Customer_4', '123454', 'cust4@example.com', 4),
       (5, 'Address 5', 1600, 'Customer_5', '123455', 'cust5@example.com', 5),
       (6, 'Address 6', 1750, 'Customer_6', '123456', 'cust6@example.com', 6),
       (7, 'Address 7', 1900, 'Customer_7', '123457', 'cust7@example.com', 7),
       (8, 'Address 8', 2050, 'Customer_8', '123458', 'cust8@example.com', 8),
       (9, 'Address 9', 2200, 'Customer_9', '123459', 'cust9@example.com', 9),
       (10, 'Address 10', 2350, 'Customer_10', '1234510', 'cust10@example.com', 10);


--waiter
INSERT INTO waiter (employee_id, waiter_role, waiter_name, cv, salary, hire_date, supervisor_id)
VALUES (11, 'Waiter_Role_1', 'Waiter_1', 'CV_1', 25000, '2023-01-01', NULL),
       (12, 'Waiter_Role_2', 'Waiter_2', 'CV_2', 26000, '2023-01-02', NULL),
       (13, 'Waiter_Role_3', 'Waiter_3', 'CV_3', 27000, '2023-01-03', NULL),
       (14, 'Waiter_Role_4', 'Waiter_4', 'CV_4', 28000, '2023-01-04', NULL),
       (15, 'Waiter_Role_5', 'Waiter_5', 'CV_5', 29000, '2023-01-05', NULL),
       (16, 'Waiter_Role_6', 'Waiter_6', 'CV_6', 30000, '2023-01-06', 11),
       (17, 'Waiter_Role_7', 'Waiter_7', 'CV_7', 31000, '2023-01-07', 12),
       (18, 'Waiter_Role_8', 'Waiter_8', 'CV_8', 32000, '2023-01-08', 13),
       (19, 'Waiter_Role_9', 'Waiter_9', 'CV_9', 33000, '2023-01-09', 14),
       (20, 'Waiter_Role_10', 'Waiter_10', 'CV_10', 34000, '2023-01-10', 15);

--table
INSERT INTO tables (table_id, seat_capacity, availability, waiter_id)
VALUES (1, 4, TRUE, 11),
       (2, 6, TRUE, 12),
       (3, 8, TRUE, 13),
       (4, 10, TRUE, 14),
       (5, 12, TRUE, 15),
       (6, 4, FALSE, 16),
       (7, 6, FALSE, 17),
       (8, 8, FALSE, 18),
       (9, 10, FALSE, 19),
       (10, 12, FALSE, 20);

-- payment_method
INSERT INTO payment_method (payment_id, payment_type, customer_id)
VALUES (1, 'Credit Card', 1),
       (2, 'Debit Card', 2),
       (3, 'Cash', 3),
       (4, 'PayPal', 4),
       (5, 'Bank Transfer', 5),
       (6, 'Google Pay', 6),
       (7, 'Apple Pay', 7),
       (8, 'Cryptocurrency', 8),
       (9, 'Cash on Delivery', 9),
       (10, 'Cheque', 10);
