#Part 1
#easy world questions
use world;
#1
SELECT name FROM country WHERE region = "South America"; 
#2
SELECT Population FROM country WHERE country.Code = 'DEU';
#3
SELECT Name FROM city WHERE CountryCode = 'JPN';
#medium world questions
#4
SELECT population FROM country WHERE Continent = "Africa" ORDER BY Population DESC LIMIT 3;
#5
SELECT country.Name, LifeExpectancy FROM country WHERE Population > 1000000 AND Population < 5000000;
#6
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';
#easy chinook questions
use Chinook_AutoIncrement;
#7
SELECT Title FROM Album JOIN Artist ON Artist.ArtistId = Album.ArtistID  WHERE Artist.name = 'AC/DC';
#8
SELECT FirstName, LastName, Email FROM Employee WHERE Country = "Brazil";
#9
SELECT Name FROM Playlist;
#medium chinook questions
#10
SELECT Count(Track.TrackId) AS TrackCount
FROM Track
Join Genre on Genre.GenreID = Track.GenreID 
WHERE Genre.name = "Rock";
#11
SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards');
#12
SELECT FirstName, LastName, SUM(Invoice.Total) AS TotalSales FROM Invoice JOIN Customer ON Invoice.CustomerID = Customer.CustomerID GROUP BY Customer.CustomerID;





#Part 2 design database- coffee shop
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  Email VARCHAR(100),
  PhoneNumber VARCHAR(20)
);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(100),
  Description TEXT,
  Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductID INT,
  OrderDate DATE,
  Quantity INT,
  TotalPrice DECIMAL(10, 2),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO Customers (CustomerID, FirstName, LastName) VALUES
(1, 'Emily', 'Sun'),
(2, 'Jane', 'Doe'),
(3, 'Bob', 'Jones'),
(4, 'Chris', 'Smith'),
(5, 'Lisa', 'Taylor');

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Espresso', 2.50),
(2, 'Latte', 3.50),
(3, 'Cappuccino', 3.00),
(4, 'Americano', 2.75),
(5, 'Mocha', 3.75);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity, TotalPrice) VALUES
(1, 1, 1, '2024-09-08', 2, 5.00),
(2, 2, 2, '2024-09-08', 1, 3.50),
(3, 3, 3, '2024-09-08', 3, 9.00),
(4, 4, 4, '2024-09-08', 1, 2.75),
(5, 5, 5, '2024-09-08', 2, 7.50);

#all customers and their orders
SELECT c.FirstName, c.LastName, p.ProductName, o.OrderDate, o.Quantity, o.TotalPrice
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID;

#total revenue for each product
SELECT p.ProductName, SUM(o.TotalPrice) AS Revenue
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductName;

#customers who have spent more than 10 dollars
SELECT c.FirstName, c.LastName, SUM(o.TotalPrice) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING SUM(o.TotalPrice) > 10;
