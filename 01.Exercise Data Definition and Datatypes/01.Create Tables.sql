use minions;


CREATE TABLE minions (
    id INT AUTO_INCREMENT,
    name VARCHAR(80),
    age INT,
    
    constraint pk_id
    PRIMARY KEY (id)
);

CREATE TABLE towns (
    town_id INT AUTO_INCREMENT,
    name VARCHAR(80),
    
    constraint pk_town_id
    PRIMARY KEY (town_id)
);

ALTER TABLE minions
ADD COLUMN town_id int;

ALTER TABLE minions
ADD constraint fk_town_id FOREIGN KEY (town_id) references towns(id);

INSERT INTO towns(id, name) VALUE(1,'Sofia');
INSERT INTO towns(id, name) VALUE(2,'Plovdiv');
INSERT INTO towns(id, name) VALUE(3,'Varna');

INSERT INTO minions(id,name, age, town_id) VALUE(1,'Kevin',22,1);
INSERT INTO minions(id,name, age, town_id) VALUE(2,'Bob',15,3);
INSERT INTO minions(id,name, age, town_id) VALUE(3,'Steward',NULL,2);

TRUNCATE TABLE minions;

DROP TABLE minions;
DROP TABLE towns;



CREATE TABLE people(
id INT NOT NULL auto_increment PRIMARY KEY,
name varchar(200) NOT NULL,
picture BLOB,
height DOUBLE(6,2),
weight DOUBLE(6,2),
gender CHAR(1) NOT NULL,
birthdate DATE NOT NULL,
biography BLOB
);

INSERT INTO people(name, picture, height, weight, gender, birthdate, biography) VALUES 
('Ivan', 'test', 1.90, 90, 'm', '1980-10-30','test'),
('Dragan', 'test', 1.90, 90, 'm', '1980-10-30','test'),
('Petkan', 'test', 1.90, 90, 'm', '1980-10-30','test'),
('Pesho', 'test', 1.90, 90, 'm', '1980-10-30','test'),
('Gosho', 'test', 1.90, 90, 'm', '1980-10-30','test');

