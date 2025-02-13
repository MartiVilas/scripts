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

--Ex5
select p.clie, count(*)
from pedidos p
group by p.clie
having count(p.num_pedido) in (select max(c) from (select count(*) as c from pedidos group by clie) as a);