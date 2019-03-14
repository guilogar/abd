-- Ejercicio 1
create table actual_departamento_empleados
as
select *
from current_dept_emp;

create table departamentos
as
select *
from departments;

create table departamentos_empleados
as
select *
from dept_emp;

create table departamentos_empleados_ultima_fecha
as
select *
from dept_emp_latest_date;

create table departamentos_coordinador
as
select *
from dept_manager;

create table empleados
as
select *
from employees;

create table salarios
as
select *
from salaries;

create table titulos
as
select *
from titles;

-- Ejercicio 2

create table lectores(
    id bigint auto_increment,
    nombre varchar(500) not null,
    apellidos varchar(500) not null,
    fecha_nacimiento date not null,
    
    constraint pk_lectores primary key (id)
);

create table libros(
    id bigint auto_increment,
    titulo varchar(500) not null,
    fecha_publicacion date not null,
    num_ejemplar bigint not null default 1,
    
    constraint pk_libros primary key (id, num_ejemplar)
);

create table prestamos(
    id_lector bigint,
    constraint fk_prestamos_lectores foreign key (id_lector) references lectores(id),
    
    id_libro bigint,
    constraint fk_prestamos_libros foreign key (id_libro) references libros(id),
    
    constraint pk_prestamos primary key (id_lector, id_libro)
);

-- Ejercicio 3

create table Hablar(
    DNI varchar(500) not null,
    nombre varchar(500) not null,
    idioma varchar(5000) not null,
    nivel_conocimimento int not null default 0,
    
    constraint pk_Hablar primary key (DNI),
    constraint ck_nivel_conocimiento check (nivel_conocimiento between 0 and 10)
);

-- Ejercicio 4

create table bibliotecas(
    id bigint auto_increment,
    nombre varchar(500) not null,
    facultad varchar(500) not null default 'Biblioteca Central',
    
    constraint pk_bibliotecas primary key (id)
);

create table libro(
    id bigint auto_increment,
    titulo varchar(500) not null,
    autor varchar(500) not null,
    fecha_publicacion date not null,
    asunto varchar(500) not null,
    biblioteca bigint,
    
    constraint pk_libro primary key (id),
    constraint fk_libro_biblioteca foreign key (biblioteca) references bibliotecas (id)
);

insert into bibliotecas(nombre, facultad)
                 values('Biblioteca de Ingenieros', 'ESI'),
                       ('Biblioteca de Maestros', 'Educación'),
                       ('Biblioteca de Quimicos', 'Quimica'),
                       ('Biblioteca', 'Biblioteca Cental');

insert into libro(titulo, autor, fecha_publicacion, asunto, biblioteca)
           values('Titulo falso 123', 'Autor falso 123', current_date(), 'Asunto falso 123', 1),
                 ('Titulo falso 123', 'Autor falso 123', current_date(), 'Asunto falso 123', 2),
                 ('Titulo falso 123', 'Autor falso 123', current_date(), 'Asunto falso 123', 3),
                 ('Titulo falso 123', 'Autor falso 123', current_date(), 'Asunto falso 123', 4);

-- Ejercicio 5
    -- a
    create table Empleados(
        id bigint auto_increment,
        nombre varchar(500) not null,
        apellido varchar(500) not null,
        sueldo double not null default 0 check (sueldo >= 0),
        
        constraint pk_Empleados primary key (id)
    );
    
    -- b
    insert into Empleados(id, nombre, apellido, sueldo)
                   values(123, 'Maria', 'García', 1200),
                         (456, 'Luis', 'Smith', 900),
                         (789, 'Jose', 'Lopez', 2800);
    
    -- c
    update Empleados set sueldo = (sueldo + (sueldo * 0.3)) where true;
    
    -- d
    alter table Empleados change apellido apellidos varchar(500);
    
