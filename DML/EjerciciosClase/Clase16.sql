-- Clase 15
-- Diego Puértolas Ruiz, 1SW

-- 1-MUESTRA EL NOMBRE Y APELLIDOS DE LOS EMPLEADOS DE LOS DEPARTAMENTOS, 
-- CUYO SALARIO MEDIO DEL DEPARTAMENTO ES SUPERIOR AL DEPARTAMENTO QUE MENOS GASTA EN SALARIOS
SELECT 
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
  ON EMP.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY
  D.department_name, EMP.first_name, EMP.last_name
HAVING
  -- Subconsulta para calcular el salario mínimo de la media de salarios por departamento
  -- y compararlo con la media de salarios del departamento del empleado actual.
  AVG(EMP.salary) > (
    SELECT
      MIN(AVG(salary))
    FROM
      EMPLOYEES
    GROUP BY
      DEPARTMENT_ID
  ); 

-- 2-MUESTRA LOS EMPLEADOS DEL DEPARTAMENTO IT QUE HAN SIDO 
-- CONTRATADOS ANTES QUE CUALQUIERA DE LOS EMPLEADOS DEL DEPARTAMENTO SALES
SELECT
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
WHERE 
  -- Subconsulta para obtener el ID del departamento IT
  EMP.department_id = (  
    SELECT 
      D.department_id
    FROM 
      DEPARTMENTS D
    WHERE 
      D.department_name = 'IT'
  )
  AND 
  -- Subconsulta para obtener la fecha de contratación más temprana del departamento SALES y 
  -- compararla con la fecha de contratación de los empleados del departamento IT.
  EMP.hire_date < (
    SELECT 
      MIN(hire_date)
    FROM 
      EMPLOYEES EMP
    WHERE 
      -- Subconsulta para obtener el ID del departamento SALES
      EMP.department_id = (
        SELECT 
          D.department_id
        FROM 
          DEPARTMENTS D
        WHERE 
          D.department_name = 'Sales'
    )
  );