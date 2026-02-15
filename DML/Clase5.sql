-- CLASE 5
-- Diego Puértolas Ruiz 1SW

-- 1- EXTRAER EL MES DE LA FECHA DE CONTRATACIÓN DEL EMPLEADO CON ID=100;
-- Usamos la función TO_CHAR() para convertir la fecha en un formato específico.
SELECT TO_CHAR(hire_date, 'MM') AS hire_month FROM EMPLOYEES WHERE employee_id = 100;

-- 2- MUESTRA TODOS LOS EMPLEADOS CONTRATADOS EN EL MES DE MAYO DE 2007;
-- Usamos la función TO_CHAR() para convertir la fecha en un formato específico y filtramos por '05-2007'.
SELECT employee_id, first_name, last_name, hire_date
FROM EMPLOYEES
WHERE TO_CHAR(hire_date, 'MM-YYYY') = '05-2007';

-- 3- CREAR UN CODIGO CONCATENANDO LAS INICIALES DEL NOMBRE Y APELLIDO DEL EMPLEADO CON EL AÑO DE CONTRATACIÓN;
-- Usamos la función SUBSTR() para obtener las iniciales y TO_CHAR() para obtener el año.
SELECT SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) || TO_CHAR(hire_date, 'YYYY') AS employee_code 
FROM EMPLOYEES;

-- 4- REPLICA EL CÓDIGO ANTERIOR COMPLETANDO CON CEROS A LA DERECHA HASTA CONSEGUIR UN CÓDIGO DE 10 CARÁCTERES
-- Usamos la función RPAD(), para rellenar con ceros a la derecha.
SELECT RPAD(SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) || TO_CHAR(hire_date, 'YYYY'), 10, '0') AS employee_code
FROM EMPLOYEES;

-- 5- MOSTRAR EL NOMBRE, APELLIDOS, SALARIO Y 11% SALARIO (REDONDEAR A 1 DECIMAL)
-- Redondear significa aproximar al número más cercano, usamos la función ROUND().
SELECT first_name, last_name, salary, ROUND(salary * 0.11, 1) AS eleven_porcent_salary
FROM EMPLOYEES;

-- 6-MOSTRAR EL NOMBRE, APELLIDOS, SALARIO Y 11% SALARIO (TRUNCAR A 1 DECIMAL)
-- Trucar significa cortar sin redondear, usamos la función TRUNC().
SELECT first_name, last_name, salary, TRUNC(salary * 0.11, 1) AS eleven_porcent_salary
FROM EMPLOYEES;

-- 7-CALCULA LA RESTA EN VALOR ABSOLUTO DE 5-8
-- Usamos la función ABS() para obtener el valor absoluto.
SELECT ABS(5 - 8) AS absolute_subtraction FROM DUAL;

-- 8-CALCULA EL TIEMPO QUE LLEVAN LOS EMPLEADOS EN SU PUESTO DE TRABAJO ACTUAL
-- Usamos SYSDATE para obtener la fecha actual y restamos la fecha de contratación.
SELECT first_name, last_name, hire_date, SYSDATE - hire_date AS days_in_position
FROM EMPLOYEES;

-- Ahora vamos a ordenar el resultado de más días a menos.
-- Para ello usamos ORDER BY con DESC para orden descendente, es decir, de mayor a menor.
SELECT first_name, last_name, hire_date, SYSDATE - hire_date AS days_in_position 
FROM EMPLOYEES
ORDER BY days_in_position DESC;

-- 9-MOSTRAR LOS EMPLEADOS CON UN SALARIO QUE DIFIERA DE 10000$ EN MENOS DE 1000$
-- Usamos la cláusula BETWEEN para filtrar los salarios dentro del rango especificado.
SELECT first_name, last_name, salary 
FROM EMPLOYEES
WHERE salary BETWEEN 9000 AND 11000 AND salary <> 10000;

-- 10-RESTAMOS LA FECHA DEL SISTEMA MENOS LA FECHA 27/01/2001
-- Usamos SYSDATE para obtener la fecha actual y TO_DATE() para convertir la cadena a fecha.
SELECT SYSDATE - TO_DATE('27-01-2001', 'DD-MM-YYYY') AS days_difference FROM DUAL;

