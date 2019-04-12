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
grant select, insert on bb_universitarias.*;

create user User2 identified by 'User2';
grant select, insert on bb_universitarias.libros_esi_uca;
grant select, insert on bb_universitarias.bb_esi_uca;

create user User3 identified by 'User3';
grant select on bb_universitarias.*;
