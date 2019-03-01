use employees;

-- Ejercicio 1
show tables;

-- Ejercicio 2
select sum(table_rows)
from information_schema.tables
where table_schema = 'employees';

-- Ejercicio 3
select *
from information_schema.tables
where table_schema = 'employees';

-- Ejercicio 4
select *
from employees
where emp_no in (
                  select *
                  from (
                         select emp_no
                         from salaries
                         where to_date >= now()
                         order by salary asc
                         limit 10
                       )
                  as employees_with_salary_low
                );

-- Ejercicio 5
select *
from employees
where emp_no in (
                  select *
                  from (
                         select emp_no
                         from salaries
                         where to_date >= now()
                         order by salary desc
                         limit 10
                       )
                  as employees_with_salary_low
                );

-- Ejercicio 6
create or replace view numero_empleados_departamento as
select d.dept_no, count(d.dept_no) as num
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join dept_manager dm on d.dept_no = dm.dept_no
                   join employees e on de.emp_no = e.emp_no
where de.to_date >= now() and dm.to_date >= now()
group by d.dept_no;

select *
from departments
where dept_no = (
      select dept_no
      from numero_empleados_departamento
      where num = (
            select max(num)
            from numero_empleados_departamento
      )
);

-- Ejercicio 7
create or replace view numero_mujeres_departamento as
select d.dept_no, count(d.dept_no) num
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join dept_manager dm on d.dept_no = dm.dept_no
                   join employees e on de.emp_no = e.emp_no
where de.to_date >= now() and
      dm.to_date >= now() and
      e.gender = 'F'
group by d.dept_no;

select num
from numero_mujeres_departamento
where dept_no = (
      select dept_no
      from departments
      where dept_name = 'Research'
);

-- Ejercicio 8
create or replace view salario_medio_hombres_departamento as
select d.dept_no, count(d.dept_no) as num,
       sum(s.salary) / count(d.dept_no) as salario_medio
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join dept_manager dm on d.dept_no = dm.dept_no
                   join employees e on de.emp_no = e.emp_no
                   join salaries s on e.emp_no = s.emp_no
where de.to_date >= now() and
      dm.to_date >= now() and
      s.to_date >= now() and
      e.gender = 'M'
group by d.dept_no;

select salario_medio
from salario_medio_hombres_departamento
where dept_no = (
      select dept_no
      from departments
      where dept_name = 'Finance'
);

-- Ejercicio 9
select sum(s.salary) / count(e.emp_no) as
       salario_medio_trabajadores
from employees e join salaries s on e.emp_no = s.emp_no
where year(e.hire_date) >= 1995 and
      year(s.to_date) >= 1995;

-- Ejercicio 10
select count(cambios_departamento) as empleados_estaticos
from (
       select count(emp_no) - 1 as cambios_departamento
       from dept_emp
       group by emp_no
     ) as cambios
where cambios_departamento = 0;

-- Ejercicio 11

-- Esto se puede resolver con un natural join
-- o bien con un producto cartesiano y despues
-- discriminando en la clausula where.

-- Aqui un ejemplo:

-- select * from employees natural join dept_manager;
