--Exercici 1
select d.department_id, d.department_name, count(*)
from departments d, employees e
group by d.department_id;

--Exercici 2
select d.department_name, count(e.employee_id)
from departments d, employees e
where e.department_id=d.department_id
group by d.department_name;

--Exercici 3
select d.department_name, count(e.employee_id)
from departments d, employees e
where d.department_id=e.department_id and d.department_name ilike 'sales'
group by department_name;

--Exercici 4
select l.city, count(department_name)
from departments d, locations l
where d.location_id = l.location_id and l.city ilike'seattle'
group by l.city;

--Exercici 5
select e.manager_id , sum(e.salary)
from employees e
group by e.manager_id
having sum(e.salary) > 15000;

--Exercici 6
select count(e.employee_id), max(e.salary)
from employees e, employees m
where e.employee_id = m.manager_id
having count(m.employee_id)>6;


--Exercici 7
select count(*) as "Num Empleats", max(e.salary) as "Salari Maxim"
from employees e, employees m
where e.employee_id = m.manager_id
having count(*)>6;


--Exercici 8
select count(e.employee_id), max(e.salary)
from employees e
where e.manager_id in ('100','121','122')
group by e.manager_id
having count(*)>6
order by manager_id;