-- Clase 6 PLSQL
-- Diego Puértolas Ruiz 1SW

-- 1. CREAR UN PROCEDIMIENTO QUE OBTENGA LA FECHA ACTUAL 
CREATE OR REPLACE PROCEDURE OBTENER_FECHA_ACTUAL(p_fecha OUT VARCHAR2)
AS
BEGIN
    p_fecha := TO_CHAR(SYSDATE,'DD/MM/YYYY');
END;
/
SET SERVEROUTPUT ON;
DECLARE
    fecha_actual VARCHAR2(10);
BEGIN 
    OBTENER_FECHA_ACTUAL(fecha_actual);
    DBMS_OUTPUT.PUT_LINE(fecha_actual);
END;
/

-- 2. CREAR UN PROCEDIMIENTO QUE CALCULE EL SALARIO MAXIMO Y EN LA LLAMADA AL PROCEDIMIENTO LO MOSTRAREMOS INCREMENTADO EN UN 15% 
CREATE OR REPLACE PROCEDURE CALCULAR_SALARIO_MAXIMO(p_salario_maximo OUT NUMBER)
AS
BEGIN
  SELECT MAX(salary) INTO p_salario_maximo 
  FROM EMPLOYEES;

  IF p_salario_maximo IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('No se pudo calcular el salario máximo porque no hay empleados.');
  END IF;
END;
/
SET SERVEROUTPUT ON;
DECLARE
  salario_maximo NUMBER;
BEGIN
  CALCULAR_SALARIO_MAXIMO(salario_maximo);
  salario_maximo := salario_maximo * 1.15; 
  DBMS_OUTPUT.PUT_LINE('El salario máximo incrementado en un 15% es: ' || salario_maximo);
END;
/

-- 3. CREAR UN PROCEDIMIENTO QUE RECIBA POR PARÁMETRO EL DEPARTAMENTO Y DEVUELVA EL GASTO TOTAL EN SALARIOS 
CREATE OR REPLACE PROCEDURE 
  CALCULAR_GASTO_DEPARTAMENTO(
    p_departamento_id IN DEPARTMENTS.department_id%TYPE, p_gasto_total OUT EMPLOYEES.salary%TYPE
  )
AS
BEGIN
  SELECT SUM(salary) INTO p_gasto_total
  FROM EMPLOYEES
  WHERE department_id = p_departamento_id;

  IF p_gasto_total IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('No hay empleados en el departamento ' || p_departamento_id || '.');
  END IF;
END;
/
SET SERVEROUTPUT ON;
DECLARE
  gasto_total NUMBER;
BEGIN
  CALCULAR_GASTO_DEPARTAMENTO(10, gasto_total);
  DBMS_OUTPUT.PUT_LINE('El gasto total en salarios del departamento es: ' || gasto_total);
END;
/

-- 4. CREAR UN PROCEDIMIENTO QUE RECIBA COMO PARAMETROS DE ENTRADA DOS CIUDADES Y MUESTRE LA DIFERENCIA DE GASTO EN SALARIOS ENTRE AMBAS. 
CREATE OR REPLACE PROCEDURE
  DIFERENCIA_GASTO_CIUDADES(
    p_ciudad1 IN LOCATIONS.city%TYPE, p_ciudad2 IN LOCATIONS.city%TYPE, p_diferencia OUT NUMBER
  )
AS
  gasto_ciudad1 NUMBER;
  gasto_ciudad2 NUMBER;
BEGIN
  SELECT SUM(EMP.salary) INTO gasto_ciudad1
  FROM EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
    ON EMP.department_id = D.department_id
  INNER JOIN LOCATIONS L
    ON D.location_id = L.location_id
  WHERE L.city = p_ciudad1;
  
  SELECT SUM(EMP.salary) INTO gasto_ciudad2
  FROM EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
    ON EMP.department_id = D.department_id
  INNER JOIN LOCATIONS L
    ON D.location_id = L.location_id
  WHERE L.city = p_ciudad2;
  
  IF gasto_ciudad1 IS NULL OR gasto_ciudad2 IS NULL THEN
    p_diferencia := NULL;
    DBMS_OUTPUT.PUT_LINE('No se pudo calcular la diferencia porque una de las ciudades no tiene empleados.');
    RETURN;
  END IF;

  p_diferencia := gasto_ciudad1 - gasto_ciudad2;
END;
/
SET SERVEROUTPUT ON;
DECLARE
  diferencia NUMBER;
BEGIN
  DIFERENCIA_GASTO_CIUDADES('New York', 'Seattle', diferencia);
  DBMS_OUTPUT.PUT_LINE('La diferencia de gasto en salarios entre las dos ciudades es: ' || diferencia);
END;
/

-- 5. CREA UN PROCEDIMIENTO ALMACENADO QUE CREE UNA TABLA CON LOS GASTOS TOTALES DE CADA CIUDAD, NOMBRE CIUDAD Y GASTO. 
-- CREA OTRO PROCEDIMIENTO QUE INSERTE UN REGISTRO DE LA CIUDAD QUE RECIBA COMO PARÁMETRO. 
CREATE OR REPLACE PROCEDURE CREAR_TABLA_GASTOS_CIUDAD 
AS
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE GASTOS_CIUDAD (CIUDAD VARCHAR2(50), GASTO NUMBER)';
  DBMS_OUTPUT.PUT_LINE('Tabla GASTOS_CIUDAD creada exitosamente.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al crear la tabla: ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE INSERTAR_GASTO_CIUDAD(p_ciudad IN VARCHAR2) AS
  gasto_total NUMBER;
BEGIN
  SELECT SUM(EMP.salary) INTO gasto_total
  FROM EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
    ON EMP.department_id = D.department_id
  INNER JOIN LOCATIONS L
    ON D.location_id = L.location_id
  WHERE L.city = p_ciudad;

  INSERT INTO GASTOS_CIUDAD (CIUDAD, GASTO) VALUES (p_ciudad, gasto_total);
  DBMS_OUTPUT.PUT_LINE('Registro insertado: CIUDAD = ' || p_ciudad || ', GASTO = ' || gasto_total);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al insertar el registro: ' || SQLERRM);
END;
/

EXECUTE CREAR_TABLA_GASTOS_CIUDAD;
EXECUTE INSERTAR_GASTO_CIUDAD('New York');
EXECUTE INSERTAR_GASTO_CIUDAD('Seattle');

-- 6. CREA UN PROCEDIMIENTO QUE BUSQUE EL DEPARTAMENTO CON MAYOR NUMERO 
-- DE EMPLEADOS Y LO INCREMENTE UN 10% SI ES EUROPEO O UN 20% SI ES AMERICANO 
CREATE OR REPLACE PROCEDURE INCREMENTAR_SALARIO_DEPARTAMENTO_MAYOR_EMPLEADOS 
AS
  v_department_id DEPARTMENTS.department_id%TYPE;
  v_region_name REGIONS.region_name%TYPE;
BEGIN
  -- Obtenemos el departamento con mayor número de empleados.
  SELECT department_id INTO v_department_id
  FROM (
    SELECT department_id, COUNT(*) AS num_empleados
    FROM EMPLOYEES
    GROUP BY department_id
    ORDER BY num_empleados DESC
  )
  WHERE ROWNUM = 1;

  -- Obtenemos la región del departamento con mayor número de empleados.
  SELECT R.region_name INTO v_region_name
  FROM DEPARTMENTS D
  INNER JOIN LOCATIONS L
    ON D.location_id = L.location_id
  INNER JOIN COUNTRIES C
    ON L.country_id = C.country_id
  INNER JOIN REGIONS R
    ON C.region_id = R.region_id
  WHERE D.department_id = v_department_id;

  -- Incrementamos el salario según la región.
  IF UPPER(v_region_name) = 'EUROPE' THEN
    UPDATE EMPLOYEES
    SET salary = salary * 1.10
    WHERE department_id = v_department_id;
    DBMS_OUTPUT.PUT_LINE('Salarios incrementados en un 10% para el departamento con mayor número de empleados en Europa.');
  ELSIF UPPER(v_region_name) = 'AMERICAS' THEN
    UPDATE EMPLOYEES
    SET salary = salary * 1.20
    WHERE department_id = v_department_id;
    DBMS_OUTPUT.PUT_LINE('Salarios incrementados en un 20% para el departamento con mayor número de empleados en América.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El departamento con mayor número de empleados no pertenece a Europa ni América. No se realizaron incrementos.');
  END IF;
EXCEPTION       
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al incrementar los salarios: ' || SQLERRM);
END;

EXECUTE INCREMENTAR_SALARIO_DEPARTAMENTO_MAYOR_EMPLEADOS;