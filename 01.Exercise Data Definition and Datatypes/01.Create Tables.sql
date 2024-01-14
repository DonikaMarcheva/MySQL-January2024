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

USE minions;

ALTER TABLE minions
ADD COLUMN town_id int;

ALTER TABLE minions
ADD constraint fk_town_id FOREIGN KEY (town_id) references towns(id);
