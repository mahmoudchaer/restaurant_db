import streamlit as st
from st_aggrid import AgGrid  # Correct import for AgGrid
import pandas as pd
import psycopg2
import time  # For auto-refresh workaround

# Set page configuration for the app
st.set_page_config(
    page_title="BBB",
    page_icon="🍽️",
    layout="wide"
)

import os

# Get the absolute path of your background image
background_image_path = os.path.abspath("BackgroundImage.png")  # Replace with your file name

# Add the custom CSS for light grey background
st.markdown("""
    <style>
    .stApp {
        background-color: #f4f4f4; /* Light grey background */
        font-family: Arial, sans-serif;
    }
    </style>
""", unsafe_allow_html=True)



# Database connection details
DB_HOST = 'localhost'
DB_NAME = 'BBB'
DB_USER = 'postgres'
DB_PASS = 'OMaHuss04@'

# Helper Functions
def fetch_data(query):
    """Fetch data from the database."""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        conn.close()
        return pd.DataFrame(data, columns=columns)
    except Exception as e:
        st.error(f"Error fetching data: {e}")
        return pd.DataFrame()

def get_tables():
    """Fetch all table names from the database."""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor()
        cursor.execute("""
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
        """)
        tables = [row[0] for row in cursor.fetchall()]
        conn.close()
        return tables
    except Exception as e:
        st.error(f"Error fetching table names: {e}")
        return []

def insert_data(table_name, columns, values):
    """Insert data into a table."""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor()

        placeholders = ", ".join(["%s"] * len(values))
        query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({placeholders})"
        cursor.execute(query, values)
        conn.commit()
        conn.close()
        st.success(f"Data inserted into {table_name} successfully!")
    except Exception as e:
        st.error(f"Error inserting data: {e}")

def get_columns(table_name):
    """Fetch column names for a table."""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor()
        cursor.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{table_name}'")
        columns = [row[0] for row in cursor.fetchall()]
        conn.close()
        return columns
    except Exception as e:
        st.error(f"Error fetching columns for {table_name}: {e}")
        return []

def call_procedure(proc_name, params):
    """Call a stored procedure."""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor()
        placeholders = ", ".join(["%s"] * len(params))
        call_query = f"CALL {proc_name}({placeholders})"
        cursor.execute(call_query, params)
        conn.commit()
        conn.close()
        st.success(f"Procedure {proc_name} executed successfully!")
    except Exception as e:
        st.error(f"Error executing procedure: {e}")

# Streamlit UI
st.title("BBB Database Dashboard")

tab0, tab1, tab2, tab3, tab4, tab5 = st.tabs([
    "Welcome", "View Data", "Run Procedures", "Insert Data", "Employees View", "Complex Queries"
])

import os

# Get the absolute path to the image
image_path = os.path.abspath("BBBLogo.png")

# Welcome Tab
with tab0:
    # Add custom CSS for a softer gradient background and enhanced styling
    st.markdown("""
        <style>
        /* Apply softer gradient background to the main content area */
        .stApp {
            background: linear-gradient(135deg, #d9e4f5, #b0c7e4); /* Softer pastel gradient */
            background-size: cover; /* Ensure it covers the whole area */
            font-family: Arial, sans-serif;
        }
        .welcome-container {
            background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent white card */
            border-radius: 15px; /* Rounded corners */
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            max-width: 700px;
            margin: 50px auto; /* Center the container */
            text-align: center;
        }
        .welcome-container img {
            width: 150px; /* Adjust logo size */
            border-radius: 50%;
            margin-bottom: 20px;
        }
        .welcome-container h1 {
            font-size: 32px;
            color: #333333; /* Dark text for readability */
            margin-bottom: 10px;
        }
        .welcome-container p {
            font-size: 18px;
            color: #555555; /* Slightly darker text for contrast */
            margin-bottom: 20px;
        }
        </style>
    """, unsafe_allow_html=True)

    # Create the welcome content
    st.markdown(f"""
        <div class="welcome-container">
            <img src="file://{image_path}" alt="Logo">
            <h1>Welcome to the BBB Restaurant Management Dashboard 🍽️</h1>
            <p>Streamline your restaurant operations with data insights, automated procedures, and more.</p>
        </div>
    """, unsafe_allow_html=True)


# View Data Tab
with tab1:
    st.header("View Data")
    
    # Get all tables from the database
    tables = get_tables()
    table = st.selectbox("Select a Table to View", tables)
    
    if table:
        query = f"SELECT * FROM {table}"
        data = fetch_data(query)
        st.dataframe(data)

        # Add filtering options for specific tables
        filterable_columns = {
            "chef": "chef_name",
            "waiter": "waiter_name",
            "delivery_driver": "driver_name",
            "hr": "hr_name",
            "administration": "adm_name",
            "customer": "cust_name",  # Updated for the customer table
        }

        # Check if the selected table has a filterable column
        if table in filterable_columns:
            column_to_filter = filterable_columns[table]
            if column_to_filter in data.columns:  # Ensure the column exists in the data
                st.subheader(f"Filter {table.capitalize()} Table by Name")
                name_filter = st.text_input(f"Search for {table.capitalize()} by Name")
                if name_filter:
                    # Apply the filter dynamically
                    filtered_data = data[data[column_to_filter].str.contains(name_filter, case=False, na=False)]
                    st.write("Filtered Results")
                    st.dataframe(filtered_data)



# Run Procedures Tab
with tab2:
    st.header("Run Procedures")

    # Dropdown for selecting a procedure
    procedure = st.selectbox(
        "Select a Procedure",
        [
            "ApplyRaiseIndividualChefSalary",
            "ApplyRaiseIndividualWaiterSalary",
            "ApplyRaiseGeneralChefSalary",
            "ApplyRaiseGeneralWaiterSalary",
            "calculate_costs",
        ]
    )
    
    # Show input fields for selected procedure
    if procedure == "ApplyRaiseIndividualChefSalary":
        emp_id = st.text_input("Chef Employee ID")
        raise_value = st.number_input("Raise Value", min_value=0.0, step=0.01)
        if st.button("Execute Procedure"):
            if emp_id.strip() and raise_value > 0:
                call_procedure(procedure, [emp_id, raise_value])
            else:
                st.error("Please provide valid inputs for Employee ID and Raise Value.")
    
    elif procedure == "ApplyRaiseIndividualWaiterSalary":
        emp_id = st.text_input("Waiter Employee ID")
        raise_value = st.number_input("Raise Value", min_value=0.0, step=0.01)
        if st.button("Execute Procedure"):
            if emp_id.strip() and raise_value > 0:
                call_procedure(procedure, [emp_id, raise_value])
            else:
                st.error("Please provide valid inputs for Employee ID and Raise Value.")
    
    elif procedure in ["ApplyRaiseGeneralChefSalary", "ApplyRaiseGeneralWaiterSalary"]:
        raise_value = st.number_input("Raise Value", min_value=0.0, step=0.01)
        if st.button("Execute Procedure"):
            if raise_value > 0:
                call_procedure(procedure, [raise_value])
            else:
                st.error("Please provide a valid Raise Value.")
    
    elif procedure == "calculate_costs":
        if st.button("Execute Procedure"):
            call_procedure(procedure, [])

# Insert Data Tab
with tab3:
    st.header("Insert Data")

    table = st.selectbox("Select Table to Insert Data", get_tables())
    if table:
        columns = get_columns(table)
        values = []
        
        for column in columns:
            if column == "salary" or "cost" in column:  # Example for numeric columns
                value = st.number_input(f"Enter {column.capitalize()}")
            else:
                value = st.text_input(f"Enter {column.capitalize()}")
            values.append(value)
        
        if st.button("Insert Data"):
            if all(values):  # Check if all inputs are filled
                insert_data(table, columns, values)
            else:
                st.error("Please fill all fields.")


# Employees View Tab
with tab4:
    st.header("Employees View")

    # Fetch the employees view data
    query = "SELECT * FROM employees"
    data = fetch_data(query)
    st.dataframe(data)

    # Filtering options
    st.subheader("Filter Employees")
    role_filter = st.selectbox("Filter by Role", ["All", "Chef", "Waiter", "Delivery Driver", "HR Employee", "Administration Employee"])
    name_filter = st.text_input("Search by Name")

    # Apply filters
    if not data.empty:
        filtered_data = data

        # Filter by role if selected
        if role_filter != "All":
            filtered_data = filtered_data[filtered_data['role'] == role_filter]

        # Filter by name if provided
        if name_filter:
            filtered_data = filtered_data[filtered_data['chef_name'].str.contains(name_filter, case=False, na=False)]

        # Display filtered results
        st.write("Filtered Results")
        st.dataframe(filtered_data)

# Complex Queries Tab
with tab5:
    st.header("Complex Queries")

    # Define the queries
    complex_queries = {
        "Top 3 Highest Paid Roles": """
            SELECT chef_role, sal
            FROM (
                SELECT chef_role, SUM(salary) AS sal
                FROM chef
                GROUP BY chef_role
            ) AS subquery
            ORDER BY sal DESC
            LIMIT 3;
        """,
        "Most and Least Ordered Meals": """
            SELECT me.meal_name AS mn, SUM(co.quantity)
            FROM meal me, contain co
            WHERE me.meal_name = co.meal_name
            GROUP BY me.meal_name
            ORDER BY SUM(co.quantity) DESC;
        """,
        "Revenue and Profit for Last 12 Months": """
            SELECT 
                TO_CHAR(co.date, 'YYYY-MM') AS month,
                SUM(me.price * c.quantity) AS total_revenue,
                SUM((me.price - me.cost_meal) * c.quantity) AS total_profit,
                ROUND((SUM((me.price - me.cost_meal) * c.quantity)) / (SUM(me.price * c.quantity)) * 100) AS percentage_profit
            FROM 
                customer_order co
            JOIN 
                contain c ON co.order_id = c.order_id
            JOIN 
                meal me ON c.meal_name = me.meal_name
            WHERE 
                co.date >= NOW() - INTERVAL '12 months'
            GROUP BY 
                TO_CHAR(co.date, 'YYYY-MM')
            ORDER BY 
                month;
        """,
        "Profitability and Salaries by Kitchen Station": """
            WITH station_profit_salary AS (
                SELECT 
                    ks.station_name,
                    SUM((me.price - me.cost_meal) * c.quantity) AS total_profit,
                    SUM(ch.salary) AS total_salaries
                FROM 
                    kitchen_station ks
                JOIN 
                    chef ch ON ks.station_name = ch.works_in
                JOIN 
                    creates cr ON ch.employee_id = cr.chef_id
                JOIN 
                    composed_of co ON cr.menu_id = co.menu_id
                JOIN 
                    contain c ON co.meal_name = c.meal_name
                JOIN 
                    meal me ON c.meal_name = me.meal_name
                GROUP BY 
                    ks.station_name
            )
            SELECT 
                station_name,
                total_profit,
                total_salaries,
                (total_profit - total_salaries) AS net_profit,
                ROUND((total_profit / NULLIF(total_salaries, 0)) * 100, 2) AS profit_to_salary_ratio
            FROM 
                station_profit_salary
            ORDER BY 
                net_profit DESC;
        """,
        "Chef Performance": """
            WITH chef_revenue AS (
                SELECT 
                    ch.employee_id AS chef_id,
                    ch.chef_name,
                    me.meal_name,
                    SUM(c.quantity * me.price) AS total_meal_revenue
                FROM 
                    chef ch
                JOIN 
                    creates cr ON ch.employee_id = cr.chef_id
                JOIN 
                    composed_of co ON cr.menu_id = co.menu_id
                JOIN 
                    contain c ON co.meal_name = c.meal_name
                JOIN 
                    meal me ON c.meal_name = me.meal_name
                GROUP BY 
                    ch.employee_id, ch.chef_name, me.meal_name
            ),
            chef_performance AS (
                SELECT 
                    chef_id,
                    chef_name,
                    SUM(total_meal_revenue) AS total_revenue_generated,
                    COUNT(meal_name) AS total_meals_created,
                    ROUND(AVG(total_meal_revenue), 2) AS avg_meal_revenue
                FROM 
                    chef_revenue
                GROUP BY 
                    chef_id, chef_name
            )
            SELECT 
                chef_id,
                chef_name,
                total_revenue_generated,
                total_meals_created,
                avg_meal_revenue,
                RANK() OVER (ORDER BY total_revenue_generated DESC) AS performance_rank
            FROM 
                chef_performance
            ORDER BY 
                performance_rank;
        """,
        "Top 3 Payment Methods": """
            SELECT payment_type, COUNT(*) AS count
            FROM payment_method
            GROUP BY payment_type
            ORDER BY count DESC
            LIMIT 3;
        """,
        # Add more queries as needed...
    }

    # Dropdown to select a query
    query_name = st.selectbox("Select a Query", list(complex_queries.keys()))

    # Button to execute the query
    if st.button("Execute Query"):
        query = complex_queries[query_name]
        try:
            # Execute the query
            data = fetch_data(query)
            st.write(f"Results for: {query_name}")
            st.dataframe(data)
        except Exception as e:
            st.error(f"Error executing query: {e}")
