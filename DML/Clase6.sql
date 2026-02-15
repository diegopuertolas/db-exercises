-- CLASE 6
-- Diego Puértolas Ruiz 1SW

-- MAX(), MIN(), COUNT(), SUM(), AVG()
-- COUNT(*): CUENTA EL NÚMERO DE FILAS NO NULAS
-- "ESPECIALES" -> MODIFICAN LA SENTENCIA SELECT

-- 1- MUESTRA EL SALARIO TOTAL ANUAL DE TODOS LOS EMPLEADOS
SELECT SUM(salary) AS total_annual_salary 
FROM EMPLOYEES;

-- 2-MUESTRA EL SALARIO MEDIO ANUAL DE TODOS LOS EMPLEADOS
SELECT AVG(salary) AS average_annual_salary
FROM EMPLOYEES;

-- 3-MUESTRA EL SALARIO MÁXIMO ANUAL DE TODOS LOS EMPLEADOS
SELECT MAX(salary) AS maximum_salary 
FROM EMPLOYEES;

-- 3-MUESTRA EL SALARIO MÍNIMO ANUAL DE TODOS LOS EMPLEADOS
SELECT MIN(salary) AS minimum_salary 
FROM EMPLOYEES;

-- 4-MUESTRA EL NUMERO DE SALARIOS PAGADOS A LOS EMPLEADOS
SELECT COUNT(job_id) AS number_of_salaries
FROM EMPLOYEES;

-- ¿Qué sucede si intervienen mas campos en el select?

-- 6-MOSTRAR EL GASTO EN SALARIOS POR CADA UNO DE LOS PUESTOS DE TRABAJO
SELECT job_id, SUM(salary) AS total_salary_per_job
FROM EMPLOYEES  
GROUP BY job_id;

-- 7- MUESTRA PARA CADA MANAGER_ID CUANTOS TRABAJADORES TIENE A SU CARGO
SELECT manager_id, COUNT(employee_id) AS number_of_employees
FROM EMPLOYEES
GROUP BY manager_id;

-- APLICACIÓN DE GROUP BY SIN UNA FUNCIÓN DE AGREGADO
-- 8-MUESTRA, SIN REPETIR, LOS DIFERENTES JOB_ID DE LOS EMPLEADOS
SELECT job_id 
FROM EMPLOYEES
GROUP BY job_id;

-- Otra forma de hacerlo es usando DISTINCT, que selecciona solo valores únicos. NO LO USAMOS.
SELECT DISTINCT job_id
FROM EMPLOYEES;

-- 9-MOSTRAR EL GASTO EN SALARIOS POR CADA UNO DE LOS PUESTOS DE TRABAJO Y DEPARTAMENTO
SELECT job_id, department_id, SUM(salary) AS total_salary_per_job_and_department
FROM EMPLOYEES
GROUP BY job_id, department_id;

-- 10- MOSTRAR EL NUMERO DE EMPLEADOS QUE HAN CAMBIADO DE TRABAJO EN CADA UNO DE LOS AÑOS
SELECT TO_CHAR(start_date, 'YYYY') AS year, COUNT(employee_id) AS number_of_employees_changed_job
FROM JOB_HISTORY
GROUP BY year;

-- Otra forma de hacerlo es usando EXTRACT para obtener el año directamente de la fecha.
SELECT EXTRACT(YEAR FROM start_date) AS year, COUNT(*)
FROM JOB_HISTORY
GROUP BY year;

-- 12- CALCULA LA MEDIA DEL SALARIO POR DEPARTAMENTO, UNICAMENTE PARA LOS DEPARTAMENTOS 100,120 Y 130
SELECT department_id, ROUND(AVG(salary), 2) AS average_salary
FROM EMPLOYEES
WHERE department_id IN (100, 120, 130)
GROUP BY department_id;

-- 13- MOSTRAR EL SALARIO ANUAL INVERTIDO EN EL DEPARTAMENTO 100
SELECT department_id, SUM(salary) AS total_salary
FROM EMPLOYEES
WHERE department_id = 100
GROUP BY department_id;

-- 14- MUESTRA EL SALARIO MAXIMO DE TODOS Y CADA UNO DE LOS DEPARTAMENTOS DE VENTAS.

-- Primero obtenemos los IDs de los departamentos de ventas
SELECT department_id FROM DEPARTMENTS WHERE UPPER(department_name) LIKE '%SALES%';

-- Luego usamos esos IDs para obtener el salario máximo en esos departamentos
SELECT department_id, MAX(salary) AS maximun_salary
FROM EMPLOYEES
WHERE department_id IN (80, 240, 250)
GROUP BY department_id;

-- O también se puede hacer en una sola consulta anidada
SELECT department_id, MAX(salary) AS maximun_salary
FROM EMPLOYEES
WHERE department_id IN (SELECT department_id FROM DEPARTMENTS WHERE UPPER(department_name) LIKE '%SALES%')
GROUP BY department_id;


-- 15- MUESTRA EL NUMERO DE CIUDADES CON DEPARTAMENTO QUE HAY EN CADA PAIS 
SELECT country_id, COUNT(city) AS number_of_cities
FROM LOCATIONS
GROUP BY country_id;

-- 16-MUESTRA EL NOMBRE Y APELLIDOS DEL ULTIMO EMPLEADO CONTRATADO.

-- Primero obtenemos la fecha de contratación más reciente
SELECT MAX(hire_date) FROM EMPLOYEES;

-- Luego usamos esa fecha para obtener el nombre y apellidos del empleado contratado en esa fecha
SELECT first_name, last_name 
FROM EMPLOYEES
WHERE hire_date = '21/04/08';

-- O también se puede hacer en una sola consulta anidada
SELECT first_name, last_name 
FROM EMPLOYEES
WHERE hire_date = (SELECT MAX(hire_date) FROM EMPLOYEES);

-- 17-MUESTRA EL TRABAJO CON MAS DIFERENCIA ENTRE EL SALARIO MÍNIMO Y MAXIMO

-- Primero calculamos la diferencia entre el salario máximo y mínimo para cada trabajo y nos quedamos con el mayor.
SELECT MAX(max_salary - min_salary) AS salary_difference
FROM JOBS;

-- Conociendo la diferencia máxima, obtenemos el trabajo correspondiente
SELECT job_title
FROM JOBS
WHERE (max_salary - min_salary) = 19920;

-- O también se puede hacer en una sola consulta anidada
SELECT job_title 
FROM JOBS
WHERE (max_salary - min_salary) = (SELECT MAX(max_salary - min_salary) FROM JOBS);

-- 18-MUESTRA EL SALARIO MEDIO DE LOS MANAGERS

-- Primero obtenemos el ID de manager de aquellos empleados que son managers
SELECT manager_id 
FROM EMPLOYEES
GROUP BY manager_id;

-- Conociendo los IDs de los managers, calculamos el salario medio de ellos
SELECT AVG(salary) AS average_manager_salary
FROM EMPLOYEES
WHERE manager_id IN (100,123,120,121,147,108,148,149,205,102,201,101,114,124,145,146,103,122); -- IDs de los managers obtneidos en la consulta anterior

-- O también se puede hacer en una sola consulta anidada
SELECT AVG(salary) AS average_manager_salary
FROM EMPLOYEES
WHERE manager_id IN (SELECT manager_id FROM EMPLOYEES);

-- 19-MUESTRA EL NÚMERO DE EMPLEADOS QUE NO TIENEN MANAGER

-- Usamos COUNT(*) para contar las filas donde manager es NULL
SELECT COUNT(*) AS number_of_employees_without_manager
FROM EMPLOYEES
WHERE manager_id IS NULL;

-- 20-MUESTRA EL NUMERO DE DEPARTAMENTOS QUE HAY EN CADA LOCALIZACIÓN
SELECT location_id, COUNT(*) AS number_of_departments
FROM DEPARTMENTS
GROUP BY location_id;