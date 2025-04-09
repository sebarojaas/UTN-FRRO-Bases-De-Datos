SHOW DATABASES;

# Ejercicio 1
# Creación de la base de datos
# Crea una base de datos llamada WeChat.

CREATE DATABASE WeChat;

USE WeChat;

# Ejercicio 2
# Creación de tabla de usuarios

CREATE TABLE IF NOT EXISTS Usuarios(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
	username VARCHAR(100) DEFAULT "Juan_Cruz",
    email VARCHAR(100) UNIQUE,
	fecha_registro DATE NOT NULL
);

DESCRIBE WeChat.Usuarios;

# Ejercicio 3
# Restricción de validación de email
# Añade una restricción en la tabla Usuarios para que el campo email no pueda
# ser nulo.

ALTER TABLE Usuarios
MODIFY email VARCHAR(200) UNIQUE NOT NULL;

DESCRIBE WeChat.Usuarios;

# Ejercicio 4
# Tabla de publicaciones

CREATE TABLE IF NOT EXISTS Publicaciones(
	id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    contenido TEXT,
    fecha_publicacion DATETIME
);

ALTER TABLE Publicaciones
ADD FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario);

# Ejercicio 5
# Crea una tabla Amigos para manejar las relaciones de amistad entre usuarios.

CREATE TABLE IF NOT EXISTS Amigos(
	id_usuario1 INT,
    id_usuario2 INT
);

ALTER TABLE WeChat.Amigos
ADD FOREIGN KEY (id_usuario1) REFERENCES WeChat.Usuarios(id_usuario);

ALTER TABLE WeChat.Amigos
ADD FOREIGN KEY (id_usuario2) REFERENCES WeChat.Usuarios(id_usuario);

# Ejercicio 6
# Inserción de usuarios

INSERT INTO Usuarios (nombre, email, fecha_registro) VALUES
('Juan Pérez', 'juan.perez@gmail.com', '2023-01-01'),
('María Gómez', 'maria.gomez@gmail.com', '2023-02-15'),
('Lucas Fernández', 'lucas.fernandez@gmail.com', '2023-03-10'),
('Ana López', 'ana.lopez@gmail.com', '2023-03-25'),
('Carlos Sánchez', 'carlos.sanchez@gmail.com', '2023-04-02'),
('Sofía Martínez', 'sofia.martinez@gmail.com', '2023-04-15'),
('Mateo Ramírez', 'mateo.ramirez@gmail.com', '2023-05-01'),
('Valentina Rodríguez', 'valentina.rodriguez@gmail.com', '2023-05-20'),
('Jorge Díaz', 'jorge.diaz@gmail.com', '2023-06-05'),
('Camila Suárez', 'camila.suarez@gmail.com', '2023-06-22');

# Ejercicio 7
# Inserción de publicaciones

INSERT INTO Publicaciones (id_usuario, contenido, fecha_publicacion) VALUES
(1, 'Este es mi primer post en la red social', '2023-01-02 10:00:00'),
(1, 'Hoy es un gran día para programar', '2023-01-03 14:30:00'),
(2, 'Mi primera publicación en la plataforma', '2023-02-16 11:15:00'),
(3, 'Amo la programación y las redes sociales', '2023-03-11 09:45:00'),
(4, 'Hoy vi una película excelente', '2023-03-26 18:20:00'),
(5, 'Comenzando un nuevo proyecto de desarrollo web', '2023-04-03 08:55:00'),
(6, 'Aprendiendo nuevas habilidades en desarrollo móvil', '2023-04-16 13:40:00'),
(7, 'Construyendo una app desde cero', '2023-05-02 16:10:00'),
(8, '¿Alguien más trabajando en proyectos open source?', '2023-05-21 12:00:00'),
(9, 'He decidido aprender Python este mes', '2023-06-06 17:25:00');

# Ejercicio 8
# Inserción de amistades

INSERT INTO Amigos (id_usuario1, id_usuario2) VALUES
(1, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10),
(9, 1);

# Ejercicio 9
# Actualización de nombre de usuario

UPDATE WeChat.Usuarios SET nombre = "Mariano Gomez" 
WHERE id_usuario = 2;


UPDATE WeChat.Usuarios SET email= "marianogomez@gmail.com" 
WHERE id_usuario = 2;

# Ejercicio 10
# Tabla de comentarios

CREATE TABLE Comentarios (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT,
    id_usuario INT,
    contenido TEXT,
    fecha_comentario DATETIME,
    FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

# Ejercicio 11
# Insercion de comentarios

INSERT INTO Comentarios (id_publicacion, id_usuario, contenido, fecha_comentario) VALUES
(1, 2, '¡Qué interesante post!', '2023-01-02 12:30:00'),
(1, 3, 'Muy bueno, Juan!', '2023-01-02 14:45:00'),
(2, 4, '¡Eso suena emocionante!', '2023-01-03 16:10:00'),
(3, 5, 'Me encanta la programación', '2023-03-12 09:50:00'),
(4, 6, '¡Excelente película!', '2023-03-26 20:05:00');

# Ejercicio 12
# Actualiza el contenido de una publicación, cambiando el texto a "Hoy es un día increíble".

CREATE TABLE IF NOT EXISTS Likes (
	id_like INT AUTO_INCREMENT PRIMARY KEY,
    fecha_like DATETIME,
    id_publicacion INT,
    id_usuario INT,
    FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

# Ejercicio 13
# Tabla de likes

UPDATE Publicaciones
SET contenido = 'Hoy es un día increíble'
WHERE id_publicacion = 1;

# Ejercicio 14
# Insertar likes

INSERT INTO Likes (id_publicacion, id_usuario, fecha_like) VALUES
(1, 2, '2023-01-02 12:35:00'),
(1, 3, '2023-01-02 14:50:00'),
(2, 4, '2023-01-03 16:15:00'),
(2, 2, '2023-01-03 16:15:00'),
(2, 3, '2023-01-03 16:15:00'),
(3, 5, '2023-03-12 09:55:00'),
(4, 6, '2023-03-26 20:10:00');

INSERT INTO Likes (id_publicacion, id_usuario, fecha_like) VALUES
(2, 2, '2023-01-03 16:15:00'),
(2, 3, '2023-01-03 16:15:00');

# Ejercicio 15
# Eliminación de un usuario

INSERT INTO Usuarios (nombre, email, fecha_registro) VALUES
('Mariano Perez', 'mariano_perez@hotmail.com', '2023-04-04');

DELETE FROM WeChat.Usuarios WHERE id_usuario = 11;
