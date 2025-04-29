-- Función para comprobar si un departamento existe
CREATE OR REPLACE FUNCTION func_comprovar_dept(dept_id INT) RETURNS BOOLEAN AS $$
DECLARE
    existe BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM departament WHERE id_departament = dept_id) INTO existe;
    RETURN existe;
END;
$$ LANGUAGE plpgsql;

-- Función para comprobar si un manager existe
CREATE OR REPLACE FUNCTION func_comprovar_mng(mng_id INT) RETURNS BOOLEAN AS $$
DECLARE
    existe BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM empleat WHERE id_empleat = mng_id) INTO existe;
    RETURN existe;
END;
$$ LANGUAGE plpgsql;

-- Función para comprobar si una localización existe
CREATE OR REPLACE FUNCTION func_comprovar_loc(loc_id INT) RETURNS BOOLEAN AS $$
DECLARE
    existe BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM localitzacio WHERE id_localitzacio = loc_id) INTO existe;
    RETURN existe;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para insertar un departamento
CREATE OR REPLACE PROCEDURE proc_alta_dept(dept_id INT, dept_nom VARCHAR, mng_id INT, loc_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Comprobar si el departamento ya existe
    IF func_comprovar_dept(dept_id) THEN
        RAISE NOTICE 'El departament ja existeix. No es pot inserir.';
        RETURN;
    END IF;
    
    -- Comprobar si el manager existe
    IF NOT func_comprovar_mng(mng_id) THEN
        RAISE NOTICE 'El mànager no existeix. No es pot inserir el departament.';
        RETURN;
    END IF;
    
    -- Comprobar si la localització existeix
    IF NOT func_comprovar_loc(loc_id) THEN
        RAISE NOTICE 'La localització no existeix. No es pot inserir el departament.';
        RETURN;
    END IF;
    
    -- Insertar el departamento
    INSERT INTO departament (id_departament, nom, id_manager, id_localitzacio)
    VALUES (dept_id, dept_nom, mng_id, loc_id);
    
    RAISE NOTICE 'Departament inserit correctament!';
END;
$$;

-- Bloque anónimo para probar el procedimiento
DO $$
DECLARE
    d_id INT := 1;
    d_nom VARCHAR := 'IT';
    mng_id INT := 100;
    loc_id INT := 10;
BEGIN
    CALL proc_alta_dept(d_id, d_nom, mng_id, loc_id);
END $$;

-- Función para obtener el nombre del empleado
CREATE OR REPLACE FUNCTION func_nom_emp(emp_id INT) RETURNS VARCHAR AS $$
DECLARE
    emp_nom VARCHAR;
BEGIN
    SELECT nom INTO emp_nom FROM empleat WHERE id_empleat = emp_id;
    
    IF emp_nom IS NULL THEN
        RAISE EXCEPTION 'No existeix cap empleat amb aquest codi' USING ERRCODE = 'P0001';
    END IF;
    
    RETURN emp_nom;
END;
$$ LANGUAGE plpgsql;

-- Bloque anónimo para probar la función
DO $$
DECLARE
    e_id INT := 100;
    nom_emp VARCHAR;
BEGIN
    BEGIN
        nom_emp := func_nom_emp(e_id);
        RAISE NOTICE 'El nom de l''empleat és: %', nom_emp;
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Error: %, SQLSTATE: %', SQLERRM, SQLSTATE;
<<<<<<< HEAD
    END;
END $$;
=======
    END;
END $$;
>>>>>>> e8ce4a9dd2509fcae3caf67f0ad037a5bfd2c7b6
