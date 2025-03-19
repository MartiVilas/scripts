/*
Exercici 1. Programa un tipus de dades TYPE personalitzat anomenat loc_pais_type. Aquest tipus de
dades no deixa fer servir dades del tipus %ROWTYPE ni %TYPE perquè es pot utilitzar en qualsevol
taula. Aquest tipus de dades ha de poder guardar el nom del país i el número de localitzacions.
Programa una funció anomenada func_loc_pais que calculi el número de localitzacions que hi ha al
país que li passes el nom del país com a paràmetre, i retorni el resultat utilitzant una variable TYPE
del tipus de dades creat anteriorment loc_pais_type.
Programa un procediment anomenat proc_loc_pais que cridi la funció func_loc_pais i mostri el
missatge:
'El país (COUNTRY_NAME) té (X) localitzacions'.
Al procediment i la funció se’ls ha de passar com a paràmetre el nom del país.
Programa un bloc anònim que demanarà a l'usuari el nom del país i cridi el procediment
proc_loc_pais.
Prova el procediment escrivint per pantalla 'Italy'..
*/

create type loc_pais_type AS
(   
    vr_nom_pais varchar(25),
    vr_num_loc  numeric
);

create or replace function func_loc_pais(par_nom_pais countries.country_name%type) returns loc_pais_type as
$$

declare
    var_loc_pais loc_pais_type;
begin
    select par_nom_pais, count(l.location_id)
    into var_loc_pais.vr_nom_pais, var_loc_pais.vr_num_loc
    from locations l,
         countries c
    where l.country_id = c.country_id
      and country_name ilike par_nom_pais;
    return var_loc_pais;
end;
$$ language plpgsql;

select func_loc_pais('Italy');

create or replace procedure proc_loc_pais(countries.country_name%type) as
$$
declare
    var_loc_pais loc_pais_type := (select public.func_loc_pais($1));
begin
    raise notice ' Els país % té % localitzacions.', var_loc_pais.vr_nom_pais, var_loc_pais.vr_num_loc;
end;
$$ language plpgsql;

call proc_loc_pais('Italy');

/*
Exercici 2. 
Realitzar un procediment que s’anomeni PROC_EMP_INFO i que es passi com a paràmetre
l’Id d’un empleat i mostri el seu ID, el seu nom, el seu càrrec (job_title) i el seu salari. Has de canviar els
nom de les columnes perquè sigui (codi_empleat, nom_empleat, càrrec, salari). Per realitzar aquest
exercici has de fer servir una variable de tipus %ROWTYPE. S’ha de programar un bloc principal que
pregunti a l’usuari pel ID de l’empleat i cridi al procediment PROC_EMP_INFO, passant el paràmetre
corresponent.
*/


CREATE OR REPLACE PROCEDURE PROC_EMP_INFO( p_employee_id employees.employee_id%TYPE)
AS $$
DECLARE
    var_empleat employees%ROWTYPE;
    var_job_title jobs.job_title%TYPE;
BEGIN
    SELECT e.*
    INTO var_empleat
    FROM employees e
    JOIN jobs j ON j.job_id = e.job_id
    WHERE e.employee_id = p_employee_id;

    SELECT job_title
    INTO var_job_title
    FROM employees e
    JOIN jobs j ON j.job_id = e.job_id
    WHERE e.employee_id = p_employee_id;

    RAISE NOTICE 'ID: %, Nombre: %, Puesto: %, Salario: %', var_empleat.employee_id, var_empleat.first_name, var_job_title, var_empleat.salary;
END;
$$language plpgsql;


do $$
    declare
    var_id employees.employee_id%type:= :idEmpl;
    begin
        call PROC_EMP_INFO(var_id);
    end;
$$language plpgsql;