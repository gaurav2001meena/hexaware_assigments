CREATE DATABASE  CourierManagement;
use CourierManagement;

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

CREATE TABLE Courier (
    CourierID INT PRIMARY KEY,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE
);

CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

INSERT INTO Users 
VALUES
(1, 'Alice Jones', 'alice.jones@example.com', 'password123', '111-222-3333', '789 Elm Street, CityD'),
(2, 'Charlie Brown', 'charlie.brown@example.com', 'password456', '444-555-6666', '101 Pine Avenue, CityE'),
(3, 'David White', 'david.white@example.com', 'password789', '666-777-8888', '456 Pine Avenue, CityF'),
(4, 'Sophie Brown', 'sophie.brown@example.com', 'password101', '999-111-2222', '789 Oak Road, CityG');

INSERT INTO Courier 
VALUES
(1, 'Sender A', '123 Oak Lane, CityF', 'Receiver A', '456 Maple Lane, CityG', 2.5, 'In Transit', 'TN123456', '2023-12-15'),
(2, 'Sender B', '789 Pine Road, CityH', 'Receiver B', '101 Elm Road, CityI', 1.8, 'Delivered', 'TN789012', '2023-12-16'),
(3, 'Sender C', '321 Elm Road, CityH', 'Receiver C', '987 Maple Road, CityI', 3.2, 'Delivered', 'TN789456', '2023-12-18'),
(4, 'Sender D', '654 Oak Avenue, CityJ', 'Receiver D', '123 Pine Avenue, CityK', 1.5, 'In Transit', 'TN012345', '2023-12-19');


INSERT INTO CourierServices 
VALUES
(1, 'Standard Delivery', 10.99),
(2, 'Express Delivery', 20.99),
(3, 'Same-Day Delivery', 30.99),
(4, 'Two-Day Delivery', 15.99),
(5, 'International Shipping', 50.99);


INSERT INTO Employee 
VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', 'Manager', 60000.00),
(2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', 'Delivery Staff', 40000.00),
(3, 'Bob Johnson', 'bob.johnson@example.com', '555-123-4567', 'Customer Service', 45000.00),
(4, 'Sam Wilson', 'sam.wilson@example.com', '777-888-9999', 'IT Specialist', 55000.00),
(5, 'Emily Davis', 'emily.davis@example.com', '333-222-1111', 'Accountant', 50000.00);

INSERT INTO Location (LocationID, LocationName, Address)
VALUES
(1, 'Office A', '123 Main Street, CityA'),
(2, 'Office B', '456 Oak Street, CityB'),
(3, 'Warehouse', '789 Pine Street, CityC'),
(4, 'Warehouse B', '987 Cedar Street, CityD'),
(5, 'Office C', '654 Birch Street, CityE');

INSERT INTO Payment 
VALUES
(1, 1, 1, 10.99, '2023-12-16'),
(2, 2, 2, 20.99, '2023-12-17'),
(3, 3, 3, 30.99, '2023-12-19'),
(4, 4, 4, 40.99, '2023-12-20');

select * from Users;

select * from Courier;

select * from Courier where SenderName='Sender A';

SELECT *
FROM Courier
WHERE CourierID = 1;

select * from Courier where Status = 'In Transit';

SELECT *
FROM Courier
WHERE CAST(DeliveryDate AS DATE) = CAST(GETDATE() AS DATE);

select * from Courier where Status = 'Delivered';

select COUNT(SenderName )as package_count , SenderName from Courier Group by SenderName;

SELECT *
FROM Courier
WHERE Weight BETWEEN 2.0 AND 5.0;

SELECT Courier.*
FROM Courier
JOIN Payment ON Courier.CourierID = Payment.CourierID
WHERE Payment.Amount > 50.0;

SELECT
    Location.LocationID,
    Location.LocationName,
    SUM(Payment.Amount) AS TotalRevenue
FROM
    Location
LEFT JOIN
    Payment ON Location.LocationID = Payment.LocationID
GROUP BY
    Location.LocationID, Location.LocationName;

SELECT
    Location.LocationID,
    Location.LocationName,
    COUNT(Courier.CourierID) AS TotalCouriersDelivered
FROM
    Location
LEFT JOIN
    Courier ON Location.LocationID = Courier.CourierID
GROUP BY
    Location.LocationID, Location.LocationName;

SELECT
    Location.LocationID,
    Location.LocationName,
    SUM(Payment.Amount) AS TotalPayments
FROM
    Location
LEFT JOIN
    Payment ON Location.LocationID = Payment.LocationID
GROUP BY
    Location.LocationID, Location.LocationName;


SELECT
    Payment.PaymentID,
    Payment.Amount,
    Payment.PaymentDate,
    Courier.*
FROM
    Payment
JOIN
    Courier ON Payment.CourierID = Courier.CourierID;

SELECT
    Payment.PaymentID,
    Payment.Amount,
    Payment.PaymentDate,
    Location.*
FROM
    Payment
JOIN
    Location ON Payment.LocationID = Location.LocationID;

SELECT
    Payment.PaymentID,
    Payment.Amount,
    Payment.PaymentDate,
    Courier.*
FROM
    Payment
JOIN
    Courier ON Payment.CourierID = Courier.CourierID;

SELECT
    Payment.PaymentID,
    Payment.Amount,
    Payment.PaymentDate,
    Courier.*
FROM
    Payment
JOIN
    Courier ON Payment.CourierID = Courier.CourierID;

SELECT
    Users.UserID,
    Users.Name AS UserName,
    CourierServices.ServiceID,
    CourierServices.ServiceName,
    CourierServices.Cost
FROM
    Users
CROSS JOIN
    CourierServices;


SELECT
    Courier.*,
    Users.Name AS SenderName,
    Users.Address AS SenderAddress
FROM
    Courier
LEFT JOIN
    Users ON Courier.CourierID = Users.UserID;

SELECT
    Name,
    Salary
FROM
    Employee
WHERE
    Salary > (SELECT AVG(Salary) FROM Employee);

SELECT
    SUM(Cost) AS TotalCost
FROM
    CourierServices
WHERE
    Cost < (SELECT MAX(Cost) FROM CourierServices);

SELECT
    Location.LocationID,
    Location.LocationName,
    MAX(Payment.Amount) AS MaxPaymentAmount
FROM
    Location
JOIN
    Payment ON Location.LocationID = Payment.LocationID
GROUP BY
    Location.LocationID, Location.LocationName
HAVING
    MAX(Payment.Amount) IS NOT NULL;