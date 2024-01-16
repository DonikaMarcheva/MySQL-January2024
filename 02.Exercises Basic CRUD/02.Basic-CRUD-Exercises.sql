use soft_uni;

SELECT * FROM departments
ORDER BY department_id;

SELECT 
    name
FROM
    departments
ORDER BY department_id;

SELECT first_name, last_name, salary FROM employees
ORDER BY employee_id;

SELECT first_name, middle_name, last_name FROM employees
ORDER BY employee_id;

SELECT 
    CONCAT(first_name, '.', last_name, '@softuni.bg') AS 'full_ email_address'
FROM
    employees;

SELECT DISTINCT salary FROM employees;

SELECT * FROM employees WHERE job_title='Sales Representative'
ORDER BY employee_id;

