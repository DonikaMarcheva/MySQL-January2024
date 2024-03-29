use soft_uni;

SELECT 
    *
FROM
    departments
ORDER BY department_id;

SELECT 
    name
FROM
    departments
ORDER BY department_id;

SELECT 
    first_name, last_name, salary
FROM
    employees
ORDER BY employee_id;

SELECT 
    first_name, middle_name, last_name
FROM
    employees
ORDER BY employee_id;

SELECT 
    CONCAT(first_name,
            '.',
            last_name,
            '@softuni.bg') AS 'full_ email_address'
FROM
    employees;

SELECT DISTINCT
    salary
FROM
    employees;

SELECT 
    *
FROM
    employees
WHERE
    job_title = 'Sales Representative'
ORDER BY employee_id;

SELECT 
    first_name, last_name, job_title
FROM
    employees
WHERE
    salary BETWEEN 20000 AND 30000
ORDER BY employee_id;

SELECT 
    CONCAT(first_name,
            ' ',
            middle_name,
            ' ',
            last_name) AS 'Full name'
FROM
    employees
WHERE
    salary = 25000 OR salary = 14000
        OR salary = 12500
        OR salary = 23600;
        
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    manager_id IS NULL;
    
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary > 50000
ORDER BY salary DESC;

SELECT 
    first_name, last_name
FROM
    employees
ORDER BY salary DESC
LIMIT 5;

SELECT 
    first_name, last_name
FROM
    employees
    WHERE department_id != 4;
    
SELECT 
    *
FROM
    employees
ORDER BY salary DESC , first_name ASC , last_name DESC , middle_name ASC;

CREATE VIEW v_employees_salaries AS
SELECT first_name, last_name, salary
FROM employees;

CREATE VIEW v_employees_job_titles  AS
SELECT CONCAT(first_name, ' ', IF(middle_name IS NULL, '',CONCAT(middle_name, ' ')), last_name) AS full_name, job_title
FROM employees;

SELECT * FROM v_employees_job_titles;

SELECT DISTINCT job_title FROM employees
ORDER BY job_title ASC;

SELECT * FROM projects
ORDER BY start_date, name
LIMIT 10;


SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 7;

SELECT department_id, name FROM departments
WHERE name IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services');

UPDATE employees
SET salary=salary*1.12
WHERE department_id IN (1, 2, 4, 11);

SELECT salary from employees;

SELECT peak_name FROM peaks
ORDER BY peak_name;

SELECT country_name, population FROM countries
WHERE continent_code='EU'
ORDER BY population DESC, country_name
LIMIT 30;

use geography;

SELECT 
    country_name,
    country_code,
    IF(currency_code != 'EUR',
        'Not Euro',
        'Euro') AS currency
FROM
    countries
ORDER BY country_name;

SELECT name FROM characters
ORDER BY name;

