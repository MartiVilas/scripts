--Ex1

create or replace procedure proc_pac(param_dni_metge metge.dni_metge%type) as
$$
declare
curs_persona cursor for (select * from persona);
var_persona record;
var_num_metges integer := (select count(*) from metge where dni_metge = $1);
var_num_visites_metge integer := (select count(*) from visita where visita.dni_metge = $1);
var_mail_pacient varchar := (select mail from persona join metge on persona.dni = metge.dni_metge where metge.dni_metge = $1);
var_cognom_metge varchar := (select persona.cognom1 from persona join metge on persona.dni = metge.dni_metge where persona.dni = $1);
begin

if var_num_metges <= 0 then
    raise exception 'El metge amb dni % no existeix!',$1;
elsif var_num_visites_metge <= 0 then
    raise exception 'El metge amb dni % no ha fet cap visita',$1;
end if;


open curs_persona;
loop
    fetch curs_persona into var_persona;
    exit when not found;
    raise notice '% % % % %',var_persona.dni,var_persona.nom,var_persona.data_naix,var_persona.telefon,var_persona.mail;
end loop;

update persona set mail = concat(var_cognom_metge,var_mail_pacient) where dni = var_persona.dni;

close curs_persona;

exception
    when sqlstate '22001' then
        raise exception 'El mail del pacient es massa llarg, no es pot actualitzar!';
end;
$$ language plpgsql;

call proc_pac(30995635);
call proc_pac(30995999);

insert into persona values (82344561,'Sara','Rius','Clavell','1967-11-15',654811345,'srius@mail.cat');
insert into metge values (82344561,'Dermatoleg');
call proc_pac(82344561);



--Ex2

create table if not exists ingressos_visites (
    total numeric(14, 2)
);

insert into ingressos_visites (total) values (0);

-- Hem quedat al examen que posaria que es una funcio perque no funciona amb procediment, dona un error dient que no esta creada cuant si.
create or replace function func_act_ingressos() returns trigger as $$
declare
    var_total_visites numeric;
begin
    select sum(preu) into var_total_visites from visita;
    update ingressos_visites set total = var_total_visites;
    raise notice 'Els ingressos actuals per les visites son %',var_total_visites;
    return new;
end;
$$ language plpgsql;

create or replace trigger trig_act_ingressos
after insert or update
on visita
for each row
execute function func_act_ingressos();



create or replace function func_comprovar_data(param_data_visita date) returns boolean as $$
    begin
        if  $1 <= current_date then
            return true;
        else return null;
        end if;
    end;
$$ language plpgsql;

create or replace function func_visit_audit() returns trigger as $$

begin
    if func_comprovar_data(NEW.data_visita) then
        -- Si la data que es vol introduir es mes gran que es avui no es pot fer el insert
            if (tg_op = 'INSERT') then
                if NEW.data_visita <= OLD.data_visita then
                return new;
                else return null;
                end if;
        -- Si el preu que te una visita canvia llavor no es pot fer el update
            elsif (tg_op = 'UPDATE') then
                if NEW.preu == OLD.preu then
                return new;
                else raise 'No es pot modificar el preu';
                end if;
            elsif (tg_op = 'DELETE') then
                return null;
            end if;
    end if;
end;
$$ language plpgsql;


create or replace trigger trig_visit_audit
before insert or update or delete
on visita
for each row
execute function func_visit_audit();



INSERT INTO visita VALUES(589995497,38702232,43995635,000028,'https://www.cemedioc.cat/infomes/pdfs/589995497.pdf','2025-05-02',125);

INSERT INTO visita VALUES(677749866,38702232,43995635,24,'https://www.cemedioc.cat/infomes/pdfs/v.pdf','2027-12-12',200);

UPDATE visita SET preu = 500 WHERE codi_visita = 57898998;

DELETE FROM visita WHERE codi_visita = 57898998;