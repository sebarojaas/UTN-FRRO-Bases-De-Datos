-- Selecciono la base de datos a utilizar.
USE utn_bbdd_modificar;

-- Creo la tabla cursos en el caso de que no exista, con todos
-- sus atributos.
CREATE TABLE IF NOT EXISTS cursos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Creo la tabla estudiantesen el caso de que no exista, con todos
-- sus atributos.
CREATE TABLE estudiantes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    curso_id INT
    # FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Modifico la tablas estudiantes y le agrego un nuevo atributo.
ALTER TABLE estudiantes
ADD mail VARCHAR(100);

-- Modifico la tablas estudiantes modificando el tipo de dato de la colmuna.
ALTER TABLE estudiantes
MODIFY COLUMN nombre VARCHAR(100);

-- Modifico la tablas estudiantes, eliminando el atributo fecha_nacimiento 
ALTER TABLE estudiantes
DROP COLUMN fecha_nacimiento;

-- Establezco a curso_id como FOREIGN KEY relacionado con el id
-- de la tabla cursos.
ALTER TABLE estudiantes
ADD FOREIGN KEY (curso_id) REFERENCES cursos(id);

-- Modifico el atributo nombre de cursos para que sea un valor único.
ALTER TABLE cursos
MODIFY COLUMN nombre VARCHAR(100) UNIQUE;

-- Modifico el atributo nombre de estudiantes para que sea un valor único.
ALTER TABLE estudiantes
MODIFY COLUMN nombre VARCHAR(100) UNIQUE;
