-- CLASE 7
-- Diego Puértolas Ruiz 1SW

-- Filtrado HAVING
-- Where -> Previo a agrupar
-- Having -> Posterior a agrupar

-- 1.MUESTRA DEPARTAMENTO Y EL SALARIO MEDIO SOLAMENTE DE LOS EMPLEADOS QUE COBRAN MÁS DE 8000
SELECT department_id, AVG(salary) AS average_salary
FROM EMPLOYEES
WHERE salary > 8000
GROUP BY department_id;

-- 2-MUESTRA LOS DEPARTAMENTOS Y SU SALARIO MEDIO SOLAMENTE CUANDO DICHO SALARIO MEDIO SEA MAYOR QUE 8000
SELECT department_id, AVG(salary) AS average_salary
FROM EMPLOYEES
GROUP BY department_id
HAVING AVG(salary) > 8000;

-- 3-MUESTRA LOS DEPARTAMENTOS Y SU SALARIO MEDIO PARA LOS EMPLEADOS QUE COBRAN MÁS DE 8000, SOLAMENTE CUANDO DICHO SALARIO MEDIO SEA MAYOR QUE 8000
SELECT department_id, AVG(salary) AS average_salary
FROM EMPLOYEES
WHERE salary > 8000
GROUP BY department_id
HAVING AVG(salary) > 8000;

-- 4-MOSTRAR LOS SALARIOS MAXIMOS MAYORES QUE 9000 DE LOS PUESTOS DE TRABAJO (JOB_ID) QUE NO SEAN 'SA_REP' NI 'IT_PROG'
SELECT job_id, MAX(salary) AS maximun_salary
FROM EMPLOYEES
WHERE job_id NOT IN ('SA_REP', 'IT_PROG')
GROUP BY job_id
HAVING MAX(salary) > 9000;

-- 5-MUESTRA LOS PAISES (COUNTRY_ID) QUE TIENEN DEPARTAMENTOS EN MAS DE UNA CIUDAD (CITY)
SELECT country_id, COUNT(*) AS number_of_cities
FROM LOCATIONS
GROUP BY country_id
HAVING COUNT(*) > 1;

-- Otra forma de hacerlo es no seleccionado el COUNT(*) con alias, y poniendo la función directamente en el HAVING
SELECT country_id
FROM LOCATIONS
GROUP BY country_id
HAVING COUNT(city) > 1;

-- 6-MUESTRA LOS DEPARTAMENTOS CUYO NUMERO DE PUESTOS DE TRABAJO JOB_ID SEA MAYOR QUE DOS
SELECT department_id, COUNT(job_id) AS number_of_jobs
FROM EMPLOYEES
GROUP BY department_id
HAVING COUNT(job_id) > 2;

-- Como solo nos piden mostrar los departamentos, podemos quitar el COUNT del SELECT
SELECT department_id
FROM EMPLOYEES
GROUP BY department_id
HAVING COUNT(job_id) > 2;

-- 7- CREA UNA CONSULTA QUE MUESTRE SI HAY CIUDADES DUPLICADOS 
SELECT city, COUNT(*) AS number_of_cities
FROM LOCATIONS
GROUP BY city
HAVING COUNT(*) > 1;

-- 8- CREA UNA CONSULTA QUE MUESTRE SI HAY EMPLEADOS DUPLICADOS 

-- Seleccionando el email, que debería ser único
SELECT email, COUNT(*) AS number_of_employees
FROM EMPLOYEES
GROUP BY email
HAVING COUNT(*) > 1;

-- 9-MUESTRA CUANTOS EMPLEADOS SE HAN CONTRATADO CADA AÑO
SELECT TO_CHAR(hire_date, 'YYYY') AS year, COUNT(employee_id) AS number_of_hired_employees
FROM EMPLOYEES
GROUP BY year
HAVING COUNT(employee_id) >= 1;

-- Otra manera de hacerlo es usando EXTRACT para obtener el año directamente de la fecha.
SELECT EXTRACT(YEAR FROM hire_date) AS year, COUNT(employee_id) AS number_of_hired_employees
FROM EMPLOYEES
GROUP BY year
HAVING COUNT(employee_id) >= 1;

-- 10-MUESTRA CUANTOS EMPLEADOS SE HAN CONTRATADO CADA MES DE CADA AÑO
SELECT TO_CHAR(hire_date, 'MM-YYYY') AS month_year, COUNT(employee_id) AS number_of_hired_employees
FROM EMPLOYEES
GROUP BY month_year
HAVING COUNT(employee_id) >= 1;

-- Otra manera de hacerlo es usando EXTRACT para obtener el mes y el año directamente de la fecha.
SELECT EXTRACT(MONTH FROM hire_date) AS month, EXTRACT(YEAR FROM hire_date) AS year, COUNT(employee_id) AS number_of_hired_employees
FROM EMPLOYEES
GROUP BY month, year
HAVING COUNT(employee_id) >= 1;

-- 11-¿QUÉ PASARÍA SI DOS EMPLEADOS TIENEN EL MISMO NOMBRE Y APELLIDOS?
SELECT first_name, last_name, COUNT(*) AS number_of_employees
FROM EMPLOYEES
GROUP BY first_name, last_name, employee_id -- Incluimos employee_id para que no los agrupe a todos
HAVING COUNT(*) > 1;

-- 12-¿PODEMOS APLICAR DOS FUNCIONES DE AGREGADO A LA VEZ?
SELECT MAX(COUNT(city)) AS max_number_of_cities
FROM LOCATIONS
GROUP BY country_id;