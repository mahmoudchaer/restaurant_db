-- Mahmoud's Tables
CREATE TABLE customer (
    customer_id id_type CONSTRAINT pk_customer PRIMARY KEY,
    address address_type,
    -- avg_rating rating_type, --derived attribute
    points int CONSTRAINT chk_customer_points_positive CHECK (points >= 0),
    cust_name name_type CONSTRAINT nn_customer_cust_name NOT NULL,
    phone_number phone_type CONSTRAINT nn_customer_phone_number NOT NULL,
    email email_type,
    table_id int, -- foreign key references id of table

    CONSTRAINT phone_email_constraint_cust UNIQUE (phone_number, email)
);

CREATE TABLE hr (
    employee_id id_type CONSTRAINT pk_hr PRIMARY KEY,
    address address_type,
    hr_name name_type CONSTRAINT nn_hr_hr_name NOT NULL,
    salary money_type CONSTRAINT chk_hr_salary_positive CHECK (salary >= 0),
    hr_role varchar(50) CONSTRAINT nn_hr_hr_role NOT NULL,
    email email_type,
    phone_number phone_type CONSTRAINT nn_hr_phone_number NOT NULL,

    CONSTRAINT phone_email_constraint_hr UNIQUE (phone_number, email)
);

CREATE TABLE payment_method (
    payment_id id_type CONSTRAINT pk_payment_method PRIMARY KEY,
    payment_type varchar(50) CONSTRAINT nn_payment_method_payment_type NOT NULL,
    customer_id id_type CONSTRAINT nn_payment_method_customer_id NOT NULL
    -- foreign key (customer_id) references customer(customer_id) on delete cascade
);

CREATE TABLE review (
    review_id id_type CONSTRAINT uq_review_review_id UNIQUE,
    customer_id id_type,
    rating rating_type CONSTRAINT nn_review_rating NOT NULL,
    description description_type,

    CONSTRAINT pk_review PRIMARY KEY (review_id, customer_id)
    -- foreign key (customer_id) references customer(customer_id) on delete cascade
);

CREATE TABLE image_review (
    image image_type CONSTRAINT nn_image_review_image NOT NULL,
    review_number int CONSTRAINT nn_image_review_review_number NOT NULL,

    CONSTRAINT pk_image_review PRIMARY KEY (image, review_number)
    -- foreign key (review_number) references review(review_id) on delete cascade
);

CREATE TABLE ingredient (
    inventory_id id_type CONSTRAINT pk_ingredient PRIMARY KEY,
    minimum_quantity quantity_type CONSTRAINT nn_ingredient_minimum_quantity NOT NULL,
    --price money_type , --derived attribute
    stock_qty quantity_type CONSTRAINT nn_ingredient_stock_qty NOT NULL,
    ingr_name name_type CONSTRAINT nn_ingredient_ingr_name NOT NULL
);

CREATE TABLE meal (
    meal_name name_type CONSTRAINT pk_meal PRIMARY KEY,
    cost_meal money_type CONSTRAINT nn_meal_cost_meal NOT NULL,
    recipe description_type CONSTRAINT nn_meal_recipe NOT NULL,
    price money_type,
    category varchar(50) CONSTRAINT nn_meal_category NOT NULL,
    description description_type CONSTRAINT nn_meal_description NOT NULL
    --avg_cook_time time, --derived
);

CREATE TABLE image_meal (
    image image_type CONSTRAINT pk_image_meal PRIMARY KEY,
    meal_name name_type CONSTRAINT nn_image_meal_meal_name NOT NULL
    -- foreign key (meal_name) references meal(meal_name)
);

-- Omar's Tables
CREATE TABLE tables (
    table_id id_type CONSTRAINT pk_tables PRIMARY KEY,
    seat_capacity int CONSTRAINT nn_tables_seat_capacity NOT NULL CONSTRAINT chk_tables_seat_capacity_non_negative CHECK (seat_capacity >= 0),
    availability boolean CONSTRAINT nn_tables_availability NOT NULL,
    waiter_id id_type --fk to waiter
);

CREATE TABLE menu (
    menu_id id_type CONSTRAINT pk_menu PRIMARY KEY,
    start_time TIME CONSTRAINT nn_menu_start_time NOT NULL,
    end_time TIME CONSTRAINT nn_menu_end_time NOT NULL,
    category varchar(255) CONSTRAINT nn_menu_category NOT NULL,
    image image_type
);

CREATE TABLE menu_day (
    menu_id id_type CONSTRAINT nn_menu_day_menu_id NOT NULL,
    day_of_week varchar(15) CONSTRAINT nn_menu_day_day_of_week NOT NULL,

    CONSTRAINT pk_menu_day PRIMARY KEY (menu_id, day_of_week)
    -- foreign key (menu_id) references menu(menu_id) on delete cascade
);

CREATE TABLE customer_order (
    order_id id_type CONSTRAINT pk_order PRIMARY KEY,
    date TIMESTAMP CONSTRAINT nn_customer_order_date NOT NULL,
    status varchar(20) CONSTRAINT nn_customer_order_status NOT NULL,
    priority INTEGER CONSTRAINT chk_customer_order_priority_range CHECK (priority > 0 AND priority < 11),
    customer_id id_type, -- fk customer_id to customer
    delivery_driver_id id_type --fk delivery_driver to delivery driver
);

CREATE TABLE chef (
    employee_id id_type CONSTRAINT pk_chef PRIMARY KEY,
    chef_name name_type CONSTRAINT nn_chef_chef_name NOT NULL,
    chef_role varchar(50) CONSTRAINT nn_chef_chef_role NOT NULL,
    salary money_type CONSTRAINT chk_chef_salary_positive CHECK (salary >= 0),
    hire_date date CONSTRAINT nn_chef_hire_date NOT NULL,
    cv description_type CONSTRAINT nn_chef_cv NOT NULL,
    supervisor_id id_type,
    works_in name_type --fk works_in to kitchen_station
    -- foreign key (supervisor_id) references chef(employee_id) on delete set null
);

CREATE TABLE waiter (
    employee_id id_type CONSTRAINT pk_waiter PRIMARY KEY,
    waiter_role varchar(50) CONSTRAINT nn_waiter_waiter_role NOT NULL,
    waiter_name name_type CONSTRAINT nn_waiter_waiter_name NOT NULL,
    cv description_type CONSTRAINT nn_waiter_cv NOT NULL,
    salary money_type CONSTRAINT chk_waiter_salary_positive CHECK (salary >= 0),
    hire_date date CONSTRAINT nn_waiter_hire_date NOT NULL,
    supervisor_id id_type -- foreign key (supervisor_id) references waiter(employee_id) on delete set null
);

-- Hussein's Tables
CREATE TABLE supplier (
    supplier_id id_type CONSTRAINT pk_supplier PRIMARY KEY,
    name_supp name_type CONSTRAINT nn_supplier_name_supp NOT NULL,
    address address_type CONSTRAINT nn_supplier_address NOT NULL,
    phone_number phone_type CONSTRAINT nn_supplier_phone_number NOT NULL,
    email email_type,

    CONSTRAINT us_constraint UNIQUE (phone_number, email) -- constraint unique supplier
);

CREATE TABLE product (
    product_name name_type CONSTRAINT nn_product_product_name NOT NULL,
    supplier_id id_type CONSTRAINT nn_product_supplier_id NOT NULL,

    CONSTRAINT pk_product PRIMARY KEY (product_name, supplier_id)
    --foreign key (supplierid) references supplier(supplierid) on delete cascade
);

CREATE TABLE delivery_driver (
    employee_id id_type CONSTRAINT pk_delivery_driver PRIMARY KEY,
    driver_name name_type CONSTRAINT nn_delivery_driver_name NOT NULL,
    contact_info phone_type CONSTRAINT nn_delivery_driver_contact_info NOT NULL,
    vehicle_type varchar(10) CONSTRAINT nn_delivery_driver_vehicle_type NOT NULL,
    waiter_contact id_type
    -- fk waiter contact references employeeid in waiter
);

CREATE TABLE assigned_locations (
    del_location VARCHAR(255) CONSTRAINT nn_assigned_locations_del_location NOT NULL,
    delivery_employee_id id_type --we could have a location not yet assigned to a driver or if the driver responsible for it just quit

    CONSTRAINT pK_assigned_locations PRIMARY KEY (del_location, delivery_employee_id)
    --foreign key (delivery_employeeid) references delivery_driver(employee_id) on delete set null
);

CREATE TABLE administration (
    employee_id id_type CONSTRAINT pk_administration PRIMARY KEY,
    adm_name name_type CONSTRAINT nn_administration_adm_name NOT NULL,
    adm_role varchar(30), -- could be null if newly hired, promoted or demoted/suspended
    salary money_type CONSTRAINT chk_administration_salary_positive CHECK (salary >= 0),
    address address_type CONSTRAINT nn_administration_address NOT NULL,
    phone_number phone_type CONSTRAINT nn_administration_phone_number NOT NULL,
    email email_type,

    CONSTRAINT phone_email_constraint_adm UNIQUE (phone_number, email)
    --no fk
);

CREATE TABLE kitchen_station (
    station_name name_type CONSTRAINT pk_kitchen_station PRIMARY KEY,
    number_of_chefs quantity_type,
    specialization varchar(30) CONSTRAINT nn_kitchen_station_specialization NOT NULL,
    manager_id id_type
    --foreign key managerid references chef(employeeid) on delete set null
);

CREATE TABLE emergency_contact_waiter (
    contact_name name_type CONSTRAINT nn_emergency_contact_waiter_contact_name NOT NULL,
    relation VARCHAR(20) CONSTRAINT nn_emergency_contact_waiter_relation NOT NULL,
    priority INTEGER CONSTRAINT nn_emergency_contact_waiter_priority NOT NULL,
    phone_number phone_type CONSTRAINT nn_emergency_contact_waiter_phone_number NOT NULL,
    waiter_id id_type,

    PRIMARY KEY (contact_name, waiter_id)
);

CREATE TABLE emergency_contact_chef (
    contact_name name_type CONSTRAINT nn_emergency_contact_chef_contact_name NOT NULL,
    relation VARCHAR(20) CONSTRAINT nn_emergency_contact_chef_relation NOT NULL,
    priority INTEGER CONSTRAINT nn_emergency_contact_chef_priority NOT NULL,
    phone_number phone_type CONSTRAINT nn_emergency_contact_chef_phone_number NOT NULL,
    chef_id id_type,

    PRIMARY KEY (contact_name, chef_id)
);

CREATE TABLE emergency_contact_delivery_driver (
    contact_name name_type CONSTRAINT nn_emergency_contact_delivery_driver_contact_name NOT NULL,
    relation VARCHAR(20) CONSTRAINT nn_emergency_contact_delivery_driver_relation NOT NULL,
    priority INTEGER CONSTRAINT nn_emergency_contact_delivery_driver_priority NOT NULL,
    phone_number phone_type CONSTRAINT nn_emergency_contact_delivery_driver_phone_number NOT NULL,
    delivery_driver_id id_type,

    PRIMARY KEY (contact_name, delivery_driver_id)
);
