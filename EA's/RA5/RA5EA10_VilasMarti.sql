/*
Exercici 1. Realitzar un programa que ens comprovi si un departament existeix o no a la taula corresponent
consultant pel codi del departament. En cas d’existir el departament s’ha d’imprimir per pantalla i s’ha de comprovar
si comença o no per la lletra A. Si comença per la lletra A, després de mostrar el nom del departament, ha de mostrar
també el missatge: COMENÇA PER LA LLETRA A, i si no comença per la lletra A, ha de mostrar el missatge: NO
COMENÇA PER LA LLETRA A.
S’han de programar les següents excepcions:
• Si no hi ha dades, s’ha de retornar: “ERROR: no dades”.
• Si retorna més d’una fila: “ERROR: retorna més files”
• Qualsevol altre error: “ERROR (sense definir)”..
Inclou el JOC DE PROVES que has utilitzat.
*/
-- No hi ha dades
DO
$$
DECLARE
    v_depId numeric :=: 999999;
    var_nom_departament VARCHAR;
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
$$;

-- Too many rows.
DO
$$
DECLARE
    v_depId numeric :=: 50;
    var_nom_departament VARCHAR;
BEGIN
    BEGIN
        SELECT e.department_id
        INTO strict var_nom_departament
        FROM employees e
        WHERE e.department_id = v_depId;

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
$$;


--Others
DO
$$
DECLARE
    v_depId numeric :=: 50;
    var_nom_departament integer;
BEGIN
    BEGIN
        SELECT e.department_id
        INTO strict var_nom_departament
        FROM employees e
        WHERE e.department_id = v_depId;

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
$$;


/*
Exercici 2. Programa un procediment anomenat proc_loc_address per modificar l’adreça d’una localització a
la taula LOCATIONS. El bloc anònim demana a l’usuari el codi de la localització i la nova adreça i passarà aquestes
dades al procediment proc_loc_address. Abans de cridar el procediment s’ha de comprovar si el codi de la
localització existeix amb la funció func_comprovar_loc . Si no existeix es mostra un missatge a l ́usuari, i si
existeix es crida el procediment per modificar l’adreça.
Controla les excepcions corresponents i inclou el JOC DE PROVES que has utilitzat.
*/


/* Funció func_comprovar_loc: retorna TRUE si existeix, FALSE si no */

CREATE OR REPLACE FUNCTION func_comprovar_loc(par_loc_id NUMBER)
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


/* Procediment proc_loc_address: modifica l'adreça d'una localització */

CREATE OR REPLACE PROCEDURE proc_loc_address(par_loc_id NUMBER, par_new_address VARCHAR)
AS
BEGIN
    UPDATE locations
    SET street_address = par_new_address
    WHERE location_id = par_loc_id;
END;
$$ LANGUAGE plpgsql;


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