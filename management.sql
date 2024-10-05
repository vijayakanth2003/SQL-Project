drop database management;


create database management;

use management;


-- table1
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE
);


INSERT INTO Customers (first_name, last_name, address, city, state, zip_code, phone_number, email)
VALUES 
('John', 'Doe', '123 Elm St', 'theni', 'tn', '62701', '2345678908', 'john.doe@example.com'),
('Jane', 'Smith', '456 Oak St', 'madurai', 'tn', '62702', '9976567149', 'jane.smith@example.com'),
('Tom', 'Johnson', '789 Pine St', 'kovai', 'tn', '62703', '8760097820', 'tom.johnson@example.com'),
('vijay','kanth', '231 sr st',  'chennai', 'tn', '627702', '7305156980', 'vijay@gmail.com'),
('jeevan', 'og',  '123 north st', 'aundipati', 'tn','62345', '8807911676', ' jeeevan@gmail.com'),
(' suersh', 'kumar', '432 south st','cunmbam', 'tn', '623456', '1234567890','suresh@gamil.com'),
('ganesh', 'raj',  '154 east st', 'theni', 'tn', '62345', '5643456676', 'raj@gamil.com');


select *from Customers;

-- table2

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    service_start_date DATE NOT NULL,
    service_end_date DATE,
    account_status ENUM('Active', 'Inactive') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) on update cascade
);

INSERT INTO Accounts ( customer_id,account_number, service_start_date, service_end_date, account_status)
VALUES 
( 1,'ACC001', '2023-01-01', '2023-02-01', 'Active'),
( 2,'ACC002', '2023-02-01', '2023-03-01', 'Active'),
( 3,'ACC003', '2023-03-01', '2023-04-01', 'Inactive'),
( 4,'ACC004', '2023-04-01', '2023-05-01', 'inactive'),
( 5,'ACC005', '2023-05-01', '2023-06-01', 'active'),
( 6,'ACC007', '2023-06-01', '2023-07-01', 'inactive'),
( 7,'ACC008', '2023-07-01', '2023-08-01', 'inactive');

select * from Accounts;

-- table3


CREATE TABLE ElectricityUsage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    billing_period_start DATE NOT NULL,
    billing_period_end DATE NOT NULL,
    kwh_used DECIMAL(10, 2) NOT NULL,
    peak_usage_time TIME,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) on update cascade
);

INSERT INTO ElectricityUsage ( account_id,billing_period_start, billing_period_end, kwh_used, peak_usage_time)
VALUES 
( 8,'2023-01-01', '2023-01-31', 350.75, '18:00:00'),
( 9,'2023-02-01', '2023-02-28', 270.50, '20:00:00'),
( 10,'2023-02-01', '2023-02-28', 400.00, '19:00:00'),
( 11,'2024-03-01', '2024-04-21', 500.00, '17:00:00'),
( 12,'2024-05-01', '2024-06-25', 600.00, '21:00:00');


select * from ElectricityUsage;

-- table4
CREATE TABLE Rates (
    rate_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    rate_name VARCHAR(50) NOT NULL,
    rate_per_kwh DECIMAL(10, 4) NOT NULL,
    effective_date DATE NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) on update cascade
);

INSERT INTO Rates (customer_id,rate_name, rate_per_kwh, effective_date)
VALUES 
(1,'Residential', 0.12, '2023-01-01'),
(2,'Commercial', 0.15, '2023-01-01'),
(3,'Industrial', 0.10, '2023-01-01'),
(4,'Commercial', 0.12,  '2024-01-01'),
( 5,'Industrial', 0.14,  '2023-04-01');

select * from Rates;

-- table5

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    billing_period_start DATE NOT NULL,
    billing_period_end DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    due_date DATE NOT NULL,
    bill_status ENUM('Paid', 'Unpaid', 'Overdue') NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) on update cascade
);

INSERT INTO Bills (account_id, billing_period_start, billing_period_end, total_amount, due_date, bill_status)
VALUES 
(8, '2023-01-01', '2023-01-31', 42.09, '2023-02-05', 'Unpaid'),
(9, '2023-02-01', '2023-02-28', 32.46, '2023-03-05', 'Paid'),
(10, '2023-02-01', '2023-02-28', 48.00, '2023-03-05', 'Unpaid');

select * from bills;


-- table6
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Bank Transfer', 'Cash') NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES Bills(bill_id) on update cascade
);

INSERT INTO Payments (bill_id, payment_date, payment_amount, payment_method)
VALUES 
(7, '2023-02-20', 32.46, 'Credit Card'),
(8, '2023-03-21', 40.43, 'Credit Card'),
(9, '2024-05-21', 50.00, 'Cash');

select * from Payments;

-- table7
CREATE TABLE Tariffs (
    tariff_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    tariff_type ENUM('Residential', 'Commercial', 'Industrial') NOT NULL,
    start_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) on update cascade
);

INSERT INTO Tariffs (account_id, tariff_type, start_date)
VALUES 
(8, 'Residential', '2023-01-01'),
(9, 'Commercial', '2023-02-01'),
(10, 'Residential', '2023-03-01');


select * from Tariffs;

-- table8

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    notification_date DATE NOT NULL,
    notification_type ENUM('Bill Reminder', 'Payment Confirmation', 'Service Interruption') NOT NULL,
    message_content TEXT NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) on update cascade
);

INSERT INTO Notifications (account_id, notification_date, notification_type, message_content)
VALUES 
(8, '2023-02-01', 'Bill Reminder', 'Your bill is due on 2023-02-05.'),
(9, '2023-03-01', 'Payment Confirmation', 'Your payment has been received.'),
(10, '2023-03-15', 'Service Interruption', 'Your service has been temporarily suspended.');

select * from Notifications;


select count(*) from Customers;

-- joins
-- inner join
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_number,
    a.account_status
FROM 
    Customers c
INNER JOIN 
    Accounts a ON c.customer_id = a.customer_id;




select address,state,email from 
customers LEFT join accounts on customers.customer_id=accounts.account_number;


select * from notifications cross join payments;



--- where

select * from customers
where first_name like'a%';



--- having

select count(customer_id),city
from customers
group by city
having count(customer_id)<5;





















