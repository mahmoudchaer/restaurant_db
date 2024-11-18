-- add foreign key to payment_method for customer_id
alter table payment_method 
add constraint fk_payment_customer 
foreign key (customer_id) references customer(customer_id) on delete cascade;

-- add foreign key to review for customer_id
alter table review 
add constraint fk_review_customer 
foreign key (customer_id) references customer(customer_id) on delete cascade;

-- add foreign key to image_review for review_number and customer_id
alter table image_review 
add constraint fk_image_review 
foreign key (review_number, customer_id) references review(review_id, customer_id) on delete cascade;

-- add foreign key to image_meal for meal_name
alter table image_meal 
add constraint fk_image_meal 
foreign key (meal_name) references meal(meal_name);

-- add foreign key to menu_day for menu_id
alter table menu_day 
add constraint fk_menu_day 
foreign key (menu_id) references menu(menu_id) on delete cascade;

-- add foreign key to orders for customer_id
alter table customer_order 
add constraint fk_orders_customer 
foreign key (customer_id) references customer(customer_id);

-- add foreign key to orders for delivery_driver_id
alter table customer_order 
add constraint fk_orders_driver 
foreign key (delivery_driver_id) references delivery_driver(employee_id );

-- add foreign key to tables for waiter_id
alter table tables 
add constraint fk_tables_waiter 
foreign key (waiter_id) references waiter(employee_id);

-- add foreign key to chef for supervisor_id
alter table chef 
add constraint fk_chef_supervisor 
foreign key (supervisor_id) references chef(employee_id) on delete set null;

-- add foreign key to chef for works_in
alter table chef 
add constraint fk_chef_kitchen 
foreign key (works_in) references kitchen_station (stationname);
