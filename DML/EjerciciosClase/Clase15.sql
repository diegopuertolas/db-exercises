-- Clase 15
-- Diego Puértolas Ruiz, 1SW

-- 1. BUSCAR LOS COMPAÑEROS DE DEPARTAMENTO DE AMIT BANDA ( SUPONEMOS QUE UN EMPELADO 
-- SOLO PUEDE TRABAJAR EN UN DEPARTAMENTO, DE LO CONTRARIO CAMBIAMOS = POR IN)
SELECT 
  EMP.first_name,
  EMP.last_name,
FROM 
  EMPLOYEES EMP
WHERE
  EMP.DEPARTMENT_ID = (
    SELECT 
      department_id
    FROM 
      EMPLOYEES
    WHERE
      first_name = 'Amit' AND last_name = 'Banda'
  );

-- 2. MUESTRA TODOS LOS EMPLEADOS QUE GANAN MENOS QUE AMIT BANDA
SELECT 
  EMP.first_name,
  EMP.last_name,
  EMP.salary
FROM 
  EMPLOYEES EMP
WHERE
  EMP.salary < (
    SELECT 
      salary
    FROM 
      EMPLOYEES
    WHERE
      first_name = 'Amit' AND last_name = 'Banda'
  );

-- 3. MUESTRA TODOS LOS EMPLEADOS QUE NO PERTENECEN AL DEPARTAMENTO DE AMIT BANDA
SELECT
  EMP.first_name,
  EMP.last_name
FROM
  EMPLOYEES EMP
WHERE
  EMP.DEPARTMENT_ID <> (
    SELECT 
      department_id
    FROM 
      EMPLOYEES
    WHERE
      first_name = 'Amit' AND last_name = 'Banda'
  );

-- 4. MOSTRAR LOS EMPLEADOS QUE COBRAN MÁS QUE EL EMPLEADO QUE MENOS COBRA DEL DEPARTAMENTO 80 O 100
SELECT 
  EMP.first_name,
  EMP.last_name,
  EMP.salary
FROM 
  EMPLOYEES EMP
WHERE
  EMP.salary > (
    SELECT 
      MIN(salary)
    FROM 
      EMPLOYEES
    WHERE
      DEPARTMENT_ID IN (80, 100)
  );

-- 5. MOSTRAR LOS EMPLEADOS MÁS ANTIGUOS QUE EL JEFE DEL DEPARTAMENTO DE VENTAS(SALES)
SELECT
  EMP.first_name,
  EMP.last_name,
  EMP.hire_date
FROM
  EMPLOYEES EMP
WHERE
  EMP.hire_date < (
    SELECT
      EMP.hire_date
    FROM
      EMPLOYEES EMP
      INNER JOIN DEPARTMENTS D
      ON EMP.employee_id = D.manager_id
    WHERE
      D.department_name = ('Sales')
  );

-- 6. MOSTRAR EL DEPARTAMENTO QUE TENGA MÁS EMPLEADOS QUE LA MEDIA DE EMPLEADOS POR DEPARTAMENTO
SELECT
  D.deparment_name,
  COUNT(E.employee_id) AS num_employees
FROM
  DEPARTMENTS D
  INNER JOIN EMPLOYEES E
  ON D.department_id = E.department_id
GROUP BY
  D.department_name
HAVING
  COUNT(E.employee_id) > (
    SELECT
      AVG(COUNT(*))
    FROM 
      EMPLOYEES
    GROUP BY
      department_id
  );  

-- 7.MOSTRAR EL DEPARTAMENTO QUE TENGA MÁS PUESTOS DE TRABAJO (JOBS) QUE EL DEPARTAMENTO IT
SELECT 
  D.department_name, 
  COUNT(EMP.employee_id) AS num_employees
FROM 
  DEPARTMENTS D
  INNER JOIN EMPLOYEES EMP
  ON D.department_id = EMP.department_id
GROUP BY 
  D.department_name
HAVING 
  COUNT(EMP.employee_id) > (
    SELECT 
      COUNT(EMP2.employee_id)
    FROM 
      EMPLOYEES EMP2
    INNER JOIN DEPARTMENTS D2 
    ON EMP2.department_id = D2.department_id
    WHERE D2.department_name = 'IT'
);