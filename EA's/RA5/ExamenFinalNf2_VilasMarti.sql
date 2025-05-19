-- Ex1Ra3 he canviat el count per el sum

create view top_clie as (select c.empresa, sum(p.num_pedido)
        from clientes c join public.pedidos p on c.num_clie = p.clie
        group by c.empresa
        order by 2 desc
    );

-- Ex2 m'he deixat un 0 a la multiplicacio i els parentesis i la cuota al group by, si no no deixa.

select nombre,edad
from repventas r join public.oficinas o on r.num_empl = o.dir
group by nombre, edad, cuota
having (cuota * 0.02) < (select sum(importe) from pedidos);

-- Ex3 He canviat el not exists per in perque comparo amb una clau primaria hi sempre ha de tenir

select *
from productos pr
join pedidos p on pr.id_fab = p.fab and pr.id_producto = p.producto
where pr.id_producto in (select id_producto
                                 from productos pr
                                 join pedidos p on pr.id_fab = p.fab and pr.id_producto = p.producto
                                 group by 1
                                 having count(num_pedido)>1
                                 );


--Ex4 A paper ho he fet en més d'una consulta i no es pot, a ordinador l'he solucionat i he posat els joins tots juntos i he canviat el exists per un in per tal de que funcioni i crei la vista. 

create view ven_servei as (
(select r.nombre,r.edad,pr.descripcion, p.fecha_pedido,sum(p.importe)
from repventas r
join pedidos p on r.num_empl = p.rep
join productos pr on p.fab = pr.id_fab and p.producto = pr.id_producto
where p.num_pedido in (select num_pedido from pedidos)
group by r.nombre,r.edad, r.nombre, pr.descripcion, p.fecha_pedido));

--Ex5 A paper no he posat el group by, l'he pensat pero no l'he posat perque anava ràpid.

select * 
from clientes c 
where c.num_clie = (select clie 
                    from pedidos p 
                    where c.num_clie=p.clie 
                    group by clie 
                    having sum(importe)>40000);


--Ex6 He afegit el group by al ordinador

create view com_per_clie as (
select c.empresa, count(p.num_pedido), sum(p.importe),min(p.importe),max(p.importe),avg(p.importe)
from clientes c join pedidos p on c.num_clie = p.clie
group by c.empresa);