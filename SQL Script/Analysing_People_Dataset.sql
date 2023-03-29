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