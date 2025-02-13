--Exercici 1

SELECT department_id, department_name
FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) >= (SELECT AVG(salary) FROM employees)
);


--Exercici 2
SELECT department_name, total_salary
FROM (
    SELECT d.department_name, SUM(e.salary) AS total_salary
    FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_name
    ORDER BY total_salary DESC
    LIMIT 1
) AS department_salary;


--Exercici 3
SELECT e.first_name, e.last_name, e.department_id
FROM employees e
WHERE (e.department_id, e.hire_date) IN (
    SELECT department_id, MIN(hire_date)
    FROM employees
    GROUP BY department_id
);


--Exercici 4

SELECT *
FROM departments d
WHERE d.department_id IN (
    SELECT department_id
    FROM employees
    WHERE termination_date BETWEEN '1992-01-01' AND '2001-12-31'
);
