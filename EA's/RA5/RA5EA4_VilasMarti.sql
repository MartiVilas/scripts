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



/*
Exercici 4 - Realitzar un programa que contingui una funció que retorni quants empleats hi ha a un departament. 
L'id del departament es passarà com a paràmetre de la funció. 
La funció s’anomenarà func_num_emp i es cridarà des d’un bloc anònim  o principal. 
El paràmetre que se li passa a la funció se li preguntarà a l’usuari i per tant, s’ha d’introduir per teclat.
*/


