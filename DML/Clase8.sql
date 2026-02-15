-- Clase 8
-- Diego Puértolas Ruiz, 1SW

-- CROSS JOIN --> Producto Cartesiano.
-- No se necesita ALIAS.
SELECT nombre, variedad 
FROM FRUTAS CROSS JOIN VARIEDADES;

-- INNER JOIN 
SELECT FRUTAS.nombre, VARIEDADES.variedad
FROM FRUTAS INNER JOIN VARIEDADES ON FRUTAS.id_fruta = VARIEDADES.id_fruta;

-- NOS FIJAMOS EN LA SENTENCIA PARA DECIR CUAL ES LA DE LA IZQ Y LA DER

-- LEFT JOIN --> Le damos prioridad a la tabla de la izquierda
-- Saca la relación de todo con todo máa los datos de la tabla de la izquierda que no tengas relación.
SELECT FRUTAS.nombre, VARIEDADES.variedad
FROM FRUTAS LEFT JOIN VARIEDADES ON FRUTAS.id_fruta = VARIEDADES.id_fruta;

-- RIGHT JOIN --> Le damos prioridad a la tabla de la derecha.
SELECT FRUTAS.nombre, VARIEDADES.variedad
FROM FRUTAS RIGHT JOIN VARIEDADES ON FRUTAS.id_fruta = VARIEDADES.id_fruta;

-- FULL JOIN --> Devuelve todos los datos que tienen relación, más todos los datos de ambas tablas que no tienen relación.
SELECT FRUTAS.nombre, VARIEDADES.variedad
FROM FRUTAS FULL JOIN VARIEDADES ON FRUTAS.id_fruta = VARIEDADES.id_fruta;

-- 1. ASIGNA A TODOS LOS EMPLEADOS TODOS LOS TRABAJOS
SELECT 
  EMP.first_name, 
  EMP.last_name, 
  J.job_title
FROM EMPLOYEES EMP
  CROSS JOIN J;

-- 2. MUESTRA LOS DEPARTAMENTOS A LOS QUE PERTENECEN LOS DIFERENTES EMPLEADOS
SELECT 
  EMP.first_name, 
  EMP.last_name, 
  D.department_name
FROM EMPLOYEES EMP 
  INNER JOIN DEPARTMENTS D 
  ON E.department_id = D.department_id;

-- 3. MUESTRA LOS EMPLEADOS Y LOS TRABAJOS ANTERIORES QUE HAN TENIDO
SELECT 
    EMP.first_name, 
    EMP.last_name, 
    HIS.job_id,
    HIS.start_date,
    HIS.end_date
FROM EMPLOYEES EMP 
    LEFT JOIN JOB_HISTORY HIS
    ON EMP.employee_id = HIS.employee_id;

-- 4. --MUESTRA LOS EMPLEADOS QUE NO HAN TENIDO UN TRABAJO ANTERIOR
SELECT 
  EMP.first_name, 
  EMP.last_name, 
  HIS.job_id
FROM EMPLOYEES EMP
  LEFT JOIN JOB_HISTORY HIS
  ON EMP.employee_id = HIS.employee_id
WHERE HIS.job_id IS NOT NULL;

-- 5. COMPROBAR SI ALGUN DEPARTAMENTO NO TIENE EMPLEADOS
SELECT 
  D.department_id,
  D.department_name
FROM DEPARTMENTS D
  LEFT JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
WHERE EMP.employee_id IS NULL;

-- 6. MOSTRAR LOS EMPLEADOS SIN DEPARTAMENTO Y LOS DEPARTAMENTOS SIN EMPLEADOS
SELECT
  EMP.first_name,
  EMP.last_name,
  D.department_name
FROM EMPLOYEES EMP
  FULL JOIN DEPARTMENTS D
  ON EMP.department_id = D.department_id
WHERE EMP.employee_id IS NULL OR D.department_id IS NULL;

-- 7. MOSTRAR NOMBRE, APELLIDO, DEPARTAMENTO AL QUE PERTENECEN Y NOMBRE DEL TRABAJO REALIZADO POR TODOS LOS EMPLEADOS
SELECT
  EMP.first_name,
  EMP.last_name,
  D.department_name,
  J.job_title
FROM EMPLOYEES EMP
  INNER JOIN DEPARTMENTS D
  ON EMP.department_id = D.department_id
  INNER JOIN JOBS J
  ON EMP.job_id = J.job_id;