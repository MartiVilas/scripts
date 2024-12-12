select last_name
from employees
where salary > 12000;

select last_name, department_id
from employees
where employee_id=176;

select last_name, department_id
from employees
where salary not between 5000 and 12000;

select first_name,job_id, hire_date
from employees
where hire_date between '1998-02-20' and '1998-05-01';

select last_name, department_id
from employees
where department_id = 20 or department_id = 50
order by last_name;