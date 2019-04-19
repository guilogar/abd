-- Ejercicio 1

drop database bb_universitarias;
create database bb_universitarias;

use bb_universitarias;

create table bb_central_uca(
    nombre varchar(500)
);

create table bb_esi_uca(
    id bigint auto increment,
    nombre varchar(500),
    primary key (id)
);

create table libros_esi_uca(
    id bigint auto increment,
    titulo varchar(500),
    autor_principal varchar(500),
    anio_publicacion date,
    asunto varchar(500),
    id_biblioteca bigint default null
);

create user User1 identified by 'User1';
grant select, insert on bb_universitarias.* to User1;

create user User2 identified by 'User2';
grant select, insert on bb_universitarias.libros_esi_uca to User2;
grant select, insert on bb_universitarias.bb_esi_uca to User2;

create user User3 identified by 'User3';
grant select on bb_universitarias.* to User3;

-- Ejercicio 2

create table Empleados(
    id bigint auto_increment,
    nombre varchar(500) not null,
    apellido varchar(500) not null,
    sueldo double not null default 0 check (sueldo >= 0),
    
    constraint pk_Empleados primary key (id)
);
    -- a
create user User4 identified by 'User4';
grant select (id,nombre,apellidos), update (id,nombre,apellidos) on bb_universitarias.Empleados to User4;

    -- b
create user User5 identified by 'User5';
grant select (id,nombre,apellidos), insert (id,nombre,apellidos) on bb_universitarias.Empleados to User5;

    -- c
revoke update on bb_universitarias.Empleados from User4;

    -- d
-- mysql -u User5 -p bb_universitarias
alter table Empleados add column 'Departamentos' varchar(500);

    -- e
-- mysql -u User5 -p bb_universitarias
grant trigger (Departamentos) on bb_universitarias.Empleados to User4;

    -- f
-- mysql -u User4 -p bb_universitarias
alter table Empleados drop column 'Departamentos';

    -- g
select @@autocommit;
set autocommit=0;

    -- h
-- mysql -u User5 -p bb_universitarias
insert into Empleados(id, nombre, apellido, sueldo)
               values(123, 'Maria', 'García', 1200),
                     (456, 'Luis', 'Smith', 900),
                     (654, 'Siul', 'Aicrag', 900),
                     (321, 'Esoj', 'Zepol', 900),
                     (789, 'Jose', 'Lopez', 2800);

    -- i
start transaction;
commit;

    -- j
-- mysql -u User4 -p bb_universitarias
insert into Empleados(id, nombre, apellido, sueldo)
               values(1, 'Maria', 'García', 1200),
                     (4, 'Luis', 'Smith', 900),
                     (6, 'Siul', 'Aicrag', 900),
                     (3, 'Esoj', 'Zepol', 900),
                     (7, 'Jose', 'Lopez', 2800);

    -- k
-- mysql -u User5 -p bb_universitarias
select * from Empleados;

    -- l
-- mysql -u User4 -p bb_universitarias
select * from Empleados;

    -- m
rollback;

    -- n
-- mysql -u User4 -p bb_universitarias
select * from Empleados;

    -- o
-- El motivo es debido al rollback ejecutado.
-- Evidentemente, en el apartado j se insertaron 5 nuevos registros.
-- Los cuales eran visualizados por los distintos usuarios. Pero al hacer un rollback, dichos cambios se revirtieron.
-- Además, anteriormente, se desactivo la opcion de autocommit, por lo que los cambios de insercion nunca fueron efectivos,
-- pudiendo hacer un rollback sin la necesidad de empezar explicitamente una transacción.
