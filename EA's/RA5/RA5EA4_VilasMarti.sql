/*
Exercici 1: Realitzar un programa que contingui una funció que dupliqui la quantitat rebuda com a
paràmetre. La funció rebrà el nom de FUNC_DUPLICAR_QUANTITAT. S’ha de programar un bloc
principal que demani per teclat la quantitat i que cridi a la funció FUNC_DUPLICAR_QUANTITAT
passant el paràmetre corresponent.
*/

create or replace function FUNC_DUPLICAR_QUANTITAT(param_cuantitat integer) returns integer as $$
    declare
        var_quantitat integer:= $1;
        var_total integer;
    begin
        var_total:= var_quantitat*2;
        return var_total;
    end;
$$language plpgsql;


do $$
declare
    var_param_a_pasar integer :=:v_num;
    var_function integer := (select FUNC_DUPLICAR_QUANTITAT(var_param_a_pasar));
begin
    raise notice 'El numero % duplicat dona %',var_param_a_pasar,var_function;
end;
$$language plpgsql;



/*
Exercici 2. Realitzar un programa que contingui una funció que calculi el factorial d’un número que
es passa com a paràmetre. La funció rebrà el nom de FUNC_FACTORIAL. S’ha de programar un
bloc principal que pregunti a l’usuari pel número a calcular i cridi a la funció FUNC_FACTORIAL,
passant el paràmetre corresponent.
*/

CREATE OR REPLACE FUNCTION FUNC_FACTORIAL(para_num_factorial integer) returns integer as
$$
declare
    var_factorial integer:= 1;
begin
    for i in 1..$1 loop
        var_factorial := var_factorial*i;
    end loop;
    return var_factorial;
end;

$$ language plpgsql;

do $$
    declare
        var_param_factorial integer :=: v_param;
        var_factorial integer := (select FUNC_FACTORIAL(var_param_factorial));
    begin
        raise notice 'El factorial de % es %',var_param_factorial,var_factorial;
    end;
$$language plpgsql;


/*
Exercici 3. Realitzar un programa que contingui un procediment anomenat PROC_ALTA_JOB que doni
d’alta un nou ofici (JOB) a la taula jobs. Totes les dades del nou ofici s’han de passat com com a
paràmetre. S’ha de programar un bloc principal que pregunti a l’usuari totes les dades del nou ofici i cridi
el procediment PROC_ALTA_JOB. Abans d’inserir s’ha de comprovar que el valor màxim i mínim del
salari no sigui negatiu i a més, que el salari mínim sigui més petit que el salari màxim. Mostra els
missatges d’error corresponents.
*/

CREATE OR REPLACE FUNCTION FUNC_COMPROBAR_POSITIU (jobs.min_salary%type) returns boolean as $$
    declare
        v_salari jobs.min_salary%type := $1;
    begin
        IF v_salari<0 THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        end if;
    end;
$$ language plpgsql;


CREATE OR REPLACE FUNCTION FUNC_COMPROBAR_MAJOR(jobs.min_salary%type, jobs.max_salary%type) returns boolean as $$
    declare

    begin
        if $1>$2 then
            return false;
        else
            return true;
        end if;
    end;
$$ language plpgsql;


CREATE OR REPLACE PROCEDURE PROC_ALTA_JOB(jobs.job_id%type,jobs.job_title%type,jobs.min_salary%type,jobs.max_salary%type) AS $$
    BEGIN
    IF not func_comprobar_positiu($3) THEN
        raise notice 'ERROR: EL SALARIO MINIMO NO PUEDE SER MENOR A 0';
    ELSIF not func_comprobar_major($3,$4) THEN
        RAISE NOTICE 'ERROR: EL SALARIO MINIMO NO PUEDE SER MAYOR AL SALARIO MAXIMO';
    ELSE
    insert into jobs (job_id, job_title, min_salary, max_salary) values ($1,$2,$3,$4);
    end if;
    end;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        v_id jobs.job_id%type := :v_id;
        v_job_title jobs.job_title%type := :v_title;
        v_min_salary jobs.min_salary%type := :v_min_salary;
        v_max_salary jobs.max_salary%type := :v_max_salary;
    BEGIN
        call PROC_ALTA_JOB(v_id,v_job_title,v_min_salary,v_max_salary);
    end;
$$ LANGUAGE plpgsql;

SELECT * FROM jobs;
