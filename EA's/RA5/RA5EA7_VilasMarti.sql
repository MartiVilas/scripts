--Ex1 

create or replace function func_num_test() returns integer as $$
    declare
        var_total_test test.codi_test%type;
    begin
    select count(test.codi_test)
    into var_total_test
    from test;
    return var_total_test;
    end;
$$ language plpgsql;



do $$
declare
    var_total_test integer:= (select func_num_test());
begin
    raise notice 'El numero total de test realitzats es de %.',var_total_test;
end;
$$ language plpgsql;

--Exercici 2

create or replace function func_despesa_test(param_data varchar) returns integer as $$
    declare
        var_total_despesa reactiu.preu%type;
    begin
        select sum(reactiu.preu)
        into var_total_despesa
        from reactiu join public.test t on reactiu.codi_reac = t.codi_reac
        where to_char(t.data_resultat, 'yyyy') = $1;

        return var_total_despesa;
    end;
$$ language plpgsql;

do $$
    declare
        var_data varchar :=: vData;
        var_funcio_despesa integer:= (select func_despesa_test(var_data));
    begin
        raise notice 'La despesa en reactius utiitzats any % ha sigut: %',var_data,var_funcio_despesa;
    end;
$$ language plpgsql;