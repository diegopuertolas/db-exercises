-- CLASE 3
-- Diego Puértolas Ruiz 1SW

-- 1-MUESTRA EL NOMBRE Y APELLIDO DE LOS USUARIOS CUYO SALARIO SEA 10000, 7000 O 8000.
SELECT first_name, last_name FROM EMPLOYEES WHERE salary IN (7000, 8000, 10000);
SELECT first_name, last_name FROM EMPLOYEES WHERE salary = 7000 OR salary = 8000 OR salary = 10000;

-- 2-MUESTRA EL NOMBRE Y APELLIDO DE LOS USUARIOS CUYO NOMBRE SEA 'PETER' U 'OLIVER'
SELECT first_name, last_name FROM EMPLOYEES WHERE first_name IN ('Peter', 'Oliver');
SELECT first_name, last_name FROM EMPLOYEES WHERE first_name = 'Peter' OR first_name = 'Oliver';

-- 3-Muestra todos los empleados cuyo nombre comience por la letra P
SELECT first_name, last_name FROM EMPLOYEES WHERE first_name LIKE 'P%';

-- 4-Muestra todos los empleados cuyo nombre CONTENGA LA CADENA 'NA'; 
SELECT first_name, last_name FROM EMPLOYEES WHERE UPPER (first_name) LIKE '%NA%';

-- 5-Buscar el identificador de los empleados cuyo identificador de trabajo comience 'MK' y hayan trabajado entre los años 2001 y 2007 en la empresa.
SELECT employee_id FROM EMPLOYEES WHERE UPPER (job_id) LIKE 'MK%' AND hire_date BETWEEN '1/1/2001' AND '31/12/2007';

-- 6- MUESTRA CONCATENADO EL NOMBRE Y APELIDOS, SEPARADOS POR UN GUIÓN, Y AÑADE LA FECHA DE CONTRATACIÓN SEPARADA POR /
SELECT first_name || '-' || last_name || '/' || hire_date AS employee_info FROM EMPLOYEES;

-- 7- MUESTRA NOMBRE Y APELLIDOS DE LOS EMPLEADOS, ASÍ COMO LA LONG DE LA CONCATENACIÓN DE ESTOS.
SELECT first_name, last_name, LENGTH(first_name || last_name) LON FROM EMPLOYEES;

-- 8-CREA UN CÓDIGO COMPUESTO POR LA CONCATENACION DE LAS INICIALES DEL NOMBRE Y APELLIDOS, ASÍ COMO LA FECHA DE CONTRATACIÓN.
SELECT SUBSTR(first_name,1, 1) || SUBSTR(last_name, 1 , 1) || hire_date AS compound_code FROM EMPLOYEES;