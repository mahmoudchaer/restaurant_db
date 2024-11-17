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

-Hussein

CREATE TABLE Supplier (
	SupplierID INTEGER NOT NULL, 
	NameSupp VARCHAR(25) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	PhoneNumber INTEGER NOT NULL,
	Email VARCHAR(30) NOT NULL,
	
	CONSTRAINT US_constraint UNIQUE (SuppierID, PhoneNumber, Email), -- Constraint 	Unique Supplier
	PRIMARY KEY (SupplierID)
	--NO FK
);

CREATE TABLE Product (
	ProductID INTEGER NOT NULL,
	ProductName VARCHAR(20) NOT NULL,
	SupplierID INTEGER NOT NULL,
	
	CONSTRAINT UP_constraint UNIQUE (ProductID),  --Constraint unique productID 
	PRIMARY KEY (ProductID),
	FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE
);


CREATE TABLE DeliveryDriver(
	EmployeeID INTEGER NOT NULL,
	DriverName VARCHAR(25) NOT NULL,
	ContactInfo INTEGER NOT NULL,
	VehicleType VARCHAR(10) NOT NULL,
	AverageRating INTEGER,
	WaiterContact INTEGER NOT NULL,

	CONSTRAINT UDD_constraint UNIQUE (EmployeeID, ContactInfo),  --Constraint Unique delivery driver
	PRIMARY KEY (EmployeeID)
	-- FK Waiter Contact references EmployeeID in waiter
);

CREATE TABLE AssignedLocations(
	LocationID INTEGER NOT NULL,
	Address VARCHAR(255) NOT NULL,
	Delivery_EmployeeID INTEGER, --We could have a location not yet assigned to a driver or if the driver responsible for it just quit

	CONSTRAINT UL_constraint UNIQUE (LocationID),   --Constraint Unique location ID
	PRIMARY KEY (LocationID),
	FOREIGN KEY (Delivery_EmployeeID) REFERENCES DeliveryDriver(EmployeeID) ON DELETE SET NULL
	
);


CREATE TABLE Administration(
	EmployeeID INTEGER NOT NULL,
	AdmName VARCHAR(25) NOT NULL,
	AdmRole VARCHAR(30), -- Could be NULL if newly hired, promoted or demoted/suspended
	Salary INTEGER, --Could be NULL if newly hired, promoted or demoted/suspended
	Address VARCHAR (255) NOT NULL, 
	PhoneNumber INTEGER NOT NULL,
	Email VARCHAR(30) NOT NULL,

	CONSTRAINT UA_constraint UNIQUE (EmployeeID, PhoneNumber, Email),
	PRIMARY KEY (EmployeeID)
	--NO FK
);



CREATE TABLE KitchenStation (
	StationName VARCHAR(25) NOT NULL,
	Number_of_Chefs INTEGER, --Could be NULL if station newly created or about to be closed
	Specialization VARCHAR(30) NOT NULL,
	ManagerID INTEGER NOT NULL,


	CONSTRAINT UK_constraint UNIQUE (StationName, ManagerID), --Constraint Unique kitchen 
	PRIMARY KEY (StationName)
	--FOREIGN KEY ManagerID REFERENCES Chef(EmployeeID) ON DELETE SET NULL
);



CREATE TABLE EmergencyContact(
	ContactName VARCHAR(25) NOT NULL,
	Relation VARCHAR(20) NOT NULL,
	Priority INTEGER NOT NULL,
	Phone_Number INTEGER NOT NULL,
	Dep_EmployeeID INTEGER NOT NULL,

	--NO UNIQUE CONSTRAINT AS TWO EMPLOYEES CAN HAVE THE SAME EMERGENCY CONTACT, SAY IF THEY WERE RELATED 
	--AND THE SAME EMPPLOYEE CAN HAVE MULTIPLE EMERGENCY CONTACTS
	CONSTRAINT PK_EContact PRIMARY KEY (ContactName, Dep_EmployeeID)
	--FOREIGN KEY Dep_EmployeeID REFERENCES Waiter(EmployeeID) ON DELETE CASCADE,
	--FOREIGN KEY Dep_EmployeeID REFERENCES DeliveryDriver(EmployeeID) ON DELETE CASCADE,
	--FOREIGN KEY Dep_EmployeeID REFERENCES Chef(EmployeeID) ON DELETE CASCADE,


);
