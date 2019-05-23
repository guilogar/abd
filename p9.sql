use videoclub;

-- Ejercicio 1

drop function if exists existe_producto;
delimiter //
create function existe_producto(cadena varchar(100)) returns boolean
begin
    declare num_rows int;
    declare existe   boolean;
    set     num_rows     = (select count(*) from products);
    set     existe       = false;
    
    if(num_rows >= 1) then
        set existe = true;
    end if;
    
    return existe;
end //

delimiter ;

-- Ejercicio 2

drop procedure if exists mostrar_usuarios_rol;
delimiter //
create procedure mostrar_usuarios_rol(in rol_id int)
begin
    select *
    from users u left join users_roles ur on u.id = ur.user_id
    where ur.rol_id = rol_id;
end //

delimiter ;

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------

use abd;

-- Ejercicio 3
drop table if exists usuarios;
create table usuarios(
    dni       varchar(50),
    nomina    double,
    pendiente double,
    invertido double,
    tipo      enum('fijo', 'temporal')
);
    -- --------------------
    -- --------------------
    -- --------------------
drop procedure if exists usuario_prestamo;
delimiter //
create procedure usuario_prestamo(in wdni varchar(50), out res int)
begin
    set res = (
        select count(*)
        from usuarios u
        where u.dni      = wdni      and
              tipo       = 'fijo'    and
              invertido >= pendiente and
              nomina    >= 1200
    );
end //
delimiter ;

-- Ejercicio 4

drop function if exists esApto;
delimiter //
create function esApto(wdni varchar(50)) returns boolean
begin
    declare num_rows int;
    declare apto     boolean;
    call usuario_prestamo(wdni, num_rows);
    set     apto     = false;
    
    if(num_rows >= 1) then
        set apto = true;
    end if;
    
    return apto;
end //

delimiter ;
