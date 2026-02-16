-- Ejercicios de Apoyo DML | Diego Puértolas Ruiz, 1SW

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