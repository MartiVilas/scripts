-- 1. Mostrar los nombres y apellidos de todos los empleados con el mismo oficio que David Austin.
SELECT first_name, last_name
FROM employees
WHERE job_id = (
    SELECT job_id FROM employees WHERE first_name = 'David' AND last_name = 'Austin'
);

-- 2. Mostrar los nombres de los países de Asia o Europa.
SELECT country_name
FROM countries
WHERE region_id IN (
    SELECT region_id FROM regions WHERE region_name IN ('Asia', 'Europe')
);

-- 3. Mostrar los apellidos de los empleados cuyo nombre no comienza por 'H' y cuyo salario es mayor que algún empleado del departamento 100.
SELECT last_name
FROM employees
WHERE first_name NOT LIKE 'H%'
AND salary > (
    SELECT MIN(salary) FROM employees WHERE department_id = 100
);

-- 4. Mostrar los apellidos de los empleados que no trabajan en el departamento de Marketing ni en el de Ventas.
SELECT last_name
FROM employees
WHERE department_id NOT IN (
    SELECT department_id FROM departments WHERE department_name IN ('Marketing', 'Sales')
);
