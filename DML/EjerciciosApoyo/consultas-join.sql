-- Ejercicios de Apoyo DML | Diego Puértolas Ruiz, 1SW

-- CONSULTAS CON JOIN

-- 1. Desarrolle una consulta que liste el nombre del empleado, el código del departamento
-- y la fecha de inicio que empezó a trabajar, ordenando el resultado por departamento y
-- por fecha de inicio, el ultimo que entro a trabajar va de primero.
SELECT
  EMP.first_name,
  EMP.department_id,
  EMP.hire_date
FROM 
  EMPLOYEES EMP
ORDER BY
  EMP.department_id,
  EMP.hire_date DESC;

-- 2. Desarrolle una consulta que liste el código, nombre y apellido de los empleados y sus
-- respectivos jefes con titulo Empleado y Jefe.
SELECT
  EMP.employee_id || ' - ' || EMP.first_name || ' ' || EMP.last_name AS employee,
  MGR.employee_id || ' - ' || MGR.first_name || ' ' || MGR.last_name AS manager
FROM 
  EMPLOYEES EMP, EMPLOYEES MGR
WHERE
  EMP.manager_id = MGR.employee_id
ORDER BY
  EMP.employee_id;

-- 3. Desarrolle una consulta que liste los países por región, los datos que debe mostrar
-- son: el código de la región y nombre de la región con los nombre se sus países.
SELECT
  R.region_id,
  R.region_name,
  C.country_name
FROM
  REGIONS R
  INNER JOIN COUNTRIES C
  ON R.region_id = C.region_id
ORDER BY
  R.region_id,
  C.country_name;

-- 4. Realice una consulta que muestre el código, nombre, apellido, inicio y fin del historial
-- de trabajo de los empleados.
SELECT
  EMP.employee_id,
  EMP.first_name,
  EMP.last_name,
  JH.start_date,
  JH.end_date
FROM
  EMPLOYEES EMP
  INNER JOIN JOB_HISTORY JH
  ON EMP.employee_id = JH.employee_id
ORDER BY
  EMP.employee_id,
  JH.start_date;
  
-- 5. Elabore una consulta que muestre el nombre y apellido del empleado con titulo
-- Empleado, el salario, porcentaje de comisión, la comisión y salario total.
SELECT
  EMP.first_name || ' ' || EMP.last_name AS employee,
  EMP.salary,
  EMP.commission_pct,
  EMP.salary * EMP.commission_pct AS commission,
  EMP.salary + (EMP.salary * EMP.commission_pct) AS total_salary
FROM
  EMPLOYEES EMP
WHERE
  EMP.commission_pct IS NOT NULL
ORDER BY
  EMP.employee_id;
