-- Ejemplo 1

SELECT titulo, fecha_publicacion
FROM biblioteca.libros
ORDER BY titulo ASC;

SELECT titulo, fecha_publicacion
FROM biblioteca.libros
ORDER BY titulo DESC;

SELECT titulo, fecha_publicacion
FROM biblioteca.libros
ORDER BY fecha_publicacion ASC;

SELECT titulo, fecha_publicacion
FROM biblioteca.libros
ORDER BY fecha_publicacion DESC;

-- Ejemplo 2

SELECT usuario_id, COUNT(*) AS total_prestamos
FROM biblioteca.prestamos
GROUP BY usuario_id
ORDER BY total_prestamos;

SELECT SUM(libro_id) AS suma_de_id
FROM biblioteca.prestamos;

SELECT alumno_id, nombre, apellido, AVG(nota) AS promedio_alumno, COUNT(*) AS cant_instancias_evaluativas
FROM utn_bbdd_testing.calificaciones
JOIN utn_bbdd_testing.alumnos ON utn_bbdd_testing.alumnos.id = utn_bbdd_testing.calificaciones.alumno_id  
GROUP BY alumno_id
ORDER BY promedio_alumno;

-- Ejemplo 3

SELECT autor_id, nombre, apellido, COUNT(*) as total_libros
FROM biblioteca.libros
JOIN biblioteca.autores ON biblioteca.autores.id_autor = biblioteca.libros.autor_id
WHERE biblioteca.libros.fecha_publicacion > '2000-00-00'
GROUP BY autor_id
HAVING COUNT(*) >= 2;

-- Ejemplo 4

SELECT libro_id
    FROM biblioteca.prestamos
    GROUP BY libro_id
    HAVING COUNT(*) >= 2;

SELECT 
    titulo
FROM
    biblioteca.libros
WHERE
    id IN (SELECT 
            libro_id
        FROM
            biblioteca.prestamos
        GROUP BY libro_id
        HAVING COUNT(*) >= 2);

SELECT 
    id, nombre
FROM
    utn_bbdd_testing.alumnos
WHERE
    nombre IN (SELECT 
            nombre
        FROM
            utn_bbdd_testing.profesores);

# Seleccionamos los usuarios que pidieron prestados los libros de Borges, especificamente "El Aleph"
SELECT 
    id_usuario, nombre, apellido
FROM
    biblioteca.usuario
WHERE
    id_usuario IN (SELECT 
            usuario_id
        FROM
            biblioteca.prestamos
                JOIN
            biblioteca.libros ON biblioteca.libros.id = biblioteca.prestamos.libro_id
        WHERE
            autor_id = (SELECT 
                    id_autor
                FROM
                    biblioteca.autores
                WHERE
                    nombre = 'Jorge Luis'
                        AND apellido = 'Borges')
                AND biblioteca.libros.titulo = 'El Aleph');

-- Ejemplo 5
CREATE INDEX idx_usuario_id ON biblioteca.prestamos(usuario_id);

-- Ejercicio 1
SELECT * 
FROM biblioteca.libros
ORDER BY titulo ASC;

-- Ejercicio 2
SELECT *
FROM biblioteca.libros
WHERE YEAR(fecha_publicacion) > "2015"
ORDER BY fecha_publicacion DESC;

-- Ejercicio 3
SELECT autor_id, COUNT(*) AS total_libros
FROM biblioteca.libros
GROUP BY autor_id;

-- Ejercicio 4
SELECT 
    usuario_id, AVG(numero_prestamos) AS promedio_libro
FROM
    (SELECT 
        usuario_id, COUNT(*) AS numero_prestamos
    FROM
        biblioteca.prestamos
    GROUP BY usuario_id) AS subconsulta
GROUP BY usuario_id;

-- Ejercicio 5
USE biblioteca;

SELECT 
    autor_id, COUNT(autor_id) AS total_libros
FROM
    libros
GROUP BY autor_id
HAVING total_libros > 1;

-- Ejercicio 6
SELECT 
    libros.id, titulo, COUNT(*) AS cantidad_prestamos
FROM
    prestamos
        JOIN
    libros ON libros.id = prestamos.libro_id
GROUP BY libros.id
HAVING cantidad_prestamos >= 1;

-- Ejercicio 7
SELECT 
    usuario.nombre, usuario.apellido
FROM
    usuario
        INNER JOIN
    prestamos ON prestamos.usuario_id = usuario.id_usuario
        INNER JOIN
    libros ON libros.id = prestamos.libro_id
        INNER JOIN
    autores ON autores.id_autor = libros.autor_id
WHERE
    autores.nombre = 'Manuel'
        AND autores.apellido = 'Puig';

-- Ejercicio 8
SELECT 
    l.titulo, p.fecha_prestamo
FROM
    biblioteca.libros l
        JOIN
    prestamos p ON l.id = p.libro_id
WHERE
    p.fecha_prestamo >= CURRENT_DATE() - INTERVAL 30 DAY;

-- Ejercicio 9

USE biblioteca;

SELECT 
            p.libro_id
        FROM
            prestamos p
        GROUP BY p.libro_id
        ORDER BY COUNT(*) DESC;

SELECT 
    l.titulo, l.fecha_publicacion
FROM
    biblioteca.libros l
WHERE
    l.id = (SELECT 
            p.libro_id
        FROM
            prestamos p
        GROUP BY p.libro_id
        ORDER BY COUNT(*) DESC
        LIMIT 1);

-- Ejercicio 10
SELECT  DATE_FORMAT(fecha_prestamo, '%Y-%m') AS mes_anio, COUNT(*) AS TOTAL_PRESTAMOS
FROM biblioteca.prestamos
GROUP BY mes_anio
ORDER BY mes_anio