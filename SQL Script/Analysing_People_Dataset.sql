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
CREATE TEMP TABLE temp_employee AS
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

--Updating the date columns in Temp Tables

--Updating temp_employee 

UPDATE temp_employee
SET hire_date = hire_date + INTERVAL '18 YEARS';

UPDATE temp_employee
SET birth_date = birth_date + INTERVAL '18 YEARS';


--Updating temp_department_employee

UPDATE temp_department_employee
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE temp_department_employee
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';

--Updating temp_department_manager

UPDATE temp_department_manager
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE temp_department_manager
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';

--Updating temp_salary

UPDATE temp_salary
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE temp_salary
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';


--Updating temp_title

UPDATE temp_title
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE temp_title
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';


--Check if the fileds get updated in temp table

SELECT *
FROM temp_employee
ORDER BY id
LIMIT 10;
--compare
SELECT *
FROM employees.employee
ORDER BY id
LIMIT 10;

--Option 2 : Creating new schema - adjusted_employees

DROP SCHEMA IF EXISTS adjusted_employees CASCADE;
CREATE SCHEMA adjusted_employees;

--employee
DROP TABLE IF EXISTS adjusted_employees.employee;
CREATE TABLE adjusted_employees.employee AS
SELECT * FROM employees.employee;

--department 
DROP TABLE IF EXISTS adjusted_employees.department;
CREATE TABLE adjusted_employees.department AS
SELECT * FROM employees.department;

--department_employee
DROP TABLE IF EXISTS adjusted_employees.department_employee;
CREATE TABLE adjusted_employees.department_employee AS
SELECT * FROM employees.department_employee;

--department_manager
DROP TABLE IF EXISTS adjusted_employees.department_manager;
CREATE TABLE adjusted_employees.department_manager AS
SELECT * FROM employees.department_manager;

--salary
DROP TABLE IF EXISTS adjusted_employees.salary;
CREATE TABLE adjusted_employees.salary AS
SELECT * FROM employees.salary;

--title
DROP TABLE IF EXISTS adjusted_employees.title;
CREATE TABLE adjusted_employees.title AS
SELECT * FROM employees.title;

--Updating date column in new adjusted schema

-- updating employee

UPDATE adjusted_employees.employee
SET hire_date = hire_date + INTERVAL '18 YEARS';

UPDATE adjusted_employees.employee
SET birth_date = birth_date + INTERVAL '18 YEARS';

--updating department_employee

UPDATE adjusted_employees.department_employee
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE adjusted_employees.department_employee
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';

--updating department_manager
UPDATE adjusted_employees.department_manager
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE adjusted_employees.department_manager
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';

--updating salary
UPDATE adjusted_employees.salary
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE adjusted_employees.salary
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';

--updating title
UPDATE adjusted_employees.title
SET from_date = from_date + INTERVAL '18 YEARS';

UPDATE adjusted_employees.title
SET to_date = to_date + INTERVAL '18 YEARS'
WHERE to_date <> '9999-01-01';

-- Check the updates
SELECT * FROM adjusted_employees.employee
ORDER BY id
LIMIT 10;

-- Database Views

-- creatng new schmea with views

DROP SCHEMA IF EXISTS v_employees CASCADE;
CREATE SCHEMA v_employees;

--Creating Table Views 

--department

DROP VIEW IF EXISTS v_employees.department;
CREATE VIEW v_employees.department AS
SELECT * FROM employees.department;

--employee

DROP VIEW IF EXISTS v_employees.employee;
CREATE VIEW v_employees.employee AS
SELECT 
  id,
  birth_date + INTERVAL '18 YEARS' AS birth_date,
  first_name,
  last_name,
  gender,
  hire_date + INTERVAL '18 YEARS' AS hire_date
FROM employees.employee;

-- department_employee

DROP VIEW IF EXISTS v_employees.department_employee;
CREATE VIEW v_employees.department_employee AS
SELECT 
  employee_id,
  department_id,
  from_date + interval '18 years' AS from_date,
  CASE 
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.department_employee;

-- department_manager

DROP VIEW IF EXISTS v_employees.department_manager;
CREATE VIEW v_employees.department_manager AS
SELECT 
  employee_id,
  department_id,
  from_date + interval '18 years' AS from_date,
  CASE 
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.department_manager;

-- salary

DROP VIEW IF EXISTS v_employees.salary;
CREATE VIEW v_employees.salary AS
SELECT 
  employee_id,
  amount,
  from_date + interval '18 years' AS from_date,
  CASE 
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.salary;

-- title

DROP VIEW IF EXISTS v_employees.title;
CREATE VIEW v_employees.title AS
SELECT 
  employee_id,
  title,
  from_date + interval '18 years' AS from_date,
  CASE 
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.title;


-- Let's check the salary of Georgi from new schema 

SELECT * 
FROM v_employees.salary
WHERE employee_id = '10001'
ORDER BY from_date DESC
LIMIT 5;

--Materialized View

--They ran on permanent tables
--Checking how Materialized View work on a Example table  

--creating Georgi Salary table
DROP TABLE IF EXISTS georgi_salary CASCADE;
CREATE TABLE georgi_salary AS
SELECT * FROM employees.salary
WHERE employee_id = 10001;

--creating materialized view
DROP MATERIALIZED VIEW IF EXISTS v_employees.georgi_salary_mv;
CREATE MATERIALIZED VIEW v_employees.georgi_salary_mv AS
SELECT 
  employee_id,
  amount,
  from_date + interval '18 years' AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.salary;
    
--Upsert georgy new salary in table 
UPDATE georgi_salary
SET to_date = '2003-01-01'
WHERE to_date = '9999-01-01';

INSERT INTO georgi_salary (employee_id,amount,from_date,to_date)
VALUES (10001,95000,'2003-01-01','9999-01-01');

--check updates
SELECT * FROM georgi_salary
ORDER BY from_date DESC
LIMIT 10;

--query data
SELECT * FROM v_employees.georgi_salary_mv
WHERE employee_id = 10001
ORDER BY from_date DESC
LIMIT 5;

--NOTE : need to refresh materialized view to get the updated data

--REFRESH MATERIALIZED VIEW v_employees.georgi_salary_mv; ??doubt
REFRESH MATERIALIZED VIEW v_employees.georgi_salary_mv;


--query data again to see changes
SELECT * FROM v_employees.georgi_salary_mv
WHERE employee_id = 10001
ORDER BY from_date DESC
LIMIT 10;


--Let's create a entire workflow for our dataset using materialized view

-- Create Schema

DROP SCHEMA IF EXISTS mv_employees CASCADE;
CREATE SCHEMA mv_employees;

--department

DROP MATERIALIZED VIEW IF EXISTS mv_employees.department;
CREATE MATERIALIZED VIEW  mv_employees.department AS
SELECT * FROM employees.department;

--employee

DROP MATERIALIZED VIEW IF EXISTS mv_employees.employee;
CREATE MATERIALIZED VIEW mv_employees.employee AS
SELECT 
  id,
  birth_date + interval '18 years' AS birth_date,
  first_name,
  last_name,
  gender,
  hire_date + interval '18 years' AS hire_date
FROM employees.employee;

--department_employee

DROP MATERIALIZED VIEW IF EXISTS mv_employees.department_employee;
CREATE MATERIALIZED VIEW mv_employees.department_employee AS
SELECT 
  employee_id,
  department_id,
  from_date + interval '18 years' AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.department_employee;

--department_manager

DROP MATERIALIZED VIEW IF EXISTS mv_employees.department_manager;
CREATE MATERIALIZED VIEW mv_employees.department_manager AS
SELECT 
  employee_id,
  department_id,
  from_date + interval '18 years' AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.department_manager;

--salary

DROP MATERIALIZED VIEW IF EXISTS mv_employees.salary;
CREATE MATERIALIZED VIEW mv_employees.salary AS
SELECT 
  employee_id,
  amount,
  from_date + interval '18 years' AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.salary;

--title

DROP MATERIALIZED VIEW IF EXISTS mv_employees.title;
CREATE MATERIALIZED VIEW mv_employees.title AS
SELECT 
  employee_id,
  title,
  from_date + interval '18 years' AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN to_date + interval '18 years'
    ELSE to_date
    END AS to_date
FROM employees.title;

--Comparing Methods/Optimazation

--Explain Plan

EXPLAIN SELECT * FROM employees.salary;

--check data type
SELECT 
  table_schema,
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_schema = 'employees'
AND table_name = 'salary' ;

--Explain Analyze

EXPLAIN ANALYZE SELECT * FROM employees.salary;

-- SELECT COMPARISION

EXPLAIN ANALYZE SELECT * FROM employees.salary;

EXPLAIN ANALYZE SELECT * FROM adjusted_employees.salary;

EXPLAIN ANALYZE SELECT * FROM v_employees.salary;

EXPLAIN ANALYZE SELECT * FROM mv_employees.salary;

--ADD WHERE FILTER

EXPLAIN ANALYZE SELECT * FROM employees.salary
WHERE employee_id = 10001;

EXPLAIN ANALYZE SELECT * FROM adjusted_employees.salary
WHERE employee_id = 10001;

EXPLAIN ANALYZE SELECT * FROM v_employees.salary
WHERE employee_id = 10001;

EXPLAIN ANALYZE SELECT * FROM mv_employees.salary
WHERE employee_id = 10001;

-- Create Index

CREATE INDEX ON adjusted_employees.salary(employee_id);
CREATE INDEX ON mv_employees.salary(employee_id);

EXPLAIN ANALYZE SELECT * FROM adjusted_employees.salary
WHERE employee_id = 10001;

EXPLAIN ANALYZE SELECT * FROM mv_employees.salary
WHERE employee_id = 10001;

--Table recreation to see changes after index on adjusted table and materialized view tables

--adjusted table
DROP TABLE IF EXISTS adjusted_employees.salary;
CREATE TABLE adjusted_employees.salary AS
SELECT * FROM employees.salary;

--Update salary table
UPDATE adjusted_employees.salary
SET from_date = from_date + interval '18 years';

UPDATE adjusted_employees.salary
SET to_date = to_date + interval '18 years'
WHERE to_date <> '9999-01-01';

EXPLAIN ANALYZE SELECT * FROM adjusted_employees.salary
WHERE employee_id = 10001;

--materialized view
REFRESH MATERIALIZED VIEW mv_employees.salary;

EXPLAIN ANALYZE SELECT * FROM mv_employees.salary
WHERE employee_id = 10001;


--Materialized View script
DROP SCHEMA IF EXISTS mv_employees CASCADE;
CREATE SCHEMA mv_employees;

-- department
DROP MATERIALIZED VIEW IF EXISTS mv_employees.department;
CREATE MATERIALIZED VIEW mv_employees.department AS
SELECT * FROM employees.department;


-- department employee
DROP MATERIALIZED VIEW IF EXISTS mv_employees.department_employee;
CREATE MATERIALIZED VIEW mv_employees.department_employee AS
SELECT
  employee_id,
  department_id,
  (from_date + interval '18 years')::DATE AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN (to_date + interval '18 years')::DATE
    ELSE to_date
    END AS to_date
FROM employees.department_employee;

-- department manager
DROP MATERIALIZED VIEW IF EXISTS mv_employees.department_manager;
CREATE MATERIALIZED VIEW mv_employees.department_manager AS
SELECT
  employee_id,
  department_id,
  (from_date + interval '18 years')::DATE AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN (to_date + interval '18 years')::DATE
    ELSE to_date
    END AS to_date
FROM employees.department_manager;

-- employee
DROP MATERIALIZED VIEW IF EXISTS mv_employees.employee;
CREATE MATERIALIZED VIEW mv_employees.employee AS
SELECT
  id,
  (birth_date + interval '18 years')::DATE AS birth_date,
  first_name,
  last_name,
  gender,
  (hire_date + interval '18 years')::DATE AS hire_date
FROM employees.employee;

-- salary
DROP MATERIALIZED VIEW IF EXISTS mv_employees.salary;
CREATE MATERIALIZED VIEW mv_employees.salary AS
SELECT
  employee_id,
  amount,
  (from_date + interval '18 years')::DATE AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN (to_date + interval '18 years')::DATE
    ELSE to_date
    END AS to_date
FROM employees.salary;

-- title
DROP MATERIALIZED VIEW IF EXISTS mv_employees.title;
CREATE MATERIALIZED VIEW mv_employees.title AS
SELECT
  employee_id,
  title,
  (from_date + interval '18 years')::DATE AS from_date,
  CASE
    WHEN to_date <> '9999-01-01' THEN (to_date + interval '18 years')::DATE
    ELSE to_date
    END AS to_date
FROM employees.title;

-- Index Creation
-- NOTE: we do not name the indexes as they will be given randomly upon creation!
CREATE UNIQUE INDEX ON mv_employees.employee USING btree (id);
CREATE UNIQUE INDEX ON mv_employees.department_employee USING btree (employee_id, department_id);
CREATE INDEX        ON mv_employees.department_employee USING btree (department_id);
CREATE UNIQUE INDEX ON mv_employees.department USING btree (id);
CREATE UNIQUE INDEX ON mv_employees.department USING btree (dept_name);
CREATE UNIQUE INDEX ON mv_employees.department_manager USING btree (employee_id, department_id);
CREATE INDEX        ON mv_employees.department_manager USING btree (department_id);
CREATE UNIQUE INDEX ON mv_employees.salary USING btree (employee_id, from_date);
CREATE UNIQUE INDEX ON mv_employees.title USING btree (employee_id, title, from_date);

--Current VS Historic Dataset

--Georgi’s Salary Revisited

SELECT *
FROM mv_employees.salary
WHERE employee_id = 10001
ORDER BY from_date DESC
LIMIT 5;

--What was Georgi’s starting salary at the beginning of 2009?
SELECT *
FROM mv_employees.salary
WHERE employee_id = 10001
  AND '2009-01-01' BETWEEN from_date and to_date;

--What is Georgi’s current salary?
SELECT *
FROM mv_employees.salary
WHERE employee_id = 10001
  AND CURRENT_DATE BETWEEN from_date and to_date;

--Georgi received a raise on 23rd of June in 2014 - how much of a percentage increase was it?
-- LAG method
WITH cte AS (
SELECT
  100 * (amount - LAG(AMOUNT) OVER (ORDER BY from_date))::NUMERIC /
    LAG(AMOUNT) OVER (ORDER BY from_date) AS percentage_difference
FROM mv_employees.salary
WHERE employee_id = 10001
  AND (
    from_date = '2014-06-23'
    OR to_date = '2014-06-23'
  )
)
SELECT *
FROM cte
WHERE percentage_difference IS NOT NULL;

-- Cross Join method
SELECT
  100 * (t2.after_amount - t1.before_amount) / t1.before_amount::NUMERIC AS percentage_difference
FROM
(
  SELECT
    amount AS before_amount
  FROM mv_employees.salary
  WHERE employee_id = 10001
    AND to_date = '2014-06-23'
) AS t1
CROSS JOIN
(
  SELECT
    amount AS after_amount
  FROM mv_employees.salary
  WHERE employee_id = 10001
    AND from_date = '2014-06-23'
) AS t2;

--What is the dollar amount difference between Georgi’s salary at date '2012-06-25' and '2020-06-21'

SELECT
  t2.amount_2020 - t1.amount_2012 AS dollar_difference
FROM
(
  SELECT
    amount AS amount_2012
  FROM mv_employees.salary
  WHERE employee_id = 10001
    AND '2012-06-25' BETWEEN from_date AND to_date
) AS t1
CROSS JOIN
(
  SELECT
    amount AS amount_2020
  FROM mv_employees.salary
  WHERE employee_id = 10001
    AND '2020-06-21' BETWEEN from_date AND to_date
) AS t2;

--Employee Mapping

SELECT * FROM mv_employees.employee
LIMIT 5;
--check rows per emp id
WITH id_cte AS (
SELECT
  id,
  COUNT(*) AS row_count
FROM mv_employees.employee
GROUP BY id
)
SELECT
  row_count,
  COUNT(DISTINCT id) AS employee_count
FROM id_cte
GROUP BY row_count
ORDER BY row_count;


--Valid Data points
--Salary
SELECT
  to_date,
  COUNT(*) AS record_count,
  COUNT(DISTINCT employee_id) AS employee_count
FROM mv_employees.salary
GROUP BY 1
ORDER BY 1 DESC
LIMIT 5;

SELECT
  COUNT(DISTINCT employee_id) AS distinct_count
FROM mv_employees.salary;

--For each employee who no longer has a valid salary data point - which year had the most employee churn and how many employees left that year?

WITH cte AS
(
SELECT
  employee_id,
  MAX(to_date) AS final_date
FROM mv_employees.salary
GROUP BY employee_id
)
SELECT
  EXTRACT(YEAR FROM final_date) AS churn_year,
  COUNT(*) AS employee_count
FROM cte
WHERE final_date != '9999-01-01'
GROUP BY churn_year
ORDER BY employee_count DESC;

--What is the average latest percentage and dollar amount change in salary for each employee who has a valid current salary record?
WITH lag_cte AS (
  SELECT
    employee_id,
    to_date,
    amount,
    LAG(amount) OVER (PARTITION BY employee_id ORDER BY from_date) AS previous_amount
  FROM mv_employees.salary
)
SELECT
  AVG(
    100 * (amount - previous_amount) / previous_amount::NUMERIC
  ) AS average_latest_percentage,
  AVG(amount - previous_amount) AS average_dollar_change
FROM lag_cte
-- keep only valid customers
WHERE to_date = '9999-01-01';


--Department Employee

SELECT * FROM mv_employees.department_employee LIMIT 5;

SELECT
  to_date,
  COUNT(*) AS record_count,
  COUNT(DISTINCT employee_id) AS employee_count
FROM mv_employees.department_employee
GROUP BY 1
ORDER BY 1 DESC
LIMIT 5;

SELECT
  COUNT(DISTINCT employee_id) AS distinct_count
FROM mv_employees.department_employee;


-- Title


SELECT * FROM mv_employees.title 
LIMIT 5;

SELECT 
  to_date,
  COUNT (*) AS record_count,
  COUNT (DISTINCT employee_id) AS employee_count
FROM mv_employees.title
GROUP BY 1
ORDER BY 1 DESC
LIMIT 5;

SELECT 
COUNT(DISTINCT employee_id) AS employee_count
FROM mv_employees.title
;