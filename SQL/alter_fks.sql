-- add foreign key to payment_method for customer_id
alter table payment_method 
add constraint fk_payment_customer 
foreign key (customer_id) references customer(customer_id) on update cascade on delete cascade;

-- add foreign key to review for customer_id
alter table review 
add constraint fk_review_customer 
foreign key (customer_id) references customer(customer_id) on update cascade on delete cascade;

-- add foreign key to image_review for review_number and customer_id
alter table image_review 
add constraint fk_image_review_review
foreign key (review_number) references review(review_id) on delete cascade,
add constraint fk_image_review_customer 
foreign key (customer_id) references customer(customer_id) on delete cascade;

-- add foreign key to image_meal for meal_name
alter table image_meal 
add constraint fk_image_meal 
foreign key (meal_name) references meal(meal_name) on update cascade on delete cascade;

-- add foreign key to menu_day for menu_id
alter table menu_day 
add constraint fk_menu_day 
foreign key (menu_id) references menu(menu_id) on update cascade on delete cascade;

-- add foreign key to orders for customer_id
alter table customer_order 
add constraint fk_orders_customer 
foreign key (customer_id) references customer(customer_id) on update cascade on delete cascade;

-- add foreign key to orders for delivery_driver_id
alter table customer_order 
add constraint fk_orders_driver 
foreign key (delivery_driver_id) references delivery_driver(employee_id) on delete set null;

-- add foreign key to chef for works_in
alter table chef 
add constraint fk_chef_kitchen 
foreign key (works_in) references kitchen_station (station_name) on delete set null;

alter table product 
add constraint fk_product_supplier 
foreign key (supplier_id) references supplier(supplier_id) on delete cascade; 

-- add foreign key to tables for waiter_id
alter table tables 
add constraint fk_tables_waiter 
foreign key (waiter_id) references waiter(employee_id) on delete set null;

alter table assigned_locations 
add constraint fk_assigned_locations_driver 
foreign key (delivery_employee_id) references delivery_driver(employee_id ) on delete set null; 


alter table delivery_driver 
add constraint fk_driver_waiter 
foreign key (waiter_contact) references waiter(employee_id ) on delete set null;


alter table kitchen_station 
add constraint fk_kitchen_chef 
foreign key (manager_id) references chef(employee_id ) on delete set null;

alter table customer 
add constraint fk_customer 
foreign key (table_id) references tables(table_id ) on delete set null;


alter table emergency_contact_waiter 
add constraint fk_emergency_contact_waiter 
foreign key (waiter_id) references waiter(employee_id) on delete cascade;

alter table emergency_contact_chef 
add constraint fk_emergency_contact_chef 
foreign key (chef_id) references chef(employee_id) on delete cascade;

alter table emergency_contact_delivery_driver 
add constraint fk_emergency_contact_delivery_driver
foreign key (delivery_driver_id) references delivery_driver(employee_id) on delete cascade;
