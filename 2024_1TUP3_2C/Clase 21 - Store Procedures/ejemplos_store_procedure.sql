USE Cyber;

DELIMITER //
CREATE PROCEDURE ObtenerReservasConClientes()
BEGIN
	SELECT Reservas.fecha_reserva, Computadoras.nombre AS computadora, Clientes.nombre AS cliente
    FROM Reservas
	JOIN Computadoras ON Reservas.id_computadora = Computadoras.id_computadora
    JOIN Clientes ON Reservas.id_cliente = Clientes.id_cliente;
END //

CALL ObtenerReservasConClientes();

# Crea un procedimiento que devuelva el 
# nombre del cliente que realizó la reserva más reciente.

DELIMITER //
CREATE PROCEDURE ClienteConReservaMasReciente()
BEGIN
	SELECT nombre FROM Clientes
    WHERE id_cliente =  ( SELECT id_cliente FROM Reservas
		ORDER BY fecha_reserva DESC
        LIMIT 1);
END //

CALL ClienteConReservaMasReciente();

DELIMITER //
CREATE PROCEDURE ClienteConReservaMasRecienteConJoin()
BEGIN
	SELECT Clientes.nombre AS nombre_cliente, Reservas.fecha_reserva
    FROM Reservas
    JOIN Clientes ON Reservas.id_cliente = Clientes.id_cliente
    ORDER BY Reservas.fecha_reserva DESC
    LIMIT 1;
END //

CALL ClienteConReservaMasRecienteConJoin();

# Crea un procedimiento almacenado que permita cambiar el estado de una computadora.
DELIMITER //
CREATE PROCEDURE CambiarEstadoComputadora(IN id_comp INT,
IN nuevo_estado ENUM ('Disponible', 'Ocupada', 'Fuera de Servicio'))
BEGIN
	UPDATE Computadoras
	SET estado = nuevo_estado
	WHERE id_computadora = id_comp;
END //

CALL CambiarEstadoComputadora(1, 'Ocupada');

# Crea un procedimiento que inserte una nueva reserva en la tabla Reservas. 
DELIMITER // 
CREATE PROCEDURE InsertarReserva( IN p_id_computadora INT,
 IN p_id_cliente INT,
 IN p_fecha_reserva DATE,
 IN p_duracion_minutos INT ) 
BEGIN 
	INSERT INTO Reservas (id_computadora,
    id_cliente,
    fecha_reserva, 
    duracion_minutos) 
    
    VALUES (p_id_computadora,
    p_id_cliente,
    p_fecha_reserva,
    p_duracion_minutos); 
END // 

CALL InsertarReserva(1, 1, '2024-12-15', 78);

# Crea un procedimiento que permita cambiar la ubicación de una computadora.
DELIMITER//
create procedure CambiarUbicacionComputadora(IN id_compu_cambiar INT,
 IN nueva_ubicacion VARCHAR(100))
begin
	update Computadoras
	set ubicacion = nueva_ubicacion
	where id_computadora = id_compu_cambiar;
end //

CALL CambiarUbicacionComputadora(1,'Sección C');

# Crea un procedimiento almacenado que inserte una nueva factura.
DELIMITER //
CREATE PROCEDURE NuevaFactura(
 IN id_clie INT,
 IN id_servicio INT,
 fecha_factura DATE,
 total DECIMAL(10,3))
BEGIN
	INSERT INTO Facturas (id_cliente, id_servicio, fecha_factura, total)
    VALUES (id_clie, id_servicio, fecha_factura,total);
END  //

CALL NuevaFactura(2, 5, CURRENT_DATE(), 1500);

# Crea un procedimiento que devuelva los clientes que han realizado más de una reserva.
DELIMITER//
CREATE PROCEDURE ClientesMasUnaReserva()
BEGIN
	SELECT cl.nombre, COUNT(r.id_reserva) AS total_reservas
	FROM Clientes cl
	JOIN Reservas r ON cl.id_cliente=r.id_cliente
	GROUP BY cl.nombre
	HAVING total_reservas > 1;
END //

CALL ClientesMasUnaReserva();

# Simular pasar valor por defecto
DELIMITER //
CREATE PROCEDURE Leone_Valentin_NuevaReserva_con_valor(IN id_cli INT,
 IN id_comp INT,
 IN duracion INT,
 fecha DATETIME)
BEGIN
	SET fecha = IFNULL(fecha, CURRENT_DATE());

	INSERT INTO Reservas (id_cliente,id_computadora,fecha_reserva,duracion_minutos)
    VALUES (id_cli, id_comp, fecha, duracion);
END  //

CALL Leone_Valentin_NuevaReserva_con_valor(1, 1, 119, NULL)

#

DELIMITER //
CREATE PROCEDURE Leone_Valentin_NuevaFactura (IN id_res INT, IN id_serv INT, IN fecha DATE)
BEGIN
	DECLARE id_cli INT;
	DECLARE tiempo_uso INT;
    DECLARE monto DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);
    
    SET id_cli = (SELECT Reservas.id_cliente FROM Reservas WHERE id_res = Reservas.id_reserva);
    SET tiempo_uso = (SELECT Reservas.duracion_minutos FROM Reservas WHERE id_res = Reservas.id_reserva);
    SET monto = (SELECT Servicios.precio FROM Servicios WHERE id_serv = Servicios.id_servicio);
    SET total = tiempo_uso*monto;
    SET fecha = IFNULL(fecha, CURRENT_DATE());
    
    INSERT INTO Facturas (id_cliente, id_servicio, fecha_factura, total)
    VALUES (id_cli, id_serv, fecha, total);
END //

CALL Leone_Valentin_NuevaFactura (1, 1, NULL)