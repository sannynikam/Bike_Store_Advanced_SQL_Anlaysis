DROP SCHEMA IF EXISTS Bike_Store;
create database Bike_Store;
use Bike_Store;

-- CREATING TABLE SCHEMA OF CUSTOMERS

CREATE TABLE Customers ( 
 Cust_Id INT PRIMARY KEY, 
 first_name VARCHAR(50), 
 last_name VARCHAR(50), 
 phone_number VARCHAR(20), 
 email VARCHAR(50), 
 street VARCHAR(50), 
 city VARCHAR(50), 
 state VARCHAR(50), 
 zip_code INT 
 
);


-- CREATING TABLE SCHEMA OF BRANDS
 
CREATE TABLE Brands ( 
 Brand_id INT PRIMARY KEY, 
 Brand_name VARCHAR(50)
 
);


-- CREATING TABLE SCHEMA OF CATEGORIES

CREATE TABLE Categories (
  Category_id INT PRIMARY KEY, 
  Category_name VARCHAR (50)
  
 );
  
  
 -- CREATING TABLE SCHENA STAFFS
 
 CREATE TABLE Staffs (
  Staff_id INT PRIMARY KEY,
  First_name varchar (50),
  last_name VARCHAR (50),
  Email VARCHAR (50),
  Phone VARCHAR (50),
  active_rate TINYINT,
  Store_id INT,
  Manager_id INT 
  
);



-- CREATING TABLE SCHEMA OF ORDERS 

 CREATE TABLE Orders (
   Order_id INT PRIMARY KEY, 
   Customer_id INT, 
   Order_Status INT, 
   Order_Date DATE,
   Required_Date DATE, 
   Shipped_Date DATE, 
   Store_id INT, 
   Staff_id INT,
   
   
   FOREIGN KEY (customer_id) REFERENCES customers(cust_id),
   FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
   
);


-- CREATING TABLE SCHEMA PRODUCTS 

CREATE TABLE Products ( 
 Product_id INT PRIMARY KEY,
 Product_name VARCHAR (50),
 Brand_id INT,
 Category_id INT,
 Model_year INT, 
 List_price float,
 
 FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
 FOREIGN KEY (category_id) REFERENCES categories(category_id)
    
 );
 
 
 -- CREATING TABLE SCHEMA ORDER ITEMS 

CREATE TABLE Order_Items (
  Order_id INT PRIMARY KEY, 
  Items_id INT, 
  Product_id INT, 
  Quantity INT, 
  List_Price INT, 
  Discount INT,
  
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
  
  );
 
 

-- CREATING TABLE SCHEMA STORES

CREATE TABLE Stores (
 Store_id INT PRIMARY KEY,
 Store_name VARCHAR (50),
 Phone VARCHAR(50),
 Email VARCHAR (50),
 Street VARCHAR (50),
 City VARCHAR (50),
 State VARCHAR (50),
 Zip_code INT
 
);


-- CREATING TABLE SCHEMA STOCKS 

CREATE TABLE Stocks (
 Store_id INT PRIMARY KEY,
 Product_id INT,
 Quantity INT,
 
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
 
);


 

  
  
  
 
 
