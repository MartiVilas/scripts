do
$$
    declare
        var_emp cursor for
            select * from employees;
        var_info_emp employees;
    begin
        open var_emp;
        loop
            fetch var_emp into var_info_emp;
            exit when not found;

            if var_info_emp.commission_pct is null then
                var_info_emp.commission_pct = 0;
            end if;

            raise notice 'Codi: %, Nom: %, Salari: %, Comissio: %, Data de alta: % ',var_info_emp.employee_id,var_info_emp.first_name,var_info_emp.salary,var_info_emp.commission_pct,var_info_emp.hire_date;
        end loop;
        close var_emp;
    end;
$$ language plpgsql;