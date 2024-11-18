create table creates (
    administration id_type,
    supplier id_type,
    primary key (administration, supplier),
    foreign key (administration) references administration(employee_id) on delete cascade,    
    foreign key (supplier) references supplier(supplier_id) on delete cascade
);


create table cooks (
    chef id_type,
    time_to_make time,
    meal name_type,
    primary key (meal, chef),
    foreign key (chef) references chef(employee_id) on delete cascade,  
    foreign key (meal) references meal(meal_name) on delete cascade
);


create table composed_of (
    menu_id id_type,
    meal_name name_type,
    primary key (menu_id, meal_name),
    foreign key (menu_id) references menu(menu_id) on delete cascade,  
    foreign key (meal_name) references meal(meal_name) on delete cascade
);



create table supplies (
    ingredient id_type,
    supplier id_type,
    supp_cost money_type not null,
    delivery_time time not null,
    contract_until date,
    primary key (ingredient, supplier),
    foreign key (ingredient) references ingredient(inventory_id) on delete cascade,  
    foreign key (supplier) references supplier(supplier_id) on delete cascade
);


CREATE TABLE shift (
    admin_id id_type NOT NULL,                      
    chef_id id_type,                                
    waiter_id id_type,                             
    start_time time_type NOT NULL,                   
    end_time time_type NOT NULL,                     
    PRIMARY KEY (admin_id, chef_id, waiter_id), 
    FOREIGN KEY (admin_id) REFERENCES administration(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (chef_id) REFERENCES chef(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (waiter_id) REFERENCES waiter(employee_id) ON DELETE CASCADE,
    CONSTRAINT check_shift_employee CHECK (chef_id IS NOT NULL OR waiter_id IS NOT NULL) 
);

CREATE TABLE hires (
    hr_id id_type NOT NULL,                               
    chef_id id_type,                                      
    waiter_id id_type,                                    
    delivery_driver_id id_type,                                                            
    PRIMARY KEY (hr_id, chef_id, waiter_id, delivery_driver_id), 
    FOREIGN KEY (hr_id) REFERENCES hr(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (chef_id) REFERENCES chef(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (waiter_id) REFERENCES waiter(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (delivery_driver_id) REFERENCES delivery_driver(employee_id) ON DELETE CASCADE,
    CONSTRAINT check_hire_employee CHECK (chef_id IS NOT NULL OR waiter_id IS NOT NULL OR delivery_driver_id IS NOT NULL) 
);

CREATE TABLE contacts (
    admin_id id_type NOT NULL,                   
    supplier_id id_type NOT NULL,                                            
    PRIMARY KEY (admin_id, supplier_id), 
    FOREIGN KEY (admin_id) REFERENCES administration(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id) ON DELETE CASCADE
);

CREATE TABLE contain (
    order_id id_type NOT NULL,               
    meal_name name_type NOT NULL,              
    quantity quantity_type NOT NULL,
    PRIMARY KEY (order_id, meal_name), 
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (meal_name) REFERENCES meal(meal_name) ON DELETE CASCADE
);
