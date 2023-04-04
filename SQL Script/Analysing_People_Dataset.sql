--Databases Table Overview

--Employee Table
SELECT *
FROM employees.employee
LIMIT 5;
--Title table
SELECT *
FROM employees.title
WHERE employee_id = 10005
ORDER BY from_date;
-- Salary Table
SELECT *
FROM employees.salary
WHERE employee_id = 10005
ORDER BY from_date;

--Department Employee Table

SELECT *
FROM employees.department_employee
WHERE employee_id =10005
ORDER BY from_date;

--Let's inspect the IDs which have worked in multiple departments

SELECT 
  employee_id,
  COUNT(DISTINCT department_id) AS unique_departments
FROM employees.department_employee
GROUP BY employee_id
ORDER BY unique_departments DESC
LIMIT 5;

SELECT *
FROM employees.department_employee
WHERE employee_id= 10029
ORDER BY from_date;

--Department Manager Table

SELECT *
FROM employees.department_manager
WHERE department_id = 'd004'
ORDER BY from_date;

--Department Table

SELECT *
FROM employees.department
ORDER BY id
LIMIT 10;

--Updating Tables to correct date field


-- employee
DROP TABLE IF EXISTS temp_employee;
CREATE TABLE temp_employee AS
SELECT * FROM employees.employee;

-- temp department employee
DROP TABLE IF EXISTS temp_department;
CREATE TEMP TABLE temp_department AS
SELECT * FROM employees.department;

-- temp department employee
DROP TABLE IF EXISTS temp_department_employee;
CREATE TEMP TABLE temp_department_employee AS
SELECT * FROM employees.department_employee;

-- department manager
DROP TABLE IF EXISTS temp_department_manager;
CREATE TEMP TABLE temp_department_manager AS
SELECT * FROM employees.department_manager;

-- salary
DROP TABLE IF EXISTS temp_salary;
CREATE TEMP TABLE temp_salary AS
SELECT * FROM employees.salary;

-- title
DROP TABLE IF EXISTS temp_title;
CREATE TEMP TABLE temp_title AS
SELECT * FROM employees.title;