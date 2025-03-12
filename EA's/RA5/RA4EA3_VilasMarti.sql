/*
Exercici 1. Escriu un programa PL/SQL que introduirem per teclat dos números. Els dos números han
de ser positius, en cas contrari s’ha de mostrar a l’usuari el missatge corresponent. S’ha de realitzar la
següent operació amb aquests números: dividir entre ells i sumar-li el segon i mostrar el resultat de
l'operació.
*/

do
$$
    declare
        var_num1     numeric := :v_Num1;
        var_num2     numeric := :v_Num2;
        var_operacio integer;
    begin
        IF var_num1 < 0 or var_num2 < 0 then
            raise notice 'Los numeros no pueden ser menores a 0';
        elsif var_num1 > 0 and var_num2 > 0 then
            var_operacio = (var_num1 / var_num2) + var_num2;
            raise notice 'El resultado de la operacion es: %', var_operacio;
        end if;
    end;
$$ language plpgsql;


/*
Escriu el mateix programa PL/SQL de l’exercici 1, però ara també s’ha de controlar que el
primer número sigui més gran que el segon. En cas contrari s’ha de mostrar el següent missatge:
‘Error! el primer número ha de ser més gran que el segon’.
*/

do
$$
    declare
        var_num1     numeric := :v_Num1;
        var_num2     numeric := :v_Num2;
        var_operacio float;
    begin
        IF var_num1 < 0 or var_num2 < 0 then
            raise notice 'Los numeros no pueden ser menores a 0';
        elsif var_num2>var_num1 then
            raise notice 'El segundo numero no puede ser mayor al primero';
        elsif var_num1 > 0 and var_num2 > 0 then
            var_operacio = (var_num1 / var_num2) + var_num2;
            raise notice 'El resultado de la operacion es: %', var_operacio;
        end if;
    end;
$$ language plpgsql;

/*
Escriu un programa PL/SQL que demani a l’usuari la seva edat i mostri el missatge
corresponent, si:
a) Entre 0 i 17 mostres 'Ets menor de edat!'
b) Entre 18 i 40 mostres 'Ja ets major de edat!'
d) > 40 mostres 'ja ets força gran'
e) Si és negatiu (<0) mostres 'L ́edat no pot ser negativa'.
*/

DO $$
DECLARE
    var_num integer := :v_numero;
BEGIN
    IF var_num < 0 THEN
        RAISE NOTICE 'La edat no pot ser negativa';
    ELSIF var_num BETWEEN 0 AND 17 THEN
        RAISE NOTICE 'Ets menor de edat';
    ELSIF var_num BETWEEN 18 AND 40 THEN
        RAISE NOTICE 'Ja ets major de edat';
    ELSIF var_num > 40 THEN
        RAISE NOTICE 'Ja ets força gran';
    END IF;
END;
$$ LANGUAGE plpgsql;


/*
Escriu un programa PL/SQL que demani quina operació es farà:
opció 1 SUMAR, opció 2 RESTAR, opció 3 MULTIPLICAR, opció 4 DIVIDIR .
Després el programa també demana dos números i ha de realitzar la operació escollida amb els dos
números introduits per teclat. S’ha de mostrar l’operació escollida, els números introduïts i el resultat.
*/

do $$
    declare
        var_opcioUsuari integer =: v_User;
        var_num1 integer =: v_num1;
        var_num2 integer =: v_num2;
        var_resultatOperacio integer := 0;
    begin
        raise notice '1.SUMAR - 2.RESTAR - 3.MULTIPLICAR - 4.DIVIDIR';

        case var_opcioUsuari
        when 1 then
            var_resultatOperacio = var_num1+var_num2;
            raise notice '%',var_resultatOperacio;

        when 2 then
            var_resultatOperacio = var_num1-var_num2;
            raise notice '%',var_resultatOperacio;

        when 3 then
            var_resultatOperacio = var_num1*var_num2;
            raise notice '%',var_resultatOperacio;

        when  4 then
            var_resultatOperacio = var_num1/var_num2;
            raise notice '%',var_resultatOperacio;
        else
            raise notice 'La opcio donada no es valida';
        end case;
    end;
$$language plpgsql;

/*
Escriu un programa PL/SQL que ens mostri els números entre un rang. El rang mínim és 1
i el màxim se li ha de preguntar a l’usuari i no pot ser menor que 2. Si no és 2 o més gran es mostra un
missatge a l'usuari i finalitza el programa. Resol l’exercici utilitzant l’estructura FOR i després
l’estructura WHILE.
*/

--Exercici amb for loop
do $$
    declare
        min numeric := 1;
        max numeric :=: v_max;
    begin
        if max <= 2 then
            raise notice 'El maxim rang ha de ser major a 2';
        end if;
        for i in min..max loop
        raise notice '%',i;
        end loop;
    end;
$$language plpgsql; 

--Exercici amb while

do $$
    declare
        min numeric := 1;
        max numeric :=: v_max;
    begin
        if max <= 2 then
            raise notice 'El maxim rang ha de ser major a 2';
        end if;
        while min <= max loop
        raise notice '%',min;
        min := min + 1;
        end loop;
    end;
$$language plpgsql;

/*
Escriu un programa PL/SQL que mostri els números entre un rang amb un salt. Tant el
rang mínim, com el màxim i el salt se li ha de preguntar a l’usuari. A més, s’ha de tenir en compte
que el rang mínim sempre ha de ser més petit que el rang màxim i que el el salt ha de ser més gran
que 1. En cas contrari s’ha de mostrar el missatge corresponent i acabar el programa.Utilitza
l'estructura de control de flux LOOP.
*/

do
$$
    declare
        min  numeric := : v_min;
        max  numeric := : v_max;
        salt numeric := : v_salt;
    begin
        if min > max then
            raise notice 'El minimo no puede ser mayor al maximo';
        elsif salt <= 1 then
            raise notice 'El salto ha de ser mayor a 1';
        end if;
        loop
            raise notice '%',min;
            if min >= max then
                exit;
            end if;
            min := min + salt;
        end loop;
    end;
$$ language plpgsql;