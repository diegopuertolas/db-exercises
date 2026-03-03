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
      MAX(salary)
    FROM
      EMPLOYEES
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
      MAX(salary)
    FROM
      EMPLOYEES
    WHERE
      department_id = EMP.department_id
  );