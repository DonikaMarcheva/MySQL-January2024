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

#6
DELIMITER $
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(10,4)) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF salary < 30000 THEN RETURN 'Low';
    ELSEIF salary <= 50000 THEN RETURN 'Average';
    ELSE RETURN 'High';
    END IF;
END $

CREATE PROCEDURE usp_get_employees_by_salary_level (salary_level VARCHAR(20))
BEGIN
SELECT first_name, last_name
FROM employees
WHERE salary_level = ufn_get_salary_level(salary)
ORDER BY first_name DESC, last_name DESC;
END $

DELIMITER ;
CALL usp_get_employees_by_salary_level('High');

#7
#first solution - check if in the word has ] or [ and replace it in order to use correct RegEx
DELIMITER //

CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
BEGIN
    DECLARE pattern VARCHAR(255);
    
    -- Escape special characters in the set_of_letters for safe use in REGEXP
    SET set_of_letters = REPLACE(set_of_letters, '[', '\\[');
    SET set_of_letters = REPLACE(set_of_letters, ']', '\\]');
    
    -- Build the REGEXP pattern
    SET pattern = CONCAT('^[' , set_of_letters , ']*$');
    
    -- Check if the word matches the pattern
    IF word REGEXP pattern THEN
        RETURN 1; -- Return 1 if the word is comprised of the given set of letters
    ELSE
        RETURN 0; -- Return 0 otherwise
    END IF;
END //

DELIMITER ;

#second solution 

DELIMITER $

CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS TINYINT
DETERMINISTIC
BEGIN
RETURN word REGEXP CONCAT('^[' , set_of_letters , ']*$');
END$

DELIMITER ;

SELECT ufn_is_word_comprised ('bobr', 'Rob')

#8
DELIMITER $

CREATE PROCEDURE usp_get_holders_full_name ()
BEGIN
SELECT concat_ws(' ', first_name, last_name) AS full_name
FROM account_holders
ORDER BY full_name;
END$

DELIMITER ;

CALL usp_get_holders_full_name ();

#9
DELIMITER $

CREATE PROCEDURE usp_get_holders_with_balance_higher_than (amount DECIMAL(20,4))
BEGIN
SELECT first_name, last_name
FROM account_holders a_h
JOIN accounts a ON a.account_holder_id=a_h.id
WHERE amount<
(SELECT SUM(balance) 
FROM accounts
WHERE account_holder_id= a_h.id
GROUP BY account_holder_id)
GROUP BY a_h.id
ORDER BY a.account_holder_id;
END$

DELIMITER ;

CALL usp_get_holders_with_balance_higher_than (70000);

#10
DELIMITER $
CREATE FUNCTION ufn_calculate_future_value (initial DECIMAL(19,4), interest_rate DOUBLE,
num_years INT) 
RETURNS DECIMAL(19,4)
READS SQL DATA
BEGIN
RETURN initial * POW(1+interest_rate, num_years);
END $

DELIMITER ;

SELECT ufn_calculate_future_value(1000,0.5,5)

#11
DELIMITER $

CREATE FUNCTION ufn_calculate_future_value (initial DECIMAL(19,4), interest_rate DECIMAL(10,4),
num_years INT) 
RETURNS DECIMAL(19,4)
READS SQL DATA
BEGIN
RETURN initial * POW(1+interest_rate, num_years);
END $

CREATE PROCEDURE usp_calculate_future_value_for_account (acc_id INT, interest DECIMAL(10,4))
BEGIN
SELECT a.id AS account_id, 
ah.first_name, ah.last_name, 
a.balance AS current_balance,
ufn_calculate_future_value(a.balance, interest, 5) AS balance_in_5_years
FROM account_holders ah
JOIN accounts a ON ah.id= a.account_holder_id
WHERE a.id=acc_id;
END$

DELIMITER ;

CALL usp_calculate_future_value_for_account(1,0.1);






