
-- Exercici 1
create or replace procedure proc_info_pacient(param_dni pacient.dni_pacient%type) as $$
    declare
        var_persona persona%rowtype;
    begin
        select *
        into var_persona
        from persona
        where dni = $1;
        raise notice '%',var_persona;
    end;
$$language plpgsql;

do $$
    declare
    var_dni pacient.dni_pacient%type :=: vDni;
    begin
        call proc_info_pacient(var_dni);
    end;
$$ language plpgsql;


--Exercici 2


create type info_reactiu_type as(
    nom_reactiu varchar(20),
    preu_reactiu numeric(8,2),
    cif_prov varchar(15),
    telefon_prov numeric(9)
);

create or replace function func_reactiu_info(reactiu.codi_reac%type) returns info_reactiu_type as $$
    declare
        
    begin


    end;
$$language plpgsql;

