select *
from EMPLOYEES;

select *
from DEPARTMENTS;

select 107*27
from dual;


select *
from EMPLOYEES
  inner join  DEPARTMENTS
on (EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID);



select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from EMPLOYEES A
  inner join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID);

--Inner join utilizando producto cartesiano
select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from  EMPLOYEES A,
      DEPARTMENTS B
where A.DEPARTMENT_ID = B.DEPARTMENT_ID;

--Se utiliza en tablas que tienen una relación y que los campos que hacen la relación se llamen igual.
select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from EMPLOYEES A
  natural join  DEPARTMENTS B;


SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES;



--Mostrar tooooodos los empleados, con o sin departamento
select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       nvl(B.DEPARTMENT_NAME,'Sin Departamento') as DEPARTMENT_NAME
from EMPLOYEES A
  left join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID);

--Left join con producto cartesiano
  select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from  EMPLOYEES A,
      DEPARTMENTS B
where A.DEPARTMENT_ID = B.DEPARTMENT_ID(+);



--Mostrar los empleados con departamento y los departamentos que no tienen empleados

select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       b.DEPARTMENT_NAME
from EMPLOYEES A
  right join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID);
--Right join con productos cartesianos

 select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from  EMPLOYEES A,
      DEPARTMENTS B
where A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID;


--Mostrar todos los empleados con o sin departamento y todos los departamentos con o sin empleados
select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       b.DEPARTMENT_NAME
from EMPLOYEES A
  full outer join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID);

--Empleados sin departamento

select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       nvl(B.DEPARTMENT_NAME,'Sin Departamento') as DEPARTMENT_NAME
from EMPLOYEES A
  left join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
where b.DEPARTMENT_ID is null;

--Departamentos sin empleados

select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       b.DEPARTMENT_NAME
from EMPLOYEES A
  right join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
where a.DEPARTMENT_ID is null;

--Empleados sin departamentos y departamentos sin empleados
select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       b.DEPARTMENT_NAME
from EMPLOYEES A
  full outer join  DEPARTMENTS B
on (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
where a.DEPARTMENT_ID is null or
      b.DEPARTMENT_ID is null;


select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from  EMPLOYEES A,
      DEPARTMENTS B
where A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID
union
select A.FIRST_NAME,
       A.LAST_NAME,
       A.SALARY,
       B.DEPARTMENT_NAME
from  EMPLOYEES A,
      DEPARTMENTS B
where A.DEPARTMENT_ID = B.DEPARTMENT_ID(+);




SELECT A.EMPLOYEE_ID,
      A.FIRST_NAME||' '||A.LAST_NAME AS NAME,
      --A.JOB_ID,
      B.JOB_TITLE,
      --A.DEPARTMENT_ID,
      C.DEPARTMENT_NAME,
       C.LOCATION_ID,
       F.CITY,
       F.COUNTRY_ID,
       G.COUNTRY_NAME,
       G.REGION_ID,
       H.REGION_NAME,
      A.MANAGER_ID,
       D.FIRST_NAME||' '||D.LAST_NAME AS MANAGER_NAME,
       D.MANAGER_ID,
       E.EMPLOYEE_ID,
       E.FIRST_NAME||' '||E.LAST_NAME AS MANAGER_OF_MANAGER_NAME

FROM EMPLOYEES A
INNER JOIN JOBS B
ON (A.JOB_ID = B.JOB_ID)
LEFT JOIN DEPARTMENTS C
on A.DEPARTMENT_ID = C.DEPARTMENT_ID
LEFT JOIN EMPLOYEES D
ON (D.EMPLOYEE_ID = A.MANAGER_ID)
LEFT JOIN EMPLOYEES E
ON (D.MANAGER_ID = E.EMPLOYEE_ID)
LEFT JOIN LOCATIONS F
ON (C.LOCATION_ID = F.LOCATION_ID)
LEFT JOIN COUNTRIES G
ON (F.COUNTRY_ID = G.COUNTRY_ID)
LEFT JOIN REGIONS H
ON (G.REGION_ID = H.REGION_ID);

--Mismo resultado con productos cartesianos y el operador(+)
SELECT A.EMPLOYEE_ID,
      A.FIRST_NAME||' '||A.LAST_NAME AS NAME,
      --A.JOB_ID,
      B.JOB_TITLE,
      --A.DEPARTMENT_ID,
      C.DEPARTMENT_NAME,
       C.LOCATION_ID,
       F.CITY,
       F.COUNTRY_ID,
       G.COUNTRY_NAME,
       G.REGION_ID,
       H.REGION_NAME,
      A.MANAGER_ID,
       D.FIRST_NAME||' '||D.LAST_NAME AS MANAGER_NAME,
       D.MANAGER_ID,
       E.EMPLOYEE_ID,
       E.FIRST_NAME||' '||E.LAST_NAME AS MANAGER_OF_MANAGER_NAME
FROM  EMPLOYEES A,
      JOBS B,
      DEPARTMENTS C,
      EMPLOYEES D,
      EMPLOYEES E,
      LOCATIONS F,
      COUNTRIES G,
      REGIONS H
where A.JOB_ID = B.JOB_ID
and   A.DEPARTMENT_ID = C.DEPARTMENT_ID(+)
and   A.MANAGER_ID = D.EMPLOYEE_ID(+)
and   D.MANAGER_ID = E.EMPLOYEE_ID(+)
and   C.LOCATION_ID = F.LOCATION_ID(+)
and   F.COUNTRY_ID = G.COUNTRY_ID(+)
and   G.REGION_ID = H.REGION_ID(+);



SELECT A.FIRST_NAME, B.DEPARTMENT_NAME
FROM EMPLOYEES A
LEFT JOIN DEPARTMENTS B
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID);


SELECT A.FIRST_NAME, B.DEPARTMENT_NAME
FROM EMPLOYEES A,
     DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+);




