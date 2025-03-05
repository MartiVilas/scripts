/*
Ex1
*/

create type loc_pais_type AS
(
    vr_nom_pais varchar(25),
    vr_num_loc  numeric
);

create or replace function func_loc_pais(par_nom_pais countries.country_name%type) returns loc_pais_type as
$$

declare
    var_loc_pais loc_pais_type;
begin
    select par_nom_pais, count(l.location_id)
    into var_loc_pais.vr_nom_pais, var_loc_pais.vr_num_loc
    from locations l,
         countries c
    where l.country_id = c.country_id
      and country_name ilike par_nom_pais;
    return var_loc_pais;
end;
$$ language plpgsql;

select func_loc_pais('Italy');

create or replace procedure proc_loc_pais(countries.country_name%type) as
$$
declare
    var_loc_pais loc_pais_type := (select public.func_loc_pais($1));
begin
    raise notice ' Els país % té % localitzacions.', var_loc_pais.vr_nom_pais, var_loc_pais.vr_num_loc;
end;
$$ language plpgsql;

call proc_loc_pais('Italy');
