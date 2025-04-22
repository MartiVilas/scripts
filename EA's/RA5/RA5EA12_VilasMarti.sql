-- Exercici 1 - a) Amb OPEN, FETCH, CLOSE i %TYPE
DO $$
DECLARE
  v_nom_departament departments.department_name%TYPE;
  v_location_id departments.location_id%TYPE;
  v_nom_ciutat locations.city%TYPE;

  c_departaments CURSOR FOR
    SELECT d.department_name, d.location_id, l.city
    FROM departments d
    JOIN locations l ON d.location_id = l.location_id;

BEGIN
  OPEN c_departaments;
  LOOP
    FETCH c_departaments INTO v_nom_departament, v_location_id, v_nom_ciutat;
    EXIT WHEN NOT FOUND;

    RAISE NOTICE 'Departament: %, Location ID: %, Ciutat: %',
      v_nom_departament, v_location_id, v_nom_ciutat;
  END LOOP;
  CLOSE c_departaments;
END;
$$;

-- Exercici 1 - b) Amb FOR ... IN ...
DO $$
BEGIN
  FOR dep IN
    SELECT d.department_name, d.location_id, l.city
    FROM departments d
    JOIN locations l ON d.location_id = l.location_id
  LOOP
    RAISE NOTICE 'Departament: %, Location ID: %, Ciutat: %',
      dep.department_name, dep.location_id, dep.city;
  END LOOP;
END;
$$;

-- Exercici 2 - a) Amb OPEN, FETCH, CLOSE i RECORD
DO $$
DECLARE
  v_empdep RECORD;

  c_emp CURSOR FOR
    SELECT e.employee_id, e.first_name, d.department_id, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;

BEGIN
  OPEN c_emp;
  LOOP
    FETCH c_emp INTO v_empdep;
    EXIT WHEN NOT FOUND;

    RAISE NOTICE 'Empleat: % - %, Departament: % - %',
      v_empdep.employee_id, v_empdep.first_name,
      v_empdep.department_id, v_empdep.department_name;
  END LOOP;
  CLOSE c_emp;
END;
$$;

-- Exercici 2 - b) Amb FOR ... IN ...
DO $$
BEGIN
  FOR emp IN
    SELECT e.employee_id, e.first_name, d.department_id, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
  LOOP
    RAISE NOTICE 'Empleat: % - %, Departament: % - %',
      emp.employee_id, emp.first_name,
      emp.department_id, emp.department_name;
  END LOOP;
END;
$$;