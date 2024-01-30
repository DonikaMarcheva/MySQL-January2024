SELECT 
    e.employee_id, e.job_title, e.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON a.address_id = e.address_id
ORDER BY address_id
LIMIT 5;

#2
SELECT 
    e.first_name, e.last_name, t.name AS town, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON a.address_id = e.address_id
        JOIN
    towns AS t ON t.town_id = a.town_id
ORDER BY e.first_name , e.last_name
LIMIT 5;

#3
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    departments AS d ON d.department_id = e.department_id
WHERE
    d.name = 'Sales'
ORDER BY e.employee_id DESC;

#4
SELECT 
    e.employee_id,
    e.first_name,
    e.salary,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    departments AS d ON d.department_id = e.department_id
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

#5
SELECT DISTINCT
    e.employee_id, e.first_name
FROM
    employees_projects AS e_p
        RIGHT JOIN
    employees AS e ON e_p.employee_id = e.employee_id
WHERE
    e_p.employee_id IS NULL
ORDER BY employee_id DESC
LIMIT 3;

#6
SELECT 
    e.first_name, e.last_name, e.hire_date, d.name AS dept_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    DATE(e.hire_date) > 1999 - 1 - 1
        AND (d.name = 'Sales' OR d.name = 'Finance')
ORDER BY hire_date;






