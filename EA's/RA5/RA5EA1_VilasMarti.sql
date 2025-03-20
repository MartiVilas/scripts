--EX1 
/*
Exercici 1. Crea un bloc anònim amb tres variables de tipus NUMERIC. Aquestes variables
han de tenir un valor inicial de 15, 40 i 35 respectivament. El bloc ha de sumar aquestes tres variables i
mostrar per pantalla ‘LA SUMA TOTAL ÉS: (la suma de les variables)’.
*/

do $$
    declare
        num1 numeric := 15;
        num2 numeric := 30;
        num3 numeric := 45;
        resultat numeric;
    begin
        resultat = num1+num2+num3;
        raise notice 'LA SUMA TOTAL ÉS: %',resultat;
    end;
$$language plpgsql;

/*
Exercici 2. Crea un bloc anònim que ha d'imprimir el cognom de l'empleat en majúscules amb codi
número 104 de la taula (EMPLOYEES), on has de declarar una variable de tipus last_name.
*/
do $$
    declare
        v_lastName employees.last_name%type;
    begin
        select e.last_name
        into v_lastName
        from employees e
        where e.employee_id = 104;
        raise notice 'El cognom del empleat amb id 104 és: %', v_lastName;
    end;
$$language plpgsql;

/*
Exercici 3. Crea un bloc anònim que ha d'imprimir el cognom en majúscules de l'empleat amb l’id
introduït per pantalla.
*/

do $$
    declare
        v_cognom employees.last_name%type;
        v_id numeric = :empId;
    begin
        select upper(e.last_name)
        into v_cognom
        from employees e
        where e.employee_id = v_id;
        raise notice 'El cognom del empleat amb el id % és: %',v_id,v_cognom;
    end;
$$ language plpgsql;

/*
Exercici 4. Crea un bloc anònim amb variables PL/SQL que mostri el salari de l'empleat amb id=120, has
de declarar una variable de tipus salary.
*/

do $$
    declare
        v_salary employees.salary%type;
        v_id numeric = 104;
    begin
    select e.salary
    into v_salary
    from employees e
    where e.employee_id = v_id;
    raise notice 'El salari del empleat amb id % és: %',v_id,v_salary;
    end;
$$language plpgsql;

/*
Exercici 5. Crea un bloc anònim amb una variable PL/SQL que imprimeixi el salari més alt dels
treballadors que treballen al departament 'SALES'.
*/

do $$
    declare
        v_salary employees.salary%type;
    begin
        select MAX(e.salary)
        into v_salary
        from employees e, departments d
        where e.department_id = d.department_id and d.department_name ilike 'sales';
        raise notice 'El salari maxim del departament Sales és: %',v_salary;
    end;
$$ language plpgsql;
