-- Clase 12
-- Diego Puértolas Ruiz, 1SW

-- 1.MUESTRA EL NÚMERO DE EMPLEADOS A CARGO DE TODOS LOS MANAGER DE DEPARTAMENTO DE EUROPA
SELECT
  EMP.manager_id,
  COUNT(*) AS num_employees
FROM
  EMPLOYEES EMP
  LEFT JOIN DEPARTMENTS D
  ON EMP.department_id = D.department_id
  LEFT JOIN LOCATIONS L
  ON D.location_id = L.location_id
  LEFT JOIN COUNTRIES C
  ON L.country_id = C.country_id
  LEFT JOIN REGIONS R
  ON C.region_id = R.region_id
WHERE
  R.region_name = 'Europe'
GROUP BY
  EMP.manager_id;

-- 2.MUESTRA EL NUMERO DE DEPARTAMENTOS EN CADA UNA DE LAS CIUDADES
SELECT
  L.city,
  COUNT(D.department_id) AS num_departments
FROM
  LOCATIONS L
  LEFT JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
GROUP BY
  L.city;

-- 3.MUESTRA EL NUMERO DE EMPLEADOS A CARGO DE TODOS LOS MANAGER DE DEPARTAMENTO 
SELECT
  D.manager_id,
  COUNT(*) AS num_employees
FROM 
  DEPARTMENTS D
  LEFT JOIN EMPLOYEES EMP
  ON D.manager_id = EMP.manager_id
GROUP BY
  D.manager_id;

-- 4.MOSTRAR NÚMERO DE EMPLEADOS EN CADA UNA DE LAS CIUDADES
SELECT
  L.city,
  COUNT(EMP.employee_id) AS num_employees
FROM
  LOCATIONS L
  INNER JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
  INNER JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
GROUP BY
  L.city;

-- 5.MUESTRA NOMBRE DE LAS CIUDADES DE AMÉRICA QUE TENGAN MÁS DE DOS DEPARTAMENTOS
SELECT
  L.city,
FROM
  LOCATIONS L
  INNER JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
  INNER JOIN COUNTRIES C
  ON L.country_id = C.country_id
  INNER JOIN REGIONS R
  ON C.region_id = R.region_id
WHERE
  R.region_name = 'Americas'
GROUP BY
  L.city
HAVING
  COUNT(D.department_id) > 2;

-- 6.MUESTRA EL GASTO EN SALARIOS DE TODOS Y CADA UNO DE LOS DEPARTAMENTOS
SELECT 
  D.department_name,
  SUM(EMP.salary) AS total_salary
FROM
  DEPARTMENTS D
  LEFT JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
GROUP BY
  D.department_name;

-- 7.MUESTRA EL GASTO EN SALARIOS DE LAS CIUDADES DEL CONTINENTE EUROPEO
SELECT
  L.city,
  SUM(EMP.salary) AS total_salary
FROM
  LOCATIONS L
  INNER JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
  INNER JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
  INNER JOIN COUNTRIES C
  ON L.country_id = C.country_id
  INNER JOIN REGIONS R
  ON C.region_id = R.region_id
WHERE
  R.region_name = 'Europe'
GROUP BY 
  L.city;

-- 8.NOMBRE Y APELLIDOS DE LOS EMPLEADOS EUROPEOS O AMERICANOS QUE HAN TENIDO MAS DE DOS PUESTOS DE TRABAJO EN LA EMPRESA.
SELECT
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
  INNER JOIN JOB_HISTORY JH
  ON EMP.employee_id = JH.employee_id
  INNER JOIN DEPARTMENTS D
  ON EMP.department_id = D.department_id
  INNER JOIN LOCATIONS L
  ON D.location_id = L.location_id
  INNER JOIN COUNTRIES C
  ON L.country_id = C.country_id
  INNER JOIN REGIONS R
  ON C.region_id = R.region_id
WHERE
  (R.region_name = 'Europe' OR R.region_name = 'Americas')
GROUP BY
  EMP.first_name,
  EMP.last_name
HAVING
  COUNT(JH.job_id) > 2;

-- 9.MUESTRA EL NOMBRE DE LAS CIUDADES QUE NO TENGAN DEPARTAMENTO DE VENTAS (Sales). HACERLO TAMBIEN PARA FINANCE
SELECT city
FROM LOCATIONS 
WHERE location_id NOT IN (
  SELECT
    L.location_id
  FROM
    LOCATIONS L
    INNER JOIN DEPARTMENTS D
    ON L.location_id = D.location_id
  WHERE
    D.department_name = 'Sales' OR D.department_name = 'Finance'
)
GROUP BY city;

-- DIME LOS QUE NO CUMPLAN ALGO ----> OJO SUBCONSULTAS

-- CUANDO UNA CONDICION NOOOO SE DEBE CUMPLIR NO SE DEBE CUMPLIR PARA NINGUNO DE LOS CASOS
-- CUANDO UNA CONDICION DEBE CUMPLIRSE CON QUE SE CUMPLA UN CASO NOS PODRIA VALE.