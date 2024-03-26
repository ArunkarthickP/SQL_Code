create database warranty_management_system;
go;

use warranty_management_system;
go;

----drop  database warranty_management_system 
---go;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- buyers table
create table buyers (
    buyer_id int primary key,
    full_name varchar(100),
    email varchar(100),
    phone bigInt,
    address varchar(255),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);

-- Insert a new buyer
INSERT INTO buyers (buyer_id, full_name, email, phone, address, created_at, created_by, updated_at) 
VALUES (1, 'Buyer1', 'buyer@example.com', 1234567890, '123 Main St', GETDATE(), 'Admin', NULL );

-- Select all buyers
SELECT * FROM buyers;


-- Update buyer information
UPDATE buyers SET full_name = 'Updated Name' WHERE buyer_id = 1;=


-- Delete a buyer
DELETE FROM buyers WHERE buyer_id = 1;


-- Drop tables in the database

DROP TABLE buyers

--- Truncate Table in database

TRUNCATE TABLE buyers;

--- Index 

CREATE INDEX idx_buyers_email ON buyers (buyer_id,email);

go

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- sellers table
create table sellers (
    seller_id int primary key,
    full_name varchar(100),
    email varchar(100),
    phone varchar(20),
    address varchar(255),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);

-- Insert a new seller
INSERT INTO sellers (seller_id, full_name, email, phone, address, created_at, created_by, updated_at) 
VALUES (1, 'Seller1', 'seller@example.com', '9876543210', '456 ABC St', GETDATE(), 'Admin', NULL);


-- Select all sellers
SELECT * FROM sellers;


-- Update seller information
UPDATE sellers SET full_name = 'Updated Name' WHERE seller_id = 1;


-- Delete a seller
DELETE FROM sellers WHERE seller_id = 1;



-- Drop tables in the database

DROP TABLE sellers;

--- Truncate Table in database

TRUNCATE TABLE sellers;

---index

CREATE INDEX idx_sellers_email ON sellers (Seller_id,email);
drop index idx_sellers_email
go;



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Brands table 

create table brands(
brand_id int primary key,
brand_name  varchar(255),
created_at date,
created_by varchar(255),
updated_at datetime
);



-- Insert a new brand
INSERT INTO brands (brand_id, brand_name, created_at, created_by, updated_at) 
VALUES (1, 'Samsung', GETDATE(), 'Admin', NULL);


-- Select all brands
SELECT * FROM brands;


-- Update brand information
UPDATE brands SET brand_name = 'Updated Brand Name' WHERE brand_id = 1;


-- Delete a brand
DELETE FROM brands WHERE brand_id = 1;


-- Drop tables in the database

DROP TABLE brands;

--- Truncate Table in database

TRUNCATE TABLE brands;

go;

CREATE INDEX idx_brands_brand_name ON brands (brand_name);


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- productstable
create table products(
    product_id int primary key,
    product_name varchar(100),
    seller_id int,
	brand_id int,
	foreign key (brand_id) references brands(brand_id),
    foreign key (seller_id) references sellers(seller_id),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);


-- Insert a new product
INSERT INTO products (product_id, product_name, seller_id, brand_id, created_at, created_by, updated_at) 
VALUES (2, 'Micro Phones', 1, 1, GETDATE(), 'Admin', NULL);

INSERT INTO products (product_id, product_name, seller_id, brand_id, created_at, created_by, updated_at) 
VALUES (1, 'Display', 1, 1, GETDATE(), 'Admin', NULL);


-- Select all products
SELECT * FROM products;


-- Update product information
UPDATE products SET product_name = 'Updated Product Name' WHERE product_id = 1;


-- Delete a product
DELETE FROM products WHERE product_id = 1;



-- Drop tables in the database

DROP TABLE products;

--- Truncate Table in database

TRUNCATE TABLE products;

---Index

CREATE INDEX idx_products_product_name ON products (product_name);
CREATE INDEX idx_products_seller_id ON products (seller_id);
CREATE INDEX idx_products_brand_id ON products (brand_id);


go;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- prices table (for both buyer and seller prices)
create table prices (
    price_id int primary key,
    product_id int,
	brand_id int,
    buyerprice decimal(10, 2),
    sellingprice decimal(10, 2),
	foreign key (brand_id) references brands(brand_id),
    foreign key (product_id) references products(product_id),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);


-- Insert a new price
INSERT INTO prices (price_id, product_id, brand_id, buyerprice, sellingprice, created_at, created_by, updated_at) 
VALUES (1, 1, 1, 100.00, 150.00, GETDATE(), 'Admin', NULL);


INSERT INTO prices (price_id, product_id, brand_id, buyerprice, sellingprice, created_at, created_by, updated_at) 
VALUES (2, 2, 1, 300.00, 450.00, GETDATE(), 'Admin', NULL);



-- Select all prices
SELECT * FROM prices;


-- Update price information
UPDATE prices SET buyerprice = 120.00, sellingprice = 180.00 WHERE price_id = 1;


-- Delete a price
DELETE FROM prices WHERE price_id = 1;


-- Drop tables in the database

DROP TABLE prices;

--- Truncate Table in database

TRUNCATE TABLE prices;

CREATE INDEX idx_prices_product_id ON prices (product_id);
CREATE INDEX idx_prices_brand_id ON prices (brand_id);


go;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- warranty plans
create table warrantyplans (
    plan_id int primary key,
    plan_name varchar(100),
	coverage_period int,
    coverage_details varchar(255),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);
go


-- Insert a new warranty plan
INSERT INTO warrantyplans (plan_id, plan_name, coverage_period, coverage_details_in_months, created_at, created_by, updated_at) 
VALUES (1, 'Basic Warranty', 12, 'Covers manufacturing defects', GETDATE(), 'Admin', NULL);


-- Select all warranty plans
SELECT * FROM warrantyplans;


-- Update warranty plan information
UPDATE warrantyplans SET plan_name = 'Extended Warranty' WHERE plan_id = 1;


-- Delete a warranty plan
DELETE FROM warrantyplans WHERE plan_id = 1;


-- Drop tables in the database

DROP TABLE warrantyplans;

--- Truncate Table in database

TRUNCATE TABLE warrantyplans;


----Index

CREATE INDEX idx_warrantyplans_plan_name ON warrantyplans (plan_name);


go


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- bills table
create table bills (
    bill_id int primary key,
    buyer_id int,
    product_id int,
    price_id int,
    plan_id int,
	brand_id int,
    purchase_date date,
    foreign key (buyer_id) references buyers(buyer_id),
    foreign key (product_id) references products(product_id),
    foreign key (price_id) references prices(price_id),
    foreign key (plan_id) references warrantyplans(plan_id),	
	foreign key (brand_id) references brands(brand_id),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);

-- Insert a new bill
INSERT INTO bills (bill_id, buyer_id, product_id, price_id, plan_id, brand_id, purchase_date, created_at, created_by, updated_at) 
VALUES (1, 1, 1, 1, 1, 1, GETDATE(), GETDATE(), 'Admin', NULL);



-- Select all bills
SELECT * FROM bills;


-- Update bill information
UPDATE bills SET purchase_date = '2024-03-26' WHERE bill_id = 1;


-- Delete a bill
DELETE FROM bills WHERE bill_id = 1;


-- Drop tables in the database

DROP TABLE bills;

--- Truncate Table in database

TRUNCATE TABLE bills;

----Index
CREATE INDEX idx_bills_buyer_id ON bills (buyer_id);
CREATE INDEX idx_bills_product_id ON bills (product_id);
CREATE INDEX idx_bills_price_id ON bills (price_id);
CREATE INDEX idx_bills_plan_id ON bills (plan_id);
CREATE INDEX idx_bills_brand_id ON bills (brand_id);


go

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- claims table
create table claims (
    claim_id int primary key,
    product_id int,
    buyer_id int,
	brand_id int,
    claim_date date,
    claim_details varchar(255),
    foreign key (product_id) references products(product_id),
    foreign key (buyer_id) references buyers(buyer_id),
	foreign key (brand_id) references brands(brand_id),
	created_at date,
	created_by varchar(255),
	updated_at datetime
);


-- Insert a new claim
INSERT INTO claims (claim_id, product_id, buyer_id, brand_id, claim_date, claim_details, created_at, created_by, updated_at) 
VALUES (1, 1, 1, 1, GETDATE(), 'Product stopped working', GETDATE(), 'Admin', NULL);


-- Select all claims
SELECT * FROM claims;


-- Update claim information
UPDATE claims SET claim_details = 'Product malfunctioned' WHERE claim_id = 1;


-- Delete a claim
DELETE FROM claims WHERE claim_id = 1;



-- Drop tables in the database

DROP TABLE claims;

--- Truncate Table in database

TRUNCATE TABLE claims;

----Index
CREATE INDEX idx_claims_product_id ON claims (product_id);
CREATE INDEX idx_claims_buyer_id ON claims (buyer_id);
CREATE INDEX idx_claims_brand_id ON claims (brand_id);

go;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------


----Reports using views
-- Create a view to display buyer information along with their purchased products
CREATE VIEW BuyerProductView AS
SELECT b.full_name AS buyer_name, p.product_name, p.product_id, b.email
FROM buyers b
JOIN bills bl ON b.buyer_id = bl.buyer_id
JOIN products p ON bl.product_id = p.product_id;

select* from BuyerProductView



-- Create a view to display seller information along with their products for sale
CREATE VIEW SellerProductView AS
SELECT s.seller_id, s.full_name AS seller_name, p.product_name, p.product_id, s.email
FROM sellers s
JOIN products p ON s.seller_id = p.seller_id;

-- Create a view to display product prices along with brand information
CREATE VIEW ProductPriceView AS
SELECT pr.product_id, pr.buyerprice, pr.sellingprice, b.brand_name
FROM prices pr
JOIN brands b ON pr.brand_id = b.brand_id;



-- Create a view to get buyer information, purchased products, and their prices (Joins Using Views)
CREATE VIEW BuyerProductPriceView AS
SELECT a.buyer_name, a.product_name, b.buyerprice, b.sellingprice
FROM BuyerProductView a
JOIN ProductPriceView b ON a.product_id = b.product_id;




-- Create a view to get total sales by product
CREATE VIEW GetTotalSalesByProduct
AS
   SELECT p.product_name, SUM(pr.sellingprice) AS total_sales
    FROM products p
    JOIN bills b ON p.product_id = b.product_id
    JOIN prices pr ON b.price_id = pr.price_id
    GROUP BY p.product_name;

select* from GetTotalSalesByProduct;



--- Create A View to display information about products and their warranty status, including the warranty plan details and the remaining coverage period.
CREATE VIEW ProductWarrantyStatusView AS
SELECT p.product_id, p.product_name, wp.plan_name, wp.coverage_period, wp.coverage_details, DATEDIFF(MONTH, GETDATE(), DATEADD(MONTH, wp.coverage_period, bl.purchase_date)) AS remaining_coverage_months
FROM products p
LEFT JOIN bills bl ON p.product_id = bl.product_id
LEFT JOIN warrantyplans wp ON bl.plan_id = wp.plan_id;



--- Create A View  to  display the count of products associated with each brand.

CREATE VIEW BrandProductCountView AS
SELECT b.brand_id, b.brand_name, COUNT(p.product_id) AS product_count
FROM brands b
LEFT JOIN products p ON b.brand_id = p.brand_id
GROUP BY b.brand_id, b.brand_name;


select*from BrandProductCountView



---Create A View to display the purchases made by each buyer, including the total number of purchases and the total amount spent.
 CREATE VIEW BuyerPurchaseSummaryView AS
SELECT b.buyer_id, b.full_name AS buyer_name, COUNT(bl.bill_id) AS total_purchases, SUM(pr.sellingprice) AS total_amount_spent
FROM buyers b
LEFT JOIN bills bl ON b.buyer_id = bl.buyer_id
LEFT JOIN prices pr ON bl.price_id = pr.price_id
GROUP BY b.buyer_id, b.full_name;




----create a view to summarize the sales made by each seller, including the total number of products sold and the total revenue generated.

CREATE VIEW SellerSalesSummaryView AS
SELECT s.seller_id, s.full_name AS seller_name, COUNT(bl.bill_id) AS total_sales, SUM(pr.sellingprice) AS total_revenue
FROM sellers s
LEFT JOIN products p ON s.seller_id = p.seller_id
LEFT JOIN bills bl ON p.product_id = bl.product_id
LEFT JOIN prices pr ON bl.price_id = pr.price_id
GROUP BY s.seller_id, s.full_name;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
----Stored Procedure Queries

CREATE PROCEDURE InsertBuyer
    @buyer_id int,
    @full_name VARCHAR(100),
    @email VARCHAR(100),
    @phone BIGINT,
    @address VARCHAR(255),
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO buyers (buyer_id,full_name, email, phone, address, created_at, created_by, updated_at)
    VALUES (@buyer_id,@full_name, @email, @phone, @address, GETDATE(), @created_by,CURRENT_TIMESTAMP);
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE InsertSeller
    @seller_id int ,
    @full_name VARCHAR(100),
    @email VARCHAR(100),
    @phone VARCHAR(20),
    @address VARCHAR(255),
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO sellers (seller_id,full_name, email, phone, address, created_at, created_by, updated_at)
    VALUES (@seller_id,@full_name, @email, @phone, @address, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE InsertBrand
    @brand_id int,
    @brand_name VARCHAR(255),
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO brands (brand_id,brand_name, created_at, created_by, updated_at)
    VALUES (@brand_id,@brand_name, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE InsertProduct
    @product_id int,
    @product_name VARCHAR(100),
    @seller_id INT,
    @brand_id INT,
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO products (product_id,product_name, seller_id, brand_id, created_at, created_by, updated_at)
    VALUES (@product_id,@product_name, @seller_id, @brand_id, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE InsertPrice
    @price_id INT,
    @product_id INT,
    @brand_id INT,
    @buyerprice DECIMAL(10, 2),
    @sellingprice DECIMAL(10, 2),
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO prices (price_id,product_id, brand_id, buyerprice, sellingprice, created_at, created_by, updated_at)
    VALUES (@price_id,@product_id, @brand_id, @buyerprice, @sellingprice, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE InsertWarrantyPlan
    @plan_id INT,
    @plan_name VARCHAR(100),
    @coverage_period INT,
    @coverage_details VARCHAR(255),
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO warrantyplans (plan_id,plan_name, coverage_period, coverage_details, created_at, created_by, updated_at)
    VALUES (@plan_id,@plan_name, @coverage_period, @coverage_details, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE InsertBill
    @bill_id INT,
    @buyer_id INT,
    @product_id INT,
    @price_id INT,
    @plan_id INT,
    @brand_id INT,
    @purchase_date DATE,
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO bills (bill_id,buyer_id, product_id, price_id, plan_id, brand_id, purchase_date, created_at, created_by, updated_at)
    VALUES (@bill_id,@buyer_id, @product_id, @price_id, @plan_id, @brand_id, @purchase_date, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE InsertClaim
    @claim_id INT,
    @product_id INT,
    @buyer_id INT,
    @brand_id INT,
    @claim_date DATE,
    @claim_details VARCHAR(255),
    @created_by VARCHAR(255)
AS
BEGIN
    INSERT INTO claims (claim_id,product_id, buyer_id, brand_id, claim_date, claim_details, created_at, created_by, updated_at)
    VALUES (@claim_id,@product_id, @buyer_id, @brand_id, @claim_date, @claim_details, GETDATE(), @created_by, CURRENT_TIMESTAMP);
END;



-----------------------------------------------------------------------------------------------------------------------------------------------------
