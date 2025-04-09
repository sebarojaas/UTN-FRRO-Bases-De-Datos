USE Cyber;

# Ejercicio 1: Obtener las reservas con el nombre del cliente y la PC utilizada.
SELECT 
	Reservas.fecha_reserva ,
	Computadoras.nombre AS nombre_pc,
	Clientes.nombre AS nombre_cliente
FROM
	Reservas
INNER JOIN
	Clientes ON Clientes.id_cliente = Reservas.id_cliente
INNER JOIN
	Computadoras ON Computadoras.id_computadora = Reservas.id_computadora;
	
# Ejercicio 2: Obtener el cliente que hizo la reserva mas reciente
SELECT 
	Clientes.nombre as nombre_cliente,
	Reservas.fecha_reserva 
FROM
	Clientes
INNER JOIN
	Reservas ON Reservas.id_cliente = Clientes.id_cliente
ORDER BY
	Reservas.fecha_reserva DESC 
LIMIT 1;

# Ejercicio 3: Obtener el total de ingresos por servicio brindado
SELECT 
	Servicios.nombre_servicio,
	SUM(Facturas.total) as total_servicio
FROM
	Facturas
JOIN
	Servicios ON Servicios.id_servicio = Facturas.id_servicio 
GROUP BY 
	Servicios.nombre_servicio 
ORDER BY 
	total_servicio;

# Ejercicio 4: Obtener el ingreso generado por PC para clientes que reservaron mas de 60 min.
SELECT 
	Computadoras.nombre ,
	Clientes.nombre,
	Reservas.duracion_minutos 
FROM 
	Computadoras
JOIN 
	Clientes ON Clientes.id_cliente = Computadoras.id_computadora
JOIN
	Reservas ON Reservas.id_computadora= Computadoras.id_computadora
WHERE 
	Reservas.duracion_minutos > 60
ORDER BY 
	Reservas.duracion_minutos DESC;

# Ejercicio 5: Obtener los clientes que no han realizado reservas.
SELECT 
	Clientes.nombre
FROM 
	Clientes
LEFT JOIN
	Reservas ON Clientes.id_cliente = Reservas.id_cliente 
WHERE
	Reservas.id_reserva IS NULL;

# Ejercicio 6: Obtener una lista de computadoras y el numero de reservas realizadas por cada una.
SELECT 
	Computadoras.nombre AS nombre_pc,
	COUNT(Reservas.id_reserva) AS total_reservas
FROM 
	Computadoras
LEFT JOIN
	Reservas ON Reservas.id_computadora = Computadoras.id_computadora 
GROUP BY 
	nombre_pc;

# Ejercicio 7: Obtener los servicios que no han sido utilizados en facturas.
SELECT 
	Servicios.nombre_servicio
FROM
	Facturas # LEFT
RIGHT JOIN
	# RIGHT
	Servicios ON  Servicios.id_servicio = Facturas.id_servicio
WHERE 
	Facturas.id_factura IS NULL;

# Ejercicio 8: Obtener los clientes y sus facturas incluyendo los que no tienen facturas.
SELECT
	Clientes.nombre AS nombre_cliente,
	Facturas.total 
FROM
	Clientes
LEFT JOIN
	Facturas ON Facturas.id_cliente = Clientes.id_cliente;

# Ejercicio 9: Obtener el total de ingresos por clientes.
SELECT
	Clientes.nombre AS nombre_cliente,
	SUM(Facturas.total) AS total_ingreso
FROM
	Clientes
LEFT JOIN
	Facturas ON Facturas.id_cliente = Clientes.id_cliente
GROUP BY
	nombre_cliente;

# Ejercicio 10: Obtener todas las reservas y la informacion de los servicios utilizados,
# incluyendo los que no tienen servicios asociados.
SELECT
	Reservas.fecha_reserva,
	Servicios.nombre_servicio
FROM
	Reservas
LEFT JOIN
	Facturas ON Reservas.id_cliente = Facturas.id_cliente 
LEFT JOIN 
	Servicios ON Facturas.id_servicio = Servicios.id_servicio;

# Ejercicio 11: Obtener los servicios que tienen un ingreso total superior a un cierto monto (elegir).
SELECT 
	Servicios.nombre_servicio,
	SUM(Facturas.total) AS monto_total
FROM
	Servicios
JOIN
	Facturas ON Facturas.id_servicio = Servicios.id_servicio
GROUP BY 
	Servicios.nombre_servicio
HAVING
	monto_total > 60;	

# Ejercicio 12: Obtener las reservas de un cliente epecífico. (Tratar de crear una store procedure)

DELIMITER //
CREATE PROCEDURE ObtenerReservas (IN nombre_cliente VARCHAR(100))
BEGIN
	SELECT 
		Reservas.fecha_reserva,
		Computadoras.nombre AS nombre_pc
	FROM
		Reservas
	JOIN
		Computadoras ON Computadoras.id_computadora  = Reservas.id_computadora 
	JOIN 
		Clientes ON Clientes.id_cliente = Reservas.id_cliente 
	WHERE
		Clientes.nombre = nombre_cliente;
END DELIMITER // 

CALL ObtenerReservas('Jorge Ortiz');

# Ejercicio 13: Obtener todos los clientes y la duracion total de sus reservas.
SELECT 
    Clientes.nombre as nombre_cliente, 
    SUM(Reservas.duracion_minutos) as duracion_total
FROM
	Clientes
LEFT JOIN
    Reservas on Clientes.id_cliente = Reservas.id_cliente
GROUP BY
    Clientes.nombre;

# Ejercicio 14: Obtener las computadoras y el tiempo total de reservas.
SELECT
	Computadoras.nombre AS nombre_pc,
    SUM(Reservas.duracion_minutos) AS duracion
FROM
	Computadoras
LEFT JOIN
	Reservas ON Computadoras.id_computadora = Reservas.id_computadora
GROUP BY
	Computadoras.nombre
ORDER BY
	duracion DESC;

#####
SELECT
	Computadoras.nombre AS nombre_pc,
	COUNT(Reservas.id_reserva) AS cant_reservas
FROM
	Computadoras
INNER JOIN	
	Reservas ON Computadoras.id_computadora  = Reservas.id_computadora 
GROUP BY 
	nombre_pc
ORDER BY
	cant_reservas DESC
LIMIT 1;
