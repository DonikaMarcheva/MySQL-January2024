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
)
