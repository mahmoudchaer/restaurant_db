--Mahmoud

CREATE TABLE Customer (
    Customer_ID id_type PRIMARY KEY,
    Address address_type,
    -- Avg_Rating rating_type, --derived attribute
    Points INT ,
    cust_Name name_type  not null,
    Phone_Number phone_type,
    Email email_type,
    Table_ID INT, -- Foreign key references id of table
    CONSTRAINT Phone_email_constraint_cust UNIQUE (Phone_Number, Email)
);

CREATE TABLE Payment_Method (
    Payment_ID id_type  PRIMARY KEY,
    Payment_Type VARCHAR(50) ,
    Customer_ID id_type 
    -- FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) on delete cascade
);

CREATE TABLE Review (
    Review_ID id_type , 
    Customer_ID id_type, 
    Rating rating_type  not null,
    Description description_type ,
    constraint pk_comp_cust_review PRIMARY KEY (Review_ID, Customer_ID)
    -- FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) on delete cascade
);

CREATE TABLE Image_Review (
    Image_ID id_type  PRIMARY KEY,
    Image image_type  not null, 
    Review_Number INT,
    Customer_ID id_type 
    -- FOREIGN KEY (Review_Number, Customer_ID) REFERENCES Review(Review_ID, Customer_ID) on delete cascade
);

Create table Ingredient (
	
	inventory_id id_type primary key,
	minimum_quantity quantity_type  not null,
	--price money_type , --derived attribute
	stock_qty quantity_type  not null,
	ingr_name name_type  not null

);

create table meal(
	meal_name name_type  primary key,
	cost_meal money_type not null,
	recipe description_type not null,
	price money_type  not null,
	category varchar (50) not null,
	description description_type  not null
	--avg_cook_time time, --derived

);

create table image_meal(
	image_id id_type  primary key,
	image image_type  not null,
	meal_name name_type 
    -- FOREIGN KEY (meal_name) REFERENCES meal(meal_name)


);

-- omar

CREATE TABLE tables (
    table_ID id_type PRIMARY KEY,         
    seat_capacity INT NOT NULL CHECK (Value>=0),          
    availability BOOLEAN NOT NULL,        
     waiter_id id_type --fk to waiter
      
);

CREATE TABLE menu (
    menu_ID id_type PRIMARY KEY,         
    start_time time_type NOT NULL,           
    end_time time_type NOT NULL,             
    category VARCHAR(255) NOT NULL,      
    image image_type                        
);


CREATE TABLE menu_day (
    menu_ID id_type NOT NULL,               
    day VARCHAR(15) NOT NULL,           
    PRIMARY KEY (menu_ID, day)      
    -- FOREIGN KEY (menu_ID) REFERENCES menu(menu_ID) ON DELETE CASCADE               
);

CREATE TABLE orders (
    order_ID id_type PRIMARY KEY,     
    date DATE NOT NULL,        
    status VARCHAR(20) NOT NULL,     
    priority VARCHAR(10),     
    customer_id id_type, -- fk customer_ID to customer
    delivery_driver_id id_type --fk delivery_driver to delivery driver
);


CREATE TABLE chef (
    employee_id id_type PRIMARY KEY,      
    chef_role VARCHAR(50) NOT NULL,          
    salary money_type NOT NULL,     
    hire_date DATE,            
    CV description_type,                            
    supervisor_id id_type,
    works_in id_type --fk works_in to kitchen_station
    -- FOREIGN KEY (supervisor_id) REFERENCES chef(employee_id) ON DELETE SET NULL               
);

CREATE TABLE waiter (
    employee_id id_type PRIMARY KEY,      
    waiter_role VARCHAR(50) NOT NULL,           
    waiter_name name_type NOT NULL,          
    CV description_type,                             
    salary money_type NOT NULL,      
    hire_date DATE NOT NULL,            
    supervisor_id id_type                 
    -- FOREIGN KEY (supervisor_id) REFERENCES waiter(employee_id) ON DELETE SET NULL                         
);
--Hussein

CREATE TABLE Supplier (
	SupplierID id_type NOT NULL, 
	NameSupp name_type NOT NULL,
	Address address_type NOT NULL,
	PhoneNumber phone_type NOT NULL,
	Email email_type NOT NULL,
	
	CONSTRAINT US_constraint UNIQUE (PhoneNumber, Email), -- Constraint 	Unique Supplier
	PRIMARY KEY (SupplierID)
);

CREATE TABLE Product (
	ProductID id_type NOT NULL,
	ProductName name_type NOT NULL,
	SupplierID id_type NOT NULL,

	PRIMARY KEY (ProductID),
	FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE
);


CREATE TABLE DeliveryDriver(
	EmployeeID id_type NOT NULL,
	DriverName name_type NOT NULL,
	ContactInfo phone_type NOT NULL,
	VehicleType VARCHAR(10) NOT NULL,
	AverageRating rating_type,
	WaiterContact id_type NOT NULL,

	CONSTRAINT UDD_constraint UNIQUE (ContactInfo),  --Constraint Unique delivery driver
	PRIMARY KEY (EmployeeID)
	-- FK Waiter Contact references EmployeeID in waiter
);

CREATE TABLE AssignedLocations(
	LocationID id_type NOT NULL,
	Address address_type NOT NULL,
	Delivery_EmployeeID id_type, --We could have a location not yet assigned to a driver or if the driver responsible for it just quit

	CONSTRAINT Location_constraint UNIQUE (LocationID),   --Constraint Unique location ID
	PRIMARY KEY (LocationID),
	FOREIGN KEY (Delivery_EmployeeID) REFERENCES DeliveryDriver(EmployeeID) ON DELETE SET NULL
	
);


CREATE TABLE Administration(
	EmployeeID id_type NOT NULL,
	AdmName name_type NOT NULL,
	AdmRole VARCHAR(30), -- Could be NULL if newly hired, promoted or demoted/suspended
	Salary money_type, --Could be NULL if newly hired, promoted or demoted/suspended
	Address address_type NOT NULL, 
	PhoneNumber phone_type NOT NULL,
	Email email_type NOT NULL,

	CONSTRAINT Phone_email_constraint_adm UNIQUE (PhoneNumber, Email),
	PRIMARY KEY (EmployeeID)
	--NO FK
);



CREATE TABLE KitchenStation (
	StationName name_type NOT NULL,
	Number_of_Chefs INTEGER, --Could be NULL if station newly created or about to be closed
	Specialization VARCHAR(30) NOT NULL,
	ManagerID id_type NOT NULL,


	CONSTRAINT station_mngr_kitchen_unique UNIQUE (StationName, ManagerID),
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
	CONSTRAINT PK_constraint PRIMARY KEY (ContactName, dep_EmployeeID)
	--FOREIGN KEY Dep_EmployeeID REFERENCES Waiter(EmployeeID) ON DELETE CASCADE,
	--FOREIGN KEY Dep_EmployeeID REFERENCES DeliveryDriver(EmployeeID) ON DELETE CASCADE,
	--FOREIGN KEY Dep_EmployeeID REFERENCES Chef(EmployeeID) ON DELETE CASCADE,
);
