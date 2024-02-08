USE  universities_db;
#1
CREATE TABLE countries(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE cities(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE,
population INT,
country_id INT NOT NULL,

FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE universities(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(60) NOT NULL UNIQUE,
address VARCHAR(80) NOT NULL UNIQUE,
tuition_fee DECIMAL(19,2) NOT NULL,
number_of_staff INT,
city_id INT,

FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE students(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(40) NOT NULL,
last_name VARCHAR(40) NOT NULL,
age INT,
phone VARCHAR(20) NOT NULL UNIQUE,
email VARCHAR(255) NOT NULL UNIQUE,
is_graduated BOOLEAN,
city_id INT,

FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE courses(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE,
duration_hours DECIMAL(19,2),
start_date DATE,
teacher_name VARCHAR(60) NOT NULL UNIQUE,
description TEXT,
university_id INT,

FOREIGN KEY (university_id) REFERENCES universities(id)
);

CREATE TABLE students_courses(
grade DECIMAL(19,2) NOT NULL,
student_id INT NOT NULL,
course_id INT NOT NULL,

FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (course_id) REFERENCES courses(id)
);

#2
INSERT INTO courses(name , duration_hours, start_date, teacher_name, description, university_id)
SELECT 
CONCAT(teacher_name, ' course'),
length(name)/10,
adddate(start_date, INTERVAL 5 DAY),
reverse(teacher_name),
CONCAT('Course ', `teacher_name`, REVERSE(description)),
DAY(start_date)
FROM courses
WHERE id<=5;

#3
UPDATE universities 
SET 
    tuition_fee = tuition_fee + 300
WHERE
    id >= 5 AND id <= 12;
    
#4
DELETE FROM universities 
WHERE
    number_of_staff IS NULL;
    
#---------------------------------------------------------------

#5
SELECT 
    id, name, population, country_id
FROM
    cities
ORDER BY population DESC;

#6
 SELECT 
    first_name, last_name, age, phone, email
FROM
    students
WHERE
    age >= 21
ORDER BY first_name DESC , email , id
LIMIT 10;

#7
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    SUBSTRING(s.email, 2, 10) AS username,
    REVERSE(s.phone) AS password
FROM
    students s
        LEFT JOIN
    students_courses sc ON sc.student_id = s.id
WHERE
    sc.course_id IS NULL
ORDER BY password DESC;

#8
SELECT 
    COUNT(sc.student_id) AS students_count,
    u.name AS university_name
FROM
    students_courses sc
        JOIN
    courses c ON c.id = sc.course_id
        JOIN
    universities u ON u.id = c.university_id
GROUP BY u.name
HAVING students_count>=8
ORDER BY students_count DESC , university_name DESC;

#9
SELECT 
    u.name AS university_name,
    c.name AS city_name,
    u.address,
    CASE
        WHEN u.tuition_fee < 800 THEN 'cheap'
        WHEN u.tuition_fee < 1200 THEN 'normal'
        WHEN u.tuition_fee < 2500 THEN 'high'
        ELSE 'expensive'
    END AS price_rank,
    u.tuition_fee
FROM
    universities u
        JOIN
    cities c ON c.id = u.city_id
ORDER BY u.tuition_fee;

#10
DELIMITER $

CREATE FUNCTION udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN 
RETURN 
(SELECT (AVG(sc.grade)) FROM courses c
JOIN students_courses sc ON c.id=sc.course_id
JOIN students s ON s.id= sc.student_id
WHERE s.is_graduated=1 AND c.name= course_name
GROUP BY c.id);
END$

DELIMITER ;
#SELECT AVG(sc.grade), c.name FROM courses c
#JOIN students_courses sc ON c.id=sc.course_id
#JOIN students s ON s.id= sc.student_id
#where s.is_graduated=1
#GROUP BY c.id;

SELECT c.name, udf_average_alumni_grade_by_course_name('Quantum Physics') as average_alumni_grade FROM courses c 
WHERE c.name = 'Quantum Physics';

#11
DELIMITER $
CREATE PROCEDURE udp_graduate_all_students_by_year (year_started INT)
BEGIN
UPDATE students s
	JOIN students_courses sc ON s.id = sc.student_id
	JOIN courses c ON sc.course_id = c.id
	SET is_graduated = 1
	WHERE YEAR(c.start_date) = year_started;
END$

DELIMITER ;
CALL udp_graduate_all_students_by_year(2017); 





