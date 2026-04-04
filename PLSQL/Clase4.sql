-- Clase 4 PLSQL
-- Diego Puértolas Ruiz 1SW

-- 1- CREA UN BLOQUE QUE CALCULE LA LETRA DEL DNI
SET SERVEROUTPUT ON;
DECLARE
  dni NUMBER := 73441850;
  cociente NUMBER;
  resultado NUMBER;
  letra CHAR(1);
BEGIN
  cociente := TRUNC(dni / 23);
  resultado := dni - (cociente * 23);
  
  CASE resultado
    WHEN 0 THEN letra := 'T';
    WHEN 1 THEN letra := 'R';
    WHEN 2 THEN letra := 'W';
    WHEN 3 THEN letra := 'A';
    WHEN 4 THEN letra := 'G';
    WHEN 5 THEN letra := 'M';
    WHEN 6 THEN letra := 'Y';
    WHEN 7 THEN letra := 'F';
    WHEN 8 THEN letra := 'P';
    WHEN 9 THEN letra := 'D';
    WHEN 10 THEN letra := 'X';
    WHEN 11 THEN letra := 'B';
    WHEN 12 THEN letra := 'N';
    WHEN 13 THEN letra := 'J';
    WHEN 14 THEN letra := 'Z';
    WHEN 15 THEN letra := 'S';
    WHEN 16 THEN letra := 'Q';
    WHEN 17 THEN letra := 'V';
    WHEN 18 THEN letra := 'H';
    WHEN 19 THEN letra := 'L';
    WHEN 20 THEN letra := 'C';
    WHEN 21 THEN letra := 'K';
    WHEN 22 THEN letra := 'E';
    ELSE
      DBMS_OUTPUT.PUT_LINE('Error: resultado fuera de rango');
  END CASE;

  DBMS_OUTPUT.PUT_LINE('La letra del DNI ' || dni || ' es: ' || letra);
END;

-- 2- EJEMPLO QUE MUESTRE UN NUMERO MIENTRAS SEA MENOR QUE DIEZ
SET SERVEROUTPUT ON;
DECLARE
  num NUMBER := 0;
BEGIN
  WHILE num < 10 LOOP
    DBMS_OUTPUT.PUT_LINE('Número: ' || num);
    num := num + 1;
  END LOOP;
END; 

-- 3- CREA UN BLOQUE QUE MUESTRE LOS NUMEROS PARES DEL 1 AL 10 (con FOR / con WHILE)

-- Con FOR
SET SERVEROUTPUT ON;
DECLARE
  i NUMBER;
BEGIN
  FOR i IN 1..10 LOOP
    IF MOD(i, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Número par: ' || i);
    END IF;
  END LOOP;
END;  

-- Con WHILE
SET SERVEROUTPUT ON;
DECLARE
  num NUMBER := 1;
BEGIN
  WHILE num <= 10 LOOP
    IF MOD(num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Número par: ' || num);
    END IF;
    num := num + 1;
  END LOOP;
END;

-- 4- CREA UN BLOQUE QUE CALCULE LOS NUMERO PRIMOS ENTRE 1 Y 1000
SET SERVEROUTPUT ON;
DECLARE
  num NUMBER := 2;
  es_primo BOOLEAN;
BEGIN
  WHILE num <= 1000 LOOP
    es_primo := TRUE;
    FOR i IN 2..TRUNC(SQRT(num)) LOOP -- Solo necesitamos verificar hasta la raíz cuadrada de num para determinar si es primo
      IF MOD(num, i) = 0 THEN
        es_primo := FALSE;
        EXIT; -- Salimos del bucle si encontramos un divisor
      END IF;
    END LOOP;
    IF es_primo THEN
      DBMS_OUTPUT.PUT_LINE(num);
    END IF;
    num := num + 1;
  END LOOP;
END; 