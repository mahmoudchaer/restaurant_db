create table creates (
    menu_id INTEGER,
    chef_id id_type,
    primary key (menu_id, chef_id),
    foreign key (menu_id) references menu(menu_id) on delete cascade,    
    foreign key (chef_id) references chef(employee_id) on delete cascade
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
    menu_id INTEGER,
    meal_name name_type,
    primary key (menu_id, meal_name),
    foreign key (menu_id) references menu(menu_id) on delete cascade,  
    foreign key (meal_name) references meal(meal_name) on delete cascade
);



create table supplies (
    ingredient INTEGER,
    supplier id_type,
    supp_cost money_type not null,
    delivery_time time not null,
    contract_until date,
    primary key (ingredient, supplier),
    foreign key (ingredient) references ingredient(inventory_id) on delete cascade,  
    foreign key (supplier) references supplier(supplier_id) on delete cascade
);


CREATE TABLE chef_shift (
    administration_id id_type NOT NULL,              
    chef_id id_type NULL,                        
    start_time TIME NOT NULL,                    
    end_time TIME NOT NULL,                     
    PRIMARY KEY (administration_id, chef_id),     
    FOREIGN KEY (administration_id) REFERENCES administration(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (chef_id) REFERENCES chef(employee_id) ON DELETE CASCADE
);

CREATE TABLE waiter_shift (
    administration_id id_type NOT NULL,             
    waiter_id id_type NOT NULL,                      
    start_time TIME NOT NULL,                    
    end_time TIME NOT NULL,                     
    PRIMARY KEY (administration_id, waiter_id),   
    FOREIGN KEY (administration_id) REFERENCES administration(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (waiter_id) REFERENCES waiter(employee_id) ON DELETE CASCADE
);

CREATE TABLE hires_waiter (
    hr_id id_type,                                                                     
    waiter_id id_type,                                                                                               
    PRIMARY KEY (hr_id, waiter_id), 
    FOREIGN KEY (hr_id) REFERENCES hr(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (waiter_id) REFERENCES waiter(employee_id) ON DELETE CASCADE 
);


CREATE TABLE hires_chef (
    hr_id id_type,                               
    chef_id id_type,                                                                                                 
    PRIMARY KEY (hr_id, chef_id), 
    FOREIGN KEY (hr_id) REFERENCES hr(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (chef_id) REFERENCES chef(employee_id) ON DELETE CASCADE
    
);


CREATE TABLE hires_driver (
    hr_id id_type,                                                                 
    delivery_driver_id id_type,                                                            
    PRIMARY KEY (hr_id,delivery_driver_id), 
    FOREIGN KEY (hr_id) REFERENCES hr(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (delivery_driver_id) REFERENCES delivery_driver(employee_id) ON DELETE CASCADE
);


CREATE TABLE contacts (
    admin_id id_type ,                   
    supplier_id id_type,                                            
    PRIMARY KEY (admin_id, supplier_id), 
    FOREIGN KEY (admin_id) REFERENCES administration(employee_id) ON DELETE set null,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id) ON DELETE set null
);

CREATE TABLE contain (
    order_id INTEGER ,               
    meal_name name_type ,              
    quantity quantity_type,
    PRIMARY KEY (order_id, meal_name), 
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (meal_name) REFERENCES meal(meal_name) ON DELETE CASCADE
);


create table places(
    order_id INTEGER,
    customer_id id_type,
    waiter_id id_type,
    primary key (waiter_id, customer_id, order_id),
    FOREIGN KEY (waiter_id) REFERENCES waiter(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id) ON DELETE CASCADE
    
);  
 







