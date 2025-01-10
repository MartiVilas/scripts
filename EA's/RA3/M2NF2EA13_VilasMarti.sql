--Exercici 1
select v.nombre, j.nombre as "Cap"
from repventas v left join repventas j on j.director=v.num_empl;

--Exercici 2
select v.num_empl, v.nombre, o.ciudad
from repventas v left join oficinas o on v.oficina_rep = o.oficina;


--Exercici 3
