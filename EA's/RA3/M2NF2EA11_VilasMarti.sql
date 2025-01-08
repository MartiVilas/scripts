--Exercici 1
select d.department_id, d.department_name, count(e.employee_id)
from departments d, employees e
group by d.department_id;


--Exercici 2
select d.department_name, count(employee_id)
from departments d, employees e
where e.department_id=d.department_id
group by d.department_name;

--Exercici 3
select count(e.employee_id)
from departments d, employees e
where department_name ilike 'sales';

--Exercici 4
select department_name
from departments d, locations l
where d.location_id = l.location_id and l.city ilike'seattle';

--Exercici 5
select e.manager_id , sum(e.salary)
from employees e
group by e.manager_id
having sum(e.salary) > 50000;

--Exercici 6
select count(e.employee_id), max(e.salary)
from employees e, employees m
where e.employee_id = m.manager_id
having count(m.employee_id)>6;


--Exercici 7
select count(e.employee_id), max(e.salary)
from employees e, employees m
where e.employee_id = m.manager_id
having count(m.employee_id)>6;


--Exercici 8
select count(e.employee_id), max(e.salary)
from employees e, employees m
where e.employee_id = m.manager_id and e.manager_id='100' or e.manager_id='121' or e.manager_id='122'
having count(m.employee_id)>6;