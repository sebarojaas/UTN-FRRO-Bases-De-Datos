### Ejercicio 1: Creación de la Base de Datos
1. **Crea una base de datos llamada `CineDB`**.

   ```sql
   CREATE DATABASE CineDB;
   USE CineDB;
   ```

### Ejercicio 2: Creación de tablas para películas y géneros
2. **Crea una tabla `Genero` y una tabla `Pelicula`** con las siguientes características:
   
   - `Genero`: contiene el ID y el nombre del género (Ej: Acción, Comedia).
   - `Pelicula`: contiene el ID de la película, título, duración, año de estreno y una clave foránea a la tabla `Genero`.

   ```sql
   CREATE TABLE Genero (
       id_genero INT AUTO_INCREMENT PRIMARY KEY,
       nombre VARCHAR(50) NOT NULL
   );

   CREATE TABLE Pelicula (
       id_pelicula INT AUTO_INCREMENT PRIMARY KEY,
       titulo VARCHAR(100) NOT NULL,
       duracion INT NOT NULL,
       ano_estreno YEAR NOT NULL,
       id_genero INT,
       FOREIGN KEY (id_genero) REFERENCES Genero(id_genero)
   );
   ```

### Ejercicio 3: Creación de tablas para usuarios y roles
3. **Crea una tabla `Usuario` y una tabla `Rol`**:
   
   - `Rol`: contiene el ID y el nombre del rol (Ej: Administrador, Cliente).
   - `Usuario`: contiene el ID del usuario, nombre, correo electrónico, contraseña y una clave foránea a la tabla `Rol`.

   ```sql
   CREATE TABLE Rol (
       id_rol INT AUTO_INCREMENT PRIMARY KEY,
       nombre VARCHAR(50) NOT NULL
   );

   CREATE TABLE Usuario (
       id_usuario INT AUTO_INCREMENT PRIMARY KEY,
       nombre VARCHAR(100) NOT NULL,
       email VARCHAR(100) NOT NULL,
       contrasena VARCHAR(100) NOT NULL,
       id_rol INT,
       FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
   );
   ```

### Ejercicio 4: Creación de tablas para salas y asientos
4. **Crea una tabla `Sala` y una tabla `Asiento`**:
   
   - `Sala`: contiene el ID de la sala y el número de la sala.
   - `Asiento`: contiene el ID del asiento, el número del asiento y una clave foránea a la tabla `Sala`.

   ```sql
   CREATE TABLE Sala (
       id_sala INT AUTO_INCREMENT PRIMARY KEY,
       numero_sala INT NOT NULL
   );

   CREATE TABLE Asiento (
       id_asiento INT AUTO_INCREMENT PRIMARY KEY,
       numero_asiento INT NOT NULL,
       id_sala INT,
       FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
   );
   ```

### Ejercicio 5: Creación de tablas para funciones y reservas
5. **Crea una tabla `Funcion` y una tabla `Reserva`**:
   
   - `Funcion`: contiene el ID de la función, fecha, hora, ID de la sala y ID de la película.
   - `Reserva`: contiene el ID de la reserva, fecha de la reserva, ID del usuario, ID del asiento y ID de la función.

   ```sql
   CREATE TABLE Funcion (
       id_funcion INT AUTO_INCREMENT PRIMARY KEY,
       fecha DATE NOT NULL,
       hora TIME NOT NULL,
       id_sala INT,
       id_pelicula INT,
       FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
       FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
   );

   CREATE TABLE Reserva (
       id_reserva INT AUTO_INCREMENT PRIMARY KEY,
       fecha_reserva DATE NOT NULL,
       id_usuario INT,
       id_asiento INT,
       id_funcion INT,
       FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
       FOREIGN KEY (id_asiento) REFERENCES Asiento(id_asiento),
       FOREIGN KEY (id_funcion) REFERENCES Funcion(id_funcion)
   );
   ```

### Ejercicio 6: Inserción de datos en las tablas
6. **Inserta datos en las tablas `Genero`, `Rol`, `Sala` y `Pelicula`**.

   ```sql
   INSERT INTO Genero (nombre) VALUES ('Acción'), ('Comedia'), ('Drama');
   INSERT INTO Rol (nombre) VALUES ('Administrador'), ('Cliente');
   INSERT INTO Sala (numero_sala) VALUES (1), (2), (3);
   INSERT INTO Pelicula (titulo, duracion, ano_estreno, id_genero) 
   VALUES ('Pelicula A', 120, 2022, 1), ('Pelicula B', 90, 2021, 2);
   ```

### Ejercicio 7: Consultas básicas de selección
7. **Selecciona todas las películas de un género específico (Ej: Acción)**.

   ```sql
   SELECT titulo, duracion, ano_estreno 
   FROM Pelicula 
   WHERE id_genero = (SELECT id_genero FROM Genero WHERE nombre = 'Acción');
   ```

### Ejercicio 8: Consultas con JOIN
8. **Muestra todas las funciones disponibles, incluyendo el nombre de la película, fecha y hora de la función, y la sala**.

   ```sql
   SELECT Pelicula.titulo, Funcion.fecha, Funcion.hora, Sala.numero_sala
   FROM Funcion
   JOIN Pelicula ON Funcion.id_pelicula = Pelicula.id_pelicula
   JOIN Sala ON Funcion.id_sala = Sala.id_sala;
   ```

### Ejercicio 9: Inserción de una reserva
9. **Realiza una reserva de un usuario en una función para un asiento específico**.

   ```sql
   INSERT INTO Reserva (fecha_reserva, id_usuario, id_asiento, id_funcion)
   VALUES ('2024-09-01', 1, 3, 2);
   ```

### Ejercicio 10: Consulta de todas las reservas de un usuario
10. **Muestra todas las reservas realizadas por un usuario específico, incluyendo el nombre de la película, fecha y hora de la función, y el asiento reservado**.

   ```sql
   SELECT Pelicula.titulo, Funcion.fecha, Funcion.hora, Asiento.numero_asiento
   FROM Reserva
   JOIN Funcion ON Reserva.id_funcion = Funcion.id_funcion
   JOIN Pelicula ON Funcion.id_pelicula = Pelicula.id_pelicula
   JOIN Asiento ON Reserva.id_asiento = Asiento.id_asiento
   WHERE Reserva.id_usuario = 1;
   ```