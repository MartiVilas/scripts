-- Exercici 1
select c.country_name
from regions r JOIN countries c on r.region_id = c.region_id
where region_name ilike 'Europe';

--Exercici 2
select d.department_name, d.location_id
from departments d;

--Exercici 3
select  e.employee_id, e.first_name, e.last_name
from employees e
where e.department_id = (select department_id from departments d where d.department_name ilike 'marketing');

--Exercici 4
select min_salary, max_salary, job_title
    from jobs;

--Exercici 5
select l.city, l.street_address, l.state_province
from locations l JOIN public.countries c on c.country_id = l.country_id
where c.country_name ilike 'United States%';

--Exerccici 6
select r.region_name, count(c.country_id)
from regions r Join public.countries c on r.region_id = c.region_id
group by r.region_name;


--Exercici 7
select j.job_title, e.first_name, e.last_name
from jobs j JOIN public.employees e on j.job_id = e.job_id;


--Exercici 8
select d.department_name
from departments d
where location_id = (select location_id from locations where city ilike 'Southlake');

--Exercici 9
select l.street_address
from locations l
where city ilike 'tokyo';

--Exercici 10
select l.country_id, count(l.location_id) as location_count
from locations l
group by l.country_id
order by location_count desc limit 1;

--Exercici 11
select j.job_title, avg(e.salary) as average, MAX(e.salary),min(e.salary)
from employees e JOIN public.jobs j on j.job_id = e.job_id
group by j.job_title
order by average desc;

--Exercici 12
select d.department_name, l.city
from departments d LEFT JOIN public.locations l on l.location_id = d.location_id;



/*DIA 13/02/2025*/


--Ex1 subconuslta relacionada
/*Sense correlacionada*/
select r.*
from repventas r join pedidos p on r.num_empl = p.rep
group by r.num_empl
having sum(importe) < 30000;

select r.*
from repventas r
where 30000 > (select sum(importe) from pedidos where pedidos.rep = r.num_empl);


--Ex2
select c.*
from clientes c
where 20000 > (select sum(importe) from pedidos p where p.clie = c.num_clie );


--Ex3
select r.nombre, count(p.num_pedido), sum(p.importe), min(p.importe), max(p.importe), avg(p.importe)
from repventas r right join pedidos p on r.num_empl = p.rep
group by r.nombre;


select r.nombre,
       (select count(p.num_pedido) from pedidos p where r.num_empl = p.rep),
       (select sum(p.importe) from pedidos p where r.num_empl = p.rep),
       (select min(p.importe) from pedidos p where r.num_empl = p.rep),
       (select max(p.importe) from pedidos p where r.num_empl = p.rep),
       (select avg(p.importe) from pedidos p where r.num_empl = p.rep)
from repventas r;


--Ex4
select c.*
from clientes c
where 10000 > any (select count(p.num_pedido) from pedidos p where p.clie = c.num_clie);


