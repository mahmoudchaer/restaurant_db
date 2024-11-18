alter table product 
add constraint fk_product_supplier 
foreign key (supplier_id) references supplier(supplier_id ) on delete set null; 


alter table assigned_locations 
add constraint fk_assigned_locations_driver 
foreign key (delivery_employee_id) references delivery_driver(employee_id ) on delete set null; 


alter table delivery_driver 
add constraint fk_driver_waiter 
foreign key (waiter_contact) references waiter(employee_id ) on delete set null;


alter table delivery_driver 
add constraint fk_driver_waiter 
foreign key (waiter_contact) references waiter(employee_id ) on delete set null;


alter table emergency_contact 
add constraint fk_emergency_waiter 
foreign key (dep_employee_id) references waiter(employee_id ) on delete cascade;


alter table emergency_contact 
add constraint fk_emergency_driver 
foreign key (dep_employee_id) references delivery_driver(employee_id ) on delete cascade;


alter table emergency_contact 
add constraint fk_emergency_chef 
foreign key (dep_employee_id) references chef(employee_id ) on delete cascade;


alter table kitcehen_station 
add constraint fk_kitchen_chef 
foreign key (manager_id) references chef(employee_id ) on delete set null;
