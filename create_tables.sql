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
    Customer_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Review (
    Review_ID INT, 
    Customer_ID INT, 
    Rating DECIMAL(3, 1) not null,
    Description TEXT,
    constraint pk_comp_cust_review PRIMARY KEY (Review_ID, Customer_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Image_Review (
    Image_ID INT PRIMARY KEY,
    Image VARCHAR(255) not null, 
    Review_Number INT,
    Customer_ID INT,
    FOREIGN KEY (Review_Number, Customer_ID) REFERENCES Review(Review_ID, Customer_ID)
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
	meal_name varchar(50)


);