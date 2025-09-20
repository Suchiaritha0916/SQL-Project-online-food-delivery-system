-- SQL-PROJECT-ONLINE FOOD DELIVERY--
#CREATING DATABASE
CREATE DATABASE ONLINE_FOOD_DELIVERY;

#USING THE DATABASE
USE ONLINE_FOOD_DELIVERY;

#TABLE DESIGNS
-- 1.CUSTOMERS:WHO ORDERS THE FOOD
-- 2.RESTAURANTS:RESTAURANTS THAT SELL FOOD
-- 3.MENU:FOOD ITEMS OFFERED BY RESTAURANTS
-- 4.ORDER:EACH ORDER PLACED
-- 5.ORDER_ITEMS:FOOD ITEMS INSIDE AN ORDER
-- 6.DELIVERY_PERSON:DELIVERY PARTNERS
-- 7.PAYMENTS:ORDER PAYMENTS

#TABLE CREATION

-- 1.CUSTOMERS TABLE-
CREATE TABLE CUSTOMERS (
CUSTOMERS_ID INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(20),
PHONE VARCHAR(50),
ADDRESS VARCHAR(100)
);

-- INSERTING VALUES INTO CUSTOMERS TABLE
INSERT INTO CUSTOMERS(NAME,PHONE,ADDRESS) VALUES
('SUCHI','8328620225','BANGLORE'),
('ANISHA','9440092204','VIZAG'),
('SUHASINI','6300038208','VIZAG'),
('VASANTHA','9823456723','HYDERABAD'),
('MANISHA','9756342356','DHONE'),
('PAVANI','8934256782','KURNOOL'),
('GAYATRY','6324578923','ADHONI'),
('TONY','8345678236','BANGLORE'),
('CHAKRI','9872458357','HYDERABAD'),
('RAGHAVU','9234567256','BANGLORE'),
('LIVIN','8763297843','KERALA'),
('EDWIN','8932578423','KERALA');
SELECT * FROM CUSTOMERS;

-- RESTAURANTS TABLE--
CREATE TABLE RESTAURANTS (
RESTAURANT_ID INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(30),
LOCATION VARCHAR(50)
);

-- INSERTING VALUES INTO RESTAURANTS TABLE--
INSERT INTO RESTAURANTS (NAME,LOCATION) VALUES
('PIZZA HUT','VIZAG'),
('DOMINAS','BANGLORE'),
('FORESTA','KURNOOL'),
('KAIRALI','KERALA'),
('MANDI HOUSE','HYDERABAD');

SELECT * FROM RESTAURANTS;

-- MENU TABLE (FOOD ITEMS OFFERED BY RESTAURANTS)--
CREATE TABLE MENU (
ITEM_ID INT PRIMARY KEY AUTO_INCREMENT,
RESTAURANT_ID INT,
ITEM_NAME VARCHAR(50),
PRICE DECIMAL(6,2),
FOREIGN KEY (RESTAURANT_ID) REFERENCES RESTAURANTS(RESTAURANT_ID)
);

-- INSERTING VALUES INTO THE MENU TABLE--
INSERT INTO MENU (RESTAURANT_ID,ITEM_NAME,PRICE) VALUES
(1,'VEG PIZZA',200),
(2,'BURGER',250),
(3,'BIYANI',350),
(4,'PANNER CURRY',200),
(5,'EGG RICE',150),
(1,'GOBHI RICE',120),
(2,'CHICKEN PULKA',400),
(3,'CHICKEN WINGS-4PCS',450),
(4,'SANDWIGY',200),
(5,'PANNER CHESEE ROLL',100);

SELECT * FROM MENU;

-- ORDERS TABLE--
CREATE TABLE ORDERS(
ORDER_ID INT PRIMARY KEY AUTO_INCREMENT,
CUSTOMERS_ID INT,
RESTAURANT_ID INT,
ORDER_DATE DATETIME,
STATUS VARCHAR(20),
foreign key (CUSTOMERS_ID) REFERENCES CUSTOMERS(CUSTOMERS_ID),
foreign key (RESTAURANT_ID)  REFERENCES RESTAURANTS(RESTAURANT_ID)
);
SELECT * FROM ORDERS;

-- INSERTING VALUES INTO THE ORDERS--
INSERT INTO ORDERS (CUSTOMERS_ID,RESTAURANT_ID,ORDER_DATE,STATUS) VALUES
(1,1,NOW(),'DELIVERED'),
(3,4,NOW(),'PACKING'),
(10,3,NOW(),'ON THE WAY'),
(12,4,NOW(),'DELIVERED'),
(6,2,NOW(),'PREPARING'),
(5,5,NOW(),'WAITING FOR PARTNER');

-- ORDER ITEMS--
CREATE TABLE ORDER_ITEMS(
ORDERITEM_ID INT PRIMARY KEY AUTO_INCREMENT,
ORDER_ID INT,
ITEM_ID INT,
QUANTITY INT,
FOREIGN KEY (ORDER_ID) references ORDERS (ORDER_ID),
FOREIGN KEY (ITEM_ID) references MENU (ITEM_ID)
);
SELECT * FROM ORDER_ITEMS;

-- INSERTING VALUES INTO THE ORDER_ITEMS TABLES
INSERT INTO ORDER_ITEMS(ORDER_ID,ITEM_ID,QUANTITY) VALUES
(1,1,2),
(3,4,2),
(2,2,1),
(3,5,3),
(2,3,2);

-- DELIVERY PERSON TABLE--
CREATE TABLE Delivery_Person (
    DeliveryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    Vehicle VARCHAR(20)
);

-- INSERTING VALUES INTO THE  Delivery_Person--
INSERT INTO Delivery_Person (Name, Phone, Vehicle) VALUES
('Arjun', '2345895134', 'Bike'),
('Ravi', '2345678123', 'Scooter'),
('Sheshy', '8645378924', 'bike'),
('Ram', '3456278912', 'Scooter'),
('Varma', '123456278', 'Bike');

select * from Delivery_Person;

-- Payments Table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT,
    Amount DECIMAL(8,2),
    Payment_Method VARCHAR(20),
    Payment_Status VARCHAR(20),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- insertng values into the Payments table--
INSERT INTO Payments (Order_ID, Amount, Payment_Method, Payment_Status) VALUES
(1, 620, 'UPI', 'Success'),
(2, 300, 'Cash', 'Pending'),
(4, 620, 'UPI', 'Success'),
(5, 620, 'Cash', 'Pending'),
(3, 620, 'UPI', 'Success');

select * from Payments;

-- All tables data
SELECT * FROM CUSTOMERS;
SELECT * FROM RESTAURANTS;
SELECT * FROM MENU;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_ITEMS;
select * from Delivery_Person;
select * from Payments;

-- queries--
#1.Show all the customers from hyderabad
select * from CUSTOMERS where address='HYDERABAD';

#2.List all the restaurants in alphabetical order
select * from RESTAURANTS order by name;

#3.Find food items price above 200
select * from menu where price>200;

#4.Get the 3 most expensive menu items
select * from menu order by price desc
limit 3;

#5.Show all delivered orders
select * from orders where status="delivered";

#6.Find customers who lives in either hyderabad or banglore
select * from customers where address="Hyderabad" or address="Banglore";
-- or--
select * from customers where address in ("Hyderabad","Banglore");

#7.show menu items wtith price between 150 and 300 in order wise
select * from menu where price between 150 and 300 order by price;

#8.List customers whose name starts with "S"
select * from customers where name like "s%";

#9.Find orders that are not yet delivered
select * from orders where status not in ("delivered");
-- or--
select * from orders where status <> "delivered";

#10.Find customer whose customerId is greater than 2
select customers_id,name from customers where customers_id>2;

#11.Find payments where amount is greater than 500 and status is success
select * from payments where amount>500 and payment_status="success";

#12.customer names with their orders
select c.name,o.order_id,o.status from orders as o 
join
customers as c on c.customers_id=o.customers_id;

#13.show all orders with the customer name and order status
select c.name,o.status from orders as o 
inner join 
customers as c on c.customers_id=o.customers_id;

#14.show restaurant name along with their food items and prices
select r.name,m.item_name,m.price from RESTAURANTS r
inner join
menu m on m.restaurant_id=r.restaurant_id;

#15.list 5 most expensive item in each restaurant
select r.name,m.item_name,m.price from restaurants r
inner join
menu m on m.restaurant_id=r.restaurant_id 
order by price desc limit 5;

#16.show all orders with payments methods and payment satus
select p.payment_method,p.payment_status from payments p
inner join
orders o on o.order_id=p.order_id;

#17.show all customers with their orders (include customers who never ordered)
select *from customers c
left join
orders r on c.customers_id=r.customers_id;

#18.List all menu items and the restaurant they belong to (show NULL if restaurant is missing).
select * from menu m
left join
restaurants r on m.restaurant_id=r.restaurant_id;

#19.Show all restaurants with orders (include restaurants that have never received an order).
select *from restaurants r
left join
orders o on o.restaurant_id=r.restaurant_id;

#20.List all customers who placed an order and also show unmatched orders
select * from orders o
right join
customers c on o.customers_id=c.customers_id;

#21.Display all items priced above 200 with restaurant names 
-- (include orders even if the restaurant is missing).
select r.name,m.item_name,m.price from restaurants r
right join
menu m on m.restaurant_id=r.restaurant_id and price>200;

#22.Find all orders with payment info (include payments even if the order doesn’t exist).
select * from payments p
right join
orders o on p.order_id=o.order_id;

#23.Display all payments and all orders — regardless of whether they’re matched.
select * from payments p
left join
orders o on p.order_id=o.order_id
union 
select * from payments p
right join
orders o on p.order_id=o.order_id;

#24.FULL JOIN Customers and Orders
SELECT c.Customers_ID, c.Name, o.Order_ID, o.Status
FROM Customers c
LEFT JOIN Orders o ON c.Customers_ID = o.Customers_ID
UNION
SELECT c.Customers_ID, c.Name, o.Order_ID, o.Status
FROM Customers c
RIGHT JOIN Orders o ON c.Customers_ID = o.Customers_ID;

#25. All possible combinations of Customers and Restaurants
SELECT c.Customers_ID, c.Name AS CustomerNames, r.Restaurant_ID, r.Name
FROM Customers c
CROSS JOIN Restaurants r;

#26.Customers with all menu items under 300
SELECT c.Customers_ID, c.Name AS CustomerName, m.Item_Name, m.Price
FROM Customers c
CROSS JOIN Menu m
WHERE m.Price < 300;

#27.Count total customers
SELECT COUNT(*) FROM Customers;
#28.Display total items in a menu card
select count(item_name) from menu;

-- 29.Average price of dominas items
SELECT AVG(Price) 
FROM Menu m
JOIN Restaurants r ON m.Restaurant_ID = r.Restaurant_ID
WHERE r.Name = 'dominas';

-- 30.Highest order amount
SELECT MAX(Amount) FROM Payments;

-- 31.Total revenue collected
SELECT SUM(Amount) FROM Payments WHERE Payment_Status = 'Success';

-- 32.Orders per restaurant
SELECT r.Name, COUNT(o.Order_ID) AS TotalOrders
FROM Restaurants r
LEFT JOIN Orders o ON r.Restaurant_ID = o.Restaurant_ID
GROUP BY r.Name;

-- 33. Orders per customer
SELECT c.Name, COUNT(o.Order_ID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.Customers_ID = o.Customers_ID
GROUP BY c.Name;

-- 34.Revenue by restaurant
SELECT r.Name, SUM(p.Amount) AS Revenue
FROM Restaurants r
JOIN Orders o ON r.Restaurant_ID = o.Restaurant_ID
JOIN Payments p ON o.Order_ID = p.Order_ID
WHERE p.Payment_Status = 'Success'
GROUP BY r.Name;

-- 35.Items sold per restaurant
SELECT r.Name, SUM(oi.Quantity) AS ItemsSold
FROM Order_Items oi
JOIN Orders o ON oi.Order_ID = o.Order_ID
JOIN Restaurants r ON o.Restaurant_ID = r.Restaurant_ID
GROUP BY r.Name;

-- 36. Customers with less than 2 orders
SELECT c.Name, COUNT(o.Order_ID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.Customers_ID = o.Customers_ID
GROUP BY c.Name
HAVING COUNT(o.Order_ID) <3;

-- 37.Restaurants with revenue > 300
SELECT r.Name, SUM(p.Amount) AS Revenue
FROM Restaurants r
JOIN Orders o ON r.Restaurant_ID = o.Restaurant_ID
JOIN Payments p ON o.Order_ID = p.Order_ID
GROUP BY r.Name
HAVING SUM(p.Amount) >300;

-- 38.Get menu items priced higher than the average price of all items.
select item_name,price from menu
where price>(select avg(price) from menu);

-- 39. Customers who never placed an order 
select name from customers
where customers_id not in (select distinct customers_id from orders);

-- 40. Customers who ordered from more than 2 restaurants
SELECT Name 
FROM Customers
WHERE Customers_ID IN (
    SELECT Customers_ID 
    FROM Orders 
    GROUP BY Customers_ID 
    HAVING COUNT(DISTINCT Restaurant_ID)<2
);

