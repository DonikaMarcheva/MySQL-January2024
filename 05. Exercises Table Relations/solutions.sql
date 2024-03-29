CREATE DATABASE relations;
use relations;
CREATE TABLE people (
person_id INT,
first_name VARCHAR(30) NOT NULL,
salary DECIMAL,
passport_id INT
);
CREATE TABLE passports (
passport_id INT AUTO_INCREMENT PRIMARY key,
passport_number VARCHAR(20) UNIQUE
);

INSERT INTO people(first_name, salary, passport_id) VALUES
('Roberto', 43300, 102),
('Tom', 56100, 103),
('Yana', 60200,101);

INSERT INTO passports(passport_id, passport_number) VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(10, 'ZE657QP2');

UPDATE passports
SET passport_id = 103 WHERE passport_number='ZE657QP2';

ALTER TABLE people
ADD CONSTRAINT fk_password_id
FOREIGN KEY (passport_id) REFERENCES passports(passport_id);

ALTER TABLE people
CHANGE person_id person_id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE people
CHANGE passport_id passport_id INT UNIQUE;

ALTER TABLE people
CHANGE salary salary DECIMAL(10,2);

#2
CREATE TABLE manufacturers (
manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20),
established_on TIMESTAMP
);

CREATE TABLE models (
model_id INT PRIMARY KEY,
name VARCHAR(20),
manufacturer_id INT,

FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);

ALTER TABLE manufacturers
CHANGE established_on established_on DATE;

INSERT INTO manufacturers(name, established_on) VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models(model_id, name, manufacturer_id) VALUES
(101,'X1',1),
(102, 'i6',1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

#3
CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20));

INSERT into students (name) VALUES 
('Mila'), ('Toni'), ('Ron');

CREATE TABLE exams(
exam_id INT PRIMARY KEY,
name VARCHAR(20));

INSERT INTO exams (exam_id, name) VALUES
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

CREATE TABLE students_exams(
student_id INT,
exam_id INT,
PRIMARY KEY (student_id, exam_id),

FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students_exams(student_id, exam_id) VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);

#4 
CREATE TABLE teachers (
teacher_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20),
manager_id INT);
ALTER TABLE teachers AUTO_INCREMENT=101;


INSERT INTO teachers(name, manager_id) VALUES
('John',null),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark',101),
('Greta',101);
ALTER TABLE teachers
ADD FOREIGN KEY (manager_id) REFERENCES teachers(teacher_id);

#5
CREATE TABLE cities (
city_id INT(11) PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);
CREATE TABLE customers (
customer_id INT(11) PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
birthday DATE,
city_id INT(11),

FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE item_types (
item_type_id INT(11) PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

CREATE TABLE items (
item_id INT(11) PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
item_type_id INT(11),

FOREIGN KEY (item_type_id ) REFERENCES item_types(item_type_id)
);

CREATE TABLE orders (
order_id INT(11) PRIMARY KEY AUTO_INCREMENT,
customer_id INT(11),

FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
order_id INT(11),
item_id int(11),

PRIMARY KEY (order_id, item_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (item_id) REFERENCES items(item_id)
);

#6
CREATE DATABASE table_relations_6;
use table_relations_6;
CREATE TABLE subjects(
subject_id INT PRIMARY KEY AUTO_INCREMENT,
subject_name VARCHAR(50)
);
CREATE TABLE majors(
major_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);
CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_number VARCHAR(12) UNIQUE,
student_name VARCHAR(50),
major_id INT,

FOREIGN KEY(major_id) REFERENCES majors(major_id)
);
CREATE TABLE payments(
payment_id INT PRIMARY KEY AUTO_INCREMENT,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT,

FOREIGN KEY (student_id) REFERENCES students(student_id)
);
CREATE TABLE agenda(
student_id INT,
subject_id INT,

PRIMARY KEY(student_id, subject_id),
FOREIGN KEY(student_id) REFERENCES students(student_id),
FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);

#9
SELECT m.mountain_range, p.peak_name, p.elevation AS peak_elevation FROM peaks p
JOIN mountains m
ON p.mountain_id=m.id
WHERE m.mountain_range='Rila'
ORDER BY p.elevation DESC;







