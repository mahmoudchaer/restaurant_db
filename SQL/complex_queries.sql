--complex queries

--get top 3 highest paid ROLES on average
SELECT chef_role, sal
FROM (
    SELECT chef_role, SUM(salary) AS sal
    FROM chef
    GROUP BY chef_role
) AS subquery
ORDER BY sal DESC
LIMIT 3;

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


