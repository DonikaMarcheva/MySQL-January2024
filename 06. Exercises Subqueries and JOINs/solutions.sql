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
    DATE(e.hire_date) > '1999-1-1'
        AND (d.name = 'Sales' OR d.name = 'Finance')
ORDER BY hire_date;

#7
SELECT 
    e.employee_id, e.first_name, p.name AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON p.project_id = ep.project_id
WHERE
    p.end_date IS NULL
        AND DATE(p.start_date) > '2002-08-13'
ORDER BY e.first_name , p.name
LIMIT 5;

#8
SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) = 2005,
        p.name = NULL,
        p.name) AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON p.project_id = ep.project_id
WHERE
    e.employee_id = 24
ORDER BY `project_name`;

#9
SELECT 
    employee_id,
    first_name,
    manager_id,
    IF(manager_id = 3,
        (SELECT 
                first_name
            FROM
                employees
            WHERE
                employee_id = 3),
        (SELECT 
                first_name
            FROM
                employees
            WHERE
                employee_id = 7)) AS manager_name
FROM
    employees
WHERE
    manager_id IN (3 , 7)
ORDER BY first_name;

#10
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    CONCAT(e1.first_name, ' ', e1.last_name) AS manager_name,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    employees AS e1 ON e1.employee_id = e.manager_id
        JOIN
    departments AS d ON d.department_id = e.department_id
ORDER BY employee_id
LIMIT 5;

#11
SELECT 
    AVG(salary) AS min_average_salary
FROM
    employees
GROUP BY department_id
ORDER BY min_average_salary
LIMIT 1;








