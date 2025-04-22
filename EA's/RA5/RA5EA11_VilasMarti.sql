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

DO
$$
DECLARE
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

