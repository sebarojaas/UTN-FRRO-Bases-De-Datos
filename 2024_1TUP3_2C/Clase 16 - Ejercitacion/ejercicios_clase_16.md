### Ejercicio 1: Creación de la Base de Datos
1. **Crea una base de datos llamada `CineDB`**.


### Ejercicio 2: Creación de tablas para películas y géneros
2. **Crea una tabla `Genero` y una tabla `Pelicula`** con las siguientes características:
   
   - `Genero`: contiene el ID y el nombre del género (Ej: Acción, Comedia).
   - `Pelicula`: contiene el ID de la película, título, duración, año de estreno y una clave foránea a la tabla `Genero`.


### Ejercicio 3: Creación de tablas para usuarios y roles
3. **Crea una tabla `Usuario` y una tabla `Rol`**:
   
   - `Rol`: contiene el ID y el nombre del rol (Ej: Administrador, Cliente).
   - `Usuario`: contiene el ID del usuario, nombre, correo electrónico, contraseña y una clave foránea a la tabla `Rol`.


### Ejercicio 4: Creación de tablas para salas y asientos
4. **Crea una tabla `Sala` y una tabla `Asiento`**:
   
   - `Sala`: contiene el ID de la sala y el número de la sala.
   - `Asiento`: contiene el ID del asiento, el número del asiento y una clave foránea a la tabla `Sala`.


### Ejercicio 5: Creación de tablas para funciones y reservas
5. **Crea una tabla `Funcion` y una tabla `Reserva`**:
   
   - `Funcion`: contiene el ID de la función, fecha, hora, ID de la sala y ID de la película.
   - `Reserva`: contiene el ID de la reserva, fecha de la reserva, ID del usuario, ID del asiento y ID de la función.

### Ejercicio 6: Inserción de datos en las tablas
6. **Inserta datos en las tablas `Genero`, `Rol`, `Sala` y `Pelicula`**.

### Ejercicio 7: Consultas básicas de selección
7. **Selecciona todas las películas de un género específico (Ej: Acción)**.

### Ejercicio 8: Consultas con JOIN
8. **Muestra todas las funciones disponibles, incluyendo el nombre de la película, fecha y hora de la función, y la sala**.


### Ejercicio 9: Inserción de una reserva
9. **Realiza una reserva de un usuario en una función para un asiento específico**.


### Ejercicio 10: Consulta de todas las reservas de un usuario
10. **Muestra todas las reservas realizadas por un usuario específico, incluyendo el nombre de la película, fecha y hora de la función, y el asiento reservado**.
