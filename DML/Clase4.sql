-- CLASE 4
-- Diego Puértolas Ruiz 1SW

-- Usamos la función TO_CHAR() para convertir la fecha en un formato específico.

-- 1-MOSTRAR LA FECHA DE CONTRATACION (HIRE_DATE) EN FORMATO TEXTO AÑO(4 DIGITOS) / MES / DIA DEL EMPLEADO CON ID=100;
SELECT TO_CHAR(hire_date, 'YYYY/MM/DD') AS hire_date_formatted FROM EMPLOYEES WHERE employee_id = 100;

-- 2- De la fecha obtenida, mostrar solamente el día de la semana,
SELECT TO_CHAR(hire_date, 'DAY') AS day_of_week FROM EMPLOYEES WHERE employee_id = 100;

-- 3- Mostrar el Numero de día de la semana y del mes de todas las fechas de contratación de los empleados
SELECT TO_CHAR(hire_date, 'D') AS day_number_of_week, TO_CHAR(hire_date, 'DD') AS day_number_of_month FROM EMPLOYEES;

-- 4-Mostrar la fecha de contratación de todos los empleados en formato dia-mes-año horas-min-seg
SELECT TO_CHAR(hire_date, 'DD/MM/YYYY HH24:MI:SS') AS hire_date_detailed FROM EMPLOYEES;

-- 5-Obtener el ultimo día del mes de la fecha de contratación de los empleados
SELECT LAST_DAY(hire_date) AS last_day_of_month FROM EMPLOYEES;

-- 6-Obtener la fecha del siguiente sabado
SELECT NEXT_DAY(sysdate, 'sábado') AS next_saturday FROM DUAL;
SELECT NEXT_DAY(TO_DATE('24/12/2025', 'DD/MM/YYYY'), 'sábado') AS next_saturday FROM DUAL;

-- 7- Añade dos meses a la fecha actual
SELECT ADD_MONTHS(sysdate, 2) AS date_plus_two_months FROM DUAL;
SELECT ADD_MONTHS(TO_DATE('24/12/2025', 'DD/MM/YYYY'), 2) AS date_plus_two_months FROM DUAL;

-- 8-AÑADE TRES MESES AL 01/08/2020 Y OBTEN EL DIA DE LA SEMANA QUE CORRESPONDA
SELECT ADD_MONTHS(sysdate, 3) AS date_plus_three_months FROM DUAL;
SELECT ADD_MONTHS(TO_DATE('24/12/2025', 'DD/MM/YYYY'),3) FROM DUAL;
SELECT 
  TO_CHAR(
    ADD_MONTHS(
      TO_DATE('24/12/2025', 'DD/MM/YYYY')
      ,3
    )
    ,'DAY'
  )
FROM DUAL;

-- 9- NUMERO DE DÍA ANUAL DEL SIGUIENTE DOMINGO
SELECT TO_CHAR(NEXT_DAY(sysdate,'domingo'),'DDD') FROM DUAL;