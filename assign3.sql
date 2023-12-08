create database HMBank;
use HMBank;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Customers (customer_id, first_name, last_name, DOB, email, phone_number, address)
VALUES
    (1, 'John', 'Doe', '19900115', 'john.doe@email.com', '123-456-7890', '123 Main St'),
    (2, 'Jane', 'Smith', '19850520', 'jane.smith@email.com', '987-654-3210', '456 Oak St'),
    (3, 'Bob', 'Johnson', '19781110', 'bob.johnson@email.com', '555-123-4567', '789 Pine St'),
    (4, 'Alice', 'Williams', '19920325', 'alice.williams@email.com', '222-333-4444', '101 Elm St'),
    (5, 'Charlie', 'Brown', '19800718', 'charlie.brown@email.com', '777-888-9999', '202 Maple St'),
    (6, 'Eva', 'Miller', '19950905', 'eva.miller@email.com', '666-555-4444', '303 Birch St'),
    (7, 'David', 'Smithson', '19831230', 'david.smithson@email.com', '111-222-3333', '404 Cedar St'),
    (8, 'Grace', 'Thompson', '19980214', 'grace.thompson@email.com', '999-111-2222', '505 Walnut St'),
    (9, 'Frank', 'Roberts', '19750628', 'frank.roberts@email.com', '333-444-5555', '606 Oak St'),
    (10, 'Hannah', 'Johnson', '19870822', 'hannah.johnson@email.com', '888-999-0000', '707 Pine St');

INSERT INTO Accounts (account_id, customer_id, account_type, balance)
VALUES
    (101, 1, 'savings', 5000.00),
    (102, 2, 'current', 10000.00),
    (103, 3, 'savings', 7500.00),
    (104, 4, 'current', 12000.00),
    (105, 5, 'savings', 3000.00),
    (106, 6, 'current', 9000.00),
    (107, 7, 'savings', 6000.00),
    (108, 8, 'current', 15000.00),
    (109, 9, 'savings', 10000.00),
    (110, 10, 'current', 8000.00);

INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES
    (1001, 101, 'deposit', 1000.00, '2023-01-05'),
    (1002, 102, 'withdrawal', 500.00, '2023-02-10'),
    (1003, 103, 'transfer', 2000.00, '2023-03-15'),
    (1004, 104, 'deposit', 1500.00, '2023-04-20'),
    (1005, 105, 'withdrawal', 1000.00, '2023-05-25'),
    (1006, 106, 'transfer', 500.00, '2023-06-30'),
    (1007, 107, 'deposit', 800.00, '2023-07-05'),
    (1008, 108, 'withdrawal', 2000.00, '2023-08-10'),
    (1009, 109, 'transfer', 1200.00, '2023-09-15'),
    (1010, 110, 'deposit', 3000.00, '2023-10-20');


SELECT
    c.first_name,
    c.last_name,
    a.account_type,
    c.email
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id;


SELECT
    c.first_name,
    c.last_name,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
JOIN
    Transactions t ON a.account_id = t.account_id;


SELECT
    customer_id,
    first_name + ' ' + last_name AS full_name,
    DOB,
    email,
    phone_number,
    address
FROM
    Customers;


DELETE FROM Accounts
WHERE account_type = 'savings' AND balance = 0.0;

SELECT
    customer_id,
    first_name,
    last_name,
    DOB,
    email,
    phone_number,
    address
FROM
    Customers
WHERE
    address LIKE '%YourCity%';

SELECT
    account_id,
    account_type,
    balance
FROM
    Accounts
WHERE
    account_id = 101;

SELECT
    account_id,
    customer_id,
    account_type,
    balance
FROM
    Accounts
WHERE
    account_type = 'current' AND balance > 1000.00;



SELECT
    t.transaction_id,
    t.account_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM
    Transactions t
JOIN
    Accounts a ON t.account_id = a.account_id
WHERE
    a.account_id = 101;

SELECT
    account_id,
    customer_id,
    account_type,
    balance
FROM
    Accounts
WHERE
    balance < 100;

SELECT
   *
FROM
    Customers
WHERE
    address NOT LIKE '%New York%';


SELECT
    AVG(balance) AS average_balance
FROM
    Accounts;

SELECT TOP 10
    account_id,
    customer_id,
    account_type,
    balance
FROM
    Accounts
ORDER BY
    balance DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(t.amount) AS total_deposits
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_type = 'deposit' AND t.transaction_date = '2023-01-05'
GROUP BY
    c.customer_id, c.first_name, c.last_name;

-- Oldest Customer
SELECT
    customer_id,
    first_name,
    last_name,
    DOB
FROM
    Customers
WHERE
    DOB = (SELECT MIN(DOB) FROM Customers);

-- Newest Customer
SELECT
    customer_id,
    first_name,
    last_name,
    DOB
FROM
    Customers
WHERE
    DOB = (SELECT MAX(DOB) FROM Customers);


SELECT
    t.*,
    a.account_type,
    c.first_name,
    c.last_name
FROM
    Transactions t
JOIN
    Accounts a ON t.account_id = a.account_id
JOIN
    Customers c ON a.customer_id = c.customer_id;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.DOB,
    c.email,
    c.phone_number,
    c.address,
    a.account_id,
    a.account_type,
    a.balance
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id;

SELECT
    t.transaction_id,
    t.account_id,
    a.account_type,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.DOB,
    c.email,
    c.phone_number,
    c.address
FROM
    Transactions t
JOIN
    Accounts a ON t.account_id = a.account_id
JOIN
    Customers c ON a.customer_id = c.customer_id
WHERE
    t.account_id = 101;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(a.account_id) AS number_of_accounts
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(a.account_id) > 1;

SELECT
    account_id,
    SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawals,
    SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE -amount END) AS difference
FROM
    Transactions
GROUP BY
    account_id;


SELECT
    account_type,
    SUM(balance) AS total_balance
FROM
    Accounts
GROUP BY
    account_type;

SELECT TOP 1
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_id,
    a.balance
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
ORDER BY
    a.balance DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    AVG(a.balance) AS average_balance
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(a.account_id) > 1;

SELECT
    t.account_id,
    a.account_type,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM
    Transactions t
JOIN
    Accounts a ON t.account_id = a.account_id
WHERE
    t.amount > (
        SELECT AVG(amount)
        FROM Transactions
    );


SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    Customers c
LEFT JOIN
    Accounts a ON c.customer_id = a.customer_id
LEFT JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_id IS NULL;


SELECT
    a.account_id,
    a.account_type,
    a.balance
FROM
    Accounts a
LEFT JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_id IS NULL;

SELECT
    t.transaction_id,
    t.account_id,
    a.account_type,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM
    Transactions t
JOIN
    Accounts a ON t.account_id = a.account_id
WHERE
    a.balance = (SELECT MIN(balance) FROM Accounts);

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(DISTINCT a.account_type) > 1;

SELECT
    account_type,
    COUNT(*) AS account_count,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM
    Accounts
GROUP BY
    account_type;

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date
FROM
    Transactions
WHERE
    account_id IN (SELECT account_id FROM Accounts WHERE customer_id = 1);

SELECT
    account_type,
    (SELECT SUM(balance) FROM Accounts a2 WHERE a2.account_type = a.account_type) AS total_balance
FROM
    Accounts a
GROUP BY
    account_type;










