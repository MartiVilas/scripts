-- 1. Mostrar los nombres de los oficios (job_title) de los empleados que trabajan en el departamento 80.
SELECT DISTINCT job_title
FROM jobs
WHERE job_id IN (
    SELECT job_id FROM employees WHERE department_id = 80
);

-- 2. Mostrar los nombres de departamentos que tengan empleados.
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT DISTINCT department_id FROM employees
);

-- 3. Mostrar los apellidos de los empleados que tienen un salario inferior al salario medio de los empleados que son representantes de ventas (job_id='SA_MAN').
SELECT last_name
FROM employees
WHERE salary < (
    SELECT AVG(salary) FROM employees WHERE job_id = 'SA_MAN'
);

-- 4. Mostrar los nombres de los países que están en el mismo continente que Argentina.
SELECT country_name
FROM countries
WHERE region_id = (
    SELECT region_id FROM countries WHERE country_name = 'Argentina'
);
