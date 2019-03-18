-- Ejercicio 1

create or replace view empleados_finance as
select e.*
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join employees e on de.emp_no = e.emp_no
where de.to_date >= curdate() and
      d.dept_name = 'Finance';

select * from empleados_finance;

-- Ejercicio 2

create or replace view mujeres_sales_1992 as
select e.*
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join employees e on de.emp_no = e.emp_no
where extract(year from de.from_date) >= 1992 and
      de.to_date >= curdate() and
      e.gender = 'F' and
      d.dept_name = 'Sales';

select * from mujeres_sales_1992;

-- Ejercicio 3

create or replace view salario_departamento as
select d.dept_no, sum(s.salary) as suma_salario
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join dept_manager dm on d.dept_no = dm.dept_no
                   join employees e on de.emp_no = e.emp_no
                   join salaries s on e.emp_no = s.emp_no
where de.to_date >= curdate() and
      dm.to_date >= curdate() and
      s.to_date >= curdate()
group by d.dept_no;

select * from salario_departamento;

-- Ejercicio 4

create or replace view datos_contratacion_empleado as
select e.first_name, e.last_name, d.dept_name, de.from_date
from departments d join dept_emp de on d.dept_no = de.dept_no
                   join employees e on de.emp_no = e.emp_no;

select * from datos_contratacion_empleado;

-- Ejercicio 5

insert into employees(emp_no, birth_date, first_name, last_name, gender, hire_date)
               values(500000, curdate(), 'No tengo', 'inventiva', 'M', curdate() + interval 1 day),
                     (500001, curdate(), 'No tengo', 'inventiva', 'M', curdate() + interval 1 day),
                     (500002, curdate(), 'No tengo', 'inventiva', 'M', curdate() + interval 1 day),
                     (500003, curdate(), 'No tengo', 'inventiva', 'M', curdate() + interval 1 day),
                     (500004, curdate(), 'No tengo', 'inventiva', 'M', curdate() + interval 1 day);

insert into dept_emp(emp_no, dept_no, from_date, to_date)
              values(500000, 'd001', curdate(), curdate() + interval 1 day),
                    (500001, 'd001', curdate(), curdate() + interval 1 day),
                    (500002, 'd001', curdate(), curdate() + interval 1 day),
                    (500003, 'd001', curdate(), curdate() + interval 1 day),
                    (500004, 'd001', curdate(), curdate() + interval 1 day);

-- Ejercicio 6

delete from dept_emp where emp_no >= 500003;
delete from employees where emp_no >= 500003;

-- Ejercicio 7

create or replace view num_libros_biblioteca as
select b.id, b.nombre, count(b.id)
from bibliotecas b left join libros l on
     b.id = l.biblioteca
group by b.id, b.nombre;

-- Ejercicio 8

create or replace view empleados_mayor_menor_sueldo as
select *
from Empleados
where sueldo = (select max(sueldo) from Empleados) or
      sueldo = (select min(sueldo) from Empleados);
