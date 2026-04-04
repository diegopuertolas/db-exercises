-- Clase 2 PLSQL
-- Diego Puértolas Ruiz 1SW

-- EJERCICIO 1: EL MAYOR DE DOS NÚMEROS
-- Declara dos variables numéricas con valores distintos. Mediante un bloque 
-- anónimo, evalúa y muestra por pantalla cuál de las dos tiene el valor mayor.
SET SERVEROUTPUT ON;
DECLARE
  num1 NUMBER := 10;
  num2 NUMBER := 20;
BEGIN
  IF num1 > num2 THEN
    DBMS_OUTPUT.PUT_LINE('El número mayor es: ' || num1);
  ELSE num2 > num1 THEN
    DBMS_OUTPUT.PUT_LINE('El número mayor es: ' || num2);
  END IF;
END;

-- EJERCICIO 2: EL MAYOR DE DOS NÚMEROS (CON IGUALDAD)
-- Modifica el bloque del Ejercicio 1 para contemplar también la posibilidad 
-- de que ambos números sean exactamente iguales, mostrando el mensaje 
-- correspondiente en cada caso.
SET SERVEROUTPUT ON;
DECLARE
  num1 NUMBER := 10;
  num2 NUMBER := 10;
BEGIN
  IF num1 > num2 THEN
    DBMS_OUTPUT.PUT_LINE('El número mayor es: ' || num1);
  ELSIF num2 > num1 THEN
    DBMS_OUTPUT.PUT_LINE('El número mayor es: ' || num2);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Ambos números son iguales.');
  END IF;
END;

-- EJERCICIO 3: IDENTIFICADOR DE NÚMEROS PARES E IMPARES
-- Crea un bloque anónimo que evalúe una variable numérica entera e imprima 
-- por pantalla si dicho número es PAR o IMPAR.
SET SERVEROUTPUT ON;
DECLARE
  num NUMBER := 15;
BEGIN
  IF MOD(num, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('El número ' || num || ' es PAR.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El número ' || num || ' es IMPAR.');
  END IF;
END;

-- EJERCICIO 4: SUMA BÁSICA 
-- Escribe un bloque PL/SQL que sume dos variables numéricas predefinidas y 
-- guarde el resultado en una tercera variable. Muestra el resultado final 
-- por pantalla.
SET SERVEROUTPUT ON;
DECLARE
  num1 NUMBER := 5;
  num2 NUMBER := 10;
  res NUMBER;
BEGIN
  res := num1 + num2;
  DBMS_OUTPUT.PUT_LINE('La suma de ' || num1 || ' y ' || num2 || ' es: ' || res || '.');
END;

-- EJERCICIO 5: EXTRACCIÓN DEL AÑO
-- Crea un bloque que, a partir de una variable que contenga una fecha concreta 
-- (por ejemplo, tu fecha de nacimiento), extraiga únicamente el año y lo 
-- muestre por pantalla.
SET SERVEROUTPUT ON;
DECLARE
  fecha DATE := TO_DATE('31/05/2006', 'DD/MM/YYYY');
  year NUMBER;
BEGIN
  year := EXTRACT(YEAR FROM fecha);
  DBMS_OUTPUT.PUT_LINE('El año extraído de la fecha ' || TO_CHAR(fecha, 'DD/MM/YYYY') || ' es: ' || year || '.');
END;

-- EJERCICIO 6: CONDICIONALES CON SUBCONSULTAS
-- Busca en la tabla EMPLOYEES el año de contratación del empleado que MÁS cobra 
-- de toda la empresa. Muestra dicho año por pantalla SOLAMENTE si el empleado 
-- fue contratado después de 2007; de lo contrario, muestra un mensaje alternativo.
SET SERVEROUTPUT ON;
DECLARE
  hire_year NUMBER;
BEGIN
  SELECT EXTRACT(YEAR from hire_date) INTO hire_year
  FROM EMPLOYEES
  WHERE salary = (
    SELECT MAX(salary)
    FROM EMPLOYEES
  );

  IF hire_year > 2007 THEN
    DBMS_OUTPUT.PUT_LINE('El año de contratación del empleado que más cobra es: ' || hire_year || '.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El empleado que más cobra fue contratado antes o en 2007.');
  END IF;
END;

-- EJERCICIO 7: CRUCES MÚLTIPLES Y FILTRADO GEOGRÁFICO
-- Busca al empleado que MENOS cobra de la empresa y recupera su nombre, apellido 
-- y el continente (región) donde está ubicado su departamento. 
-- Muestra su nombre y apellido por pantalla ÚNICAMENTE si trabaja en 'Europe'. 
-- Si no es europeo, muestra un mensaje de advertencia.
SET SERVEROUTPUT ON;
DECLARE
  emp_name EMPLOYEES.first_name%TYPE;
  emp_surname EMPLOYEES.last_name%TYPE;
  emp_region REGIONS.region_name%TYPE;
BEGIN
  SELECT 
    first_name, 
    last_name, 
    region_name 
    INTO emp_name, emp_surname, emp_region
  FROM 
    EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
    ON EMP.department_id = D.department_id
  INNER JOIN LOCATIONS L
    ON D.location_id = L.location_id
  INNER JOIN COUNTRIES C
    ON L.country_id = C.country_id
  INNER JOIN REGIONS R
    ON C.region_id = R.region_id
  WHERE EMP.salary = (
    SELECT MIN(salary)
    FROM EMPLOYEES
  );

  IF emp_region = 'Europe' THEN 
    DBMS_OUTPUT.PUT_LINE('El empleado que menos cobra es: ' || emp_name || ' ' || emp_surname || '.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El empleado que menos cobra no trabaja en Europa, sino en ' || emp_region || '.');
  END IF;
END;