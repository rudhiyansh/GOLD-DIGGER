# DATA DIGGER

# Create GOLD DIGGER DATABASE

CREATE DATABASE GOLD_DIGGER;

#Create Costomers Tabel

USE GOLD_DIGGER;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY AUTO_INCREMENT ,
Name VARCHAR (50),
Email VARCHAR (100),
Address VARCHAR (150)
);

# Insert at least 5 sample customers into the Customers table.

INSERT INTO customers (Name, Email, Address) VALUES
('Alice', 'alice@email.com', '12 MG Road, Surat'),
('Bhavesh', 'bhavesh@email.com', '45 Ring Road, Surat'),
('Alice', 'alice.j@email.com', '9 Park Street, Ahmedabad'),
('Kavita', 'kavita@email.com', '78 Station Road, Vadodara'),
('Rohit', 'rohit@email.com', '3 Lake View, Rajkot');

# Retrieve all customer details.

SELECT * FROM customers;

# Update a customer's address.

UPDATE customers
SET Address = "103 , Station Road , Navsari"
WHERE CustomerID = 2;

# Delete a customer using their CustomerID.

DELETE FROM customers WHERE CustomerID = 1;

# Display all customers whose name is 'Alice'.

SELECT * FROM customers
WHERE Name = "Alice";

#Create Orders Tables 

USE GOLD_DIGGER ;

CREATE TABLE orders (
OrderID INT PRIMARY KEY AUTO_INCREMENT ,
CustomerID INT,
OrderDate DATE ,
TotalAmount DECIMAL (10,2) 
);

# Insert at least 5 sample orders into the Orders table.

INSERT INTO orders (CustomerID , OrderDate , TotalAmount) VALUES
(1, '2026-08-01', 2500.00),
(2, '2026-08-05', 1200.50),
(1, '2026-08-10', 3400.00),
(3, '2026-09-15', 899.00),
(4, '2026-09-29', 5600.00);

# Retrieve all orders made by a specific customer.

SELECT * FROM orders 
WHERE CustomerID = 2;

# Update an order's total amount.

UPDATE orders 
SET TotalAmount = 2000.00
WHERE OrderID = 2;

# Delete an order using its OrderID.

DELETE FROM orders WHERE OrderID = 3;

# Retrieve orders placed in the last 30 days.

SELECT * FROM orders
WHERE OrderDate > 30 ;

# Retrieve the highest, lowest, and average order amount using aggregate functions.

SELECT MAX(TotalAmount) , MIN(TotalAmount) , AVG(TotalAmount) FROM orders;

#Create Products Table 

USE GOLD_DIGGER;

CREATE TABLE products (
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductName VARCHAR (50),
price DECIMAL (10,2),
stock INT 
);

# Insert at least 5 sample products into the Products table.

INSERT INTO products (ProductName, Price, Stock) VALUES
('Wireless Mouse', 650.00, 40),
('Mechanical Keyboard', 2200.00, 15),
('USB-C Hub', 1499.00, 0),
('Laptop Stand', 899.00, 25),
('Bluetooth Speaker', 1899.00, 10);

# Retrieve all products sorted by price in descending order.

SELECT * FROM products
ORDER BY price DESC;

# Update the price of a specific product.

UPDATE products
SET price = 3200.00
WHERE ProductID = 3;

# Delete a product if it's out of stock.

DELETE FROM products
WHERE stock = 0;

# Retrieve products whose price is between ₹500 and ₹2000.

SELECT * FROM products
WHERE price BETWEEN 500 AND 2000;

# Retrieve the most expensive and cheapest product using MAX() and MIN().

SELECT MAX(price) AS MaxPrice , MIN(price) AS MinPrice FROM products;

#Create OrderDetails Table

USE GOLD_DIGGER;

CREATE TABLE OrderDetails (
OrderDetailIID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT ,
ProductID INT,
Quantity INT,
SubTotal DECIMAL (10,2),
FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

# Insert at least 5 sample records into the OrderDetails table.

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 2, 1398.00),
(1, 2, 1, 2200.00),
(2, 4, 1, 899.00),
(4, 1, 3, 2097.00),
(5, 2, 1, 2200.00);

# Retrieve all order details for a specific order.

SELECT * FROM OrderDetails WHERE OrderID = 2;

# Calculate the total revenue generated from all orders using SUM().

SELECT SUM(SubTotal) AS TotalRevenue FROM OrderDetails ;

# Retrieve the top 3 most ordered products.

SELECT p.ProductName , SUM(o.Quantity) AS TotalQuantitySold FROM OrderDetails o 
JOIN products p ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC
LIMIT 3;

# Count how many times a specific product has been sold using COUNT().

SELECT p.ProductName , COUNT(*) AS TimesSold , SUM(o.Quantity) AS TotalUnitsSold
FROM OrderDetails o 
JOIN products p ON o.ProductID = p.ProductID
WHERE o.ProductID = 1
GROUP BY p.ProductName;