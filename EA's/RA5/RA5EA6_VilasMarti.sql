--Ex1

create or replace procedure proc_alta_pais(param_counrty_id countries.country_id%type, param_counrty_name countries.country_name%type, param_region_name regions.region_name%type ) as $$
    declare
        var_region_id regions.region_id%type;
    begin
        select regions.region_id
        into var_region_id
        from regions
        where region_name ilike $3;

        insert into countries values($1,$2,var_region_id);
    end;
$$language plpgsql;


do $$
    declare
        var_country_id countries.country_id%type :=: v_id;
        var_country_name countries.country_name%type :=: v_name;
        var_region_name regions.region_name%type :=: v_Region;
        var_nou_pais countries%rowtype;
    begin
        call proc_alta_pais(var_country_id,var_country_name,var_region_name);

        select *
        into var_nou_pais
        from countries
        where country_id = var_country_id;
        raise notice '%',var_nou_pais;
    end;

$$ language plpgsql;



--Ex2

create or replace function func_nom_manager(param_dep_id departments.department_id%type) returns employees.first_name%type as $$
declare
    var_nom_manager employees.first_name%type;
begin
    select e.first_name
    into var_nom_manager
    from employees e join departments d on e.department_id = d.department_id
    where e.employee_id = d.manager_id and e.department_id = $1;
    return var_nom_manager;
end;
$$ language plpgsql;

do $$
    declare
        var_department_id departments.department_id%type :=: v_id;
        var_resultat_funcio employees.first_name%type;
    begin
        select func_nom_manager(var_department_id) into var_resultat_funcio;
        raise notice '%',var_resultat_funcio;
    end;
$$ language plpgsql;


-- Ex3

--Ex3

create type dades_empl as (
    var_nom varchar,
    var_cognom varchar,
    var_department_name varchar,
    var_loc_id numeric);

create or replace procedure proc_dades_empl () as $$
declare

begin

end;
    $$ language plpgsql;
