-- Clase 15
-- Diego Puértolas Ruiz, 1SW

-- 7-MUESTRA EL MANAGER QUE TIENE MÁS TRABAJADORES A SU CARGO.
SELECT
  M.first_name,
  M.last_name
FROM 
  EMPLOYEES M
  INNER JOIN EMPLOYEES E
  ON M.employee_id = E.manager_id
GROUP BY
  M.first_name, M.last_name
HAVING
  COUNT(*) > (
    SELECT
      MAX(COUNT(*))
    FROM
      EMPLOYEES EMP
    GROUP BY
      EMP.manager_id
  );

-- 8-MUESTRA EL NOMBRE Y APELLIDOS DE LOS EMPLEADOS DE LOS DEPARTAMENTOS, CUYO SALARIO MEDIO DEL DEPARTAMENTO ES INFERIOR A 
-- LA MEDIA, LOCALIZADOS EN EUROPA Y QUE NO TRABAJEN COMO SALES MANAGER.
SELECT
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D 
  ON EMP.department_id = D.department_id
  INNER JOIN LOCATIONS L
  ON D.location_id = L.location_id
  INNER JOIN COUNTRIES C
  ON L.country_id = C.country_id
WHERE
  -- Subconsulta para obtener los departamentos localizados en Europa, para ello
  -- obtenemos los países localizados en Europa y luego la región de esos países.
  C.country_id IN (
    SELECT
      country_id
    FROM
      COUNTRIES
    WHERE
      region_id = (
        SELECT
          region_id
        FROM
          REGIONS
        WHERE
          region_name = 'Europe'
      )
  )
AND
  D.department_id IN (
    SELECT
      department_id
    FROM
      EMPLOYEES EMP
    GROUP BY
      department_id
    HAVING
      AVG(salary) < (
        SELECT
          AVG(salary)
        FROM
          EMPLOYEES
      )
  )
AND
  EMP.job_id <> (
    SELECT
      job_id
    FROM
      JOBS
    WHERE
      job_title = 'SA_MAN'
  );

-- 9-CALCULA LOS EMPLEADOS CUYO SALARIO ESTE COMPRENDIDO ENTRE LA MEDIA DE 
-- LOS DEPARTAMENTOS SITUADOS EN EUROPA Y LOS SITUADOS EN AMÉRICA.
SELECT
  EMP.first_name,
  EMP.last_name
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
WHERE
  EMP.salary < (
    -- Subconsulta para obtener la media de los salarios de los departamentos situados en Europa.
    SELECT
      ROUND(AVG(EMP.salary), 2)
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
    WHERE
      R.region_name = 'Europe'
  ) AND EMP.salary > (
    -- Subconsulta para obtener la media de los salarios de los departamentos situados en América.
    SELECT
      ROUND(AVG(EMP.salary), 2)
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
    WHERE
      R.region_name = 'America'
  ); 

-- 10-MUESTRA A TODOS LOS EMPLEADOS QUE NO ESTÉN TRABAJANDO EN EL DEPARTAMENTO 30 Y QUE GANEN
-- MÁS QUE TODOS LOS EMPLEADOS QUE TRABAJAN EN EL DEPARTAMENTO 30.
SELECT
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
WHERE
  EMP.department_id <> 30
AND
  EMP.salary > (
    -- Subconsulta para obtener el salario máximo de los empleados que trabajan en el departamento 30.
    SELECT
      MAX(salary)
    FROM
      EMPLOYEES
    WHERE
      department_id = 30 
  );

-- 11-MUESTRA LOS EMPLEADOS QUE ESTÁN EN DEPARTAMENTOS QUE TIENEN MENOS DE 10 EMPLEADOS.
SELECT
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
WHERE
  EMP.department_id IN (
    -- Subconsulta para obtener los departamentos que tienen menos de 10 empleados.
    SELECT
      D.department_id
    FROM
      DEPARTMENTS D
      INNER JOIN EMPLOYEES EMP
      ON D.department_id = EMP.department_id
    GROUP BY
      D.department_id
    HAVING
      COUNT(*) < 10
  );
