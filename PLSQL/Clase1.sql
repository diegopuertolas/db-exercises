-- Clase 1 PLSQL
-- Diego Puértolas Ruiz 1SW

-- Hola Mundo en PLSQL
SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hola Mundo!');
END;

-- Declaración de variables
SET SERVEROUTPUT ON;
DECLARE 
  MI_NOMBRE VARCHAR2(50) := 'Diego Puértolas Ruiz';
  MI_EDAD NUMBER(3) := 19;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Mi nombre es: ' || MI_NOMBRE || ' y tengo ' || MI_EDAD || ' años.');
END;

-- Ejemplo de consulta SQL dentro de un bloque PLSQL
SET SERVEROUTPUT ON;
DECLARE
  MAX_SALARY NUMBER(10) := 0;
BEGIN
  SELECT MAX(salary) INTO MAX_SALARY
  FROM EMPLOYEES;
  
  DBMS_OUTPUT.PUT_LINE('El salario máximo es: ' || MAX_SALARY);
END;

-- Otra forma de declarar la variable utilizando el tipo de dato de la tabla
SET SERVEROUTPUT ON;
DECLARE
  MAX_SALARY EMPLOYEES.salary%TYPE;
BEGIN
  SELECT MAX(salary) INTO MAX_SALARY
  FROM EMPLOYEES;

  DBMS_OUTPUT.PUT_LINE('El salario máximo es: ' || MAX_SALARY);
END;

-- Ejemplo de consulta SQL con varias columnas
SET SERVEROUTPUT ON;
DECLARE
  FIRST_NAME EMPLOYEES.first_name%TYPE;
  LAST_NAME EMPLOYEES.last_name%TYPE;
BEGIN
  SELECT first_name, last_name INTO FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
  WHERE employee_id = 100;

  DBMS_OUTPUT.PUT_LINE('El nombre del empleado con ID 100 es: ' || FIRST_NAME || ' ' || LAST_NAME);
END;

-- Ejemplo de consulta SQL con una condición más compleja
SET SERVEROUTPUT ON;
DECLARE
  DEP_ID DEPARTMENTS.department_id%TYPE;
  MAX_SALARY EMPLOYEES.salary%TYPE;
BEGIN
  -- Obtenemos el ID del departamento IT.
  SELECT department_id INTO DEP_ID
  FROM DEPARTMENTS
  WHERE department_name = 'IT';

  -- Obtenemos el salario máximo del departamento IT y lo almacenamos en la variable MAX_SALARY.
  SELECT MAX(salary) INTO MAX_SALARY
  FROM EMPLOYEES
  WHERE department_id = DEP_ID;

  DBMS_OUTPUT.PUT_LINE('El salario máximo del departamento IT es: ' || MAX_SALARY);
END;

-- Ejemplo de consulta SQL con varias columnas utilizando un registro.
SET SERVEROUTPUT ON;
DECLARE
  NOMBRE_COMPLETO EMPLOYEES%ROWTYPE;
BEGIN
  SELECT * INTO NOMBRE_COMPLETO 
  FROM EMPLOYEES 
  WHERE employee_id = 100;

  DBMS_OUTPUT.PUT_LINE('El nombre del empleado con ID 100 es: ' || NOMBRE_COMPLETO.first_name || ' ' || NOMBRE_COMPLETO.last_name);
END;

-- Ejemplo de consulta SQL con varias columnas utilizando un registro y una relación entre tablas.
SET SERVEROUTPUT ON;
DECLARE
  NOMBRE_EMPLEADO EMPLOYEES%ROWTYPE;
  NOMBRE_MANAGER EMPLOYEES%ROWTYPE;
BEGIN
  -- Obtenemos el registro del empleado con ID 120 y lo almacenamos en la variable NOMBRE_EMPLEADO.
  SELECT * INTO NOMBRE_EMPLEADO
  FROM EMPLOYEES
  WHERE employee_id = 120;

  -- Obtenemos el registro del manager del empleado con ID 120 y lo almacenamos en la variable NOMBRE_MANAGER.
  SELECT * INTO NOMBRE_MANAGER
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = NOMBRE_EMPLEADO.manager_id;

  DBMS_OUTPUT.PUT_LINE('El nombre del empleado con ID 120 es: ' || NOMBRE_EMPLEADO.first_name || ' ' || NOMBRE_EMPLEADO.last_name);
  DBMS_OUTPUT.PUT_LINE('El nombre del manager del empleado con ID 120 es: ' || NOMBRE_MANAGER.first_name || ' ' || NOMBRE_MANAGER.last_name);
END;