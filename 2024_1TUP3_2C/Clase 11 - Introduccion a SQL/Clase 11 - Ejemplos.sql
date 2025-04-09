USE utn_bbdd_testing;

SELECT * FROM alumnos;

SELECT nombre, apellido FROM profesores;

SELECT * FROM cursos;

SELECT nombre, apellido FROM alumnos WHERE nombre = 'Roger';

# Nos sirve para poder consultar posteriormente las notas de Roger.
SELECT id FROM alumnos WHERE nombre = 'Roger' AND apellido = 'Steele';

SELECT nombre FROM aulas WHERE capacidad BETWEEN 20 AND 50;

SELECT alumno_id FROM calificaciones WHERE nota BETWEEN 0 AND 5.9;

SELECT alumno_id FROM calificaciones WHERE nota BETWEEN 6 AND 10;

SELECT id, nombre, apellido FROM alumnos WHERE nombre IN ('Derek', 'Lucia', 'Joe', 'Lisa', 'Frank');

SELECT id, nombre, apellido, email  FROM profesores WHERE email LIKE '%example.com';

SELECT id, nombre, apellido, email  FROM profesores WHERE email LIKE '%example.org';

SELECT id, nombre, apellido, email  FROM profesores WHERE email LIKE 'mich%';

SELECT id, nombre, apellido, email  FROM profesores WHERE email LIKE 'm%';

SELECT id, nombre, apellido, email  FROM profesores WHERE email LIKE '%17%';

SELECT id, nombre, apellido, email  FROM profesores WHERE apellido IN ('Kelley', 'Thomas');

SELECT id, nombre, apellido, email  FROM profesores WHERE nombre LIKE 'k%' AND apellido IN ('Kelley', 'Thomas');

SELECT COUNT(*) FROM inscripciones;

SELECT COUNT(*) FROM inscripciones WHERE curso_id = 7;

SELECT COUNT(id) FROM alumnos WHERE email LIKE '%example.com' OR email LIKE '%example.net';

SELECT COUNT(*) FROM calificaciones WHERE nota BETWEEN 6 AND 10;

SELECT SUM(presente) FROM asistencias WHERE curso_id = 7;

SELECT COUNT(*) FROM asistencias WHERE curso_id = 10 AND presente = 0; 

SELECT AVG(nota) from calificaciones WHERE nota BETWEEN 6 AND 10;

SELECT AVG(nota) from calificaciones WHERE nota BETWEEN 0 AND 5.9;

SELECT AVG(nota) from calificaciones WHERE nota;

SELECT MAX(nota) from calificaciones WHERE nota;

SELECT MIN(nota) from calificaciones WHERE nota;

# Ejercicio 1:
# Obtén una lista de todos los profesores que pertenecen al departamento de 'Science'.
# Muestra su nombre, apellido y el nombre del departamento.
# ACLARACIÓN: 1 corresponde al id del departamento Science.

SELECT nombre, apellido FROM profesores WHERE departamento_id = 1;

# Ejercicio 2:
# Calcula el número total de inscripciones en cada curso.
# Muestra el nombre del curso y la cantidad de alumnos inscritos.

SELECT cursos.nombre AS nombre_curso, COUNT(inscripciones.id) AS total_inscripciones
FROM cursos
LEFT JOIN inscripciones ON cursos.id = inscripciones.id
GROUP BY cursos.id, cursos.nombre;

# Ejercicio 3:
# Encuentra todos los alumnos que nacieron entre el 1 de enero de 1995 y el 31 de diciembre de 2000. 
# Muestra su nombre, apellido y fecha de nacimiento.

SELECT nombre, apellido, fecha_nacimiento
FROM alumnos
WHERE fecha_nacimiento BETWEEN '1995-01-01' AND '2000-12-31';

# Probamos con otra fecha
SELECT nombre, apellido, fecha_nacimiento
FROM alumnos
WHERE fecha_nacimiento >= '2001-01-01';

# Ejercicio 4:
# Obtén una lista de los cursos y los nombres de los profesores que los imparten,
# pero solo para aquellos cursos que se dictan en aulas con una capacidad mayor a 30 personas.

SELECT cursos.nombre AS nombre_curso, profesores.nombre AS nombre_profesores
FROM cursos
INNER JOIN profesores ON cursos.profesor_id = profesores.id
INNER JOIN horarios ON cursos.id = horarios.curso_id
INNER JOIN aulas ON horarios.aula_id = aulas.id
WHERE aulas.capacidad > 35;
