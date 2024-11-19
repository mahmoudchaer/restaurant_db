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
