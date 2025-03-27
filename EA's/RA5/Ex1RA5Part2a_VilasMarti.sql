--Exercici 1

create or replace function func_num_venedors(param_id_fab productos.id_fab%type,
                                             param_id_prod productos.id_producto%type) returns integer as
$$
declare
    var_num_venedors integer;
begin
    select count(pe.rep)
    into var_num_venedors
    from productos p
             join pedidos pe
                  on p.id_fab = pe.fab and p.id_producto = pe.producto
                      and pe.fab ilike $1 and pe.producto ilike $2;
    return var_num_venedors;
end;
$$ language plpgsql;


create or replace function func_num_clients(param_id_fab productos.id_fab%type,
                                            param_id_prod productos.id_producto%type) returns integer as
$$
declare
    var_num_clients integer;
begin
select count(c.num_clie)
into var_num_clients
from clientes c join pedidos p
on c.num_clie = p.clie
where p.fab ilike 'rei' and p.producto ilike '2a44l';
return var_num_clients;
end;
$$ language plpgsql;

create or replace function func_mitjana_imports(param_id_fab productos.id_fab%type,
                                            param_id_prod productos.id_producto%type) returns numeric as
$$
declare
    var_cuantitat integer;
    var_import integer;
    var_num_pedidos integer;
    var_mitjana_imports numeric(8,2);
begin
    select count(p.num_pedido)
    into var_num_pedidos
    from pedidos p
    where p.fab ilike $1 and p.producto ilike $2;


    select p.importe
    into var_import
    from pedidos p
    where p.fab ilike $1 and p.producto ilike $2;

    select p.cant
    into var_cuantitat
    from pedidos p
    where p.fab ilike $1 and p.producto ilike $2;
    var_mitjana_imports := ((var_cuantitat*var_import)/var_num_pedidos);
    return var_mitjana_imports;
end;
$$ language plpgsql;


select avg(p.importe)
from pedidos p
where p.fab ilike 'rei' and p.producto ilike '2a45c';

create or replace function func_min_quantitat(param_id_fab productos.id_fab%type,
                                              param_id_prod productos.id_producto%type) returns integer as
$$
declare
    var_quantitat_minima integer;
begin
select min(p.cant)
into var_quantitat_minima
from pedidos p
where p.fab ilike $1 and p.producto ilike $2;
return var_quantitat_minima;
end;
$$ language plpgsql;


create or replace function func_max_quantitat(prarm_id_fab productos.id_fab%type,
                                              param_id_prod productos.id_producto%type) returns integer as
$$
declare
var_quantitat_max integer;
begin
select max(p.cant)
into var_quantitat_max
from pedidos p
where p.fab ilike $1 and p.producto ilike $2;
return var_quantitat_max;
end;
$$ language plpgsql;

create type info_producte_type as (
    vr_num_venedors integer,
    vr_num_clients integer,
    vr_mitja_imports numeric(8,2),
    vr_min_quantitat integer,
    vr_max_quantitat integer);

do $$
    declare
        var_id_fab productos.id_fab%type:=:v_id_fab;
        var_id_producto productos.id_producto%type:=:v_id_producto;
        var_info_producte info_producte_type;
    begin
        var_info_producte.vr_num_venedors:= (select func_num_venedors(var_id_fab,var_id_producto));
        var_info_producte.vr_num_clients:= (select func_num_clients(var_id_fab,var_id_producto));
        var_info_producte.vr_mitja_imports:= (select func_mitjana_imports(var_id_fab,var_id_producto));
        var_info_producte.vr_min_quantitat:= (select func_min_quantitat(var_id_fab,var_id_producto));
        var_info_producte.vr_max_quantitat:= (select func_max_quantitat(var_id_fab,var_id_producto));

        raise notice '%',var_info_producte;
    end;
$$ language plpgsql;


--Exercici2


create or replace procedure proc_baixa_ven(param_id_venedor repventas.num_empl%type) as $$
    declare
        var_quantitat_clients integer;
        var_id_empl repventas.num_empl%type;
    begin
        update repventas set titulo = 'Baixa' where num_empl = $1;
        raise notice 'Empleat donat de baixa';

        select count(c.num_clie)
        into var_quantitat_clients
        from repventas r
        join clientes c on r.num_empl = c.rep_clie
        where r.num_empl = $1;

        select r.num_empl, count(c.num_clie)
        into var_id_empl
        from clientes c join repventas r on c.rep_clie = r.num_empl
        group by 1
        order by 2
        limit 1;

        update clientes set rep_clie = var_id_empl where rep_clie=$1;
    end;
    $$language plpgsql;

select * from clientes;
    do $$
        declare
            var_id_empl repventas.num_empl%type:=:v_Id;
        begin
            call proc_baixa_ven(var_id_empl);
        end;
    $$language plpgsql;



--Exercici3

create or replace procedure proc_test_fets(persona.cognom1%type, test.preu%type) as $$
    declare
        var_num_test integer;
    begin
        select count(t.codi_test)
        into var_num_test
        from test t
        join public.tecnic t2 on t.dni_tecnic = t2.dni_tecnic
        join public.persona p on t2.dni_tecnic = p.dni
        where p.cognom1 ilike $1 and t.preu>$2;

        IF var_num_test <=0 then
            raise notice 'El tecnic % no ha analitzat cap test amb preu superior a %€',$1,$2;
        ELSIF var_num_test > 0 then
            raise notice 'El tecnic % ha realitzat % tests amb preu superior a: %€',$1,var_num_test,$2;
        end if;
    end;
$$language plpgsql;

do $$
    declare
        var_cognom persona.cognom1%type:=:v_Cognom;
        var_preu numeric:=:v_Preu;
    begin
        call proc_test_fets(var_cognom,var_preu);
    end;
$$language plpgsql;