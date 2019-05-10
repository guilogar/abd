-- Ejercicio 1

use employees;

-- Se necesita refrescar esta tabla periodicamente para que no contenga
-- datos de sueldos antiguos. Pero como se prevee escritura
-- concurrente en la base de datos, se crea una transaccion para evitar
-- entrelazado patologico en la base de datos;

begin;
    delete from salaries
    where to_date <= curdate();
commit;


-- Ejercicio 2

use employees;

set @sueldo = 0;

-- Primer trigger
-- --------------
-- En este trigger, se elimina todos los sueldos antiguos.

drop trigger if exists eliminar_sueldo_antiguo;
create trigger eliminar_sueldo_antiguo before insert on salaries
for each row
    delete from salaries
    where to_date <= curdate();

-- Segundo trigger
-- ---------------
-- En este segundo trigger, se actualiza la variable sueldo
-- despues de cuando se haya hecho una insercion

drop trigger if exists sueldo_total;
create trigger sueldo_total after insert on salaries
for each row set @sueldo = @sueldo + NEW.salary;

-- begin;
    -- insert into salaries (emp_no, salary, from_date, to_date)
            -- values   (10001, 50000, curdate(), date_add(curdate(), interval 1 year));
    -- select @sueldo as 'Dinero total que se gasta la empresa en sueldos actualmente.';
-- commit;
