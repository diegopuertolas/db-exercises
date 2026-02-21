-- Clase 14 - Subconsultas
-- Diego Puértolas Ruiz, 1SW

-- 1-MUESTRA EL NOMBRE DE DEPARTAMENTO Y EL SALARIO MÁS ALTO DE LOS EMPLEADOS DE CADA DEPARTAMENTO.
SELECT 
  D.department_name, 
  MAX(E.salary) AS max_salary
FROM 
  DEPARTMENTS D
  INNER JOIN employees E 
  ON D.department_id = E.department_id
GROUP BY D.department_name;

-- Usando subconsulta:
SELECT
  D.department_name,
  EMP.salary
FROM 
  DEPARTMENTS D
  INNER JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
WHERE
  EMP.salary = (
    SELECT 
      MAX(salary)
    FROM 
      EMPLOYEES EMP2
    WHERE 
      EMP.department_id = EMP2.department_id
  );

-- 2-Muestra el nombre y apellidos de los empleados que tengan un salario superior a la media.
SELECT 
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
WHERE
  EMP.salary > (
    SELECT 
      AVG(salary)
    FROM
      EMPLOYEES
  );

-- 3-MUESTRA EL NOMBRE DEL DEPARTAMENTO QUE NO TIENE EMPLEADOS CON NINGÚN TRABAJO IT
SELECT
  D.department_name
FROM
  DEPARTMENTS D
  LEFT JOIN EMPLOYEES EMP -- LEFT JOIN para mostrar departamentos sin empleados.
  ON D.department_id = EMP.department_id
WHERE
  EMP.employee_id NOT IN (
    SELECT 
      employee_id
    FROM 
      EMPLOYEES 
    WHERE 
      job_id LIKE '%IT%'
  ) OR EMP.employee_id IS NULL
GROUP BY 
  D.department_name;

-- 4-MUESTRA EL NOMBRE DE LA CIUDAD QUE TIENE EL MAYOR NUMERO DE DEPARTAMENTOS.
SELECT
  L.city
FROM
  LOCATIONS L
  INNER JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
GROUP BY
  L.city
HAVING
  COUNT(*) = (
    SELECT 
      MAX(COUNT(*))
    FROM
      DEPARTMENTS
    GROUP BY 
      location_id
  );

-- 5-MUESTRA EL NOMBRE DE LOS TRABAJOS QUE NUNCA SE HAN REALIZADO ANTERIORMENTE POR OTRAS PERSONAS.
SELECT
  J.job_title
FROM 
  JOBS J
WHERE
  J.job_id NOT IN (
    SELECT
      job_id
    FROM 
      JOB_HISTORY
  );

