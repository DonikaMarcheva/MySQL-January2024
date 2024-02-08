USE  real_estate_db;

#1

CREATE TABLE cities(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE property_types(
id INT PRIMARY KEY AUTO_INCREMENT,
type VARCHAR(40) NOT NULL UNIQUE,
description TEXT
);

CREATE TABLE properties(
id INT PRIMARY KEY AUTO_INCREMENT,
address VARCHAR(80) NOT NULL UNIQUE,
price DECIMAL(19,2) NOT NULL,
area DECIMAL(19,2),
property_type_id INT,
city_id INT,

FOREIGN KEY (property_type_id) REFERENCES property_types(id),
FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE agents(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(40) NOT NULL,
last_name VARCHAR(40) NOT NULL,
phone VARCHAR(20) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE,
city_id INT,

FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE buyers(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(40) NOT NULL,
last_name VARCHAR(40) NOT NULL,
phone VARCHAR(20) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE,
city_id INT,

FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE property_offers(
property_id INT NOT NULL,
agent_id INT NOT NULL,
price DECIMAL(19,2) NOT NULL,
offer_datetime DATETIME,

FOREIGN KEY (property_id) REFERENCES properties(id),
FOREIGN KEY (agent_id) REFERENCES agents(id)
);

CREATE TABLE property_transactions(
id INT PRIMARY KEY AUTO_INCREMENT,
property_id INT NOT NULL,
buyer_id INT NOT NULL,
transaction_date DATE,
bank_name VARCHAR(30),
iban VARCHAR(40) UNIQUE,
is_successful BOOLEAN,

FOREIGN KEY (property_id) REFERENCES properties(id),
FOREIGN KEY (buyer_id) REFERENCES buyers(id)
);

#2

INSERT INTO property_transactions(property_id, buyer_id, transaction_date, bank_name, iban, is_successful)
SELECT
agent_id + DAY(offer_datetime),
agent_id + MONTH(offer_datetime),
DATE(offer_datetime),
CONCAT_WS(' ', 'Bank',agent_id ),
CONCAT('BG', price, agent_id),
1
FROM property_offers
WHERE agent_id<=2;

#3

UPDATE properties 
SET 
    price = price - 50000
WHERE
    price >= 800000;
    
    
#4

DELETE FROM property_transactions 
WHERE
    is_successful = 0;
    
#-----------------------------------------------

#5
SELECT 
    id, first_name, last_name, phone, email, city_id
FROM
    agents
ORDER BY city_id DESC , phone DESC;

#6

SELECT 
    property_id, agent_id, price, offer_datetime
FROM
    property_offers
WHERE
    YEAR(offer_datetime) = 2021
ORDER BY price
LIMIT 10;

#7

SELECT a.first_name, po.price
FROM property_offers po
LEFT JOIN agents a ON a.id=po.agent_id
ORDER BY a.first_name DESC, price DESC;

#7

SELECT 
    LEFT(p.address, 6) AS agent_name,
    LENGTH(p.address) * 5430 AS price
FROM
    properties p
        LEFT JOIN
    property_offers po ON po.property_id = p.id
WHERE
    agent_id IS NULL
ORDER BY agent_name DESC , price DESC;

#8

SELECT 
    bank_name, COUNT(iban) AS `count`
FROM
    property_transactions
GROUP BY bank_name
HAVING `count` >= 9
ORDER BY `count` DESC , bank_name;

#9

    SELECT 
    address,
    area,
    CASE
        WHEN area <= 100 THEN 'small'
        WHEN area <= 200 THEN 'medium'
        WHEN area <= 500 THEN 'large'
        ELSE 'extra large'
    END AS size
FROM
    properties
ORDER BY area , address DESC;

#10
DELIMITER $

CREATE FUNCTION udf_offers_from_city_name (cityName VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN 
RETURN 
(SELECT COUNT(*) AS 'offers_count'
FROM property_offers po
JOIN properties p ON p.id=po.property_id
JOIN cities c ON c.id=p.city_id
WHERE c.name= cityName
GROUP BY p.city_id);
END$

DELIMITER ;

#11
DELIMITER $

CREATE PROCEDURE udp_special_offer (first_name VARCHAR(50))
BEGIN
UPDATE property_offers po
JOIN agents a ON agent_id=po.agent_id
SET po.price=po.price-0.1*po.price
WHERE a.first_name=first_name;
END$

DELIMITER ;
CALL udp_special_offer('Hans');

