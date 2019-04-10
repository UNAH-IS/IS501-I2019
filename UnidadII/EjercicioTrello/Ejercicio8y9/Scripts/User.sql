--Crear nuevo usuario(esquema) con el password "PASSWORD" 
CREATE USER TRELLO
  IDENTIFIED BY "oracle"
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP;
--asignar cuota ilimitada al tablespace por defecto  
ALTER USER TRELLO QUOTA UNLIMITED ON USERS;

--Asignar privilegios basicos
GRANT create session TO TRELLO;
GRANT create table TO TRELLO;
GRANT create view TO TRELLO;
GRANT create any trigger TO TRELLO;
GRANT create any procedure TO TRELLO;
GRANT create sequence TO TRELLO;
GRANT create synonym TO TRELLO;
GRANT create materialized view TO TRELLO;