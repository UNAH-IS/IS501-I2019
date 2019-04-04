/*1. Mostrar el listado de los estudiantes con la siguiente información (Para los cruces utilizar productos
cartesianos y el operador (+)):
a. Nombre completo con cada inicial en mayúscula.
b. Campus actual.
c. Lugar de nacimiento.
d. Lugar de residencia.
e. Cantidad de carreras que tiene matriculadas.
f. Porcentaje de asignaturas aprobadas (Total de asignaturas aprobadas/Total de asignaturas de
todas sus carreras).
g. Promedio de todas las carreras matriculadas (Utilizar campo PROMEDIO_CARRERA).
*/
WITH CARRERAS AS (
  SELECT CODIGO_ALUMNO, COUNT(*) AS CANTIDAD_CARRERAS
  FROM TBL_CARRERAS_X_ALUMNOS
  GROUP BY CODIGO_ALUMNO
)
SELECT A.CODIGO_ALUMNO,
       INITCAP(B.NOMBRE || ' ' || B.APELLIDO) AS NOMBRE_ALUMNO,
       C.NOMBRE_CAMPUS,
       D.NOMBRE_LUGAR                         AS NOMBRE_LUGAR_NACIMIENTO,
       E.NOMBRE_LUGAR                         AS NOMBRE_LUGAR_RECIDENCIA,
       NVL(F.CANTIDAD_CARRERAS, 0)            AS CANTIDAD_CARRERAS
FROM TBL_ALUMNOS A,
     TBL_PERSONAS B,
     TBL_CAMPUS C,
     TBL_LUGARES D,
     TBL_LUGARES E,
     CARRERAS F
WHERE A.CODIGO_ALUMNO = B.CODIGO_PERSONA
  AND B.CODIGO_CAMPUS = C.CODIGO_CAMPUS
  AND B.CODIGO_LUGAR_NACIMIENTO = D.CODIGO_LUGAR
  AND B.CODIGO_LUGAR_RESIDENCIA = E.CODIGO_LUGAR
  AND A.CODIGO_ALUMNO = F.CODIGO_ALUMNO(+);
;
/*
2. Mostrar los alumnos con excelencia académica (Cum Laude >= 80) para cada carrera, puede darse el caso
de que un estudiante tenga más de una carrera y en ambas sea excelencia académica. Para este ejercicio
NO utilizar el campo PROMEDIO_CARRERA de la tabla TBL_CARRERA_X_ALUMNOS, en su lugar hacer
el cálculo del historial académico. Información a mostrar:
a. Nombre completo con cada inicial en mayúscula.
b. Número de cuenta.
c. Carrera
d. Promedio para dicha carrera: Sumatoria de las UV * Promedio por asignatura/Sumatoria del total
de UV por carrera.
Ejemplo del cálculo del promedio:
Clase UV Promedio UV x Promedio
BDI 5 60 300
Sociologia 4 100 400
Sumatoria: 9 - 700
Promedio ponderado:
700/9 =
77.77777778*/
WITH PROMEDIOS_X_CARRERA AS (
  SELECT A.CODIGO_ALUMNO,
         C.CODIGO_CARRERA,
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS)              as UV,
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS * A.PROMEDIO) AS UV_X_PROMEDIO,
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS * A.PROMEDIO) /
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS)  AS PROMEDIO_PONDERADO
  FROM TBL_HISTORIAL A
         INNER JOIN TBL_SECCION B
                    ON (A.CODIGO_SECCION = B.CODIGO_SECCION)
         INNER JOIN TBL_ASIGNATURAS C
                    ON (B.CODIGO_ASIGNATURA = C.CODIGO_ASIGNATURA)
  GROUP BY A.CODIGO_ALUMNO,
           C.CODIGO_CARRERA
)
SELECT A.*, B.NUMERO_CUENTA,
       INITCAP(C.NOMBRE||' '||C.APELLIDO) AS NOMBRE_COMPLETO,
       D.NOMBRE_CARRERA
FROM PROMEDIOS_X_CARRERA A
INNER JOIN TBL_ALUMNOS B
ON (A.CODIGO_ALUMNO = B.CODIGO_ALUMNO)
INNER JOIN TBL_PERSONAS C
ON (B.CODIGO_ALUMNO = C.CODIGO_PERSONA)
INNER JOIN TBL_CARRERAS D
ON (A.CODIGO_CARRERA = D.CODIGO_CARRERA)
--WHERE PROMEDIO_PONDERADO >=80
ORDER BY A.CODIGO_ALUMNO, A.CODIGO_CARRERA;

select (280+360)/(4+4) as promedio_a1_c1 from dual; --80
select (325+260)/(5+4) as promedio_a1_c3 from dual --65

  /*
3. Basado en el promedio calculado del inciso anterior, mostrar el estudiante con mayor promedio(ñoñ@) y el
estudiante con menor promedio.
*/
--CREAR VISTA DEL INCISO ANTERIOR PARA NO COMPLICAR LA SOLUCION
 CREATE OR REPLACE VIEW VW_PROMEDIOS_X_CARRERA AS
 WITH PROMEDIOS_X_CARRERA AS (
  SELECT A.CODIGO_ALUMNO,
         C.CODIGO_CARRERA,
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS)              as UV,
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS * A.PROMEDIO) AS UV_X_PROMEDIO,
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS * A.PROMEDIO) /
         SUM(C.CANTIDAD_UNIDADES_VALORATIVAS)  AS PROMEDIO_PONDERADO
  FROM TBL_HISTORIAL A
         INNER JOIN TBL_SECCION B
                    ON (A.CODIGO_SECCION = B.CODIGO_SECCION)
         INNER JOIN TBL_ASIGNATURAS C
                    ON (B.CODIGO_ASIGNATURA = C.CODIGO_ASIGNATURA)
  GROUP BY A.CODIGO_ALUMNO,
           C.CODIGO_CARRERA
)
SELECT A.*, B.NUMERO_CUENTA,
       INITCAP(C.NOMBRE||' '||C.APELLIDO) AS NOMBRE_COMPLETO,
       D.NOMBRE_CARRERA
FROM PROMEDIOS_X_CARRERA A
INNER JOIN TBL_ALUMNOS B
ON (A.CODIGO_ALUMNO = B.CODIGO_ALUMNO)
INNER JOIN TBL_PERSONAS C
ON (B.CODIGO_ALUMNO = C.CODIGO_PERSONA)
INNER JOIN TBL_CARRERAS D
ON (A.CODIGO_CARRERA = D.CODIGO_CARRERA)
ORDER BY A.CODIGO_ALUMNO, A.CODIGO_CARRERA;

--ESTUDIANTES CON EL MEJOR PROMEDIO
SELECT *
FROM VW_PROMEDIOS_X_CARRERA
WHERE PROMEDIO_PONDERADO = (
  SELECT MAX(PROMEDIO_PONDERADO)
  FROM VW_PROMEDIOS_X_CARRERA
);


--ESTUDIANTES CON EL PEOR PROMEDIO
SELECT *
FROM VW_PROMEDIOS_X_CARRERA
WHERE PROMEDIO_PONDERADO = (
  SELECT MIN(PROMEDIO_PONDERADO)
  FROM VW_PROMEDIOS_X_CARRERA
);

  /*
4. Mostrar el listado de todas las secciones con la siguiente información:
a. Código Alterno
b. Hora Inicio (Formato de 24h).
c. Hora Fin (Formato de 24h).
d. Nombre completo del maestro.
e. Fecha inicio del periodo (Formato Dia -NOMBRE MES - Año)
f. Fecha fin del periodo (Formato Dia -NOMBRE MES - Año)
g. Cantidad de alumnos matriculados.
h. Cantidad de alumnos en lista de espera.
i. Cantidad de cupos libres.
*/
SELECT A.CODIGO_SECCION, A.CODIGO_ALTERNO,
      D.NOMBRE|| ' '|| D.APELLIDO AS NOMBRE_MAESTRO,
      TO_CHAR(A.HORA_INICIO,'HH24:MI:SS') AS HORA_INICIO,
      TO_CHAR(A.HORA_FIN,'HH24:MI:SS') AS HORA_FIN,
      TO_CHAR(B.FECHA_INICIO,'DD-FMMONTH-YYYY') FECHA_INICIO,
      TO_CHAR(B.FECHA_FIN,'DD-FMMONTH-YYYY') FECHA_FIN,
       NVL(C.ALUMNOS_MATRICULADOS,0) ALUMNOS_MATRICULADOS,
       NVL(E.ALUMNOS_LISTA_ESPERA,0) ALUMNOS_LISTA_ESPERA,
       A.CANTIDAD_CUPOS,
       A.CANTIDAD_CUPOS - NVL(C.ALUMNOS_MATRICULADOS,0) AS CANTIDAD_CUPOS_LIBRES
FROM TBL_SECCION A
INNER JOIN TBL_PERIODOS B
ON (A.CODIGO_PERIODO = B.CODIGO_PERIODO)
LEFT JOIN (
  SELECT CODIGO_SECCION, COUNT(*) AS ALUMNOS_MATRICULADOS
  FROM TBL_MATRICULA
  WHERE CODIGO_ESTADO_MATRICULA = 1
  GROUP BY CODIGO_SECCION
)  C
ON (A.CODIGO_SECCION = C.CODIGO_SECCION)
INNER JOIN TBL_PERSONAS D
ON (A.CODIGO_MAESTRO = D.CODIGO_PERSONA)
LEFT JOIN (
  SELECT CODIGO_SECCION, COUNT(*) AS ALUMNOS_LISTA_ESPERA
  FROM TBL_MATRICULA
  WHERE CODIGO_ESTADO_MATRICULA = 2
  GROUP BY CODIGO_SECCION
)  E
ON (A.CODIGO_SECCION = E.CODIGO_SECCION);

SELECT *
FROM TBL_ESTADOS_MATRICULA;



/*PRUEBAS INDEPENDIENTES, NO ES PARTE DEL EJERCICIO*/
CREATE TABLE TMP(
  FECHA DATE
);
INSERT INTO TMP(FECHA) VALUES (TO_DATE('25/12/2019 10:30:23', 'dd/mm/yyyy hh:mi:ss'));
SELECT *
FROM TMP
WHERE TRUNC(FECHA) = TO_DATE('25/12/2019', 'DD/MM/YYYY');
/*

5. Identificar al maestro con mayor salario y al maestro con menor salario. Mostrar su nombre completo y el
salario.*/

SELECT A.NOMBRE||' '||A.APELLIDO AS NOMBRE,
       b.SUELDO_BASE
FROM TBL_PERSONAS A
INNER JOIN TBL_EMPLEADOS B
ON (A.CODIGO_PERSONA = B.CODIGO_EMPLEADO)
INNER JOIN TBL_MAESTROS C
ON (A.CODIGO_PERSONA = C.CODIGO_MAESTRO)
WHERE B.SUELDO_BASE = (
  SELECT MAX(SUELDO_BASE)
  FROM TBL_EMPLEADOS A
  INNER JOIN TBL_MAESTROS B
  ON (A.CODIGO_EMPLEADO = B.CODIGO_MAESTRO)
);


SELECT A.NOMBRE||' '||A.APELLIDO AS NOMBRE,
       b.SUELDO_BASE
FROM TBL_PERSONAS A
INNER JOIN TBL_EMPLEADOS B
ON (A.CODIGO_PERSONA = B.CODIGO_EMPLEADO)
INNER JOIN TBL_MAESTROS C
ON (A.CODIGO_PERSONA = C.CODIGO_MAESTRO)
WHERE B.SUELDO_BASE = (
  SELECT MIN(SUELDO_BASE)
  FROM TBL_EMPLEADOS A
  INNER JOIN TBL_MAESTROS B
  ON (A.CODIGO_EMPLEADO = B.CODIGO_MAESTRO)
);
/*
6. Mostrar todos los estudiantes con más de 3 asignaturas matriculadas por periodo. Obtener los siguientes
datos:
a. Nombre completo
b. Cuenta
c. Lugar de procedencia.
d. Siguiente nivel en el lugar de precedencia (Lugar padre).
e. Periodo
f. Cantidad de asignaturas por periodo.*/
SELECT A.CODIGO_ALUMNO,
       B.NOMBRE||' '||B.APELLIDO AS NOMBRE,
       C.NUMERO_CUENTA,
       D.NOMBRE_LUGAR,
       G.NOMBRE_LUGAR AS NOMBRE_LUGAR_PADRE,
       F.NOMBRE_PERIODO,
       COUNT(*) CANTIDAD_ASIGNATURAS
FROM TBL_MATRICULA A
INNER JOIN TBL_PERSONAS B
ON (A.CODIGO_ALUMNO = B.CODIGO_PERSONA)
INNER JOIN TBL_ALUMNOS C
ON (A.CODIGO_ALUMNO = C.CODIGO_ALUMNO)
INNER JOIN TBL_LUGARES D
ON (B.CODIGO_LUGAR_NACIMIENTO = D.CODIGO_LUGAR)
INNER JOIN TBL_SECCION E
ON (A.CODIGO_SECCION = E.CODIGO_SECCION)
INNER JOIN TBL_PERIODOS F
ON (E.CODIGO_PERIODO = F.CODIGO_PERIODO)
LEFT JOIN TBL_LUGARES G
ON (D.CODIGO_LUGAR_PADRE = G.CODIGO_LUGAR)
GROUP BY A.CODIGO_ALUMNO,
       B.NOMBRE||' '||B.APELLIDO,
       C.NUMERO_CUENTA,
       D.NOMBRE_LUGAR,
         G.NOMBRE_LUGAR,
       F.NOMBRE_PERIODO
HAVING COUNT(*)>=3;


  /*
7. Mostrar que estudiantes tienen asignaturas matriculadas sin requisito.*/

SELECT  A.CODIGO_ALUMNO,
       D.NOMBRE||' '||D.APELLIDO AS NOMBRE,
        C.CODIGO_ASIGNATURA,
        C.NOMBRE_ASIGNATURA
FROM TBL_MATRICULA A
INNER JOIN TBL_SECCION B
ON (A.CODIGO_SECCION = B.CODIGO_SECCION)
INNER JOIN TBL_ASIGNATURAS C
ON (B.CODIGO_ASIGNATURA = C.CODIGO_ASIGNATURA)
INNER JOIN TBL_PERSONAS D
ON (A.CODIGO_ALUMNO = D.CODIGO_PERSONA)
WHERE B.CODIGO_ASIGNATURA NOT IN (
  SELECT CODIGO_ASIGNATURA FROM TBL_REQUISITOS
);

SELECT *FROM TBL_REQUISITOS WHERE CODIGO_ASIGNATURA IN (19,20);

