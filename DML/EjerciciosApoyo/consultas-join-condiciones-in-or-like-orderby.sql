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

-- 12. Desarrolle una consulta que muestre el nombre de la región, el nombre del país, el
-- estado de la provincia, el código de los empleados que son manager, el nombre y
-- apellido del empleado que es manager de los países del reino Unido (UK), Estados
-- Unidos de América (US), respectivamente de los estados de la provincia de
-- Washington y Oxford.

SELECT 
  R.region_name,
  C.country_name,
  L.state_province,
  E.employee_id,
  E.first_name,
  E.last_name
FROM
  REGIONS R
  INNER JOIN COUNTRIES C 
  ON R.region_id = C.region_id
  INNER JOIN LOCATIONS L 
  ON C.country_id = L.country_id
  INNER JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
  INNER JOIN EMPLOYEES E 
  ON D.manager_id = E.employee_id
WHERE
  C.country_name IN ('United Kingdom', 'United States of America')
  AND L.state_province IN ('Washington', 'Oxford');

-- 13. Realice una consulta que muestre el nombre y apellido de los empleados que trabajan
-- para departamentos que están localizados en países cuyo nombre comienza con la
-- letra C, que muestre el nombre del país.
SELECT
  E.first_name,
  E.last_name,
  C.country_name
FROM
  EMPLOYEES E
  INNER JOIN DEPARTMENTS D
  ON E.department_id = D.department_id
  INNER JOIN LOCATIONS L
  ON D.location_id = L.location_id
  INNER JOIN COUNTRIES C
  ON L.country_id = C.country_id
WHERE
  C.country_name LIKE 'C%';