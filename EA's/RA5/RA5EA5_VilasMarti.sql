/*
Exercici 1: Realitzar un procediment anomentar proc_baixa_emp que doni de baixa un empleat, i que tingui com a parametre l'id de l'empleat. 
S'ha de programar un bloc anonim que cridi el procediment i se li passi com a parametre l'id de 'empleat que l'usuari introdueixi pel teclat.
Prova el procediment en una taula que sigui copia de la taula <<employees>>.
*/

CREATE OR REPLACE PROCEDURE proc_baixa_emp(param_id employees_copy.employee_id%type) as
$$
declare
    var_rowtype employees_copy%rowtype;
begin
    select *
    into var_rowtype
    from employees_copy
    where employee_id = $1;

    delete from employees_copy where employee_id = var_rowtype.employee_id;
end;
$$ language plpgsql;

do
$$
    declare
        var_id employees_copy.employee_id%type := : v_id;
    begin
        call proc_baixa_emp(var_id);
        raise notice 'Empleat % eliminat',var_id;
    end;
$$ language plpgsql;


/*
Exercici 2. Realitzar un programa que contingui una funció que retorni quants empleats hi ha a un
departament. L'id del departament es passarà com a paràmetre de la funció. La funció s’anomenarà
func_num_emp i es cridarà des d’un bloc anònim o principal. El paràmetre que se li passa a la
funció se li preguntarà a l’usuari i per tant, s’ha d’introduir pel teclat.
*/


CREATE OR REPLACE FUNCTION func_num_emp(departments.department_id%type) returns integer as $$
    declare
        var_total_treballadors integer;
    begin
        select count(employee_id)
        into var_total_treballadors
        from departments join employees on departments.department_id = employees.department_id
        where departments.department_id = $1;
        return var_total_treballadors;
    end;
$$ language plpgsql;

do $$
    declare
        var_id_dep departments.department_id%type:=:v_id;
        var_total_treballadors integer := (select func_num_emp(var_id_dep));
    begin
        raise notice 'El departament % te % treballadors',var_id_dep,var_total_treballadors;
    end;
$$ language plpgsql;

