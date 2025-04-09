Aquí tienes 15 ejercicios que incluyen *joins*, *subconsultas*, *right joins*, y la creación de *stored procedures*:

### 1. **Listar propiedades con sus anfitriones:**
   **Enunciado:** Mostrar el nombre de las propiedades junto con el nombre de sus anfitriones.
   ```sql
   SELECT p.nombre AS Propiedad, u.nombre AS Anfitrion
   FROM propiedades p
   JOIN usuarios u ON p.anfitrion_id = u.usuario_id
   WHERE u.tipo = 'anfitrion';
   ```

### 2. **Propiedades reservadas por cada huésped:**
   **Enunciado:** Mostrar el nombre de cada huésped junto con los nombres de las propiedades que ha reservado.
   ```sql
   SELECT u.nombre AS Huesped, p.nombre AS Propiedad
   FROM reservas r
   JOIN usuarios u ON r.huesped_id = u.usuario_id
   JOIN propiedades p ON r.propiedad_id = p.propiedad_id
   WHERE u.tipo = 'huésped';
   ```

### 3. **Propiedades que nunca han sido reservadas:**
   **Enunciado:** Listar todas las propiedades que no han sido reservadas nunca.
   ```sql
   SELECT p.nombre
   FROM propiedades p
   LEFT JOIN reservas r ON p.propiedad_id = r.propiedad_id
   WHERE r.reserva_id IS NULL;
   ```

### 4. **Reseñas de propiedades con puntuación baja:**
   **Enunciado:** Obtener las propiedades que tienen una calificación promedio menor a 3.
   ```sql
   SELECT p.nombre, AVG(r.calificacion) AS Promedio
   FROM reseñas r
   JOIN propiedades p ON r.propiedad_id = p.propiedad_id
   GROUP BY p.nombre
   HAVING AVG(r.calificacion) < 3;
   ```

### 5. **Right Join entre propiedades y reservas:**
   **Enunciado:** Mostrar todas las propiedades y sus reservas, incluyendo las propiedades sin reservas.
   ```sql
   SELECT p.nombre AS Propiedad, r.reserva_id AS Reserva
   FROM propiedades p
   RIGHT JOIN reservas r ON p.propiedad_id = r.propiedad_id;
   ```

### 6. **Propiedades con más de 5 reservas confirmadas:**
   **Enunciado:** Listar las propiedades que han sido reservadas al menos 5 veces con estado 'confirmada'.
   ```sql
   SELECT p.nombre, COUNT(r.reserva_id) AS Reservas
   FROM reservas r
   JOIN propiedades p ON r.propiedad_id = p.propiedad_id
   WHERE r.estado = 'confirmada'
   GROUP BY p.nombre
   HAVING COUNT(r.reserva_id) >= 5;
   ```

### 7. **Huéspedes que han reservado en más de una propiedad:**
   **Enunciado:** Mostrar los huéspedes que han reservado en más de una propiedad diferente.
   ```sql
   SELECT u.nombre, COUNT(DISTINCT r.propiedad_id) AS Propiedades
   FROM reservas r
   JOIN usuarios u ON r.huesped_id = u.usuario_id
   GROUP BY u.nombre
   HAVING COUNT(DISTINCT r.propiedad_id) > 1;
   ```

### 8. **Disponibilidad de una propiedad específica:**
   **Enunciado:** Mostrar las fechas disponibles para la propiedad 'Casa de Playa'.
   ```sql
   SELECT d.fecha_disponible
   FROM disponibilidad d
   JOIN propiedades p ON d.propiedad_id = p.propiedad_id
   WHERE p.nombre = 'Casa de Playa' AND d.disponible = TRUE;
   ```

### 9. **Propiedades con servicios específicos:**
   **Enunciado:** Mostrar todas las propiedades que tienen el servicio 'Wi-Fi'.
   ```sql
   SELECT p.nombre
   FROM propiedades p
   JOIN propiedades_servicios ps ON p.propiedad_id = ps.propiedad_id
   JOIN servicios s ON ps.servicio_id = s.servicio_id
   WHERE s.nombre = 'Wi-Fi';
   ```

### 10. **Huéspedes sin reservas:**
   **Enunciado:** Listar los huéspedes que nunca han hecho una reserva.
   ```sql
   SELECT u.nombre
   FROM usuarios u
   LEFT JOIN reservas r ON u.usuario_id = r.huesped_id
   WHERE r.reserva_id IS NULL AND u.tipo = 'huésped';
   ```

### 11. **Propiedades más caras que el promedio:**
   **Enunciado:** Mostrar las propiedades cuyo precio por noche es mayor al promedio de todas las propiedades.
   ```sql
   SELECT nombre, precio_por_noche
   FROM propiedades
   WHERE precio_por_noche > (SELECT AVG(precio_por_noche) FROM propiedades);
   ```

### 12. **Stored Procedure para agregar un nuevo servicio a una propiedad:**
   **Enunciado:** Crear un procedimiento almacenado para agregar un nuevo servicio a una propiedad específica.
   ```sql
   DELIMITER //
   CREATE PROCEDURE agregarServicioPropiedad(IN prop_id INT, IN servicio_nombre VARCHAR(255))
   BEGIN
       DECLARE serv_id INT;
       SELECT servicio_id INTO serv_id FROM servicios WHERE nombre = servicio_nombre;
       IF serv_id IS NULL THEN
           INSERT INTO servicios (nombre) VALUES (servicio_nombre);
           SET serv_id = LAST_INSERT_ID();
       END IF;
       INSERT INTO propiedades_servicios (propiedad_id, servicio_id) VALUES (prop_id, serv_id);
   END //
   DELIMITER ;
   ```

### 13. **Propiedades reservadas entre dos fechas:**
   **Enunciado:** Listar las propiedades reservadas entre el 1 de noviembre de 2024 y el 30 de noviembre de 2024.
   ```sql
   SELECT p.nombre
   FROM reservas r
   JOIN propiedades p ON r.propiedad_id = p.propiedad_id
   WHERE r.fecha_inicio BETWEEN '2024-11-01' AND '2024-11-30';
   ```

### 14. **Huéspedes con reservas pendientes:**
   **Enunciado:** Mostrar el nombre de los huéspedes que tienen reservas pendientes.
   ```sql
   SELECT u.nombre
   FROM reservas r
   JOIN usuarios u ON r.huesped_id = u.usuario_id
   WHERE r.estado = 'pendiente';
   ```

### 15. **Número total de reservas por anfitrión:**
   **Enunciado:** Obtener el número total de reservas para cada anfitrión.
   ```sql
   SELECT u.nombre AS Anfitrion, COUNT(r.reserva_id) AS TotalReservas
   FROM usuarios u
   JOIN propiedades p ON u.usuario_id = p.anfitrion_id
   JOIN reservas r ON p.propiedad_id = r.propiedad_id
   WHERE u.tipo = 'anfitrion'
   GROUP BY u.nombre;
   ```

Estos ejercicios cubren varios aspectos de SQL como *joins*, *subconsultas*, *right joins* y *stored procedures*, en el contexto del sistema de reservas de Airbnb.