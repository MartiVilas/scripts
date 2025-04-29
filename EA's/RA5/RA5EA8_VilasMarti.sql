
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
        var_nou_info info_reactiu_type;
    begin
        select r.nom, r.preu, r.cif_prov, p.telefon
        into var_nou_info.nom_reactiu,var_nou_info.preu_reactiu, var_nou_info.cif_prov,var_nou_info.telefon_prov
        from reactiu r join public.proveidor p on r.cif_prov = p.cif
        where codi_reac = $1;
        return var_nou_info;
    end;
$$language plpgsql;

do $$
    declare
        var_id_react reactiu.codi_reac%type:=: v_id;
        var_func_reactiu info_reactiu_type:= (select func_reactiu_info(var_id_react));
    begin
        raise notice '%',var_func_reactiu;
    end;
$$ language plpgsql;