
-- Exercici 1
DO $$
DECLARE
  v_dept_id INTEGER := 60;
  emp RECORD;
  CURSOR c_emps(p_dept_id INTEGER) IS
    SELECT employee_id, last_name FROM employees WHERE department_id = p_dept_id;
BEGIN
  OPEN c_emps(v_dept_id);
  LOOP
    FETCH c_emps INTO emp;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE 'ID: %, Cognom: %', emp.employee_id, emp.last_name;
  END LOOP;
  CLOSE c_emps;
END;
$$;

-- Exercici 2 - Funció
CREATE OR REPLACE FUNCTION func_comp_dep(p_dept_id INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (SELECT 1 FROM departments WHERE department_id = p_dept_id);
END;
$$ LANGUAGE plpgsql;

-- Exercici 2 - Bloc
DO $$
DECLARE
  v_dept_id INTEGER := 60;
BEGIN
  IF func_comp_dep(v_dept_id) THEN
    FOR emp IN SELECT employee_id, last_name FROM employees WHERE department_id = v_dept_id LOOP
      RAISE NOTICE 'ID: %, Cognom: %', emp.employee_id, emp.last_name;
    END LOOP;
  ELSE
    RAISE NOTICE 'El departament no existeix!';
  END IF;
END;
$$;

-- Exercici 3
CREATE OR REPLACE FUNCTION func_emps_dep(p_dept_id INTEGER)
RETURNS SETOF employees AS $$
BEGIN
  RETURN QUERY SELECT * FROM employees WHERE department_id = p_dept_id;
END;
$$ LANGUAGE plpgsql;

-- Exercici 4
CREATE TABLE emp_nou_salary AS SELECT * FROM employees;

DO $$
DECLARE
  emp RECORD;
  nou_salari NUMERIC;
  CURSOR curs_emps IS SELECT * FROM emp_nou_salary;
BEGIN
  OPEN curs_emps;
  LOOP
    FETCH curs_emps INTO emp;
    EXIT WHEN NOT FOUND;
    nou_salari := emp.salary * 1.18;
    RAISE NOTICE 'El salari antic de % era % i el nou salari serà: %', emp.last_name, emp.salary, nou_salari;
    UPDATE emp_nou_salary SET salary = nou_salari WHERE employee_id = emp.employee_id;
  END LOOP;
  CLOSE curs_emps;
END;
$$;

-- Exercici 5
DO $$
DECLARE
  v_dept_id INTEGER := 60;
  emp RECORD;
  CURSOR curs_comiss(p_dept_id INTEGER) IS
    SELECT * FROM emp_nou_salary WHERE department_id = p_dept_id;
BEGIN
  OPEN curs_comiss(v_dept_id);
  LOOP
    FETCH curs_comiss INTO emp;
    EXIT WHEN NOT FOUND;
    IF emp.commission_pct IS NULL THEN
      UPDATE emp_nou_salary SET commission_pct = 0 WHERE employee_id = emp.employee_id;
    ELSE
      UPDATE emp_nou_salary SET commission_pct = emp.commission_pct + 0.20 WHERE employee_id = emp.employee_id;
    END IF;
  END LOOP;
  RAISE NOTICE 'El departament % ja no té més empleats.', v_dept_id;
  CLOSE curs_comiss;
EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE 'Error inesperat.';
END;
$$;

-- Exercici 6
CREATE TABLE emp_with_comiss AS SELECT * FROM employees;

DO $$
DECLARE
  emp RECORD;
  CURSOR c_emps IS SELECT * FROM emp_with_comiss;
BEGIN
  OPEN c_emps;
  LOOP
    FETCH c_emps INTO emp;
    EXIT WHEN NOT FOUND;
    IF emp.commission_pct IS NULL THEN
      DELETE FROM emp_with_comiss WHERE employee_id = emp.employee_id;
    END IF;
  END LOOP;
  CLOSE c_emps;
END;
$$;
