-- Clase 7 PLSQL
-- Diego Puértolas Ruiz 1SW

-- 1-Crea un procedimiento almacenado que reciba un parámetro de entrada en forma 
-- de identificador de empleado y muestre por pantalla su nombre, apellidos, departamento y salario.
CREATE OR REPLACE PROCEDURE OBTENER_INFO_EMPLEADO(p_employee_id IN EMPLOYEES.employee_id%TYPE)
AS
  v_first_name EMPLOYEES.first_name%TYPE;
  v_last_name EMPLOYEES.last_name%TYPE;
  v_department_id EMPLOYEES.department_id%TYPE;
  v_salary EMPLOYEES.salary%TYPE;
BEGIN
  SELECT first_name, last_name, department_id, salary INTO v_first_name, v_last_name, v_department_id, v_salary
  FROM EMPLOYEES
  WHERE employee_id = p_employee_id;
  DBMS_OUTPUT.PUT_LINE('Empleado: ' || v_first_name || ' ' || v_last_name);
  DBMS_OUTPUT.PUT_LINE('Departamento ID: ' || v_department_id);
  DBMS_OUTPUT.PUT_LINE('Salario: ' || v_salary);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró ningún empleado con ID ' || p_employee_id);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al obtener la información del empleado: ' || SQLERRM);
END;

EXECUTE OBTENER_INFO_EMPLEADO(101);

-- 2-Crea un procedimiento almacenado que reciba un parámetro de entrada en forma de 
-- identificador de departamento y a través de un parámetro de salida, 
-- retorne el salario medio de dicho departamento mostrándolo por pantalla 
-- fuera del procedimiento.
CREATE OR REPLACE PROCEDURE OBTENER_SALARIO_MEDIO_DPTO(p_department_id IN DEPARTMENTS.department_id%TYPE, p_avg_salary OUT NUMBER)
AS
BEGIN
  SELECT AVG(salary) INTO p_avg_salary
  FROM EMPLOYEES
  WHERE department_id = p_department_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontraron empleados en el departamento ' || p_department_id);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al calcular el salario medio: ' || SQLERRM);
    ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
DECLARE
  avg_salary NUMBER;
BEGIN
  OBTENER_SALARIO_MEDIO_DPTO(10, avg_salary);
  DBMS_OUTPUT.PUT_LINE('El salario medio del departamento 10 es: ' || avg_salary);
END;
/

/*
3-Realiza un procedimiento almacenado que nos permita registrar clientes en una 
tabla, comprobando que el ID_CLIENTE no se repita. En caso que se repita el 
procedimiento actualizará el ID con el adecuado que corresponda y deberá 
retornar el ID usado.
Pasos:
	1-Creamos una tabla para trabajar.
		-Nombre tabla: CLIENTES
		-Campos:
			-ID_CLIENTE numérico
			-Nombre tipo texto(40)
			-Apellidos tipo texto(100)
	2-Definimos el procedimiento con los siguientes parámetros:
			-ID de entrada y salida
			-Nombre de entrada
			-Apellido de entrada
	3-Dentro del procedimiento:
            1º Ver si existe el ID recibido. Te recomiendo que esto lo guardes en una variable
            2º SI existe el ID, busca el mayor ID y súmale una unidad. El ID usado deberá ser el parámetro que retorne el procedimiento.
            3º Ahora con el nuevo ID realiza el insert en la tabla.
*/
CREATE TABLE CLIENTES (
  id_cliente NUMBER,
  nombre VARCHAR2(40),
  apellidos VARCHAR2(100)
);

CREATE OR REPLACE PROCEDURE REGISTRAR_CLIENTE(p_id_cliente IN OUT NUMBER, p_nombre IN VARCHAR2, p_apellidos IN VARCHAR2)
AS
  v_id_exists NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_id_exists
  FROM CLIENTES
  WHERE id_cliente = p_id_cliente;

  IF v_id_exists > 0 THEN
    SELECT MAX(id_cliente) + 1 INTO p_id_cliente
    FROM CLIENTES;
  END IF;

  INSERT INTO CLIENTES (id_cliente, nombre, apellidos)
  VALUES (p_id_cliente, p_nombre, p_apellidos);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al registrar el cliente: ' || SQLERRM);
    ROLLBACK;
END;

/
DECLARE
    ID_CLI NUMBER;
BEGIN
    ID_CLI:=1;
    REGISTRAR_CLIENTE(ID_CLI,'Diego','Puértolas Ruiz');
    DBMS_OUTPUT.PUT_LINE('El ID_CLIENTE final insertado es: ' || TO_CHAR(ID_CLI));
END;
/

SELECT * FROM CLIENTES;