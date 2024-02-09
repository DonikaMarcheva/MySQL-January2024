USE restaurant_db;

#1

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL UNIQUE,
type VARCHAR(30) NOT NULL,
price DECIMAL(10,2) NOT NULL
);

CREATE TABLE clients(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birthdate DATE NOT NULL,
card VARCHAR(50),
review TEXT
);

CREATE TABLE tables (
id INT PRIMARY KEY AUTO_INCREMENT,
floor INT NOT NULL,
reserved BOOLEAN,
capacity INT NOT NULL
);

CREATE TABLE waiters(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50),
salary DECIMAL(10,2)
);

CREATE TABLE orders (
id INT PRIMARY KEY AUTO_INCREMENT,
table_id INT NOT NULL,
waiter_id INT NOT NULL,
order_time TIME NOT NULL,
payed_status BOOLEAN,

FOREIGN KEY (table_id) REFERENCES tables(id),
FOREIGN KEY (waiter_id) REFERENCES waiters(id)
);


CREATE TABLE orders_products(
order_id INT NOT NULL,
product_id INT NOT NULL,

FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE orders_clients (
order_id INT NOT NULL,
client_id INT NOT NULL,

FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (client_id) REFERENCES clients(id)
);

#2

INSERT INTO products(name , type , price )
SELECT
CONCAT(last_name, ' ', 'specialty'),
'Cocktail',
CEIL(0.01*salary)
FROM waiters
WHERE id>6 AND (salary is NOT NULL);

#3

UPDATE orders 
SET 
    table_id = table_id - 1
WHERE
    id >= 12 AND id <= 23;
    
#4

DELETE w
FROM waiters w
	LEFT JOIN orders o ON w.id = o.waiter_id
WHERE o.waiter_id IS NULL;

#--------------------------

#5

SELECT 
    id, first_name, last_name, birthdate, card, review
FROM
    clients
ORDER BY birthdate DESC , id DESC; 
