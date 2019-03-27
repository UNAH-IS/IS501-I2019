/*1. Consultar la cantidad de likes por publicaci�n.*/
SELECT CODIGO_PUBLICACION, COUNT(*) AS CANTIDAD_LIKES
FROM TBL_LIKE_PUBLICACIONES
GROUP BY CODIGO_PUBLICACION;

SELECT A.CODIGO_PUBLICACION, 
        B.CONTENIDO_PUBLICACION,
        COUNT(*) AS CANTIDAD_LIKES
FROM TBL_LIKE_PUBLICACIONES A
INNER JOIN TBL_PUBLICACIONES B
ON (A.CODIGO_PUBLICACION = B.CODIGO_PUBLICACION)
GROUP BY A.CODIGO_PUBLICACION,
    B.CONTENIDO_PUBLICACION;



/*
2. Consultar la cantidad de likes por fotograf�a.*/
SELECT CODIGO_FOTO, COUNT(*) AS CANTIDAD_FOTOS
FROM TBL_LIKE_FOTOGRAFIAS
GROUP BY CODIGO_FOTO;

/*
3. Consultar los grupos en los cuales la cantidad de usuarios sea mayor que 5, mostrar el nombre
del grupo y la cantidad de usuarios.
*/
SELECT  A.CODIGO_GRUPO, 
        B.NOMBRE_GRUPO,
        COUNT(*) AS CANTIDAD_USUARIOS
FROM TBL_GRUPOS_X_USUARIO A
INNER JOIN TBL_GRUPOS B
ON (A.CODIGO_GRUPO = B.CODIGO_GRUPO)
GROUP BY A.CODIGO_GRUPO,B.NOMBRE_GRUPO
HAVING COUNT(*)>5;

/*
4. Mostrar la cantidad de amistades pendientes y rechazadas.*/
SELECT A.CODIGO_USUARIO,C.NOMBRE_USUARIO, A.CODIGO_ESTATUS, B.NOMBRE_ESTATUS, COUNT(*) CANTIDAD_SOLICITUDES
FROM TBL_AMIGOS A
INNER JOIN TBL_ESTATUS_SOLICITUDES B
ON (A.CODIGO_ESTATUS = B.CODIGO_ESTATUS)
INNER JOIN TBL_USUARIOS C
ON (A.CODIGO_USUARIO = C.CODIGO_USUARIO)
WHERE A.CODIGO_ESTATUS IN (2,3)
GROUP BY A.CODIGO_USUARIO, C.NOMBRE_USUARIO, A.CODIGO_ESTATUS, B.NOMBRE_ESTATUS
ORDER BY A.CODIGO_USUARIO, NOMBRE_ESTATUS;

SELECT *
FROM TBL_ESTATUS_SOLICITUDES;

/*5. Mostrar el usuario con mayor cantidad de amigos confirmados (El m�s cool).
*/
--Cantidad máxima de amigos confirmados
SELECT MAX(CANTIDAD_AMIGOS_CONFIRMADOS)
FROM (
       SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_AMIGOS_CONFIRMADOS
       FROM TBL_AMIGOS
       WHERE CODIGO_ESTATUS = 1
       GROUP BY CODIGO_USUARIO
       ORDER BY 2 DESC
     );


--Solucion sin WITH
SELECT A.CODIGO_USUARIO, B.NOMBRE_USUARIO, COUNT(*) AS CANTIDAD_AMIGOS_CONFIRMADOS
FROM TBL_AMIGOS A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
WHERE CODIGO_ESTATUS = 1
GROUP BY A.CODIGO_USUARIO,B.NOMBRE_USUARIO
HAVING COUNT(*) = (
      SELECT MAX(CANTIDAD_AMIGOS_CONFIRMADOS)
      FROM (
         SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_AMIGOS_CONFIRMADOS
         FROM TBL_AMIGOS
         WHERE CODIGO_ESTATUS = 1
         GROUP BY CODIGO_USUARIO
         ORDER BY 2 DESC
       )
  )
ORDER BY 2 DESC;




--EQUIVALENTE A LA ANTERIOR PERO USANDO WITH
WITH AMIGOS_CONFIRMADOS AS (
  SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_AMIGOS_CONFIRMADOS
  FROM TBL_AMIGOS
  WHERE CODIGO_ESTATUS = 1
  GROUP BY CODIGO_USUARIO
)
SELECT A.CODIGO_USUARIO,
       B.NOMBRE_USUARIO,
       A.CANTIDAD_AMIGOS_CONFIRMADOS
FROM AMIGOS_CONFIRMADOS A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
WHERE CANTIDAD_AMIGOS_CONFIRMADOS = (
      SELECT MAX(CANTIDAD_AMIGOS_CONFIRMADOS)
      FROM AMIGOS_CONFIRMADOS
);



/*
6. Mostrar el usuario con m�s solicitudes rechazadas (Forever alone).*/
WITH AMIGOS_RECHAZADOS AS (
  SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_AMIGOS_RECHAZADOS
  FROM TBL_AMIGOS
  WHERE CODIGO_ESTATUS = 2
  GROUP BY CODIGO_USUARIO
)
SELECT A.CODIGO_USUARIO,
       B.NOMBRE_USUARIO,
       --CASE WHEN B.NOMBRE_USUARIO = 'Usuario 11' tHEN 'Rony' else b.NOMBRE_USUARIO end ,
       A.CANTIDAD_AMIGOS_RECHAZADOS
FROM AMIGOS_RECHAZADOS A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
WHERE CANTIDAD_AMIGOS_RECHAZADOS = (
      SELECT MAX(CANTIDAD_AMIGOS_RECHAZADOS)
      FROM AMIGOS_RECHAZADOS
);

/*
7. Mostrar la cantidad de usuarios registrados mensualmente.*/

  /*
8. Mostrar la edad promedio de los usuarios por g�nero.
9. Con respecto al historial de accesos se necesita saber el crecimiento de los accesos del d�a 19 de
agosto del 2015 con respecto al d�a anterior, la f�rmula para calcular dicho crecimiento se
muestra a continuaci�n:
((b-a)/a) * 100
Donde:
a = Cantidad de accesos del d�a anterior (18 de Agosto del 2015)
b = Cantidad de accesos del d�a actual (19 de Agosto del 2015)
Mostrar el resultado como un porcentaje (Concatenar %)
10. Crear una consulta que muestre lo siguiente:
� Nombre del usuario.
� Pa�s donde pertenece.
� Cantidad de publicaciones que tiene.
� Cantidad de amigos confirmados.
Cantidad de likes que ha dado.
� Cantidad de fotos en las que ha sido etiquetado.
� Cantidad de accesos en el historial.
Tip: utilice subconsultas.
11. De la consulta anterior cree una vista materializada y util�cela desde una tabla din�mica en Excel
para mostrar una gr�fica de l�nea que muestre la cantidad de amigos por cada usuario.
Nota: Para cada consulta tiene que mostrarse la informaci�n legible para el usuario*/