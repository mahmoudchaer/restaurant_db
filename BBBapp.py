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
st.title("BBB Database Dashboard🍽️")

tab0, tab1, tab2, tab3, tab4, tab5, tab6 = st.tabs([
    "Welcome Page", "View Data", "Run Procedures", "Insert Data", "Employees View", "Available Operations", "Visuals"
])


# Welcome Tab
with tab0:

    # Create the welcome content
    st.markdown(f"""
        <div class="welcome-container">
            <h1>Welcome to the BBB Restaurant Management Dashboard </h1>
            <p>Kindly navigate to your tab of interest.</p>
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

    # Define all complex queries
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
        "Most Expensive 3 Products in Inventory": """
            SELECT i.ingr_name,
                   s.ingredient,
                   s.supp_cost,
                   i.stock_qty,
                   (i.stock_qty * s.supp_cost) AS total_cost
            FROM ingredient i
            JOIN supplies s ON i.inventory_id = s.ingredient
            ORDER BY total_cost DESC 
            LIMIT 3;
        """,
        "Waiters Bringing Most Revenue": """
            SELECT 
                w.waiter_name AS Waiter,
                SUM(m.price * c.quantity) AS Total_Revenue
            FROM 
                waiter w
            JOIN 
                places p ON w.employee_id = p.waiter_id
            JOIN 
                contain c ON p.order_id = c.order_id
            JOIN 
                meal m ON c.meal_name = m.meal_name
            GROUP BY 
                w.waiter_name
            ORDER BY 
                Total_Revenue DESC
            LIMIT 5;
        """,
        "Highest Customer Reviews by Meal": """
            SELECT 
                c.cust_name AS Customer,
                r.rating AS Rating,
                r.description AS Review_Description,
                m.meal_name AS Meal
            FROM 
                review r
            JOIN 
                customer c ON r.customer_id = c.customer_id
            JOIN 
                image_review ir ON r.review_id = ir.review_number
            JOIN 
                image_meal im ON ir.image = im.image
            JOIN 
                meal m ON im.meal_name = m.meal_name
            WHERE 
                r.rating >= 4
            ORDER BY 
                r.rating DESC;
        """,
        "Ingredients Needing Restocking": """
            SELECT 
                ingr_name AS Ingredient,
                stock_qty AS Stock,
                minimum_quantity AS Minimum_Required
            FROM 
                ingredient
            WHERE 
                stock_qty < minimum_quantity
            ORDER BY 
                stock_qty ASC;
        """,
        "Shift Hours of Chefs (Highest to Lowest)": """
            SELECT 
                ch.chef_name AS Chef,
                COUNT(cs.administration_id) AS Total_Shifts,
                SUM(EXTRACT(EPOCH FROM (cs.end_time - cs.start_time))/3600) AS Total_Working_Hours
            FROM 
                chef ch
            JOIN 
                chef_shift cs ON ch.employee_id = cs.chef_id
            GROUP BY 
                ch.chef_name
            ORDER BY 
                Total_Working_Hours DESC;
        """,
        "Most Popular Meal Categories": """
            SELECT 
                m.category AS Meal_Category,
                COUNT(co.order_id) AS Total_Orders
            FROM 
                meal m
            JOIN 
                contain co ON m.meal_name = co.meal_name
            GROUP BY 
                m.category
            ORDER BY 
                Total_Orders DESC;
        """,
        "Total Spending by Customers with Payment Methods": """
            SELECT 
                c.cust_name AS Customer,
                SUM(m.price * co.quantity) AS Total_Spent,
                pm.payment_type AS Payment_Method
            FROM 
                customer c
            JOIN 
                customer_order o ON c.customer_id = o.customer_id
            JOIN 
                contain co ON o.order_id = co.order_id
            JOIN 
                meal m ON co.meal_name = m.meal_name
            JOIN 
                payment_method pm ON c.customer_id = pm.customer_id
            GROUP BY 
                c.cust_name, pm.payment_type
            ORDER BY 
                Total_Spent DESC;
        """,
        "Recursive Query: Chef Supervisors": """
            WITH RECURSIVE Chef_Supervisor (ChefID, SupervisorID) AS (
                SELECT
                    employee_id AS ChefID,
                    supervisor_id AS SupervisorID
                FROM
                    chef
                WHERE
                    supervisor_id IS NOT NULL
                UNION
                SELECT
                    C.employee_id AS ChefID,
                    S.SupervisorID AS SupervisorID
                FROM
                    chef AS C
                JOIN
                    Chef_Supervisor AS S
                ON
                    C.supervisor_id = S.ChefID
            )
            SELECT *
            FROM Chef_Supervisor;
        """,
        "Recursive Query: Waiter Supervisors": """
            WITH RECURSIVE Waiter_Supervisor (WaiterID, SupervisorID) AS (
                SELECT
                    employee_id AS WaiterID,
                    supervisor_id AS SupervisorID
                FROM
                    waiter
                WHERE
                    supervisor_id IS NOT NULL
                UNION
                SELECT
                    W.employee_id AS WaiterID,
                    S.SupervisorID AS SupervisorID
                FROM
                    waiter AS W
                JOIN
                    Waiter_Supervisor AS S
                ON
                    W.supervisor_id = S.WaiterID
            )
            SELECT *
            FROM Waiter_Supervisor;
        """,
    }

    # Dropdown to select a query
    query_name = st.selectbox("Select a Query", list(complex_queries.keys()))

    # Button to execute the selected query
    if st.button("Execute Query"):
        query = complex_queries[query_name]
        try:
            data = fetch_data(query)  # Execute the query
            st.write(f"Results for: {query_name}")
            st.dataframe(data)  # Display the query results
        except Exception as e:
            st.error(f"Error executing query: {e}")

import matplotlib.pyplot as plt
import seaborn as sns

with tab6:  # New tab for visuals
    st.header("Visuals")

    # Dropdown to select a table for plotting
    table_for_plot = st.selectbox("Select a Table for Visualization", get_tables())

    if table_for_plot:
        query = f"SELECT * FROM {table_for_plot}"
        data = fetch_data(query)  # Fetch data from the selected table

        if not data.empty:
            # Show raw data preview
            st.subheader(f"Data Preview from {table_for_plot}")
            st.dataframe(data, height=200)

            # Filter numerical and categorical columns (exclude ID columns)
            numeric_columns = [col for col in data.select_dtypes(include=['number']).columns if 'id' not in col.lower()]
            categorical_columns = [col for col in data.select_dtypes(include=['object']).columns if 'id' not in col.lower()]

            # Example 1: Bar Plot for numerical columns
            st.subheader("Bar Plot")
            if len(numeric_columns) >= 2:
                x_col = st.selectbox("Select X-axis Column", numeric_columns, key="bar_x")
                y_col = st.selectbox("Select Y-axis Column", numeric_columns, key="bar_y")

                if x_col and y_col and x_col != y_col:
                    fig, ax = plt.subplots(figsize=(8, 4))  # Smaller plot size
                    sns.barplot(x=data[x_col], y=data[y_col], ax=ax, palette="viridis")
                    ax.set_title(f"{x_col} vs {y_col}", fontsize=14)
                    ax.set_xlabel(x_col, fontsize=12)
                    ax.set_ylabel(y_col, fontsize=12)
                    ax.tick_params(axis='x', rotation=45)
                    st.pyplot(fig)
                else:
                    st.warning("Please select two different numerical columns.")
            else:
                st.write("Not enough numerical columns for a bar plot.")

            # Example 2: Pie Chart for categorical columns
            st.subheader("Pie Chart")
            if len(categorical_columns) > 0:
                cat_col = st.selectbox("Select Column for Pie Chart", categorical_columns, key="pie_col")
                if cat_col:
                    fig, ax = plt.subplots(figsize=(6, 6))  # Smaller plot size
                    data[cat_col].value_counts().plot.pie(
                        autopct="%1.1f%%", startangle=90, ax=ax, wedgeprops={"edgecolor": "k"}
                    )
                    ax.set_ylabel("")  # Remove y-label for pie chart
                    ax.set_title(f"Distribution of {cat_col}", fontsize=14)
                    st.pyplot(fig)
            else:
                st.write("No categorical columns available for a pie chart.")

            # Example 3: Line Plot for trends
            st.subheader("Line Plot")
            if len(numeric_columns) >= 2:
                x_line_col = st.selectbox("Select X-axis Column for Line Plot", numeric_columns, key="line_x")
                y_line_col = st.selectbox("Select Y-axis Column for Line Plot", numeric_columns, key="line_y")

                if x_line_col and y_line_col and x_line_col != y_line_col:
                    fig
