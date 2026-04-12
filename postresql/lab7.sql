-- PARTE 1 -------------------------------------------------------------------------------------
SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM salesRep;

SELECT * FROM offices;

SELECT c.company, o.order_num, o.amount
FROM customers c
JOIN orders o ON c.cust_num = o.cust;


SELECT c.company, o.order_num, o.amount, s.name
FROM customers c
JOIN orders o ON c.cust_num = o.cust
JOIN salesRep s ON c.cust_rep = s.empl_num;

SELECT c.company, SUM(o.amount) AS total_gastado
FROM customers c
JOIN orders o ON c.cust_num = o.cust
GROUP BY c.company;

SELECT *
FROM orders o 
FULL OUTER JOIN customers c ON o.rep = cust_rep;




--PARTE 2 -----------------------------------------------------------------------------------

--EJ 1
CREATE VIEW empleado102 AS 
SELECT *
FROM orders AS o
WHERE o.rep = 102;

SELECT * FROM empleado102;

--EJ 2
CREATE VIEW inciso2 AS 
SELECT c.company, SUM(o.amount) AS total_pedidos
FROM customers c 
JOIN orders o ON o.cust = cust_num
GROUP BY c.company
HAVING SUM(o.amount) > 30000;

SELECT * FROM inciso2;

--EJ 3
CREATE VIEW inciso3 AS 
SELECT o.office, o.city, o.region
FROM offices o;

SELECT * FROM inciso3;


--EJ 4
CREATE VIEW inciso4 AS 
SELECT c.company, c.cust_rep, s.name
FROM customers c 
JOIN salesRep s ON c.cust_rep = s.empl_num;

SELECT * FROM inciso4;

--EJ 5
CREATE VIEW inciso5 AS
 SELECT o.office, SUM(od.amount) as total_ventas, AVG(s.age) AS promedio_edad
 FROM offices o 
 JOIN salesRep s ON o.office = s.rep_office
 JOIN orders od ON s.empl_num = od.rep
 GROUP BY o.office;
 
 SELECT * FROM inciso5;
 
 
 -- PARTE 3 -------------------------------------------------------------------------------
 --VISTA SIMPLE
 CREATE VIEW customersView AS 
 SELECT *
 FROM customers c;
 
 UPDATE customersView 
 SET credit_limit = 100000
 WHERE cust_num = 2101;
 
 INSERT INTO customersView (cust_num, company, cust_rep, credit_limit)
 VALUES (2108, 'Sofi Corp.', 108, 50000);
 
 DELETE FROM customersView WHERE cust_num = 2103;
 
 SELECT * FROM customersView;
 
 
--VISTA CON FILTRO
CREATE VIEW customersFilterView AS
SELECT * 
FROM customers c 
WHERE credit_limit > 40000;

UPDATE customersFilterView 
SET credit_limit = 80000
WHERE cust_num = 2102;

UPDATE customersFilterView
SET credit_limit = 1000
WHERE company = 'Acme Mfg.';


SELECT * FROM customersFilterView;


--VISTA CON JOIN
CREATE VIEW customersJoinView AS
SELECT c.company, s.name AS rep_name 
FROM customers c 
JOIN salesRep s ON c.cust_rep = s.empl_num;

UPDATE customersJoinView
SET company = 'New JCP Inc.'
WHERE company = 'JCP Inc.';

SELECT * FROM customersJoinView;

--VISTA CON GROUP BY
CREATE VIEW customersGroupView AS 
SELECT c.company, SUM(o.amount) as total_spent
FROM customers c 
JOIN orders o ON c.cust_num = o.cust
GROUP BY c.company;

UPDATE customersGroupView 
SET total_spent = 5000
WHERE company = 'JCP Inc.';

SELECT * FROM customersGroupView;

--VISTA CON OPCION CHECK
CREATE VIEW customersCheckView AS
SELECT * 
FROM customers c 
WHERE credit_limit > 40000 
WITH CHECK OPTION;

UPDATE customersCheckView
SET credit_limit = 10000
WHERE cust_num = '2102';

SELECT * FROM customersCheckView;

--VISTA MATERIALIZADA
CREATE MATERIALIZED VIEW pedidosView AS 
SELECT *
FROM orders;

INSERT INTO orders VALUES (999999,'2024-01-01',2101,102,'REI','2A44L',5,500);

REFRESH MATERIALIZED VIEW pedidosVIEW;

SELECT * FROM pedidosView;




--PARTE 4----------------------------------------------------------------------------

DROP VIEW customersView;
DROP VIEW customersFilterView;
DROP VIEW customersJoinView;
DROP VIEW customersGroupView;
DROP VIEW customersCheckView;
DROP MATERIALIZED VIEW pedidosView;


EXPLAIN ANALYZE SELECT * FROM customersView;

EXPLAIN ANALYZE SELECT * FROM customersFilterView;

EXPLAIN ANALYZE SELECT * FROM customersJoinView;

EXPLAIN ANALYZE SELECT * FROM customersGroupView;

EXPLAIN ANALYZE SELECT * FROM customersCheckView;

EXPLAIN ANALYZE SELECT * FROM pedidosView;









