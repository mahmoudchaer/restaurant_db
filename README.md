
# Bakri's Big Burgers - Database Management System ![Project Logo](images/logo.png)


This project presents a comprehensive database management system (DBMS) designed for **Bakri's Big Burgers**, a restaurant that serves as a prototype for managing complex operations in the food service industry.

## Overview

The system addresses critical aspects of restaurant management, including:

- **Customer management**: Tracking orders, preferences, and reviews.
- **Employee management**: Managing roles, salaries, and shifts for chefs, waiters, delivery drivers, and HR staff.
- **Inventory control**: Monitoring ingredients and suppliers to ensure consistent stock levels.
- **Operational optimization**: Improving workflow and decision-making through structured data management.

## Features

- **Entity-Relationship Model**:
  - Comprehensive ER diagram outlining entities, attributes, and relationships.
  - Support for complex operations like multi-valued attributes, weak entities, and ternary relationships.

- **Entities**:
  - Customers, Orders, Meals, Tables, Waiters, Chefs, Delivery Drivers, Menu, HR, Administration, Suppliers, Ingredients, Emergency Contacts, Kitchen Stations, and Reviews.

- **Key Relationships**:
  - **Orders** are linked to customers, waiters, and meals.
  - **Meals** depend on ingredients supplied by suppliers.
  - **Reviews** connect customers to their dining experiences.
  - **Shift assignments** optimize employee scheduling.

## Tools Used

- **ER Diagram**: Created using [draw.io](https://draw.io).
- **Relational Mapping**: Converted ER design into relational tables for efficient database storage and querying.

## Database Benefits

1. **Efficiency**:
   - Streamlined data retrieval for customers, staff, and managers.
   - Real-time tracking of orders, inventory, and employee performance.

2. **Accuracy**:
   - Prevents errors in bookings, orders, and stock management.
   - Derived attributes like average customer ratings ensure data consistency.

3. **Enhanced Decision Making**:
   - Provides actionable insights into operations and performance metrics.

## How to Use

1. Clone the repository containing the database scripts and diagrams.
2. Set up the database in your preferred relational database management system (e.g., PostgreSQL, MySQL).
3. Use the provided schema to create tables and populate data.
4. Run SQL queries to manage operations such as placing orders, managing inventory, or viewing customer reviews.

## Team Members

- **Mahmoud Chaer** (Team Leader) - [mmc55@mail.aub.edu](mailto:mmc55@mail.aub.edu)
- **Hussein Moukalled** - [ham69@mail.aub.edu](mailto:ham69@mail.aub.edu)
- **Omar Chehab** - [oac05@mail.aub.edu](mailto:oac05@mail.aub.edu)

## Instructor

- **Dr. Hussein Bakri**

## Course

- EECE 433 – Database Systems (Group 6)

## License

This project is for educational purposes only and is submitted in partial fulfillment of course requirements. All rights reserved.
