#1
DELIMITER $

CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
SELECT first_name, last_name FROM employees
WHERE salary > 35000
ORDER BY first_name, last_name, employee_id;

END $

DELIMITER ;

CALL usp_get_employees_salary_above_35000();

#2
DELIMITER $

CREATE PROCEDURE usp_get_employees_salary_above(target_salary DECIMAL(10,4))
BEGIN
SELECT first_name, last_name FROM employees
WHERE salary >= target_salary
ORDER BY first_name, last_name, employee_id;

END $

DELIMITER ;

CALL usp_get_employees_salary_above (45000);

#3
#First solution
DELIMITER $

CREATE PROCEDURE usp_get_towns_starting_with (starting_chars VARCHAR(10))
BEGIN
SELECT name FROM towns
WHERE LEFT(name, length(starting_chars))=starting_chars
ORDER BY name;

END $

DELIMITER ;

CALL usp_get_towns_starting_with  ('b');

#second solution 
DELIMITER $

CREATE PROCEDURE usp_get_towns_starting_with(IN starting_string VARCHAR(10))
BEGIN
    SELECT name
    FROM soft_uni.towns
    WHERE name LIKE CONCAT(starting_string, '%')
    ORDER BY name;
END $

DELIMITER ;

CALL usp_get_towns_starting_with  ('b');

#4
DELIMITER $

CREATE PROCEDURE usp_get_employees_from_town (expected_town_name VARCHAR(30))
BEGIN
SELECT e.first_name, e.last_name
FROM employees e
JOIN addresses USING(address_id)
JOIN towns t USING(town_id)
WHERE t.name= expected_town_name
ORDER BY e.first_name, e.last_name, e.employee_id;
END $

DELIMITER ;

CALL usp_get_employees_from_town ('Sofia');

#5
DELIMITER $
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(10,4)) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF salary < 30000 THEN RETURN 'Low';
    ELSEIF salary <= 50000 THEN RETURN 'Average';
    ELSE RETURN 'High';
    END IF;
END $

DELIMITER ;

SELECT UFN_GET_SALARY_LEVEL(50000);

