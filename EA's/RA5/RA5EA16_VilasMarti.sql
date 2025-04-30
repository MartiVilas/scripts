/*
Ex1

Programar un trigger associat a la taula employees. El trigger s'anomernara trig_restriccions_emp i ha de controlar les seguent situacions.
Quan inserim un nou empleat no pot tenir un salari negatiu.
Quan modifiquem les dades d'un empleat, si es modifica el camp salari, nomes podrà incrementar i nomes si te comissio al camp commission_pct.
Mostra els missatges d'error corresponents quan es dispari el trigger i escriu el joc de proves que has fet per comprovar el trigger.
*/
create or replace function func_commissio() returns trigger as $$
begin
    if new.salary != old.salary or new.salary < old.salary or old.commission_pct IS NOT NULL then
    RAISE EXCEPTION 'ERROR! El salari actualitzat no pot ser menor al salari anterior.';
    end if;
end; $$ language plpgsql;

create or replace trigger trig_restriccions_emp before update
on employees
for each row
execute procedure func_commissio();



/*
Ex2

Programas un trigger associat a la taule employees que faci fallar qualsevol operacio de modificacio del first_name o 
del codi de l'empleat o que suposi una pujada de sou superior al 10%.
El trigger s'anomenara trig_errada_modificacio. 
Mostra els missatges d'error corresponents quan es dispari el trigger i escriu el joc de proves que has fet per provar el trigger.
*/