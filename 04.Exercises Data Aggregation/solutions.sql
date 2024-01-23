use gringotts;
#1
SELECT COUNT(id) AS 'count'
FROM wizzard_deposits;

#2
SELECT MAX(magic_wand_size) AS 'longest_magic_wand'
FROM wizzard_deposits;

#3
SELECT deposit_group, MAX(magic_wand_size) AS 'longest_magic_wand'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `longest_magic_wand`, deposit_group;

#4
SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

#5
SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum;

#6
SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator='Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;

#7
SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator='Ollivander family'
GROUP BY deposit_group
HAVING `total_sum` < 150000
ORDER BY total_sum DESC;

#8
SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group;

#9
SELECT
CASE
WHEN age>=0 and age<=10 THEN '[0-10]'
WHEN age>= 11 and age<= 20 THEN '[11-20]'
WHEN age>= 21 and age<=30 THEN '[21-30]'
WHEN age>=31 and age<=40 THEN '[31-40]'
WHEN age >= 41 and age<= 50 THEN '[41-50]'
WHEN age >= 51 and age<=60 THEN '[51-60]'
WHEN age>=61 THEN '[61+]'
END
AS age_group, COUNT(id) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group 
ORDER BY age_group;


#10
SELECT LEFT(first_name,1) AS first_letter
FROM wizzard_deposits
WHERE deposit_group='Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

#11

#12
SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE department_id IN (2,5,7) AND date_format(hire_date, '%d/%c/%Y') > 01/01/2000
GROUP BY department_id;

#other easier decision
SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE department_id IN (2,5,7) AND hire_date>01-01-2000
GROUP BY department_id;

#13

#14
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id





