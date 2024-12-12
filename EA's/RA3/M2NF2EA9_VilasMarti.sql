select * from employees;

/*1. Mostra el nom i cognom de tots els empleats. S'han de mostrar amb la primera lletra en majúscula i la resta en minúscules.*/
select initcap(first_name), initcap(last_name) from employees;

/*2. Mostra els empleats que han sigut contractats durant el mes de maig.*/
select first_name, last_name, hire_date from employees where to_char(hire_date,'MM') = '05';

/*3. Mostra els oficis (job_title) diferents que hi ha a la base de dades.*/
select job_title from jobs group by job_title;

/*4. Calcula quants empleats hi ha en cada departament.*/
select count(employee_id), department_name from employees, departments group by employees.department_id, department_name;

/*5. Calcula quants empleats hi ha de cada tipus d'ocupació (JOB_ID).*/
select count(employee_id), jobs.job_title from employees, jobs group by employees.job_id, jobs.job_title;

/*6. Mostra el número de països que tenen cadascun dels continents que tinguin com identificador de regió 1,2 o 3;*/
select count(countries.country_id) from countries where region_id in (1,2,3);

/*7. Mostra per cada manager el manager_id, el nombre d'emplets que té al seu carrec i la mitja dels salaris d'aquests empleats.*/
select manager_id, count(employee_id), avg(salary) from employees  group by manager_id;

/*8. Mostra l’id del departament i el número d’empleats dels departaments amb més de 4 empleats.*/
select department_id, count(employee_id) from employees group by department_id having count(employee_id)>4;



