--mahmoud

create table customer (
    customer_id id_type primary key,
    address address_type,
    -- avg_rating rating_type, --derived attribute
    points int,
    cust_name name_type not null,
    phone_number phone_type,
    email email_type,
    table_id int, -- foreign key references id of table
    constraint phone_email_constraint_cust unique (phone_number, email)
);

create table hr (
    employee_id id_type primary key,
    address address_type,
    hr_name name_type not null,
    salary money_type not null,
    hr_role varchar(50) not null,
    email email_type not null,
    phone_number phone_type not null,
    constraint phone_email_constraint_hr unique (phone_number, email)
);

create table payment_method (
    payment_id id_type primary key,
    payment_type varchar(50),
    customer_id id_type
    -- foreign key (customer_id) references customer(customer_id) on delete cascade
);

create table review (
    review_id id_type, 
    customer_id id_type, 
    rating rating_type not null,
    description description_type,
    constraint pk_comp_cust_review primary key (review_id, customer_id)
    -- foreign key (customer_id) references customer(customer_id) on delete cascade
);

create table image_review (
    image_id id_type primary key,
    image image_type not null, 
    review_number int,
    customer_id id_type 
    -- foreign key (review_number, customer_id) references review(review_id, customer_id) on delete cascade
);

create table ingredient (
    inventory_id id_type primary key,
    minimum_quantity quantity_type not null,
    --price money_type , --derived attribute
    stock_qty quantity_type not null,
    ingr_name name_type not null
);

create table meal (
    meal_name name_type primary key,
    cost_meal money_type not null,
    recipe description_type not null,
    price money_type not null,
    category varchar(50) not null,
    description description_type not null
    --avg_cook_time time, --derived
);

create table image_meal (
    image_id id_type primary key,
    image image_type not null,
    meal_name name_type 
    -- foreign key (meal_name) references meal(meal_name)
);

-- omar

create table tables (
    table_id id_type primary key,         
    seat_capacity int not null check (seat_capacity>=0),          
    availability boolean not null,
    waiter_id id_type --fk to waiter
);

create table menu (
    menu_id id_type primary key,         
    start_time time_type not null,           
    end_time time_type not null,             
    category varchar(255) not null,      
    image image_type                        
);

create table menu_day (
    menu_id id_type not null,               
    day varchar(15) not null,           
    primary key (menu_id, day)      
    -- foreign key (menu_id) references menu(menu_id) on delete cascade               
);

create table orders (
    order_id id_type primary key,     
    date date not null,        
    status varchar(20) not null,     
    priority varchar(10),     
    customer_id id_type, -- fk customer_id to customer
    delivery_driver_id id_type --fk delivery_driver to delivery driver
);

create table chef (
    employee_id id_type primary key,      
    chef_role varchar(50) not null,          
    salary money_type not null,     
    hire_date date,            
    cv description_type,                            
    supervisor_id id_type,
    works_in name_type  --fk works_in to kitchen_station
    -- foreign key (supervisor_id) references chef(employee_id) on delete set null               
);

create table waiter (
    employee_id id_type primary key,      
    waiter_role varchar(50) not null,           
    waiter_name name_type not null,          
    cv description_type,                             
    salary money_type not null,      
    hire_date date not null,            
    supervisor_id id_type                 
    -- foreign key (supervisor_id) references waiter(employee_id) on delete set null              
);

--hussein

create table supplier (
    supplierid id_type not null, 
    namesupp name_type not null,
    address address_type not null,
    phonenumber phone_type not null,
    email email_type not null,
    constraint us_constraint unique (phonenumber, email), -- constraint unique supplier
    primary key (supplierid)
);

create table product (
    productid id_type not null,
    productname name_type not null,
    supplierid id_type not null,
    primary key (productid),
    foreign key (supplierid) references supplier(supplierid) on delete cascade
);

create table deliverydriver (
    employeeid id_type not null,
    drivername name_type not null,
    contactinfo phone_type not null,
    vehicletype varchar(10) not null,
    averagerating rating_type,
    waitercontact id_type not null,
    constraint udd_constraint unique (contactinfo),  --constraint unique delivery driver
    primary key (employeeid)
    -- fk waiter contact references employeeid in waiter
);

create table assignedlocations (
    locationid id_type not null,
    address address_type not null,
    delivery_employeeid id_type, --we could have a location not yet assigned to a driver or if the driver responsible for it just quit
    constraint location_constraint unique (locationid),   --constraint unique location id
    primary key (locationid),
    foreign key (delivery_employeeid) references deliverydriver(employeeid) on delete set null
);

create table administration (
    employeeid id_type not null,
    admname name_type not null,
    admrole varchar(30), -- could be null if newly hired, promoted or demoted/suspended
    salary money_type, --could be null if newly hired, promoted or demoted/suspended
    address address_type not null, 
    phonenumber phone_type not null,
    email email_type not null,
    constraint phone_email_constraint_adm unique (phonenumber, email),
    primary key (employeeid)
    --no fk
);

create table kitchenstation (
    stationname name_type not null,
    number_of_chefs integer, --could be null if station newly created or about to be closed
    specialization varchar(30) not null,
    managerid id_type not null,
    constraint station_mngr_kitchen_unique unique (stationname, managerid),
    primary key (stationname)
    --foreign key managerid references chef(employeeid) on delete set null
);

create table emergencycontact (
    contactname varchar(25) not null,
    relation varchar(20) not null,
    priority integer not null,
    phone_number integer not null,
    dep_employeeid integer not null,
    --no unique constraint as two employees can have the same emergency contact, say if they were related 
    --and the same employee can have multiple emergency contacts
    constraint pk_constraint primary key (contactname, dep_employeeid)
    --foreign key dep_employeeid references waiter(employeeid) on delete cascade,
    --foreign key dep_employeeid references deliverydriver(employeeid) on delete cascade,
    --foreign key dep_employeeid references chef(employeeid) on delete cascade,
);
