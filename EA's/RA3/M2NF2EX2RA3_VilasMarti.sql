/*
Durant tot l'examen hi han funcions com podria ser count() o sum() als where i no funcinen, les he canviat totes al datagrip.
He solucionat casi tots els errors de l'examen a paper al datagrip, menys la última pregunta.
*/



--Ex1 (funciona amb el canvi de solucionar el problema de les funcions al where)
select r.nombre
from repventas r join pedidos p on r.num_empl = p.rep
where (select sum(importe) from pedidos) > 50000;


--Ex2 funciona sense canvis
select o.oficina, o.ciudad, o.dir, o.region
from oficinas o left join repventas r on o.oficina = r.oficina_rep
where region ilike 'Este';


--Ex3 funciona sense canvis
select r.nombre,r.edad,p.clie, p.fecha_pedido, p.producto,p.cant
from repventas r right join pedidos p on r.num_empl = p.rep
where (select count(num_pedido) from pedidos) > 0
order by p.clie;



--Ex4 funciona sense canvis
select * from repventas
where oficina_rep in (select oficina
       from oficinas
       where region ilike 'oeste');



--Ex5 (funciona amb el canvi de les funcions al where)
select *
from clientes c join pedidos p on c.num_clie = p.clie
where (select sum(importe) from pedidos)>40000;


/*
Ex 6

Aquesta a paper esta mal feta directament.
Haig de fer una subconsulta per cada taula que necesito extreure informació.
Quan ho he fet a paper no he he sapigut verue, al dataGrip ho he vist al instant.
*/
select *
from pedidos p
where clie in (select c.num_clie
              from clientes c
              where rep_clie = (select num_empl
                                from repventas
                                where nombre ilike 'Sue%'));



--Ex7
/*
M'ha faltat verue el group by del encunciat on posa PER CADA VENEDOR i tot i aixi se m'ha passat.
El canvi ha sigut posar el group by i solucionar la funcio count() al having possant una subconsulta.
*/
select r.nombre, count(p.num_pedido), sum(p.importe), min(p.importe), max(p.importe), avg(p.importe)
from repventas r join pedidos p on r.num_empl = p.rep
group by r.nombre
having (select count(num_pedido) from pedidos) > 0;



--Ex8
/*
Funciona amb el canvi de les funciones al where. L'he canviat amb una subconsulta per tal de poder obtenir la informació que vull igualment
*/
select empresa from clientes join pedidos p on clientes.num_clie = p.clie
where (select sum(importe) from pedidos) > 15000 and (select count(num_pedido)
                                                      from pedidos
                                                      where (select count(num_pedido)) > 0);



--Ex9
/*
Funciona sense canvis
*/
select r1.nombre, r2.director as "Cap", o.ciudad, o.dir as "Director"
from repventas r1 left join repventas r2 on r1.num_empl=r2.director right join oficinas o on r2.oficina_rep = o.oficina;



--Ex10 
/*
Aquest no el se fer, he intentat enrecordarme de exercicis que vam fer amb el mateix problema pero no recordo
*/
