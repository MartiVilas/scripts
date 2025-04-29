
DO
$$
DECLARE
    curs_empleats CURSOR FOR SELECT empno, ename, sal, COALESCE(comm, 0), hiredate FROM emp;
    reg_empleat curs_empleats%ROWTYPE;
BEGIN
    OPEN curs_empleats;
    LOOP
        FETCH curs_empleats INTO reg_empleat;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Codi: %, Nom: %, Salari: %, Comissió: %, Data: %',
            reg_empleat.empno, reg_empleat.ename, reg_empleat.sal, reg_empleat.coalesce, reg_empleat.hiredate;
    END LOOP;
    CLOSE curs_empleats;
END;
$$;

DO
$$
DECLARE
    reg_empleat RECORD;
BEGIN
    FOR reg_empleat IN
        SELECT empno, ename, sal, COALESCE(comm, 0) AS comm, hiredate FROM emp
    LOOP
        RAISE NOTICE 'Codi: %, Nom: %, Salari: %, Comissió: %, Data: %',
            reg_empleat.empno, reg_empleat.ename, reg_empleat.sal, reg_empleat.comm, reg_empleat.hiredate;
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION func_control_neg(par_salari NUMERIC)
RETURNS BOOLEAN AS
$$
BEGIN
    IF par_salari < 0 THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;
$$ LANGUAGE plpgsql;

DO
$$
DECLARE
    vinput NUMERIC :=: v_Int;
    curs_empleats CURSOR FOR SELECT empno, ename, sal FROM emp WHERE sal > vinput;
    reg_empleat curs_empleats%ROWTYPE;
BEGIN
    IF func_control_neg(vinput) THEN
        OPEN curs_empleats;
        LOOP
            FETCH curs_empleats INTO reg_empleat;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'Codi: %, Nom: %, Salari: %',
                reg_empleat.empno, reg_empleat.ename, reg_empleat.sal;
        END LOOP;
        CLOSE curs_empleats;
    ELSE
        RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu';
    END IF;
END;
$$;

DO
$$
DECLARE
    vinput NUMERIC :=: v_Int;
    reg_empleat RECORD;
BEGIN
    IF func_control_neg(vinput) THEN
        FOR reg_empleat IN
            SELECT empno, ename, sal FROM emp WHERE sal > vinput
        LOOP
            RAISE NOTICE 'Codi: %, Nom: %, Salari: %',
                reg_empleat.empno, reg_empleat.ename, reg_empleat.sal;
        END LOOP;
    ELSE
        RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu';
    END IF;
END;
$$;
