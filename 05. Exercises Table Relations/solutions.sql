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

