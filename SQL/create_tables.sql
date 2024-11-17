--Mahmoud

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Address VARCHAR(255),
    -- Avg_Rating DECIMAL(4, 1), --derived attribute
    Points INT,
    cust_Name VARCHAR(100) not null,
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Table_ID INT -- Foreign key references id of table
);

CREATE TABLE Payment_Method (
    Payment_ID INT PRIMARY KEY,
    Payment_Type VARCHAR(50) ,
    Customer_ID INT
    -- FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) on delete cascade
);

CREATE TABLE Review (
    Review_ID INT, 
    Customer_ID INT, 
    Rating DECIMAL(3, 1) not null,
    Description TEXT,
    constraint pk_comp_cust_review PRIMARY KEY (Review_ID, Customer_ID)
    -- FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) on delete cascade
);

CREATE TABLE Image_Review (
    Image_ID INT PRIMARY KEY,
    Image VARCHAR(255) not null, 
    Review_Number INT,
    Customer_ID INT
    -- FOREIGN KEY (Review_Number, Customer_ID) REFERENCES Review(Review_ID, Customer_ID) on delete cascade
);

Create table Ingredient (
	
	inventory_id int primary key,
	minimum_quantity int not null,
	--price int, --derived attribute
	stock_qty int not null,
	ingr_name varchar(100) not null

);

create table meal(
	meal_name varchar(100) primary key,
	cost_meal decimal (3,1) not null,
	recipe varchar(500) not null,
	price decimal(3,2) not null,
	category varchar (50) not null,
	description varchar(200) not null
	--avg_cook_time time, --derived

);

create table image_meal(
	image_id int primary key,
	image varchar(255) not null,
	meal_name varchar(100)
    -- FOREIGN KEY (meal_name) REFERENCES meal(meal_name)


);

-- omar

CREATE TABLE menu (
    menu_ID INT PRIMARY KEY,         
    start_time TIME NOT NULL,           
    end_time TIME NOT NULL,             
    category VARCHAR(255) NOT NULL,      
    image varchar(255)                        
);


CREATE TABLE menu_day (
    menu_ID INT NOT NULL,               
    day VARCHAR(15) NOT NULL,           
    PRIMARY KEY (menu_ID, day)      
    -- FOREIGN KEY (menu_ID) REFERENCES menu(menu_ID) ON DELETE CASCADE               
);

CREATE TABLE orders (
    order_ID INT PRIMARY KEY,     
    date DATE NOT NULL,        
    status VARCHAR(20) NOT NULL,     
    priority VARCHAR(10),     
    customer_id int, -- fk customer_ID to customer
    delivery_driver_id int --fk delivery_driver to delivery driver

);

CREATE TABLE tables (
    table_ID INT PRIMARY KEY,         
    seat_capacity INT NOT NULL,          
    availability BOOLEAN NOT NULL,        
    waiter_id int -- fk waiter_ID to waiter

);

CREATE TABLE chef (
    employee_id INT PRIMARY KEY,      
    chef_role VARCHAR(50) NOT NULL,          
    salary INT NOT NULL,     
    hire_date DATE,            
    CV TEXT,                            
    supervisor_id INT,
    works_in int --fk works_in to kitchen_station
    -- FOREIGN KEY (supervisor_id) REFERENCES chef(employee_id) ON DELETE SET NULL               
);
