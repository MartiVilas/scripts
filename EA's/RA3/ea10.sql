-- Exercici 1

select e.first_name, e.last_name, d.department_name
from employees e, departments d
where d.department_id = e.department_id and department_name ilike 'sales';

--Exercici 2
select e.first_name, e.last_name, d.department_name
from employees e, departments d
where department_name != 'IT' and department_name != 'Purchasing';

--Exercici 3
select city from locations where city like '_u%';

--Exercici 4
select d.*, city from departments d, locations l where postal_code = '98199';

--Exercici 5
select j.job_title, e.* from jobs j, employees e where job_title ilike 'programmer';

-- Exercici 6

