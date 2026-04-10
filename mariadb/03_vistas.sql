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


