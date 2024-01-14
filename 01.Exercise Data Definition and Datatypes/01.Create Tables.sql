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

select * from minions
