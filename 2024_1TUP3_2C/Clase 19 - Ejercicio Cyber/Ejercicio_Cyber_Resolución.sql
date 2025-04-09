# Creacion de una BBDD para un Cyber
# Creacion de la BBDD.

CREATE DATABASE Cyber;

USE Cyber;

# Creación de la tabla computadoras.
CREATE TABLE IF NOT EXISTS Computadoras(
	id_computadora INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    estado ENUM('Disponible', 'Ocupada', 'Fuera de Servicio') NOT NULL
);

# Creación de la tabla clientes.
CREATE TABLE IF NOT EXISTS Clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# Creación de la tabla servicios.
CREATE TABLE IF NOT EXISTS Servicios(
	id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    precio DECIMAL NOT NULL
);

ALTER TABLE Servicios
MODIFY COLUMN precio DECIMAL(10, 3) NOT NULL;

TRUNCATE TABLE Servicios;

# Creación de la tabla reservas.
CREATE TABLE IF NOT EXISTS Reservas(
	id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_computadora INT,
    fecha_reserva DATETIME NOT NULL,
    duracion_minutos INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_computadora) REFERENCES Computadoras(id_computadora)
);

# Creación de tabla facturas.
CREATE TABLE IF NOT EXISTS Facturas(
	id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_servicio INT,
    fecha_factura DATE NOT NULL,
    total DECIMAL(10, 3) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio)
);

# Insertamos datos en Computadoras
INSERT INTO Computadoras(nombre, ubicacion, estado)
VALUES
('PC 01', 'Sección A', 'Disponible'),
('PC 02', 'Sección A', 'Ocupada'),
('PC 03', 'Sección A', 'Disponible'),
('PC 04', 'Sección B', 'Fuera de Servicio'),
('PC 05', 'Sección B', 'Disponible'),
('PC 06', 'Sección B', 'Ocupada'),
('PC 07', 'Sección C', 'Disponible'),
('PC 08', 'Sección C', 'Disponible'),
('PC 09', 'Sección C', 'Fuera de Servicio'),
('PC 10', 'Sección D', 'Disponible'),
('PC 11', 'Sección D', 'Ocupada'),
('PC 12', 'Sección D', 'Disponible'),
('PC 13', 'Sección A', 'Disponible'),
('PC 14', 'Sección A', 'Ocupada'),
('PC 15', 'Sección B', 'Disponible'),
('PC 16', 'Sección B', 'Fuera de Servicio'),
('PC 17', 'Sección C', 'Ocupada'),
('PC 18', 'Sección C', 'Disponible'),
('PC 19', 'Sección D', 'Ocupada'),
('PC 20', 'Sección D', 'Disponible'),
('PC 21', 'Sección A', 'Fuera de Servicio'),
('PC 22', 'Sección B', 'Ocupada'),
('PC 23', 'Sección C', 'Disponible'),
('PC 24', 'Sección D', 'Disponible'),
('PC 25', 'Sección A', 'Ocupada');

# Insercición de datos en Clientes.
INSERT INTO Clientes(nombre, mail)
VALUES
('Juan Pérez', 'juan.perez@example.com'),
('María García', 'maria.garcia@example.com'),
('Carlos López', 'carlos.lopez@example.com'),
('Ana Martínez', 'ana.martinez@example.com'),
('Luis Fernández', 'luis.fernandez@example.com'),
('Patricia González', 'patricia.gonzalez@example.com'),
('David Sánchez', 'david.sanchez@example.com'),
('Laura Ramírez', 'laura.ramirez@example.com'),
('Miguel Rodríguez', 'miguel.rodriguez@example.com'),
('Carmen Díaz', 'carmen.diaz@example.com'),
('Francisco Moreno', 'francisco.moreno@example.com'),
('Elena Jiménez', 'elena.jimenez@example.com'),
('Jorge Ortiz', 'jorge.ortiz@example.com'),
('Gloria Romero', 'gloria.romero@example.com'),
('José Torres', 'jose.torres@example.com'),
('Lucía Hernández', 'lucia.hernandez@example.com'),
('Andrés Ruiz', 'andres.ruiz@example.com'),
('Sofía Castro', 'sofia.castro@example.com'),
('Raúl Mendoza', 'raul.mendoza@example.com'),
('Clara Muñoz', 'clara.munoz@example.com'),
('Sergio Vega', 'sergio.vega@example.com'),
('Beatriz Reyes', 'beatriz.reyes@example.com'),
('Ignacio Silva', 'ignacio.silva@example.com'),
('Victoria Ramos', 'victoria.ramos@example.com'),
('Pablo Delgado', 'pablo.delgado@example.com');

# Inserción de datos en servicios.
INSERT INTO Servicios(nombre_servicio, precio)
VALUES
('Internet por hora', 1.50),
('Impresión B/N', 0.10),
('Impresión color', 0.30),
('Escaneo', 0.50),
('Fotocopia', 0.15),
('Acceso a juegos en línea', 2.00),
('Descarga de archivos', 0.25),
('Venta de CD/DVD', 1.00),
('Edición de video', 5.00),
('Instalación de software', 3.00),
('Mantenimiento de PC', 7.00),
('Reparación de software', 8.00),
('Reparación de hardware', 10.00),
('Backup de datos', 5.00),
('Diseño gráfico', 15.00),
('Retoque fotográfico', 10.00),
('Conexión de impresora', 2.50),
('Alquiler de sala privada', 10.00),
('Asistencia técnica', 5.50),
('Llamada VoIP', 0.05),
('Acceso a conferencias en línea', 3.00),
('Acceso a redes privadas', 4.00),
('Videollamadas HD', 1.75),
('Venta de accesorios', 2.50),
('Alquiler de teclado/mouse', 1.00);

INSERT INTO Reservas(id_cliente, id_computadora, fecha_reserva, duracion_minutos)
VALUES
(1, 1, '2024-10-02 09:30:00', 60),
(2, 2, '2024-10-02 10:00:00', 30),
(3, 3, '2024-10-02 10:15:00', 45),
(4, 4, '2024-10-02 11:00:00', 90),
(5, 5, '2024-10-02 11:30:00', 120),
(6, 6, '2024-10-02 12:00:00', 60),
(7, 7, '2024-10-02 12:30:00', 30),
(8, 8, '2024-10-02 13:00:00', 45),
(9, 9, '2024-10-02 14:00:00', 90),
(10, 10, '2024-10-02 14:30:00', 60),
(11, 11, '2024-10-02 15:00:00', 45),
(12, 12, '2024-10-02 16:00:00', 120),
(13, 13, '2024-10-02 16:30:00', 30),
(14, 14, '2024-10-02 17:00:00', 60),
(15, 15, '2024-10-02 17:30:00', 45),
(16, 16, '2024-10-02 18:00:00', 90),
(17, 17, '2024-10-02 18:30:00', 120),
(18, 18, '2024-10-02 19:00:00', 60),
(19, 19, '2024-10-02 19:30:00', 45),
(20, 20, '2024-10-02 20:00:00', 30),
(21, 21, '2024-10-02 20:30:00', 60),
(22, 22, '2024-10-02 21:00:00', 120),
(23, 23, '2024-10-02 21:30:00', 45),
(24, 24, '2024-10-02 22:00:00', 60),
(25, 25, '2024-10-02 22:30:00', 90);

INSERT INTO Facturas(id_cliente, id_servicio, fecha_factura, total)
VALUES
(1, 1, '2024-10-01', 1.50),
(2, 2, '2024-10-01', 0.10),
(3, 3, '2024-10-01', 0.30),
(4, 4, '2024-10-01', 0.50),
(5, 5, '2024-10-01', 0.15),
(6, 6, '2024-10-01', 2.00),
(7, 7, '2024-10-01', 0.25),
(8, 8, '2024-10-01', 1.00),
(9, 9, '2024-10-01', 5.00),
(10, 10, '2024-10-01', 3.00),
(11, 11, '2024-10-01', 7.00),
(12, 12, '2024-10-01', 8.00),
(13, 13, '2024-10-01', 10.00),
(14, 14, '2024-10-01', 5.00),
(15, 15, '2024-10-01', 15.00),
(16, 16, '2024-10-01', 10.00),
(17, 17, '2024-10-01', 2.50),
(18, 18, '2024-10-01', 10.00),
(19, 19, '2024-10-01', 5.50),
(20, 20, '2024-10-01', 0.05),
(21, 21, '2024-10-01', 3.00),
(22, 22, '2024-10-01', 4.00),
(23, 23, '2024-10-01', 1.75),
(24, 24, '2024-10-01', 2.50),
(25, 25, '2024-10-01', 1.00);

# Ejercicio 1: Obtener las reservas con el nombre del cliente y la PC utilizada.

SELECT fecha_reserva, Computadoras.nombre, Clientes.nombre
FROM Reservas
JOIN Clientes ON Clientes.id_cliente = Reservas.id_cliente
JOIN Computadoras ON Computadoras.id_computadora = Reservas.id_computadora;

# Obtener el cliente que hizo la reserva mas reciente.
SELECT Clientes.nombre AS nombre_cliente, Reservas.fecha_reserva
FROM Reservas
INNER JOIN Clientes ON Clientes.id_cliente = Reservas.id_cliente
ORDER BY Reservas.fecha_reserva DESC
LIMIT 1;

SELECT nombre
FROM Clientes
WHERE id_cliente = (SELECT id_cliente FROM Reservas ORDER BY fecha_reserva DESC LIMIT 1);

# Obtener el total de ingresos por servicio brindado.
SELECT s.nombre_servicio, SUM(f.total) AS total_ingreso
FROM Facturas f
JOIN Servicios s ON f.id_servicio = s.id_servicio
GROUP BY s.nombre_servicio
ORDER BY total_ingreso DESC;

# Obtener el ingreso generado por PC para clientes que reservaron mas de 60 minutos.
SELECT Computadoras.nombre as computadora, SUM(Facturas.total) AS ingreso_total
FROM Reservas
JOIN Computadoras ON Reservas.id_computadora = Computadoras.id_computadora
JOIN Facturas ON Reservas.id_cliente = Facturas.id_cliente
WHERE Reservas.duracion_minutos > 60
GROUP bY Computadoras.nombre
ORDER BY ingreso_total;

# Obtener el numero del cliente y nombre con la mayor cantidad de minutos reservados.
SELECT 
    Clientes.id_cliente, Clientes.nombre
FROM
    Clientes
WHERE
    id_cliente = (SELECT 
            id_cliente
        FROM
            Reservas
        ORDER BY duracion_minutos DESC
        LIMIT 1)












