<<<<<<< HEAD

DO
$$
DECLARE
    curs_empleats CURSOR FOR SELECT empno, ename, sal, COALESCE(comm, 0), hiredate FROM emp;
    reg_empleat curs_empleats%ROWTYPE;
BEGIN
    OPEN curs_empleats;
    LOOP
        FETCH curs_empleats INTO reg_empleat;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Codi: %, Nom: %, Salari: %, Comissió: %, Data: %',
            reg_empleat.empno, reg_empleat.ename, reg_empleat.sal, reg_empleat.coalesce, reg_empleat.hiredate;
    END LOOP;
    CLOSE curs_empleats;
END;
$$;

DO
$$
DECLARE
    reg_empleat RECORD;
BEGIN
    FOR reg_empleat IN
        SELECT empno, ename, sal, COALESCE(comm, 0) AS comm, hiredate FROM emp
    LOOP
        RAISE NOTICE 'Codi: %, Nom: %, Salari: %, Comissió: %, Data: %',
            reg_empleat.empno, reg_empleat.ename, reg_empleat.sal, reg_empleat.comm, reg_empleat.hiredate;
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION func_control_neg(par_salari NUMERIC)
RETURNS BOOLEAN AS
$$
BEGIN
    IF par_salari < 0 THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;
$$ LANGUAGE plpgsql;

DO
$$
DECLARE
    vinput NUMERIC :=: v_Int;
    curs_empleats CURSOR FOR SELECT empno, ename, sal FROM emp WHERE sal > vinput;
    reg_empleat curs_empleats%ROWTYPE;
BEGIN
    IF func_control_neg(vinput) THEN
        OPEN curs_empleats;
        LOOP
            FETCH curs_empleats INTO reg_empleat;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'Codi: %, Nom: %, Salari: %',
                reg_empleat.empno, reg_empleat.ename, reg_empleat.sal;
        END LOOP;
        CLOSE curs_empleats;
    ELSE
        RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu';
    END IF;
END;
$$;
=======
DO
$$
DECLARE
    v_depId numeric :=: v_id;
    var_nom_departament integer;
BEGIN
    BEGIN
        SELECT d.department_name
        INTO strict var_nom_departament
        FROM departments d
        WHERE d.department_id = v_depId;

        RAISE NOTICE 'Nom del departament: %', var_nom_departament;

        IF var_nom_departament ILIKE 'A%' THEN
            RAISE NOTICE 'COMENÇA PER LA LLETRA A';
        ELSE
            RAISE NOTICE 'NO COMENÇA PER LA LLETRA A';
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE NOTICE 'ERROR: no dades';
        WHEN TOO_MANY_ROWS THEN
            RAISE NOTICE 'ERROR: retorna més files';
        WHEN OTHERS THEN
            RAISE NOTICE 'ERROR %, %',SQLSTATE, SQLERRM;
    END;
END;
$$ language plpgsql;




CREATE OR REPLACE FUNCTION func_comprovar_loc(par_loc_id integer)
RETURNS BOOLEAN AS
$$
DECLARE
    var_compte INTEGER;
BEGIN
    SELECT COUNT(*) INTO var_compte
    FROM locations
    WHERE location_id = par_loc_id;

    RETURN var_compte > 0;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE proc_loc_address(par_loc_id integer, par_new_address VARCHAR)
AS $$
BEGIN
    UPDATE locations
    SET street_address = par_new_address
    WHERE location_id = par_loc_id;
END;
$$ language plpgsql;


-- Prova: localització existent (hauria de modificar-se correctament)
DO
$$
DECLARE
    v_loc_id integer := 1000;
    v_new_address VARCHAR := 'Carrer Principal 123';
BEGIN
    BEGIN
        IF func_comprovar_loc(v_loc_id) THEN
            CALL proc_loc_address(v_loc_id, v_new_address);
            RAISE NOTICE 'Adreça actualitzada correctament';
        ELSE
            RAISE NOTICE 'ERROR: la localització no existeix';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'ERROR (sense definir)';
    END;
END;
$$language plpgsql;


-- Prova: localització inexistent (no s'ha de modificar res)
>>>>>>> e8ce4a9dd2509fcae3caf67f0ad037a5bfd2c7b6

DO
$$
DECLARE
<<<<<<< HEAD
    vinput NUMERIC :=: v_Int;
    reg_empleat RECORD;
BEGIN
    IF func_control_neg(vinput) THEN
        FOR reg_empleat IN
            SELECT empno, ename, sal FROM emp WHERE sal > vinput
        LOOP
            RAISE NOTICE 'Codi: %, Nom: %, Salari: %',
                reg_empleat.empno, reg_empleat.ename, reg_empleat.sal;
        END LOOP;
    ELSE
        RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu';
    END IF;
END;
$$;
=======
    v_loc_id integer := 9999;  -- ID que segurament no existeix
    v_new_address VARCHAR := 'Carrer Fals 456';
BEGIN
    BEGIN
        IF func_comprovar_loc(v_loc_id) THEN
            CALL proc_loc_address(v_loc_id, v_new_address);
            RAISE NOTICE 'Adreça actualitzada correctament';
        ELSE
            RAISE NOTICE 'ERROR: la localització no existeix';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'ERROR (sense definir)';
    END;
END;
$$language plpgsql;


-- Prova: error inesperat (pas de NULL)

DO
$$
DECLARE
    v_loc_id integer := NULL;
    v_new_address VARCHAR := 'Carrer Error';
BEGIN
    BEGIN
        IF func_comprovar_loc(v_loc_id) THEN
            CALL proc_loc_address(v_loc_id, v_new_address);
            RAISE NOTICE 'Adreça actualitzada correctament';
        ELSE
            RAISE NOTICE 'ERROR: la localització no existeix';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'ERROR (sense definir)';
    END;
END;
$$ language plpgsql;

>>>>>>> e8ce4a9dd2509fcae3caf67f0ad037a5bfd2c7b6
