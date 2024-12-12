-- 1
select last_name
from employees
where salary > 12000;

-- 2
select last_name, department_id
from employees
where employee_id=176;

-- 3
select last_name, department_id
from employees
where salary not between 5000 and 12000;

-- 4
select first_name,job_id, hire_date
from employees
where hire_date between '1998-02-20' and '1998-05-01';


-- 5
select last_name, department_id
from employees
where department_id = 20 or department_id = 50
order by last_name;


-- 6
select first_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '1998';

-- 7
select first_name, job_id
from employees
where manager_id is null;

-- 8
select last_name,salary,commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

-- 9
select last_name
from employees
where last_name like '__a%';

-- 10
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

-- 11
select last_name, salary
from employees
where job_id = 'AD_ASST' or job_id = 'AC_ACCOUNT'
and salary !=2500 and salary!=3500 and salary !=7000;