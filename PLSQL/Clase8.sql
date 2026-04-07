-- Clase 9 PLSQL
-- Diego Puértolas Ruiz 1SW

/* 
1- Crea una tabla llamada SALARIO_CA con los siguientes campos:
    • ID VARCHAR2(5)
    • SALARIO NUMBER(7,2)

Una vez realizada la tabla, crea un bloque sin nombre que mediante una única 
consulta inserte en dicha tabla el resultado de recuperar los campos 
EMPLOYEE_ID y CALCULO_SALARIO de los empleados de TORONTO cuyo salario sea
mayor que 3000.

El campo CALCULO_SALARIO, se obtiene a partir del campo salario, SALARY, 
de los empleados encontrados, dividido por el número de departamentos que 
tienen las ciudades de CANADA distintas de TORONTO.

Controla el proceso mediante transacciones y excepciones. En particular, 
personaliza los errores de división por cero con su correspondiente excepción.
Las excepciones deberán mostrar por pantalla el nº de error de Oracle y 
su descripción oficial concatenados.

El proceso se va a completar con un control externo mediante una tabla de Log.
Esta tabla llamada LOG_SALARIO_CA, deberá contener los siguientes campos:
    - FECHA_FIN: Donde guardaremos la fecha y hora de los procesos. 
      Se pide que incluya fracciones de segundo.
    - PROCESO: Nombre del proceso que está sucediendo. Por ejemplo “INSERT SALARIO_CA”.
    - DESCRIPCION: Donde guardaremos si el proceso ha terminado ok o el error sucedido. 
      Para la excepción OTHERS puedes incluir simplemente ‘ERROR’.

Dicha tabla de Log es necesario rellenarla tanto con los errores como con 
los éxitos del proceso.

(Referencia excepciones Oracle: https://docs.oracle.com/cd/E11882_01/timesten.112/e21639/exceptions.htm#TTPLS191)
*/
-- CREACIÓN DE TABLAS
CREATE TABLE SALARIO_CA (
    id_salario VARCHAR2(5), 
    salario NUMBER(7,2)
);

CREATE TABLE LOG_SALARIO_CA (
    fecha_fin TIMESTAMP, 
    proceso VARCHAR2(100), 
    descripcion VARCHAR2(80)
);

BEGIN
    INSERT INTO SALARIO_CA(id_salario, salario) 
    SELECT 
        EMPLOYEE_ID, 
        (SALARY / (SELECT COUNT(*) FROM DEPARTMENTS D
                   INNER JOIN LOCATIONS L
                   ON D.LOCATION_ID = L.LOCATION_ID AND L.CITY <> 'Toronto' 
                   WHERE L.COUNTRY_ID = 'CA'
                  )) AS CALCULO_SALARIO 
    FROM EMPLOYEES EM 
    INNER JOIN DEPARTMENTS DE 
        ON EM.DEPARTMENT_ID = DE.DEPARTMENT_ID 
    INNER JOIN LOCATIONS LO 
        ON DE.LOCATION_ID = LO.LOCATION_ID AND LO.CITY = 'Toronto' 
    WHERE EM.SALARY > 3000; 
    
    COMMIT;
    INSERT INTO LOG_SALARIO_CA(fecha_fin, proceso, descripcion) 
        VALUES(SYSTIMESTAMP, 'INSERT SALARIO_CA', 'TERMINADO OK');
    COMMIT;

EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('ERROR en el proceso. ERROR: ' || TO_CHAR(SQLERRM) || ' -> ' || SQLCODE);
        ROLLBACK;
        INSERT INTO LOG_SALARIO_CA(fecha_fin, proceso, descripcion) 
            VALUES(SYSTIMESTAMP, 'INSERT SALARIO_CA', 'DIVISIÓN POR CERO'); 
        COMMIT;
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM || ' -> ' || TO_CHAR(SQLCODE));
        ROLLBACK;
        INSERT INTO LOG_SALARIO_CA(fecha_fin, proceso, descripcion) 
            VALUES(SYSTIMESTAMP, 'INSERT SALARIO_CA', 'ERROR');
        COMMIT;
END;
/

-- 2- Crea un procedimiento almacenado que reciba una cadena y la muestre al revés.
CREATE OR REPLACE PROCEDURE MOSTRAR_AL_REVES (p_cadena IN VARCHAR2)
AS
  v_cadena_reves VARCHAR2(100) := '';
BEGIN
  FOR i IN REVERSE 1..LENGTH(p_cadena) LOOP
    v_cadena_reves := v_cadena_reves || SUBSTR(p_cadena, i, 1);
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE(v_cadena_reves);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    ROLLBACK;
END MOSTRAR_AL_REVES;
/
EXECUTE MOSTRAR_AL_REVES('Hola Mundo');
