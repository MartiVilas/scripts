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

select country_name, region_name
from regions r, countries c
where region_name ilike 'europe' or region_name ilike 'asia';

--Exercici 7
select e.first_name, d.department_name, j.end_date
from departments d, job_history j, employees e
where to_char(end_date, 'YYYY')='1993';


--Exercici 8
select e.first_name, e.last_name, d.department_name
from employees e, departments d, locations l
where l.city ilike 'seattle';

--Exercici 9
select d.department_name, l.city, c.country_name
from departments d, locations l, countries c
where l.country_id = c.country_id and d.location_id=l.location_id;


--Exercici 10
select e.last_name, j.job_id
from employees e, employees m, jobs j
where e.employee_id = m.manager_id and e.job_id=m.job_id ;

--Exercici 11
select e.last_name, j.job_id, j.job_title
from employees e, employees m, jobs j
where e.employee_id = m.manager_id and e.job_id=m.job_id ;
