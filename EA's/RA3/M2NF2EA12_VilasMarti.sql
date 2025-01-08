-- Exercici 1

select e.first_name, d.department_name, e.manager_id
from employees e join departments d using(department_id);

select e.first_name, d.department_name, e.manager_id
from employees e join departments d on e.department_id = d.department_id;

-- Exercici 2

select l.city, d.department_name
from locations l join departments d using(location_id)
where location_id='1400';

select l.city, d.department_name
from locations l join departments d on l.location_id = d.location_id
where l.location_id='1400';

--Exercici 3

select distinct (e.last_name), m.hire_date
from employees e join employees m on (e.hire_date>m.hire_date) and e.last_name ilike 'davies';
