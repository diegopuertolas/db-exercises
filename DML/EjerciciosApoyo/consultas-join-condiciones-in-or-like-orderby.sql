-- Ejercicios de Apoyo DML | Diego Puértolas Ruiz, 1SW

-- CONSULTAS CON JOIN Y CONDICIONES IN, OR, LIKE Y ORDER BY

-- 11. Desarrolle una consulta que muestre el salario promedio de los empleados de los departamentos 30 y 80.
SELECT
  D.department_name,
  ROUND(AVG(E.salary), 2) AS average_salary
FROM
  DEPARTMENTS D
  INNER JOIN EMPLOYEES E
  ON D.department_id = E.department_id
WHERE
  D.department_id IN (30, 80)
GROUP BY
  D.department_name;

