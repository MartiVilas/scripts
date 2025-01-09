

--Exercici 1
select e.first_name, d.department_name, e.manager_id
from employees e join departments d using(department_id);

select e.first_name, d.department_name, e.manager_id
from employees e join departments d on e.department_id = d.department_id;

--Exercici 2
select l.city, d.department_name
from locations l join departments d using(location_id)
where location_id='1400';

select l.city, d.department_name
from locations l join departments d on l.location_id = d.location_id
where l.location_id='1400';

--Exercici 3
select e.last_name, e.hire_date
from employees e
join employees m on m.last_name ilike 'davies' and e.hire_date > m.hire_date;

--Exercici 4
select e.first_name,e.last_name, d.department_name, l.city
from employees e join departments d using(department_id) join locations l using(location_id)
order by l.city;

select e.first_name,e.last_name, d.department_name, l.city
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id
order by l.city;

--Exercici 5

select d.department_id, e.last_name
from employees e
join employees m on e.department_id = m.department_id
join departments d on e.department_id = d.department_id
where m.employee_id = '120';

