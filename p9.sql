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

-- Ejercicio 3
    -- a)
    -- b)
    -- c)
    -- d)
    -- e)
    
    -- --------------------
    -- --------------------
    -- --------------------
    
    -- a)
    -- b)
    -- c)

-- Ejercicio 4
