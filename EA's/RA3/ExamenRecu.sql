-- Ex 1
select productos.id_fab, productos.id_producto, productos.descripcion
from productos
where id_fab ilike 'imm' and precio > 2000;


select p.num_pedido, p.fecha_pedido, p2.id_fab
from pedidos p join public.productos p2 on p2.id_fab = p.fab and p2.id_producto = p.producto
where id_fab ilike 'bic' or id_fab ilike 'fea' or id_fab ilike 'qsa';


select o.oficina, o.ciudad
from oficinas o
where region ilike 'oest' and ventas < 600000 or region ilike 'est' and ventas < 700000;

-- BIEN
SELECT fab AS id_fab, num_pedido
FROM pedidos
WHERE importe = (
    SELECT MAX(p2.importe)
    FROM pedidos p2
    WHERE p2.fab = pedidos.fab
)
AND importe > 30000;

select r.num_empl, round(avg(c.limite_credito), 1)
from repventas r join public.clientes c on r.num_empl = c.rep_clie
group by r.num_empl
order by 2 desc;


select productos.id_fab, count(productos.id_producto)
from productos
group by 1
having count(id_producto) > 6;


select distinct repventas.num_empl, repventas.nombre, repventas.edad
from repventas join public.oficinas o on repventas.num_empl = o.dir
where cuota between 300000 and 400000;


select  c.empresa, c.limite_credito, r.nombre
from clientes c join public.repventas r on r.num_empl = c.rep_clie
where limite_credito >= 50000;


SELECT r.num_empl, r.nombre, r.edad
FROM repventas r
LEFT JOIN clientes c ON r.num_empl = c.rep_clie
WHERE c.rep_clie IS NULL;


select distinct p.id_fab, p.id_producto,p.precio
from productos p
where p.precio = (select max(p2.precio) from productos p2);


-- Examen 2
select c.num_clie, c.empresa, c.limite_credito
from clientes c
join public.repventas r on c.rep_clie = r.num_empl
join public.oficinas o on o.oficina = r.oficina_rep
where c.limite_credito between 40000 and 70000 and region ilike 'nord';

select r.num_empl ,r.nombre
from repventas r
where cuota < 300000 and edad > 45;


select c.empresa, r.nombre
from clientes c join public.repventas r on c.rep_clie = r.num_empl;


select productos.id_producto, productos.precio
from productos
where precio > 2500 and id_fab ilike 'qsa' or id_fab ilike 'imm' or id_fab ilike 'fea';


select o.oficina, o.ciudad
from oficinas o
where (region ilike 'oest' or region ilike 'est') and ventas > 500000;


select p.id_fab, count(p.id_producto)
from productos p
where precio > 2500
group by p.id_fab
having count(id_producto) > 2;


select c.empresa, c.limite_credito, r.nombre, o.ciudad
from clientes c
join public.repventas r on r.num_empl = c.rep_clie
join public.oficinas o on o.oficina = r.oficina_rep;


select p2.id_fab, count(p.num_pedido)
from pedidos p join public.productos p2 on p.fab = p2.id_fab and p.producto = p2.id_producto
group by 1
having count(p.num_pedido) > 5;


SELECT p.id_fab, p.id_producto, p.precio
FROM productos p
WHERE id_fab ILIKE 'qsa'
  AND p.precio = (
    SELECT MAX(p2.precio)
    FROM productos p2
    WHERE p2.id_fab ILIKE 'qsa'
  );


select r.num_empl, count(c.num_clie)
from repventas r join public.clientes c on r.num_empl = c.rep_clie
group by r.num_empl
having count(c.num_clie) > 2;


select r.num_empl, r.nombre
from repventas r left join public.clientes c on r.num_empl = c.rep_clie
where c.num_clie is null;


select c.empresa, c.limite_credito, r.nombre
from clientes c
join public.repventas r on c.rep_clie = r.num_empl
where c.limite_credito > 50000;


select p.id_fab, p.id_producto
from productos p join public.pedidos p2 on p.id_fab = p2.fab and p.id_producto = p2.producto
where p2.importe = (select max(p3.importe) from pedidos p3);