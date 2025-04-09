USE biblioteca;

# Explicacion JOINS
# INNER JOIN: nos devuelve el subconjunto que tienen coincidencia en ambas tablas.
# A Interccion B
# 
# LEFT JOIN: Nos devuelve todas las de la tabla izquierda y las filas coincidentes con la tabla derecha.
# 
# FULL JOIN: Nos devuelve cualquier coincidenecia.
# A Union B

# 
#                      |---> autores
#                      |
#     |-->  libros -----
#     |                |
#     |                |---> editoriales
#     |
#     |---> prestamos ---------> usuarios
#

-- Ejercicio 1:
-- Crea una base de datos llamada biblioteca.
CREATE DATABASE biblioteca;

-- Ejercicio 2:
-- Crea una tabla llamada libros en la base de datos biblioteca, con los siguientes campos:
-- 		id (entero, clave primaria, autoincremental),
-- 		titulo (cadena de hasta 100 caracteres),
-- 		autor (cadena de hasta 100 caracteres),
-- 		fecha_publicacion (date).

CREATE TABLE IF NOT EXISTS libros (
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL UNIQUE,
    autor VARCHAR(100) NOT NULL,
    fecha_publicacion DATE NOT NULL
);

-- Ejercicio 3:
-- Crear una tabla con claves foráneas
-- Crea una tabla llamada prestamos con los siguientes campos:
-- 		prestamo_id (entero, clave primaria, autoincremental),
-- 		libro_id (entero, clave foránea que referencia la tabla libros),
--		usuario_id (entero, representa el usuario del prestamo),
-- 		fecha_prestamo (fecha),
-- 		fecha_devolucion (fecha).

CREATE TABLE IF NOT EXISTS prestamos(
	prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    libro_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL
);

# Ejercicio 4:
# Crea una tabla llamada usuarios con los siguientes campos:
#		id_usuario (int),
#		nombre (texto),
#		apellido (texto),
#		fecha_nacimiento (date),
#		email (texto),
#		fecha_alta (texto),
#		telefono (texto),
#		estado_del_cliente (texto (ACTIVO | SUSPENDIDO | VETADO))

CREATE TABLE IF NOT EXISTS usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100),
    fecha_alta DATE NOT NULL,
    telefono VARCHAR(50),
    estado_cliente VARCHAR(25)
);

# Ejercicio 5:
# Crea una tabla llamada autores con los siguientes campos:
#		id_autor (int),
#		nombre (texto),
#		apellido (texto),
#		email (texto)

CREATE TABLE IF NOT EXISTS autores(
	id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

# Ejercicio 6:
# Crea una tabla llamada editoriales con los siguientes campos:
#		id_editorial (int),
#		razon_social (texto),
#		cuit (texto),
#		email (texto),
#		direccion (texto)

CREATE TABLE IF NOT EXISTS editoriales(
	id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    cuit INT NOT NULL UNIQUE,
    email VARCHAR(100),
    direccion VARCHAR(100)
);

# Ejercicio 7:
# a) Borrar el atributo erróneo autor
# b) Crear el atributo autor_id
# c) Establacer como Foreign Key

ALTER TABLE libros
DROP COLUMN autor;

ALTER TABLE libros
ADD FOREIGN KEY (autor_id) REFERENCES autores(id_autor);

# Ejercicio 8:
# Añadir las editoriales a libros.

ALTER TABLE libros
ADD COLUMN editorial_id INT;

ALTER TABLE libros
ADD FOREIGN KEY (editorial_id) REFERENCES editoriales(id_editorial);

# Ejercicio 9:
# Crear las relaciones entre libros <- prestamos -> usuario

ALTER TABLE prestamos
ADD FOREIGN KEY (libro_id) REFERENCES libros(id);

ALTER TABLE prestamos
ADD FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario);

# Modificamos el tamaño del entero de CUIT para que acepte numeros más grandes.ALTER
ALTER TABLE editoriales
MODIFY cuit INT(20);

# Ejercicio 10:
# Insertamos datos en la tabla autores
INSERT INTO autores (nombre, apellido, email) VALUES
('Jorge Luis', 'Borges', 'jorge.borges@gmail.com'),
('Julio', 'Cortázar', 'julio.cortazar@yahoo.com'),
('Adolfo', 'Bioy Casares', 'adolfo.bioy@outlook.com'),
('Manuel', 'Puig', 'manuel.puig@gmail.com'),
('Roberto', 'Arlt', 'roberto.arlt@hotmail.com'),
('Silvina', 'Ocampo', 'silvina.ocampo@gmail.com'),
('Leopoldo', 'Lugones', 'leopoldo.lugones@yahoo.com'),
('Macedonio', 'Fernández', 'macedonio.fernandez@outlook.com'),
('Ricardo', 'Piglia', 'ricardo.piglia@gmail.com'),
('Sara', 'Gallardo', 'sara.gallardo@hotmail.com'),
('María', 'Teresa Andruetto', 'maria.andruetto@gmail.com'),
('Eduardo', 'Sacheri', 'eduardo.sacheri@yahoo.com'),
('Mariana', 'Enríquez', 'mariana.enriquez@outlook.com'),
('Claudia', 'Piñeiro', 'claudia.pineiro@gmail.com'),
('Martín', 'Kohan', 'martin.kohan@hotmail.com');

INSERT INTO autores (nombre, apellido, email) VALUES
('Hebe', 'Uhart', 'hebe.uhart@gmail.com'),           -- autor_id = 20
('Samanta', 'Schweblin', 'samanta.schweblin@yahoo.com'), -- autor_id = 21
('César', 'Aira', 'cesar.aira@outlook.com'),         -- autor_id = 22
('Juan José', 'Saer', 'juan.saer@hotmail.com'),      -- autor_id = 23
('Rodolfo', 'Walsh', 'rodolfo.walsh@gmail.com'),     -- autor_id = 24
('Ricardo', 'Rojas', 'ricardo.rojas@outlook.com'),   -- autor_id = 25
('Angélica', 'Gorodischer', 'angelica.gorodischer@yahoo.com'), -- autor_id = 26
('Enrique', 'Medrano', 'enrique.medrano@hotmail.com'), -- autor_id = 27
('María', 'Teresa Andruetto', 'maria.andruetto@gmail.com'), -- autor_id = 28
('Eduardo', 'Galeano', 'eduardo.galeano@hotmail.com');

INSERT INTO editoriales (razon_social, cuit, email, direccion) VALUES
('Sudamericana', 711222339, 'contacto@sudamericana.com', 'Av. Corrientes 1234, Buenos Aires'),
('Emecé Editores', 644556778, 'info@emeceditores.com', 'Calle Sarmiento 4321, Buenos Aires'),
('Editorial Planeta', 789990213, 'ventas@editorialplaneta.com', 'Av. Callao 4567, Buenos Aires'),
('Alianza Editorial', 714445522, 'alianza@editorialalianza.com', 'Florida 1122, Buenos Aires'),
('Ediciones de la Flor', 777788990, 'contacto@edicionesdelaflor.com', 'Av. Rivadavia 9876, Buenos Aires'),
('Editorial Losada', 765432100, 'info@editoriallosada.com', 'San Martín 4455, Buenos Aires'),
('Siglo XXI Editores', 780000999, 'sigloxxi@sigloxxieditores.com', 'Av. Belgrano 6543, Buenos Aires'),
('Editorial Anagrama', 655443322, 'ventas@anagrama.com', 'Calle Corrientes 7890, Buenos Aires'),
('Interzona Editora', 800002222, 'info@interzona.com', 'Av. Belgrano 8765, Buenos Aires'),
('Eterna Cadencia', 812345678, 'contacto@eternacadencia.com', 'Av. Santa Fe 3456, Buenos Aires');

INSERT INTO libros (titulo, autor_id, fecha_publicacion) VALUES
('Ficciones', 1, '1944-01-01'),
('Rayuela', 2, '1963-06-28'),
('El Aleph', 1, '1949-07-01'),
('Los Siete Locos', 5, '1929-09-15'),
('Boquitas Pintadas', 4, '1969-03-01'),
('La invención de Morel', 3, '1940-01-01'),
('Los lanzallamas', 5, '1931-07-25'),
('El túnel', 6, '1948-12-30'),
('Cuentos completos', 6, '1959-06-12'),
('La casa de Adela', 12, '2019-08-11'),
('Las cosas que perdimos en el fuego', 12, '2016-03-05'),
('Papeles en el viento', 11, '2011-05-15'),
('La sombra del viento', 13, '2001-06-06'),
('Una suerte pequeña', 14, '2015-10-12'),
('Ciencias Morales', 15, '2007-04-09'),
('El secreto de sus ojos', 11, '2005-02-18'),
('La señora del perrito', 16, '1899-12-01'),
('El jugador', 17, '1866-01-01'),
('El proceso', 18, '1925-04-01'),
('El ruido de las cosas al caer', 19, '2011-07-15');

INSERT INTO usuario (nombre, apellido, fecha_nacimiento, email, fecha_alta, telefono, estado_cliente) VALUES
('Lucía', 'González', '1990-05-21', 'lucia.gonzalez@gmail.com', '2022-01-15', '01112345678', 'ACTIVO'),
('Martín', 'Pérez', '1985-07-10', 'martin.perez@yahoo.com', '2021-09-30', '01198765432', 'ACTIVO'),
('Valeria', 'Fernández', '1995-08-13', 'valeria.fernandez@hotmail.com', '2023-03-22', '01187654321', 'ACTIVO'),
('Gustavo', 'Martínez', '1980-02-17', 'gustavo.martinez@gmail.com', '2020-05-10', '01111223344', 'SUSPENDIDO'),
('Joaquín', 'Gómez', '1992-12-09', 'joaquin.gomez@yahoo.com', '2021-06-12', '01155667788', 'ACTIVO'),
('Carla', 'Rodríguez', '1988-11-02', 'carla.rodriguez@gmail.com', '2020-10-01', '01133445566', 'ACTIVO'),
('Federico', 'Sánchez', '1997-03-30', 'federico.sanchez@hotmail.com', '2023-02-28', '01122334455', 'VETADO'),
('Sofía', 'Romero', '2000-07-15', 'sofia.romero@gmail.com', '2023-05-20', '01166554433', 'ACTIVO'),
('Micaela', 'Ponce', '1993-10-11', 'micaela.ponce@yahoo.com', '2022-08-14', '01199887766', 'ACTIVO'),
('Ignacio', 'Vázquez', '1987-04-25', 'ignacio.vazquez@hotmail.com', '2021-11-05', '01188776655', 'SUSPENDIDO');

INSERT INTO prestamos (libro_id, usuario_id, fecha_prestamo, fecha_devolucion) VALUES
(21, 3, '2024-01-10', '2024-01-20'),
(22, 5, '2024-02-05', '2024-02-12'),
(23, 1, '2024-03-01', '2024-03-15'),
(24, 7, '2024-04-10', '2024-04-20'),
(25, 4, '2024-05-14', '2024-05-28'),
(26, 2, '2024-06-01', '2024-06-10'),
(27, 6, '2024-07-10', '2024-07-24'),
(28, 8, '2024-08-01', '2024-08-11'),
(29, 9, '2024-09-05', '2024-09-18'),
(30, 10, '2024-10-11', '2024-10-25'),
(31, 12, '2024-11-02', '2024-11-12'),
(32, 15, '2024-12-01', '2024-12-10'),
(33, 11, '2024-11-22', '2024-12-05'),
(34, 13, '2024-09-10', '2024-09-24'),
(35, 17, '2024-07-20', '2024-08-03'),
(36, 18, '2024-08-12', '2024-08-22'),
(37, 20, '2024-09-25', '2024-10-05'),
(38, 14, '2024-04-15', '2024-04-28'),
(21, 19, '2024-05-10', '2024-05-20'),
(22, 9, '2024-06-25', '2024-07-09'),
(23, 4, '2024-03-15', '2024-03-29'),
(24, 6, '2024-04-18', '2024-05-02'),
(25, 2, '2024-08-05', '2024-08-20'),
(26, 8, '2024-09-10', '2024-09-20'),
(27, 1, '2024-10-15', '2024-10-25'),
(28, 14, '2024-11-18', '2024-12-01'),
(29, 17, '2024-12-05', '2024-12-15');

# EJERCICIOS DE CONSULTAS (Queries)

# Ejercicio 1 :
# Obtené una lista con todos los libros y los nombres de los autores.

SELECT libros.titulo , autores.nombre, autores.apellido
FROM libros
INNER JOIN autores on libros.autor_id = autores.id_autor;

# Ejercicio 2: 
# Encontrar los libros publicados después del 2000.

SELECT titulo, fecha_publicacion
FROM libros
WHERE YEAR(fecha_publicacion) > 2000;

SELECT titulo, fecha_publicacion
FROM libros
WHERE MONTH(fecha_publicacion) = 3;

SELECT titulo, fecha_publicacion
FROM libros
WHERE DAY(fecha_publicacion) > 15;

# Ejercicio 3: 
# Mostrar los nombres de los usuarios activos, ordenar por apellido
# de forma descendente.

SELECT nombre, apellido
FROM usuario
WHERE estado_cliente = 'ACTIVO'
ORDER BY apellido ASC;

# Ejercicio 4:
# Contá cuanto cuantos prestamos se realizó por usuario.

SELECT usuario.nombre, usuario.apellido, COUNT(*) AS cantidad_prestamos
FROM prestamos
JOIN usuario ON usuario.id_usuario = prestamos.usuario_id
GROUP BY usuario_id;

# Ejercicio 5:
# Mostrar los titulos de los prestamos de usuarios SUSPENDIDOS.

SELECT libros.titulo
FROM prestamos
JOIN libros ON prestamos.libro_id = libros.id
JOIN usuario ON prestamos.usuario_id = usuario.id_usuario
WHERE usuario.estado_cliente = 'SUSPENDIDO';

# Ejercicio 6:
# Calcular el numero total de libros  que hay en la BBDD y 
# la cantidad de autores distintos.

SELECT
	COUNT(id) AS total_libros,
    COUNT(DISTINCT autor_id) AS total_autores
FROM libros;

# Ejercicio 8:
# Obtener la cantidad de alumnos por curso
# Usar un JOIN entre Inscripciones y Cursos 
# para contar cuántos alumnos hay en cada curso.

USE utn_bbdd_testing;

SELECT cursos.nombre, COUNT(inscripciones.alumno_id) AS total_alumnos
FROM inscripciones
INNER JOIN cursos ON cursos.id = inscripciones.curso_id
GROUP BY cursos.nombre;

SELECT cursos.nombre, COUNT(inscripciones.alumno_id) AS total_alumnos
FROM cursos
INNER JOIN inscripciones ON cursos.id = inscripciones.curso_id
GROUP BY cursos.nombre;

# Ejercicio 9:
# Listar cursos que se dictan en aulas con capacidad mayor a 30 alumnos
# y que hayan empezado después de 2023
# Usar un JOIN entre Cursos, Horarios y Aulas y agregar una
# cláusula WHERE para la capacidad y la fecha.

USE utn_bbdd_testing;

SELECT cursos.nombre_curso
FROM cursos
INNER JOIN horarios ON cursos.id_curso = horarios.curso_id
INNER JOIN aulas ON horarios.aula_id = aulas.id_aula
WHERE aulas.capacidad > 30 AND cursos.fecha_inicio > '2023-01-01';

# Ejercicio 10:
# Obtener el promedio de calificaciones por curso
# Usar funciones de agregación para calcular el promedio
# de calificaciones de cada curso.

USE utn_bbdd_testing;

SELECT cursos.nombre AS nombre_curso, AVG(calificaciones.nota) AS promedio_nota
FROM calificaciones
INNER JOIN inscripciones ON inscripciones.alumno_id = calificaciones.alumno_id
INNER JOIN cursos ON inscripciones.curso_id = cursos.id
GROUP BY cursos.nombre;

# Ejercicio 11:
# Listar los alumnos con calificaciones por encima del promedio en su curso
# Usar una subconsulta para calcular el promedio de calificaciones 
# en cada curso y luego filtrar a los estudiantes con calificaciones mayores a ese promedio.

# Ejercicio 12:
# Obtener el número de alumnos inscritos por departamento de profesor
# Usar JOINs entre Cursos, Inscripciones, y Profesores 
# para obtener la cantidad de alumnos por departamento del profesor.

# Ejercicio 13:
# Listar los cursos que se dictan en un día específico y un rango de horas
# Usar un JOIN entre Cursos y Horarios, y filtrar por día de la semana y hora.

# Ejercicio 14:
# Listar alumnos que no se han inscrito en ningún curso
# Usar una subconsulta con NOT IN para listar los alumnos
# que no tienen registros en la tabla Inscripciones.

# Ejercicio 15:
# Obtener el curso más largo en duración (fecha_fin - fecha_inicio)
# Usar una función para calcular la duración del curso y 
# ordenar para obtener el de mayor duración.

# Ejercicio 16:
# Obtener la lista de profesores que no tienen cursos asignados
# Usar un LEFT JOIN para encontrar los profesores que no están relacionados con ningún curso

# Ejercicio 17:
# Listar los cursos con el mayor número de inscripciones y
# la calificación promedio más alta
# Combinar funciones de agregación (COUNT y AVG)
# y agrupar para obtener cursos ordenados por cantidad de inscripciones
# y calificación promedio.