CREATE database TechShop;

use TechShop;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Oak St'),
(3, 'Bob', 'Johnson', 'bob.johnson@example.com', '5551234567', '789 Pine St'),
(4, 'Alice', 'Williams', 'alice.williams@example.com', '3334445555', '101 Maple Ave'),
(5, 'Charlie', 'Brown', 'charlie.brown@example.com', '7778889999', '202 Cedar Rd'),
(6, 'Eva', 'Davis', 'eva.davis@example.com', '1112223333', '303 Elm Blvd'),
(7, 'Frank', 'Miller', 'frank.miller@example.com', '4445556666', '404 Birch Ln'),
(8, 'Grace', 'Taylor', 'grace.taylor@example.com', '6667778888', '505 Spruce Dr'),
(9, 'Henry', 'Moore', 'henry.moore@example.com', '9990001111', '606 Willow St'),
(10, 'Ivy', 'Clark', 'ivy.clark@example.com', '2223334444', '707 Oak Dr');

-- Inserting sample records into Products table
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES
(1, 'Laptop', 'High-performance laptop with SSD', 999.99),
(2, 'Smartphone', 'Latest model with dual cameras', 599.99),
(3, 'Tablet', '10-inch tablet with long battery life', 299.99),
(4, 'Headphones', 'Noise-canceling headphones with Bluetooth', 149.99),
(5, 'Smartwatch', 'Fitness tracker with heart rate monitor', 129.99),
(6, 'Desktop Computer', 'Powerful desktop for gaming and design', 1499.99),
(7, 'Printer', 'Wireless all-in-one printer with scanner', 199.99),
(8, 'Camera', 'Digital camera with 20MP sensor', 499.99),
(9, 'External Hard Drive', '1TB portable hard drive', 79.99),
(10, 'Wireless Router', 'High-speed dual-band router', 129.99);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(1, 1, '2023-01-01', 1499.98),
(2, 2, '2023-02-01', 799.99),
(3, 3, '2023-03-01', 899.95),
(4, 4, '2023-04-01', 449.97),
(5, 5, '2023-05-01', 259.98),
(6, 6, '2023-06-01', 3199.97),
(7, 7, '2023-07-01', 499.98),
(8, 8, '2023-08-01', 999.99),
(9, 9, '2023-09-01', 159.98),
(10, 10, '2023-10-01', 999.99);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 3, 1),
(4, 2, 4, 2),
(5, 3, 5, 3),
(6, 3, 6, 1),
(7, 4, 7, 1),
(8, 5, 9, 2),
(9, 6, 8, 1),
(10, 7, 10, 1);

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES
(1, 1, 50, '2023-01-01 08:00:00'),
(2, 2, 100, '2023-02-01 10:30:00'),
(3, 3, 75, '2023-03-01 12:45:00'),
(4, 4, 30, '2023-04-01 14:15:00'),
(5, 5, 80, '2023-05-01 16:30:00'),
(6, 6, 20, '2023-06-01 18:00:00'),
(7, 7, 40, '2023-07-01 20:15:00'),
(8, 8, 15, '2023-08-01 22:45:00'),
(9, 9, 60, '2023-09-01 00:30:00'),
(10, 10, 25, '2023-10-01 02:00:00');


SELECT FirstName, LastName, Email
FROM Customers;

SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES (11, 'Gaurav', 'Meena', 'gaurav@example.com', '8306618299', '108 Brij Vatika');

UPDATE Products
SET Price = Price * 1.10;

DELETE FROM OrderDetails
WHERE OrderID = 1;


DELETE FROM Orders
WHERE OrderID = 1;

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (1 , 1, '2023-12-15', 199.99);

UPDATE Customers
SET Email = 'newemail@example.com',
Address = 'new example'
WHERE CustomerID = 1;

UPDATE Orders
SET TotalAmount = (
    SELECT SUM(OrderDetails.Quantity * Products.Price)
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
)

-- Delete from OrderDetails table first
DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 1);

-- Delete from Orders table
DELETE FROM Orders
WHERE CustomerID = 1;

ALTER TABLE Products
ADD Category VARCHAR(255);


INSERT INTO Products (ProductID, ProductName, Description, Price, Category)
VALUES (11, 'New Electronic Gadget', 'Description of the new gadget', 399.99, 'Electronic Gadget');

ALTER TABLE Orders
ADD Status VARCHAR(50);

UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 1;


SELECT
    Orders.OrderID,
    Customers.FirstName AS CustomerFirstName,
    Customers.LastName AS CustomerLastName,
    Orders.OrderDate,
    Orders.TotalAmount
FROM
    Orders
JOIN
    Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT
    Products.ProductName,
    SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM
    Products
JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Products.ProductName;

SELECT * FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT TOP 1
    Products.ProductName,
    SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM
    Products
JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Products.ProductName
ORDER BY
    TotalQuantityOrdered DESC;

SELECT
    ProductName,
    Category
FROM
    Products;

SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    AVG(Orders.TotalAmount) AS AverageOrderValue
FROM
    Customers
JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName;

SELECT TOP 1
    Orders.OrderID,
    Customers.CustomerID,
    Customers.FirstName,
    Orders.TotalAmount AS TotalRevenue
FROM
    Orders
JOIN
    Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY
    Orders.TotalAmount DESC;

SELECT
    Products.ProductID,
    Products.ProductName,
    COUNT(OrderDetails.OrderID) AS OrderCount
FROM
    Products
LEFT JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Products.ProductID, Products.ProductName
ORDER BY
    OrderCount DESC;

SELECT
    SUM(Orders.TotalAmount) AS TotalRevenue
FROM
    Orders
WHERE
    Orders.OrderDate >= '2023-01-01'
    AND Orders.OrderDate <= '2023-12-31';

SELECT
    *
FROM
    Customers
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Orders
        WHERE Orders.CustomerID = Customers.CustomerID
    );

SELECT COUNT(*) AS TotalProducts
FROM Products;

SELECT
    SUM(TotalAmount) AS TotalRevenue
FROM
    Orders;

SELECT
    AVG(OrderDetails.Quantity) AS AverageQuantityOrdered
FROM
    OrderDetails
JOIN
    Products ON OrderDetails.ProductID = Products.ProductID
WHERE
    Products.Category = 'Electronic Gadget';

SELECT
    SUM(TotalAmount) AS TotalRevenue
FROM
    Orders
WHERE
    CustomerID = 2;

SELECT TOP 1
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    COUNT(Orders.OrderID) AS NumberOfOrders
FROM
    Customers
JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName
ORDER BY
    NumberOfOrders DESC;

SELECT TOP 1
    Products.Category,
    SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM
    Products
JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Products.Category
ORDER BY
    TotalQuantityOrdered DESC;


SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    COUNT(Orders.OrderID) AS NumberOfOrders,
    SUM(Orders.TotalAmount) AS TotalRevenue,
    AVG(Orders.TotalAmount) AS AverageOrderValue
FROM
    Customers
LEFT JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName;

SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    COUNT(Orders.OrderID) AS OrderCount
FROM
    Customers
LEFT JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName
ORDER BY
    OrderCount DESC;

