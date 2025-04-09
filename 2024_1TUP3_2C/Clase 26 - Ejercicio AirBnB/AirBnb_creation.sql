CREATE DATABASE IF NOT EXISTS airbnb_hotel_system;
USE airbnb_hotel_system;

CREATE TABLE IF NOT EXISTS usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    tipo ENUM('anfitrion', 'huésped') NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS propiedades (
    propiedad_id INT AUTO_INCREMENT PRIMARY KEY,
    anfitrion_id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    direccion VARCHAR(255) NOT NULL,
    ciudad VARCHAR(100),
    estado VARCHAR(100),
    pais VARCHAR(100),
    precio_por_noche DECIMAL(10,2) NOT NULL,
    capacidad INT NOT NULL,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (anfitrion_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE
);
	
CREATE TABLE IF NOT EXISTS propiedades (
    propiedad_id INT AUTO_INCREMENT PRIMARY KEY,
    anfitrion_id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    direccion VARCHAR(255) NOT NULL,
    ciudad VARCHAR(100),
    estado VARCHAR(100),
    pais VARCHAR(100),
    precio_por_noche DECIMAL(10,2) NOT NULL,
    capacidad INT NOT NULL,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (anfitrion_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS fotos_propiedad (
    foto_id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    url_foto VARCHAR(255) NOT NULL,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(propiedad_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reservas (
    reserva_id INT AUTO_INCREMENT PRIMARY KEY,
    huesped_id INT NOT NULL,
    propiedad_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    numero_huespedes INT NOT NULL,
    estado ENUM('pendiente', 'confirmada', 'cancelada', 'completada') NOT NULL,
    fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (huesped_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(propiedad_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reseñas (
    reseña_id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT NOT NULL,
    huesped_id INT NOT NULL,
    propiedad_id INT NOT NULL,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_reseña DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reserva_id) REFERENCES reservas(reserva_id)
        ON DELETE CASCADE,
    FOREIGN KEY (huesped_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(propiedad_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mensajes (
    mensaje_id INT AUTO_INCREMENT PRIMARY KEY,
    remitente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (remitente_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE,
    FOREIGN KEY (destinatario_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favoritos (
    favorito_id INT AUTO_INCREMENT PRIMARY KEY,
    huesped_id INT NOT NULL,
    propiedad_id INT NOT NULL,
    fecha_agregado DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (huesped_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(propiedad_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS disponibilidad (
    disponibilidad_id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    fecha_disponible DATE NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(propiedad_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS servicios (
    servicio_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS propiedades_servicios (
    propiedad_id INT NOT NULL,
    servicio_id INT NOT NULL,
    PRIMARY KEY (propiedad_id, servicio_id),
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(propiedad_id)
        ON DELETE CASCADE,
    FOREIGN KEY (servicio_id) REFERENCES servicios(servicio_id)
        ON DELETE CASCADE
);

INSERT INTO usuarios (nombre, email, contraseña, telefono, direccion, tipo)
VALUES 
('Juan Perez', 'juanperez@mail.com', '123456', '555-1234', 'Calle Falsa 123', 'anfitrion'),
('Maria Lopez', 'marialopez@mail.com', 'abcdef', '555-5678', 'Calle Real 456', 'huésped'),
('Carlos Garcia', 'carlosgarcia@mail.com', 'qwerty', '555-9999', 'Avenida Principal 789', 'anfitrion'),
('Ana Torres', 'anatorres@mail.com', 'password', '555-1111', 'Boulevard Norte 12', 'huésped'),
('Luis Martinez', 'luismartinez@mail.com', 'abc123', '555-2345', 'Calle Central 90', 'anfitrion'),
('Carmen Diaz', 'carmendiaz@mail.com', '123abc', '555-8765', 'Pasaje Sur 45', 'huésped'),
('Jose Alvarez', 'josealvarez@mail.com', 'pass5678', '555-3421', 'Ruta 56', 'anfitrion'),
('Laura Fernandez', 'laurafernandez@mail.com', 'zxcvbnm', '555-9876', 'Calle 13', 'huésped'),
('David Gutierrez', 'davidgutierrez@mail.com', 'ilovecats', '555-4532', 'Avenida Luna 101', 'anfitrion'),
('Clara Ruiz', 'clararuiz@mail.com', 'hunter2', '555-5632', 'Calle Lago 12', 'huésped'),
('Ricardo Flores', 'ricardoflores@mail.com', 'starwars1', '555-0912', 'Avenida del Sol 22', 'anfitrion'),
('Silvia Ramirez', 'silviaramirez@mail.com', 'password123', '555-6543', 'Calle Arboles 34', 'huésped'),
('Miguel Vega', 'miguelvega@mail.com', 'mypassword', '555-9871', 'Camino Viejo 45', 'anfitrion'),
('Rosa Cruz', 'rosacruz@mail.com', 'opensesame', '555-5642', 'Calle Estrella 12', 'huésped'),
('Manuel Soto', 'manuelsoto@mail.com', 'superman123', '555-1212', 'Avenida Norte 56', 'anfitrion'),
('Julia Morales', 'juliamorales@mail.com', '1111abcd', '555-3214', 'Calle Oeste 67', 'huésped'),
('Pedro Herrera', 'pedroherrera@mail.com', 'mypassword456', '555-4829', 'Boulevard Pacifico 5', 'anfitrion'),
('Daniela Lopez', 'danielalopez@mail.com', 'qwertyuiop', '555-9876', 'Calle Rio 23', 'huésped'),
('Santiago Rojas', 'santiagorojas@mail.com', 'abcabc123', '555-3571', 'Avenida Lomas 98', 'anfitrion'),
('Gloria Vasquez', 'gloriavasquez@mail.com', 'password789', '555-9034', 'Calle Alta 7', 'huésped');

INSERT INTO propiedades (anfitrion_id, nombre, descripcion, direccion, ciudad, estado, pais, precio_por_noche, capacidad)
VALUES
(1, 'Casa de Playa', 'Hermosa casa frente al mar', 'Av. Mar 123', 'Cancún', 'Quintana Roo', 'México', 100.00, 6),
(1, 'Cabaña en la Montaña', 'Una acogedora cabaña en las montañas', 'Ruta 45', 'Bariloche', 'Río Negro', 'Argentina', 80.00, 4),
(3, 'Departamento Moderno', 'Cómodo departamento en el centro de la ciudad', 'Calle Centro 456', 'Ciudad de México', 'CDMX', 'México', 50.00, 2),
(5, 'Villa de Lujo', 'Villa de lujo con piscina privada', 'Paseo de la Palma 789', 'Ibiza', 'Baleares', 'España', 500.00, 10),
(7, 'Apartamento Familiar', 'Amplio apartamento para familias', 'Calle del Sol 22', 'Miami', 'Florida', 'EE.UU.', 150.00, 6),
(9, 'Estudio en el Corazón de la Ciudad', 'Estudio minimalista en zona céntrica', 'Calle 123', 'Lima', 'Lima', 'Perú', 60.00, 2),
(1, 'Casa Rural', 'Una encantadora casa rural rodeada de naturaleza', 'Ruta 34', 'Mendoza', 'Mendoza', 'Argentina', 90.00, 5),
(3, 'Loft Moderno', 'Loft moderno y elegante', 'Avenida Principal 345', 'Bogotá', 'Cundinamarca', 'Colombia', 70.00, 3),
(7, 'Penthouse de Lujo', 'Exclusivo penthouse con vista panorámica', 'Avenida del Mar 101', 'Santiago', 'RM', 'Chile', 300.00, 8),
(5, 'Casa Colonial', 'Casa colonial restaurada', 'Calle Vieja 77', 'Cartagena', 'Bolívar', 'Colombia', 120.00, 4),
(9, 'Casa de Campo', 'Casa de campo con viñedo propio', '', 'Ruta del Vino', 'Toscana', 'Italia', 200.00, 8),
(3, 'Departamento en la Playa', 'Departamento frente al mar', 'Avenida Playa 101', 'Punta Cana', 'La Altagracia', 'República Dominicana', 180.00, 5),
(7, 'Casa en la Montaña', 'Casa con vistas a la montaña', 'Calle Montaña 99', 'San Martín de los Andes', 'Neuquén', 'Argentina', 140.00, 6),
(1, 'Cabaña Rústica', 'Cabaña en medio del bosque', 'Camino Viejo', 'Villa La Angostura', 'Neuquén', 'Argentina', 75.00, 4),
(9, 'Apartamento en el Centro', 'Apartamento pequeño en el centro', 'Calle Principal 2', 'Buenos Aires', 'Buenos Aires', 'Argentina', 65.00, 2),
(5, 'Casa en la Colina', 'Casa en lo alto de la colina con vista al valle', 'Camino a la Colina', 'San Francisco', 'California', 'EE.UU.', 220.00, 7),
(7, 'Bungalow en la Playa', 'Bungalow en la orilla del mar', 'Playa del Sol 32', 'Hawái', 'Hawái', 'EE.UU.', 300.00, 6),
(9, 'Ático con Terraza', 'Ático con terraza y jacuzzi', 'Avenida Las Palmas', 'Madrid', 'Madrid', 'España', 350.00, 5),
(3, 'Casa de Lujo', 'Casa moderna con diseño exclusivo', 'Calle Estilo 101', 'París', 'Isla de Francia', 'Francia', 450.00, 10),
(1, 'Estudio Económico', 'Pequeño estudio ideal para viajeros', 'Calle Principal 10', 'Montevideo', 'Montevideo', 'Uruguay', 40.00, 2);

INSERT INTO reservas (huesped_id, propiedad_id, fecha_inicio, fecha_fin, numero_huespedes, estado)
VALUES 
(2, 1, '2024-11-01', '2024-11-10', 4, 'confirmada'),
(4, 2, '2024-12-05', '2024-12-12', 2, 'pendiente'),
(6, 3, '2024-12-20', '2024-12-25', 1, 'confirmada'),
(8, 4, '2024-11-15', '2024-11-22', 6, 'cancelada'),
(10, 5, '2024-11-18', '2024-11-25', 3, 'completada'),
(2, 6, '2024-10-10', '2024-10-17', 2, 'confirmada'),
(4, 7, '2024-12-22', '2024-12-28', 5, 'pendiente'),
(6, 8, '2024-11-30', '2024-12-05', 2, 'confirmada'),
(8, 9, '2024-12-01', '2024-12-08', 4, 'completada'),
(10, 10, '2024-11-12', '2024-11-20', 2, 'pendiente'),
(2, 11, '2024-11-01', '2024-11-07', 2, 'confirmada'),
(4, 12, '2024-12-15', '2024-12-22', 4, 'completada'),
(6, 13, '2024-12-25', '2025-01-01', 5, 'confirmada'),
(8, 14, '2024-12-10', '2024-12-17', 4, 'pendiente'),
(10, 15, '2024-11-05', '2024-11-12', 3, 'completada'),
(2, 16, '2024-11-22', '2024-11-30', 6, 'confirmada'),
(4, 17, '2024-12-05', '2024-12-15', 2, 'pendiente'),
(6, 18, '2024-11-08', '2024-11-15', 3, 'confirmada'),
(8, 19, '2024-12-20', '2024-12-28', 5, 'completada'),
(10, 19, '2024-11-25', '2024-12-01', 1, 'cancelada');


INSERT INTO pagos (reserva_id, metodo_pago, monto, fecha_pago, estado) 
VALUES 
(21, 'tarjeta_credito', 1000.00, '2024-10-15', 'completado'), 
(22, 'paypal', 800.00, '2024-11-01', 'completado'), 
(23, 'tarjeta_debito', 500.00, '2024-12-05', 'completado'), 
(24, 'tarjeta_credito', 3000.00, '2024-12-10', 'completado'),  -- Cambiado a 'tarjeta_credito'
(25, 'tarjeta_credito', 700.00, '2024-12-15', 'completado'), 
(26, 'paypal', 150.00, '2024-11-01', 'completado'), 
(27, 'tarjeta_credito', 1800.00, '2024-11-25', 'pendiente'), 
(28, 'tarjeta_debito', 200.00, '2024-12-01', 'completado'), 
(29, 'paypal', 3000.00, '2024-12-01', 'completado'), 
(30, 'tarjeta_debito', 500.00, '2024-11-15', 'completado'), 
(31, 'tarjeta_credito', 2000.00, '2024-11-01', 'completado'), 
(32, 'tarjeta_debito', 1600.00, '2024-12-05', 'pendiente'), 
(33, 'paypal', 1200.00, '2024-12-10', 'completado'), 
(34, 'tarjeta_debito', 2500.00, '2024-12-15', 'pendiente'), 
(35, 'tarjeta_debito', 300.00, '2024-11-10', 'completado'), 
(36, 'paypal', 1400.00, '2024-11-05', 'completado'), 
(37, 'tarjeta_credito', 180.00, '2024-11-22', 'pendiente'), 
(38, 'tarjeta_debito', 2200.00, '2024-11-01', 'completado'), 
(39, 'paypal', 3500.00, '2024-12-10', 'completado');

INSERT INTO fotos (propiedad_id, url, descripcion)
VALUES
(1, 'http://example.com/foto1.jpg', 'Vista desde la casa de playa al atardecer'),
(1, 'http://example.com/foto2.jpg', 'Sala de estar espaciosa con vista al mar'),
(2, 'http://example.com/foto3.jpg', 'Cabaña en la montaña, rodeada de naturaleza'),
(2, 'http://example.com/foto4.jpg', 'Dormitorio principal con chimenea'),
(3, 'http://example.com/foto5.jpg', 'Departamento moderno con cocina equipada'),
(3, 'http://example.com/foto6.jpg', 'Terraza con vista al centro de la ciudad'),
(4, 'http://example.com/foto7.jpg', 'Villa de lujo con piscina y jardín'),
(4, 'http://example.com/foto8.jpg', 'Habitación principal con baño en suite'),
(5, 'http://example.com/foto9.jpg', 'Apartamento familiar amplio y luminoso'),
(5, 'http://example.com/foto10.jpg', 'Sala de juegos para niños'),
(6, 'http://example.com/foto11.jpg', 'Estudio minimalista en el corazón de la ciudad'),
(6, 'http://example.com/foto12.jpg', 'Decoración moderna y sencilla'),
(7, 'http://example.com/foto13.jpg', 'Casa rural rodeada de viñedos'),
(7, 'http://example.com/foto14.jpg', 'Espacio exterior con zona de barbacoa'),
(8, 'http://example.com/foto15.jpg', 'Loft moderno con sala de estar y cocina integrada'),
(8, 'http://example.com/foto16.jpg', 'Terraza con vista panorámica de la ciudad'),
(9, 'http://example.com/foto17.jpg', 'Penthouse con jacuzzi y vista al océano'),
(9, 'http://example.com/foto18.jpg', 'Terraza con área de descanso'),
(10, 'http://example.com/foto19.jpg', 'Casa colonial restaurada con diseño vintage'),
(10, 'http://example.com/foto20.jpg', 'Patio interior con jardín tropical');

INSERT INTO servicios (nombre)
VALUES
('WiFi gratuito'),
('Desayuno incluido'),
('Servicio de limpieza diario'),
('Piscina'),
('Estacionamiento gratuito'),
('Aire acondicionado'),
('Servicio de lavandería'),
('Traslado al aeropuerto'),
('Gimnasio'),
('Spa'),
('Acceso a la playa privada'),
('Televisión por cable'),
('Servicio a la habitación'),
('Cocina completa'),
('Balcón privado'),
('Jacuzzi'),
('Chimenea'),
('Bicicletas disponibles'),
('Barbacoa'),
('Terraza con vista');

INSERT INTO propiedades_servicios (propiedad_id, servicio_id)
VALUES
(1, 1), (1, 2), (1, 4), (1, 5),
(2, 1), (2, 3), (2, 5),
(3, 1), (3, 4), (3, 6),
(4, 1), (4, 2), (4, 5), (4, 8), (4, 10),
(5, 1), (5, 5), (5, 6), (5, 9), (5, 12),
(6, 1), (6, 4), (6, 6),
(7, 1), (7, 5), (7, 6), (7, 7), (7, 8),
(8, 1), (8, 3), (8, 4), (8, 5), (8, 11),
(9, 1), (9, 2), (9, 6), (9, 7), (9, 9),
(10, 1), (10, 5), (10, 6), (10, 7), (10, 13),
(11, 1), (11, 2), (11, 4), (11, 14),
(12, 1), (12, 6), (12, 8),
(13, 1), (13, 3), (13, 5), (13, 6),
(14, 1), (14, 4), (14, 7),
(15, 1), (15, 2), (15, 4), (15, 9),
(16, 1), (16, 5), (16, 6),
(17, 1), (17, 4), (17, 7),
(18, 1), (18, 2), (18, 6),
(19, 1), (19, 3), (19, 5), (19, 12);










