SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

SELECT first_name
FROM employees
WHERE department_id IN(3,10) AND
YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

SELECT name
FROM towns
WHERE length(name) =5 OR length(name)=6
ORDER BY name;

SELECT *
FROM towns
WHERE name LIKE 'M%' OR name LIKE 'K%' OR name LIKE 'B%' OR name LIKE 'E%'
ORDER BY name;

/* other solution of 6  */
SELECT *
FROM towns
WHERE left(name,1) in ('M','K','B','E')
ORDER BY name;

SELECT *
FROM towns
WHERE name NOT LIKE 'R%' AND name NOT LIKE 'B%' AND name NOT LIKE 'D%'
ORDER BY name;

/* other solution of 7 */
SELECT *
FROM towns
WHERE left(name,1) NOT IN ('R','B','D')
ORDER BY name;


CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name 
FROM employees
WHERE year(hire_date)>2000;

SELECT * FROM v_employees_hired_after_2000;

SELECT first_name, last_name
FROM employees
WHERE length(last_name) = 5;

use geography;

SELECT country_name, iso_code
FROM countries
WHERE country_name LIKE '%A%A%A%'
ORDER BY iso_code;

SELECT peak_name, river_name,
CONCAT(LOWER(peak_name), SUBSTR(LOWER(river_name),2)) AS mix
FROM peaks, rivers
WHERE right(peak_name,1)=left(river_name,1)
ORDER BY mix;

USE diablo;

SELECT name, date_format(start,'%Y-%m-%d') AS start
FROM games
WHERE year(start) in(2011, 2012)
ORDER BY start, name
LIMIT 50;

SELECT user_name, substring(email,LOCATE('@',email)+1) AS 'email provider'
FROM users
ORDER BY `email provider`, user_name;

SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE "___.1%.%.___"
ORDER BY user_name
