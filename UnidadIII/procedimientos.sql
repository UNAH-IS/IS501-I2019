Tipos de procedimientos:
*Bloques anonimos:
    Programa/procedimiento sin nombre
    No se almacena en la base de datos
    Se ejecuta tras el llamado al bloque anonimo
    Sintaxis:
        DECLARE
          /*DECLARACION DE VARIABLES*/
        BEGIN
          /*INSTRUCCIONES*/
        END;

        SET SERVEROUTPUT ON; --HABILITAR LA CONSOLA DE ORACLE

        BEGIN
          DBMS_OUTPUT.PUT_LINE('hOLA MUNDO');
        END;


        DECLARE
          V_NOMBRE VARCHAR2(100):='Juan';
          V_APELLIDO VARCHAR2(100);
          V_EDAD NUMBER;
        BEGIN
          V_APELLIDO:='Perez';
          SELECT 35 INTO V_EDAD
          FROM DUAL;
          DBMS_OUTPUT.PUT_LINE('hOLA '||V_NOMBRE||' '||V_APELLIDO||'('||V_EDAD||')');
        END;

*Procedimientos almacenados:
      Si tienen un nombre
      Si se almacenan en la base de datos
      No se ejecutan en el momento, primero se compilan, se almacenan y luego se pueden ejecutar


      Sintaxis
      CREATE OR REPLACE PROCEDURE NOMBRE(
          PARAMETRO1 TIPODATO1 [IN|OUT],
          PARAMETRO2 TIPODATO2 [IN|OUT],
          ...
          PARAMETRON TIPODATON [IN|OUT]
      ) AS
        /*DECLARACION DE VARIABLES*/
      BEGIN
        /*INSTRUCCIONES*/
      END;

      CREATE OR REPLACE PROCEDURE P_HOLA_MUNDO(
          P_NOMBRE VARCHAR2,
          P_APELLIDO VARCHAR2,
          P_EDAD NUMBER
      ) AS
        /*DECLARACION DE VARIABLES*/
      BEGIN
        DBMS_OUTPUT.PUT_LINE('hOLA '||P_NOMBRE||' '||P_APELLIDO||'('||P_EDAD||')');
      END;

      Como ejecutar un procedimiento almacenado:
       execute nombre_procedimiento();
       call nombre_procedimiento();
        begin
          nombre_procedimiento();
        end;

        Ejemplo:
        execute p_hola_mundo('Juan','Perez',38);

Ejemplo para insertar un empleado
create or replace PROCEDURE P_AGREGAR_EMPLEADO(
    p_first_name employees.first_name%TYPE,
    p_last_name employees.last_name%TYPE,
    p_email employees.email%TYPE,
    p_phone_number employees.phone_number%TYPE,
    p_hire_date employees.hire_date%TYPE,
    p_job_id employees.job_id%TYPE,
    p_salary employees.salary%TYPE,
    p_commission_pct employees.commission_pct%TYPE,
    p_manager_id employees.manager_id%TYPE,
    p_department_id employees.department_id%TYPE,
    p_mensaje out varchar2,
    p_codigo_resultado out integer
) AS
    v_cantidad number;
BEGIN
    select count(*)
    into v_cantidad
    from employees
    where email = p_email;

    IF (v_cantidad = 0) THEN
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id
        ) VALUES (
            employees_seq.nextval,
            p_first_name,
            p_last_name,
            p_email,
            p_phone_number,
            p_hire_date,
            p_job_id,
            p_salary,
            p_commission_pct,
            p_manager_id,
            p_department_id
        );
        commit;
        p_mensaje := 'Registro almanceado con éxito';
        p_codigo_resultado:=1;
    ELSE
        p_mensaje := 'El correo esta duplicado, no se pudo guardar';
        p_codigo_resultado:=0;
    END IF;
    --LOREM IPSUM
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLCODE || '-'||SQLERRM);
        ROLLBACK;
        p_mensaje:= 'Error al guardar el empleado: ' || SQLCODE || '-'||SQLERRM;
        p_codigo_resultado:=0;
END;

EXECUTE P_AGREGAR_EMPLEADO(p_first_name => 'Juan',p_last_name => 'Perez',p_email => 'jperez@gmail.com',p_phone_number => '',p_hire_date => sysdate,p_job_id => 'SA_MAN',p_salary => 2000,p_commission_pct => 0.5,p_manager_id => 100,p_department_id => 20);


*Funciones Almacenadas
*Triggers


SELECT 35 FROM DUAL;