create type test_type1 as(
    codi_test   numeric(20),
    codi_mostra numeric(20),
    DNI_pacient numeric(9));

create or replace function func_test_sel(param_date date) returns setof test_type1 as
$$
declare
    test_row test_type1;
    test_cursor cursor for
    select codi_test, codi_mostra, dni_pacient
    from test
    where data_resultat = param_date;
begin
    open test_cursor;
    loop
        fetch test_cursor into test_row;
        exit when not found;
        return next test_row;
    end loop;
    close test_cursor;
end; $$ language plpgsql;

select func_test_sel('2017-03-22' :: DATE);


create type test_type2 as(
    codi_test numeric(20),
    dni_tecnic numeric(9),
    codi_reactiu numeric(20));

create or replace function func_test_sel(param_decimal decimal(8,2)) returns setof test_type2 as $$
    declare
        test_row test_type2;
        test_cursor cursor for
        select codi_test, dni_tecnic, codi_reac
        from test
        where preu > param_decimal;
    begin
        open test_cursor;
        loop
            fetch test_cursor into test_row;
            exit when not found;
            return next test_row;
        end loop;
        close test_cursor;
    end; $$ language plpgsql;

select func_test_sel(150.00);