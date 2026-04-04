-- Clase 3 PLSQL
-- Diego Puértolas Ruiz 1SW

-- EJERCICIO 1: CREA UN BLOQUE QUE MUESTRE EL TRIMESTRE DE CONTRATACION, DEL EMPLEADO MAS ANTIGUO.

-- Anidando IFs
SET SERVEROUTPUT ON;
DECLARE
  hire_date EMPLOYEES.hire_date%TYPE;
BEGIN
  SELECT MIN(hire_date) INTO hire_date 
  FROM EMPLOYEES;

  IF EXTRACT(MONTH FROM hire_date) IN (1, 2, 3) THEN
    DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el primer trimestre.');
  ELSIF EXTRACT(MONTH FROM hire_date) IN (4, 5, 6) THEN
    DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el segundo trimestre.');
  ELSIF EXTRACT(MONTH FROM hire_date) IN (7, 8, 9) THEN
    DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el tercer trimestre.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el cuarto trimestre.');
  END IF;
END;

-- Estructura CASE
SET SERVEROUTPUT ON;
DECLARE
  hire_date EMPLOYEES.hire_date%TYPE;
BEGIN
  SELECT MIN(hire_date) INTO hire_date 
  FROM EMPLOYEES;

  CASE 
    WHEN EXTRACT(MONTH FROM hire_date) IN (1, 2, 3) THEN
      DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el primer trimestre.');
    WHEN EXTRACT(MONTH FROM hire_date) IN (4, 5, 6) THEN
      DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el segundo trimestre.');
    WHEN EXTRACT(MONTH FROM hire_date) IN (7, 8, 9) THEN
      DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el tercer trimestre.');
    WHEN EXTRACT(MONTH FROM hire_date) IN (10, 11, 12) THEN
      DBMS_OUTPUT.PUT_LINE('El empleado más antiguo fue contratado en el cuarto trimestre.');
  END CASE;
END;

-- EJERCICIO 2: CREA UN BLOQUE EN EL QUE MEDIANTE UN RESULTADO ALMACENADO EN UNA VARIABLE 
-- CON RESULTADOS <10, INDIQUE SI HA GANADO EL VISITANTE, EL LOCAL O HAN EMPATADO

-- Anidando IFs
SET SERVEROUTPUT ON;
DECLARE
  result NUMBER := 8; 
BEGIN
  IF result < 10 THEN
    DBMS_OUTPUT.PUT_LINE('El visitante ha ganado.');
  ELSIF result > 10 THEN
    DBMS_OUTPUT.PUT_LINE('El local ha ganado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Han empatado.');
  END IF;
END;

-- Estructura CASE
SET SERVEROUTPUT ON;
DECLARE
  result NUMBER := 12;
BEGIN 
  CASE 
    WHEN result < 10 THEN
      DBMS_OUTPUT.PUT_LINE('El visitante ha ganado.');
    WHEN result > 10 THEN
      DBMS_OUTPUT.PUT_LINE('El local ha ganado.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Han empatado.');
  END CASE;
END;

-- EJERCICIO 3: CREA UN BLOQUE QUE INDIQUE SI LA CIUDAD DEL EMPLEADO QUE MAYOR COMISION TIENE ES EUROPEA 
SET SERVEROUTPUT ON;
DECLARE
  region REGIONS.region_name%TYPE;
BEGIN
  -- Obtenemos la región del empleado con mayor comisión
  SELECT R.region_name INTO region
  FROM REGIONS R
  INNER JOIN COUNTRIES C
    ON R.region_id = C.region_id
  INNER JOIN LOCATIONS L
    ON C.country_id = L.country_id
  INNER JOIN DEPARTMENTS D
    ON L.location_id = D.location_id
  INNER JOIN EMPLOYEES E
    ON D.department_id = E.department_id
  WHERE E.commission_pct = (
    SELECT MAX(commission_pct)
    FROM EMPLOYEES
  );

  IF region = 'Europe' THEN
    DBMS_OUTPUT.PUT_LINE('La ciudad del empleado con mayor comisión es europea.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('La ciudad del empleado con mayor comisión no es europea.');
  END IF;
END;

-- EJERCICIO 4: CREA UN BLOQUE QUE MUESTRE LOS NUMEROS PARES DEL 1 AL 10
SET SERVEROUTPUT ON;
DECLARE
  i NUMBER := 1;
BEGIN
  FOR i IN 1..10 LOOP
    IF MOD(i, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(i);
    END IF;
  END LOOP;
END;