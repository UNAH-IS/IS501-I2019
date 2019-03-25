select campo1,campo2,campo3,campo4
 from tbl_tmp
where campo3 = 23
or campo3 = 22;

select campo1,campo2,campo3,campo4
 from tbl_tmp
where campo3 in (23,22);

select campo1,campo2,campo3,campo4
 from tbl_tmp
where campo4 >=0
and campo4<=70;

select campo1,campo2,campo3,campo4
 from tbl_tmp
where campo4 between 0 and 70;

select campo1,campo2,campo3,campo4
 from tbl_tmp
where campo2 like 'Ju%';

select campo1,campo2,campo3,campo4
 from tbl_tmp
where campo2 like '%a%o%';



select campo1,campo2,campo3,campo4
 from tbl_tmp
order by campo2 desc, campo3 desc;

create table tbl_tmp_fechas(
  codigo integer,
  fecha date
);


select codigo,
       fecha,
       to_char(fecha, 'DD/MM/YYYY') fecha_2,
       to_char(fecha, 'DD') as dia,
       to_char(fecha, 'MM') as mes,
       to_char(fecha, 'YYYY') as anio,
       to_char(fecha, 'DD/FMMONTH/YYYY') fecha_3,
       to_char(fecha, 'YEAR')
from tbl_tmp_fechas;


select to_char(to_date('31/12/2019','DD/MM/YYYY'),'DDD')-
       to_char(sysdate,'DDD')
from dual;

select to_char(sysdate,'D')
from dual;

select to_char(to_date('31/12/2019','DD/MM/YYYY'),'DDD')
from dual;

select sysdate
from tbl_tmp_fechas;

select *
from tbl_tmp_fechas;

insert into tbl_tmp_fechas (codigo,fecha)
values (1, to_date('01/08/2019', 'DD/MM/YYYY'));

insert into tbl_tmp_fechas (codigo,fecha)
values (1, to_date('12-01-1990', 'MM-DD-YYYY'));


insert into tbl_tmp_fechas (codigo,fecha)
values (3, to_date('12-01-1990 23:13:44', 'MM-DD-YYYY HH24:MI:SS'));
commit;

select to_char(fecha, 'ddmmyyyyhh24miss')
from tbl_tmp_fechas;


--Ultimo día del mes
select last_day(sysdate)
from dual;

--Primer dia del mes
select trunc(sysdate,'month')
from dual;

--Primer dia del año
select trunc(sysdate,'year')
from dual;

--Elimina la hora
select trunc(sysdate)
from dual;

--Dias de diferencia entre dos fechas
select sysdate - to_date('12/01/2019', 'DD/MM/YYYY')
from dual;


select trunc(sysdate) - to_date('12/01/2019', 'DD/MM/YYYY')
from dual;


insert into tbl_areas (codigo_area, nombre_area)
values (SEQ_CODIGO_AREA.nextval, 'Matematicas');



commit;
select codigo_area, nombre_area, SEQ_CODIGO_AREA.nextval
from tbl_areas;


select SEQ_CODIGO_AREA.currval
from dual;


SELECT CHR(98)
FROM DUAL;

SELECT CONCAT('Buenas ', 'Tardes') as resultado
from dual;

select 'Pollo'||' Crudo'
from dual;


--Human resources
select first_name ||' '|| last_name as nombre_completo,
        salary*0.04 as impuesto
from hr.employees;



select first_name ||' '|| last_name as nombre_completo
from hr.employees
where upper(first_name ||' '|| last_name) like upper('%sT%');


select lpad('5',4, '0')
from dual;

select lpad(employee_id,5,'0')
from hr.employees