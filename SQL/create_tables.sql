--mahmoud
CREATE TABLE customer (
    customer_id id_type,
    address address_type,
    -- avg_rating rating_type, --derived attribute
    points int,
    cust_name name_type,
    phone_number phone_type,
    email email_type,
    table_id int, -- foreign key references id of table
	
    CONSTRAINT phone_email_constraint_cust unique (phone_number, email),
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);

CREATE TABLE hr (
    employee_id id_type,
    address address_type,
    hr_name name_type,
    salary money_type,
    hr_role varchar(50) not null,
    email email_type,
    phone_number phone_type,
	
    CONSTRAINT phone_email_constraint_hr unique (phone_number, email),
    CONSTRAINT pk_hr PRIMARY KEY (employee_id)
);

CREATE TABLE payment_method (
    payment_id id_type,
    payment_type varchar(50),
    customer_id id_type,
    -- foreign key (customer_id) references customer(customer_id) on delete cascade

    CONSTRAINT pk_payment_method PRIMARY KEY (payment_id)
);

CREATE TABLE review (
    review_id id_type UNIQUE, 
    customer_id id_type, 
    rating rating_type not null,
    description description_type,
	
    CONSTRAINT pk_review PRIMARY KEY (review_id, customer_id)
    -- foreign key (customer_id) references customer(customer_id) on delete cascade
);

CREATE TABLE image_review (
    image image_type, 
    review_number int,

    CONSTRAINT pk_image_review PRIMARY KEY (image,review_number)
    -- foreign key (review_number, customer_id) references review(review_id, customer_id) on delete cascade
);

CREATE TABLE ingredient (
    inventory_id id_type,
    minimum_quantity quantity_type not null,
    --price money_type , --derived attribute
    stock_qty quantity_type not null,
    ingr_name name_type not null,

    CONSTRAINT pk_ingredient PRIMARY KEY (inventory_id)
);

CREATE TABLE meal (
    meal_name name_type,
    cost_meal money_type not null,
    recipe description_type not null,
    price money_type not null,
    category varchar(50) not null,
    description description_type not null,
    --avg_cook_time time, --derived
	
    CONSTRAINT pk_meal PRIMARY KEY (meal_name)
);

CREATE TABLE image_meal (
    image BYTEA primary key,
    meal_name name_type,
    -- foreign key (meal_name) references meal(meal_name)
);

-- omar

CREATE TABLE tables (
    table_id id_type,         
    seat_capacity int not null check (seat_capacity>=0),          
    availability boolean not null,
    waiter_id id_type, --fk to waiter

    CONSTRAINT pk_tables PRIMARY KEY (table_id)
);

CREATE TABLE menu (
    menu_id id_type,         
    start_time time_type not null,           
    end_time time_type not null,             
    category varchar(255) not null,      
    image image_type,

    CONSTRAINT pk_menu PRIMARY KEY (menu_id)
);

CREATE TABLE menu_day (
    menu_id id_type not null,               
    day_of_week varchar(15) not null,
	
    CONSTRAINT pk_menu_day PRIMARY KEY (menu_id, day_of_week)      
    -- foreign key (menu_id) references menu(menu_id) on delete cascade               
);

CREATE TABLE customer_order (
    order_id id_type,     
    date TIMESTAMP not null,        
    status varchar(20) not null,     
    priority INTEGER CHECK (priority>0 AND priority<11),     
    customer_id id_type, -- fk customer_id to customer
    delivery_driver_id id_type, --fk delivery_driver to delivery driver

    CONSTRAINT pk_order PRIMARY KEY (order_id)
);

CREATE TABLE chef (
    employee_id id_type,      
    chef_role varchar(50) not null,          
    salary money_type not null,     
    hire_date date,            
    cv description_type,                            
    supervisor_id id_type,
    works_in name_type,  --fk works_in to kitchen_station
    -- foreign key (supervisor_id) references chef(employee_id) on delete set null    

    CONSTRAINT pk_chef PRIMARY KEY (employee_id)
);

CREATE TABLE waiter (
    employee_id id_type,      
    waiter_role varchar(50) not null,           
    waiter_name name_type,          
    cv description_type,                             
    salary money_type,      
    hire_date date not null,            
    supervisor_id id_type,                
    -- foreign key (supervisor_id) references waiter(employee_id) on delete set null    

    CONSTRAINT pk_waiter PRIMARY KEY (employee_id)
);

--hussein

CREATE TABLE supplier (
    supplier_id id_type, 
    name_supp name_type,
    address address_type not null,
    phone_number phone_type not null,
    email email_type not null,
	
    CONSTRAINT us_constraint unique (phone_number, email), -- constraint unique supplier
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id)
);

CREATE TABLE product (
    product_name name_type,
    supplier_id id_type,
	
    CONSTRAINT pk_product PRIMARY KEY (product_name, supplier_id)
	
    --foreign key (supplierid) references supplier(supplierid) on delete cascade
);

CREATE TABLE delivery_driver (
    employee_id id_type,
    driver_name name_type not null,
    contact_info phone_type not null,
    vehicle_type varchar(10) not null,
    average_rating rating_type,
    waiter_contact id_type not null,
	
    CONSTRAINT udd_constraint unique (contact_info),  --constraint unique delivery driver
    CONSTRAINT pk_delivery_driver primary key (employee_id)
    -- fk waiter contact references employeeid in waiter
);

CREATE TABLE assigned_locations (
    del_location id_type,
    delivery_employee_id id_type, --we could have a location not yet assigned to a driver or if the driver responsible for it just quit
	
    CONSTRAINT pK_assigned_locations PRIMARY  KEY (del_location, delivery_employee_id)
    --foreign key (delivery_employeeid) references delivery_driver(employee_id) on delete set null
);

CREATE TABLE administration (
    employee_id id_type,
    adm_name name_type not null,
    adm_role varchar(30), -- could be null if newly hired, promoted or demoted/suspended
    salary money_type, --could be null if newly hired, promoted or demoted/suspended
    address address_type not null, 
    phone_number phone_type not null,
    email email_type not null,
	
    CONSTRAINT phone_email_constraint_adm UNIQUE (phone_number, email),
    CONSTRAINT pk_administration PRIMARY KEY (employee_id)
    --no fk
);

CREATE TABLE kitchen_station (
    station_name name_type not null,
    number_of_chefs integer, --could be null if station newly created or about to be closed
    specialization varchar(30) not null,
    manager_id id_type not null,
	
    CONSTRAINT station_mngr_kitchen_unique UNIQUE (station_name, manager_id),
    CONSTRAINT pk_kitchen_station PRIMARY KEY (station_name)
    --foreign key managerid references chef(employeeid) on delete set null
);

CREATE TABLE emergency_contact (
    contact_name varchar(25) not null,
    relation varchar(20) not null,
    priority integer not null,
    phone_number integer not null,
    dep_employee_id integer not null,
    --no unique constraint as two employees can have the same emergency contact, say if they were related 
    --and the same employee can have multiple emergency contacts
	
    CONSTRAINT pk_emergency_contact PRIMARY KEY (contact_name, dep_employee_id)
    --foreign key dep_employeeid references waiter(employeeid) on delete cascade,
    --foreign key dep_employeeid references deliverydriver(employeeid) on delete cascade,
    --foreign key dep_employeeid references chef(employeeid) on delete cascade,
);
