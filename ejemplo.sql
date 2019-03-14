-- drop table if exists cuidades;
-- create table ciudades (
    -- cid_num bigint auto_increment,
    -- cid_nom varchar(500) not null,
    -- num_personas bigint check (num_personas > 0),
    
    -- primary key (cid_num)
-- );

-- drop table if exists actas;
-- create table actas(
    -- act_num bigint auto_increment,
    -- act_asg bigint,
    -- act_dni varchar(9),
    -- act_con varchar(10),
    -- act_nota int check (nota between 0 and 10),
    
    -- constraint pk_actas primary key (act_num, act_dni)
-- );

delimiter |
create trigger preInsercion before insert on ciudades
for each row
if new.num_personas <0 then
    set new.num_personas = 0;
end if;
| delimiter;
