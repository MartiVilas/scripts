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



/* 
Exercici 3: Realitzar un programa que contingui una funció anomenada func_cost_dept que retorni la
suma total dels salaris dels empleats d’un departament en concret. La funció es cridarà des d’un bloc
anònim o principal. El paràmetre que se li passa a la funció és l’id del departament i se li preguntarà a
l’usuari, i per tant, s’ha d’introduir pel teclat.
*/


create or replace function  func_cost_dept(param_id employees.employee_id%type ) returns integer as $$
    declare
    v_total_empleats integer;
    begin

    select sum(e.salary)
    into v_total_empleats
    from employees e
    where e.department_id = $1;
    return v_total_empleats;
    end;
$$ language plpgsql;

do $$
    declare
    vIdDepartament departments.department_id%type :=: vId;
    v_func integer:= (select func_cost_dept(vIdDepartament));
    begin
        raise notice 'El total de empleats en el departament % es de %',vIdDepartament,v_func;
    end;
$$ language plpgsql;



/*
Exercici 4. Realitzar un procediment anomenat proc_mod_com que modifiqui el valor de la comissió
d’un empleat que s’introdueixi l'id per teclat.
Per a modificar aquesta comissió hem de tenir en compte que:
• Si el salari és menor a 3000, la nova comissió és 0.1.
• Si el salari està entre 3000 i 7000, la nova comissió és 0.15.
• Si el salari és més gran que 7000, la nova comissió és 0.2.
S'ha de programar un bloc anònim que cridi el procediment i se li passi com a paràmetre l'id de
l'empleat que l'usuari introdueixi pel teclat.
*/


create or replace procedure proc_mod_com(employees.employee_id%type) as
$$

declare
    v_salary_empleat employees.salary%type;
    v_comissio employees.commission_pct%type;
begin
    select salary
    into v_salary_empleat
    from employees
    where employee_id = $1;

    if v_salary_empleat < 3000 then
        update employees set commission_pct = 0.1 where employee_id = $1;
    elsif v_salary_empleat between 3000 and 7000 then
        update employees set commission_pct = 0.15 where employee_id = $1;
    elsif v_salary_empleat > 7000 then
        update employees set commission_pct = 0.2 where employee_id = $1;
    end if;

    select commission_pct
    into v_comissio
    from employees e
    where employee_id = $1;

    raise notice 'La comisio del empleat amb id % ha canviat a %',$1,v_comissio;
end;

$$ language plpgsql;

do $$
    declare
        v_id_empleat employees.employee_id%type :=: v_id;
    begin
        call proc_mod_com(v_id_empleat);
    end;

$$ language plpgsql;
