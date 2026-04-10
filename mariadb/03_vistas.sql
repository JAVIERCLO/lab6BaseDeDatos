--================================================================================================================================================== 
-- Parte 2: vistas
--================================================================================================================================================== 

-- Definir una vista para el empleado nº 102 que contenga solo los pedidos emitidos, por los clientes asignados al mismo
CREATE VIEW v_pedidos_empleado_102 AS
SELECT o.*
FROM orders o
JOIN customers c ON o.cust = c.cust_num
WHERE c.cust_rep = 102;

SELECT * FROM v_pedidos_empleado_102;

-- Definir una vista, que muestre únicamente clientes que tienen más de Q30000 en pedidos registrados actualmente

CREATE VIEW v_clientes_pedidos_30000 AS
SELECT c.company,
SUM(o.amount) AS total
FROM customers c
JOIN orders o ON c.cust_num = o.cust
GROUP BY c.company
HAVING SUM(o.amount) > 30000;

SELECT * FROM v_clientes_pedidos_30000;

-- Definir una vista de la tabla oficinas, para el personal del procesamiento de pedidos que incluya la ciudad, el número de oficina y la región
CREATE VIEW v_oficinas AS
SELECT offi.city, offi.office, offi.region
FROM offices offi;

SELECT * FROM v_oficinas

-- En la tabla clientes, para el mismo departamento, que incluya el nombre de los clientes y la asignación de los vendedores
CREATE VIEW v_clientes_vendedores AS
SELECT c.company,
s.name, s.title
FROM customers c
JOIN salesRep s ON c.cust_rep = s.empl_num;

SELECT * FROM v_clientes_vendedores;

-- Definir una vista que muestre el total de ventas y el promedio de edad de cada oficina.
CREATE VIEW v_ventas_y_edad_promedio_oficina AS
SELECT offi.office,
offi.sales,
AVG(s.age) AS edad_promedio
FROM offices offi
JOIN salesRep s ON offi.office = s.rep_office
GROUP BY offi.office, offi.sales;

SELECT * FROM v_ventas_y_edad_promedio_oficina;

--================================================================================================================================================== 
-- Parte 3: Comparacion
--================================================================================================================================================== 

-- Vista simple
-- a. Cree una vista que le permita obtener todos los datos de los clientes
CREATE VIEW v_info_clientes AS
SELECT * FROM customers
-- b. Aumente el limite de credito de un cliente a traves de la vista
UPDATE v_info_clientes
SET credit_limit = 1000000
WHERE cust_num = 2101;

SELECT * FROM v_info_clientes
-- c. Inserte un nuevo cliente a traves de la vista
INSERT INTO v_info_clientes (cust_num, company, cust_rep, credit_limit)
VALUES (2108, 'Coca Cola', 102, 20123);

SELECT * FROM v_info_clientes
-- d. Borre un cliente a traves de la vista
DELETE FROM v_info_clientes
WHERE cust_num = 2108;

SELECT * FROM v_info_clientes

-- Vista con filtro
-- a. Cree una vista que permita seleccionar los clientes que tienen más de 40000 de límite de crédito
CREATE VIEW v_clientes_credito_mas_de_40000 AS
SELECT * FROM customers
WHERE credit_limit > 40000;

SELECT * FROM v_clientes_credito_mas_de_40000
-- b. Aumente el límite de crédito a cualquier cliente a 80000 a traves de la vista

UPDATE v_clientes_credito_mas_de_40000
SET credit_limit = 80000
WHERE cust_num = 2102;

SELECT * FROM v_clientes_credito_mas_de_40000
-- c. Ponga el límite de credito al cliente "Acme Mfg" en 1000 a traves de la vista
UPDATE v_clientes_credito_mas_de_40000
SET credit_limit = 1000
WHERE cust_num = 2107;

SELECT * FROM v_clientes_credito_mas_de_40000;
-- Vista con join
-- a. Cree una vista que obtenga que muestre una lista donde, para cada cliente, aparezca, el nombre de la empresa (company) y el nombre del vendedor asignado
CREATE VIEW v_cliente_vendedor AS
SELECT c.company,
s.name
FROM customers c 
JOIN salesRep s ON c.cust_rep = s.empl_num;

SELECT * FROM v_cliente_vendedor;
-- b. Cambiele el nombre a la compania ""JPC Inc." a traves de la vista
UPDATE v_cliente_vendedor
SET company = 'Monsters Inc.'
WHERE company = 'JCP Inc.';

SELECT * FROM v_cliente_vendedor;

-- Vista con group by
-- a. Cree una vista que obtenga, para cada cliente, el total de dinero que ha gastado en pedidos
CREATE VIEW v_total_gastado_clientes AS
SELECT c.cust_num,
c.company,
SUM(o.amount) AS total_gastado
FROM orders o
JOIN customers c ON o.cust = c.cust_num
GROUP BY c.company;

SELECT * FROM v_total_gastado_clientes;
-- b. Actualice el total gastado para el cliente 2101 a traves de la vista
UPDATE v_total_gastado_clientes
SET total_gastado = 777
WHERE cust_num = 2101;
-- No Funciona el update

-- Vista con opcion check
-- a. Cree una vista que muestre unicamente los clientes cuyo limite de credito sea mayor a 40000. Ademas, asegurese de que cualquier modificacion realizada a traves de la vista no permita que un cliente deje de cumplir esa condicion.
CREATE VIEW clientes_limite_de_credito_alto AS
SELECT *
FROM customers
WHERE credit_limit > 40000
WITH CHECK OPTION;

SELECT * FROM clientes_limite_de_credito_alto;
-- b. Establezca un limite en 10000 para el cliente 2102
UPDATE clientes_limite_de_credito_alto
SET credit_limit = 10000
WHERE cust_num = 2102;
-- El check funciona y no permite el cambio

-- Vista materializada
-- a. Cree una vista materializada que almacene la informacion de todos los pedidos en la base de datos
-- No es posible crear vistas materializadas en MariaDB.