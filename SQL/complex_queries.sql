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

