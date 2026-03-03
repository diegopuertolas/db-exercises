-- Ejercicios de Apoyo DML | Diego Puértolas Ruiz, 1SW

-- SUBCONSULTAS

-- 34. Desarrolle una consulta que liste el apellido, el nombre y salario del empleado con el
-- salario mayor de los todos los departamentos.
SELECT 
  EMP.first_name,
  EMP.last_name,
  EMP.salary
FROM 
  EMPLOYEES EMP
WHERE
  EMP.salary = (
    SELECT
      MAX(EMP2.salary)
    FROM
      EMPLOYEES EMP2
  );

-- 35. Desarrolle una consulta que muestre código de departamento, el nombre y apellido de
-- los empleados de únicamente de los departamentos en donde existen empleados con
-- nombre ‘Jonh’.
SELECT
  D.department_id,
  EMP.first_name,
  EMP.last_name
FROM 
  EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
  ON EMP.department_id = D.department_id
WHERE
  D.department_id IN (
    SELECT
      D.department_id
    FROM 
      DEPARTMENTS D
      INNER JOIN EMPLOYEES EMP
      ON D.department_id = EMP.department_id
    WHERE
      EMP.first_name = 'John'
  );

-- 36. Desarrolle una consulta que liste el código de departamento, nombre, apellido y salario
-- de únicamente los empleados con máximo salario en cada departamento.
SELECT
  EMP.department_id,
  EMP.first_name,
  EMP.last_name,
  EMP.salary
FROM
  EMPLOYEES EMP
WHERE
  EMP.salary = (
    SELECT
      MAX(EMP2.salary)
    FROM
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = EMP.department_id
  );

-- 37. Elabore una consulta que muestre el código del departamento, el nombre de
-- departamento y el salario máximo de cada departamento.
SELECT
  D.department_id,
  D.department_name,
  (
    SELECT
      MAX(EMP2.salary)
    FROM 
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = D.department_id
  )
FROM 
  DEPARTMENTS D;

-- Para que no muestre los departamentos sin empleados:
SELECT
  D.department_id,
  D.department_name,
  EMP.salary
FROM
  DEPARTMENTS D
  INNER JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
WHERE
  EMP.salary = (
    SELECT
      MAX(EMP2.salary)
    FROM 
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = D.department_id
  );

-- 38. Encuentra todos los registros en la tabla empleados que contengan un valor que
-- ocurre dos veces en una columna dada.
SELECT
  *
FROM 
  EMPLOYEES EMP
WHERE
  2 = (
    SELECT
      COUNT(*)
    FROM 
      EMPLOYEES EMP2
    WHERE
      EMP2.salary = EMP.salary -- Aquí se puede cambiar por cualquier otra columna, como el nombre, el apellido, etc.
  );

-- 39. Realice una consulta que liste los empleados que están en departamentos que tienen
-- menos de 10 empleados.
SELECT
  EMP.first_name,
  EMP.last_name
FROM 
  EMPLOYEES EMP
WHERE
  (
    SELECT
      COUNT(*)
    FROM
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = EMP.department_id
  ) < 10;

-- Otra forma de hacerlo, sería seleccionar directamente los departamentos con menos de 10 empleados.
SELECT
  EMP.first_name,
  EMP.last_name
FROM 
  EMPLOYEES EMP
WHERE
  EMP.department_id IN (
    SELECT
      department_id
    FROM
      EMPLOYEES EMP2
    GROUP BY
      department_id
    HAVING
      COUNT(*) < 10
  ); -- Devolverá 27 ya que no cuenta las personas que tienen el department_id nulo.

-- 40. Desarrolle una consulta que muestre el mayor salario entre los empleados que
-- trabajan en el departamento 30 (department_id) y que empleados ganan ese salario.
SELECT
  EMP.first_name,
  EMP.last_name,
  EMP.salary
FROM
  EMPLOYEES EMP
WHERE
  EMP.department_id = 30
  AND
  EMP.salary = (
    SELECT
      MAX(salary)
    FROM
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = 30 
  );

-- 41. Elabore una consulta que muestre los departamentos en donde no exista ningún empleado.
SELECT
  D.department_id,
  D.department_name
FROM
  DEPARTMENTS D
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM
      EMPLOYEES EMP
    WHERE
      EMP.department_id = D.department_id
  )

-- 42. Desarrolle una consulta que muestre a todos los empleados que no estén trabajando
-- en el departamento 30 y que ganen más que todos los empleados que trabajan en el
-- departamento 30.
SELECT
  EMP.first_name,
  EMP.last_name,
  EMP.salary
FROM
  EMPLOYEES EMP
WHERE
  EMP.department_id <> 30
  AND
  EMP.salary > (
    SELECT
      MAX(EMP2.salary) 
    FROM
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = 30
  );

-- 43. Realice una consulta que muestre los empleados que son gerentes (manager_id) y el
-- número de empleados subordinados a cada uno, ordenados descendentemente por
-- número de subordinado. Excluya a los gerentes que tienen 5 empleados subordinados
-- o menos.
SELECT
  EMP.first_name,
  EMP.last_name,
  -- Subconsulta para contar el número de empleados subordinados a cada gerente
  ( 
    SELECT
      COUNT(*)
    FROM 
      EMPLOYEES EMP2
    WHERE
      EMP2.manager_id = EMP.manager_id
  ) AS num_subordinados
FROM
  EMPLOYEES EMP
WHERE
  EMP.manager_id IS NOT NULL -- Para asegurarnos de que solo seleccionamos a los gerentes
  AND
  (
    SELECT
      COUNT(*)
    FROM 
      EMPLOYEES EMP2
    WHERE
      EMP2.manager_id = EMP.manager_id
  ) > 5 -- Excluimos a los gerentes con 5 o menos subordinados
ORDER BY
  (
    SELECT
      COUNT(*)
    FROM 
      EMPLOYEES EMP2
    WHERE
      EMP2.manager_id = EMP.manager_id
  ) DESC; -- Ordenamos descendentemente por número de subordinados

-- 44. Desarrolle una consulta donde muestre el código de empleado , el apellido, salario,
-- nombre de región, nombre de país, estado de la provincia , código de departamento,
-- nombre de departamento donde cumpla las siguientes condiciones :
-- • Que los empleados que seleccione su salario sea mayor al promedio de su
-- departamento.
-- • Que no seleccione los del estado de la provincia de Texas
-- • Que ordene la información por código de empleado ascendentemente.
-- • Que no escoja los del departamento de finanzas (Finance)
SELECT
  EMP.employee_id,
  EMP.first_name,
  EMP.last_name,
  EMP.salary,
  R.region_name,
  C.country_name,
  L.state_province,
  D.department_id,
  D.department_name
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
  EMP.salary > (
    SELECT
      AVG(EMP2.salary)
    FROM
      EMPLOYEES EMP2
    WHERE
      EMP2.department_id = EMP.department_id
  )
  AND
  L.state_province <> 'Texas'
  AND
  D.department_name <> 'Finance'
ORDER BY
  EMP.employee_id ASC;
