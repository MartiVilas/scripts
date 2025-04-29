/* Exercici 1: Comprovar que la comissió no sigui més gran que el salari */

CREATE OR REPLACE FUNCTION func_comprovar_comissio()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.commission_pct > NEW.salary THEN
    RAISE EXCEPTION 'La comissió no pot ser superior al salari.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_comissio
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION func_comprovar_comissio();

/* Joc de proves exercici 1 */
/* 
INSERT INTO employees (employee_id, first_name, last_name, salary, commission_pct)
VALUES (300, 'Anna', 'Martí', 4000, 5000); -- Error: comissió > salari

INSERT INTO employees (employee_id, first_name, last_name, salary, commission_pct)
VALUES (301, 'Pau', 'García', 4000, 200); -- Correcte
*/

--------------------------------------------------------------------------------

/* Exercici 2: Comprovar que el nom del departament no sigui NULL */

CREATE OR REPLACE FUNCTION func_comprovar_nom_departament()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.department_name IS NULL THEN
    RAISE EXCEPTION 'El nom del departament no pot ser nul.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_nom_departament_notnull
BEFORE INSERT ON departments
FOR EACH ROW
EXECUTE FUNCTION func_comprovar_nom_departament();

/* Joc de proves exercici 2 */
/* 
INSERT INTO departments (department_id, department_name, location_id)
VALUES (300, NULL, 1700); -- Error: nom null

INSERT INTO departments (department_id, department_name, location_id)
VALUES (301, 'Logística', 1700); -- Correcte
*/

--------------------------------------------------------------------------------

/* Exercici 3: Auditar operacions a la taula EMPLOYEES */

-- Creació de la taula d'auditoria
CREATE TABLE resauditaremp (
  resultat VARCHAR(200)
);

CREATE OR REPLACE FUNCTION func_auditar_employees()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO resauditaremp (resultat)
  VALUES (TG_OP);
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_auditartaulaemp
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH STATEMENT
EXECUTE FUNCTION func_auditar_employees();


/* Joc de proves exercici 3 */
/* 
-- Inserció
INSERT INTO employees (employee_id, first_name, last_name, salary)
VALUES (302, 'Laura', 'Sánchez', 3500);

-- Actualització
UPDATE employees
SET salary = salary + 500
WHERE employee_id = 302;

-- Esborrat
DELETE FROM employees
WHERE employee_id = 302;

-- Consultar auditories
SELECT * FROM resauditaremp;
*/

