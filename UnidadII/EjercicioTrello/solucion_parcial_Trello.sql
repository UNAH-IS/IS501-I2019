/*
Consultar el usuario que ha hecho más comentarios sobre una tarjeta (El más prepotente), para
este usuario mostrar el nombre completo, correo, cantidad de comentarios y cantidad de
tarjetas a las que ha comentado (pista: una posible solución para este último campo es utilizar
count(distinct campo))

*/


SELECT A.CODIGO_USUARIO,
       B.NOMBRE||''||B.APELLIDO AS NOMBRE,
       B.CORREO,
       COUNT(*) AS CANTIDAD_COMENTARIOS,--CODIGO_TARJETA, CODIGO_COMENTARIO
       COUNT(DISTINCT CODIGO_TARJETA) CANTIDAD_TARJETAS_COMENTADO
 FROM TBL_COMENTARIOS A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY A.CODIGO_USUARIO,
         B.NOMBRE||''||B.APELLIDO,
         B.CORREO
HAVING COUNT(*) = (
 SELECT MAX(CANTIDAD_COMENTARIOS)
 FROM (
       SELECT CODIGO_USUARIO, COUNT(*) CANTIDAD_COMENTARIOS
       FROM TBL_COMENTARIOS
       GROUP BY CODIGO_USUARIO
      )
);

/*

Mostrar todos los usuarios con la siguiente información:
• Nombre completo del Usuario
• Correo
• Cantidad de tableros creados
• Cantidad de organizaciones a las que pertenece
• Cantidad de tarjetas creadas
• Cantidad de archivos adjuntos subidos

*/


SELECT A.CODIGO_USUARIO,
       A.NOMBRE||' '||A.APELLIDO NOMBRE,
       A.CORREO,
       NVL(B.CANTIDAD_TABLEROS,0) AS CANTIDAD_TABLEROS,
       NVL(C.CANTIDAD_ORGANIZACIONES,0) AS CANTIDAD_ORGANIZACIONES,
       NVL(D.CANTIDAD_TARJETAS,0) AS CANTIDAD_TARJETAS,
       NVL(E.CANTIDAD_ARCHIVOS,0) AS CANTIDAD_ARCHIVOS
FROM TBL_USUARIOS A
LEFT JOIN (
  SELECT CODIGO_USUARIO_CREA, COUNT(*) AS CANTIDAD_TABLEROS
  FROM TBL_TABLERO
  GROUP BY CODIGO_USUARIO_CREA
) B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO_CREA)
LEFT JOIN (
  SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_ORGANIZACIONES
  FROM TBL_USUARIOS_X_ORGANIZACION
  GROUP BY CODIGO_USUARIO
) C
ON (A.CODIGO_USUARIO = C.CODIGO_USUARIO)
LEFT JOIN (
   SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_TARJETAS
   FROM TBL_TARJETAS
   GROUP BY CODIGO_USUARIO
) D
ON (A.CODIGO_USUARIO = D.CODIGO_USUARIO)
LEFT JOIN (
  SELECT CODIGO_USUARIO,COUNT(*) AS CANTIDAD_ARCHIVOS
  FROM TBL_ARCHIVOS_ADJUNTOS
  GROUP BY CODIGO_USUARIO
 ) E
ON (A.CODIGO_USUARIO = E.CODIGO_USUARIO);


/*
Un usuario puede estar suscrito a tableros, listas y tarjetas, de tal forma que si hay algún cambio
se le notifica en su teléfono o por teléfono, sabiendo esto, se necesita mostrar los nombres de
todos los usuarios con la cantidad de suscripciones de cada tipo, en la consulta se debe mostrar:
• Nombre completo del usuario
• Cantidad de tableros a los cuales está suscrito
• Cantidad de listas a las cuales está suscrito
• Cantidad de tarjetas a las cuales está suscrito
*/
SELECT CODIGO_USUARIO, COUNT(CODIGO_LISTA), COUNT(CODIGO_TABLERO), COUNT(CODIGO_TARJETA)
FROM TBL_SUSCRIPCIONES
GROUP BY CODIGO_USUARIO;