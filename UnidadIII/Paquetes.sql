--CREAR EL ENCABEZADO DEL PAQUETE
CREATE  OR REPLACE PACKAGE PKG_EMPLOYEES AS
    PROCEDURE P_AGREGAR_EMPLEADO(
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
        p_codigo_resultado out integer,
        p_employee_id out integer
    );
    
    PROCEDURE P_ACTUALIZAR_EMPLEADO(
        p_employee_id integer,
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
    );
    
    PROCEDURE P_ELIMINAR_EMPLEADO(p_employee_id INTEGER);
    
END;



CREATE  OR REPLACE PACKAGE BODY PKG_EMPLOYEES AS
    PROCEDURE P_AGREGAR_EMPLEADO(
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
        p_codigo_resultado out integer,
        p_employee_id out integer
    ) AS 
    v_cantidad number;
    BEGIN
        select count(*)
        into v_cantidad
        from employees 
        where email = p_email;
    
        IF (v_cantidad = 0) THEN
            p_employee_id:=employees_seq.nextval;
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
                p_employee_id,
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
    
    PROCEDURE P_ACTUALIZAR_EMPLEADO(
        p_employee_id integer,
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
    )AS
    BEGIN   
        NULL;
    END;
    
    PROCEDURE P_ELIMINAR_EMPLEADO(p_employee_id INTEGER)
    AS
    BEGIN
        NULL;
    END;
    
END;


EXECUTE PKG_EMPLOYEES.P_ELIMINAR_EMPLEADO(1);

