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
