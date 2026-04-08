-- =========================
-- LIMPIEZA
-- =========================
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS salesRep;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS products;

-- =========================
-- TABLAS
-- =========================

CREATE TABLE offices(
    office INT PRIMARY KEY,
    city VARCHAR(50),
    region VARCHAR(50),
    target DECIMAL(10,2),
    sales DECIMAL(10,2)
);

CREATE TABLE salesRep(
    empl_num INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    rep_office INT,
    title VARCHAR(50),
    hire_date DATETIME,
    manager INT,
    quota DECIMAL(10,2),
    sales DECIMAL(10,2),
    FOREIGN KEY (rep_office) REFERENCES offices(office),
    FOREIGN KEY (manager) REFERENCES salesRep(empl_num)
);

CREATE TABLE customers(
    cust_num INT PRIMARY KEY,
    company VARCHAR(100),
    cust_rep INT,
    credit_limit DECIMAL(10,2),
    FOREIGN KEY (cust_rep) REFERENCES salesRep(empl_num)
);

CREATE TABLE products (
    mfr_id CHAR(3),
    product_id CHAR(5),
    description VARCHAR(100),
    price DECIMAL(10,2),
    qty_on_hand INT,
    PRIMARY KEY (mfr_id, product_id)
);

CREATE TABLE orders (
    order_num INT PRIMARY KEY,
    order_date DATETIME,
    cust INT,
    rep INT,
    mfr CHAR(3),
    product CHAR(5),
    qty INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (cust) REFERENCES customers(cust_num),
    FOREIGN KEY (rep) REFERENCES salesRep(empl_num),
    FOREIGN KEY (mfr, product) REFERENCES products(mfr_id, product_id)
);

-- =========================
-- INSERTS
-- =========================

-- offices
INSERT INTO offices VALUES
(101,'Denver','Western',300000,186042),
(102,'New York','Eastern',575000,692637),
(103,'Chicago','Eastern',800000,735042),
(104,'Atlanta','Eastern',350000,367911),
(105,'Los Angeles','Western',725000,835915);

-- salesRep
INSERT INTO salesRep VALUES
(102,'Sue Smith',48,101,'Sales Rep','1986-12-10',NULL,350000,464000),
(104,'Bill Adams',37,102,'Sales Rep','1988-02-12',102,350000,367911),
(105,'Mary Jones',31,103,'Sales Rep','1989-10-12',102,300000,392725),
(106,'Sam Clark',52,104,'VP Sales','1988-06-14',NULL,275000,299000),
(108,'Tom Brown',45,105,'Sales Rep','1990-03-01',106,280000,310000);

-- customers
INSERT INTO customers VALUES
(2101,'JCP Inc.',102,50000),
(2102,'First Corp.',104,65000),
(2103,'Acme Mfg.',105,50000),
(2104,'Carter & Sons',102,40000),
(2105,'Ace International',108,35000),
(2106,'Smithson Corp.',104,20000),
(2107,'Jones Mfg.',106,65000);

-- products
INSERT INTO products VALUES
('REI','2A44L','Ratchet Link',79,210),
('ACI','41003','Widget Remover',2750,25),
('FEA','00114','Reducer',355,38),
('QSA','K47','Plate',180,2),
('ACI','41004','900-lb Brace',1875,9),
('ACI','4100Z','Size 3 widget',107,207),
('REI','2A44R','Size 4 widget',117,139);

-- orders
INSERT INTO orders VALUES
(112961,'1989-12-17',2101,102,'REI','2A44L',7,553),
(112962,'1989-12-18',2102,104,'ACI','41003',2,5500),
(112978,'1989-02-20',2103,105,'FEA','00114',6,2130),
(113961,'2008-12-20',2104,102,'QSA','K47',4,720),
(114961,'1989-12-21',2105,108,'ACI','41004',3,5625),
(115161,'1998-12-22',2106,104,'ACI','4100Z',9,963),
(111963,'2011-12-23',2107,106,'REI','2A44R',10,1170);