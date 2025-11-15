
-- Intermediate SQL Project: Online Store Database

-- 1. Create Tables
CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price INT
);

CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 2. Insert Data
INSERT INTO Customers VALUES
(1, 'Rahul', 'Bangalore'),
(2, 'Anita', 'Mumbai'),
(3, 'Vikram', 'Delhi');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Headphones', 'Electronics', 3000),
(103, 'Chair', 'Furniture', 2500);

INSERT INTO Orders VALUES
(501, 1, 101, 1, '2024-04-01'),
(502, 2, 102, 2, '2024-04-03'),
(503, 1, 103, 1, '2024-04-05'),
(504, 3, 101, 1, '2024-04-07');

-- 3. Query: Get all orders with customer and product names
SELECT O.OrderID, C.Name AS Customer, P.ProductName, O.Quantity, O.OrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID;

-- 4. Query: Total amount spent by each customer
SELECT C.Name, SUM(P.Price * O.Quantity) AS TotalSpent
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.Name;

-- 5. Query: Most expensive product ordered
SELECT ProductName, Price
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

-- 6. Query: Count orders made in April 2024
SELECT COUNT(*) AS TotalOrders
FROM Orders
WHERE OrderDate BETWEEN '2024-04-01' AND '2024-04-30';

-- 7. Query: List customers who bought Electronics items
SELECT DISTINCT C.Name
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Category = 'Electronics';
