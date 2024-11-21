--complex queries (12)

--get top 3 highest paid ROLES on average
SELECT chef_role, sal
FROM (
    SELECT chef_role, SUM(salary) AS sal
    FROM chef
    GROUP BY chef_role
) AS subquery
ORDER BY sal DESC
LIMIT 3;

-- ----------------------------------------------------

-- find most and least ordered meals
select me.meal_name mn, sum(co.quantity)
from meal me, contain co
where me.meal_name= co.meal_name
group by me.meal_name
order by sum(co.quantity) desc

-- get revenue and profit for last 12 months from orders
SELECT 
    TO_CHAR(co.date, 'YYYY-MM') AS month,
    SUM(me.price * c.quantity) AS total_revenue,
    SUM((me.price - me.cost_meal) * c.quantity) AS total_profit,
    Round((SUM((me.price - me.cost_meal) * c.quantity)) / (SUM(me.price * c.quantity)) * 100) AS percentage_profit
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

-- profitability and salaries of by kitchen station
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

-- ----------------------------------------------------

--chef by performance from meals cooked
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

-- -------------------------------------------------------------


-- Top 3 payment methods
SELECT payment_type, COUNT(*) AS count
FROM payment_method
GROUP BY payment_type
ORDER BY count DESC
LIMIT 3;

-- -------------------------------------------------------------

--Most expensive 3 products in the inventory
SELECT i.ingr_name,
       s.ingredient,
       s.supp_cost,
       i.stock_qty,
       (i.stock_qty * s.supp_cost) AS total_cost
FROM ingredient i
JOIN supplies s ON i.inventory_id = s.ingredient
ORDER BY total_cost  DESC 
LIMIT 3

-- ------------------------------------------------------------


--Waiters that bring in the most revenue

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

-- -------------------------------------------------------------
 -- Show highest customer reviews alongside the meals they reviewed

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
    r.rating DESC

-- ------------------------------------------------------------

-- Show ingredients that need restocking, i.e. ingredients with stock lower than the minimum 

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


-- ------------------------------------------------------------

-- Return shift hours of chefs from highest to lowest

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


-- ------------------------------------------------------------

-- Return most popular meal categories

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



-- ------------------------------------------------------------

-- Calculate the total amount spent by each customer, including detailed payment methods.

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








