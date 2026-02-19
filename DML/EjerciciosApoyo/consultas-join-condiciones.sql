-- Ejercicios de Apoyo DML | Diego Puértolas Ruiz, 1SW

-- CONSULTAS CON JOIN Y CONDICIONES

-- 6. Elabore una consulta que liste nombre del trabajo y el salario de los empleados que
-- son manager, cuyo código es 100 o 125 y cuyo salario sea mayor de 6000.
SELECT
  J.job_title,
  EMP.salary
FROM
  EMPLOYEES EMP
  INNER JOIN JOBS J
  ON EMP.job_id = J.job_id
WHERE
  EMP.manager_id IN (100, 125)
  AND EMP.salary > 6000
ORDER BY
  EMP.employee_id;

-- 7. Desarrolle una consulta que liste el código de la localidad, la ciudad y el nombre del
-- departamento de únicamente de los que se encuentran fuera de estados unidos (US).
SELECT
  L.location_id,
  L.city,
  D.department_name
FROM
  LOCATIONS L
  INNER JOIN DEPARTMENTS D
  ON L.location_id = D.location_id
  INNER JOIN COUNTRIES C
  ON L.country_id = C.country_id
WHERE
  C.country_id <> 'US'
ORDER BY
  L.location_id;

-- 8. Realice una consulta que muestres el código de la región, nombre de la región y el
-- nombre de los países que se encuentran en “Asia”.
SELECT
  R.region_id,
  R.region_name,
  C.country_name
FROM
  REGIONS R
  INNER JOIN COUNTRIES C
  ON R.region_id = C.region_id
WHERE
  R.region_name = 'Asia'
ORDER BY
  R.region_id,
  C.country_name;

-- 9. Elabore una consulta que liste el código de la región y nombre de la región, código de
-- la localidad, la ciudad, código del país y nombre del país, de solamente de las
-- localidades mayores a 2400.
SELECT
  R.region_id,
  R.region_name,
  L.location_id,
  L.city,
  C.country_id,
  C.country_name
FROM
  REGIONS R
  INNER JOIN COUNTRIES C
  ON R.region_id = C.region_id
  INNER JOIN LOCATIONS L
  ON C.country_id = L.country_id
WHERE
  L.location_id > 2400
ORDER BY
  R.region_id,
  L.location_id;

-- 10. Desarrolle una consulta donde muestre el código de región con un alias de Región, el
-- nombre de la región con una etiqueta Nombre Región , que muestre una cadena string
-- (concatenación) que diga la siguiente frase “Código País: CA Nombre: Canadá “,CA es
-- el código de país y Canadá es el nombre del país con etiqueta País, el código de
-- localización con etiqueta Localización , la dirección de calle con etiqueta Dirección y el
-- código postal con etiqueta “Código Postal”, esto a su vez no deben aparecer código
-- postal que sean nulos.
SELECT
  R.region_id AS "Región",
  R.region_name AS "Nombre Región",
  'Código País: ' || C.country_id || ' Nombre: ' || C.country_name AS "País",
  L.location_id AS "Localización",
  L.street_address AS "Dirección",
  L.postal_code AS "Código Postal"
FROM
  REGIONS R
  INNER JOIN COUNTRIES C
  ON R.region_id = C.region_id
  INNER JOIN LOCATIONS L
  ON C.country_id = L.country_id
WHERE
  L.postal_code IS NOT NULL
ORDER BY
  R.region_id,
  C.country_id,
  L.location_id;

