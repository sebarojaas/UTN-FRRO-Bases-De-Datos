-- 1. Listar propiedades con sus anfitriones:

SELECT p.nombre AS propiedad, u.nombre AS usuario
FROM propiedades p
INNER JOIN usuarios u ON u.usuario_id = p.anfitrion_id
WHERE u.tipo = 'anfitrion';

-- 2. Propiedades reservadas por cada huésped:

SELECT u.nombre AS huesped, p.nombre AS propiedad
FROM reservas r
JOIN usuarios u ON u.usuario_id = r.huesped_id
JOIN propiedades p ON p.propiedad_id = r.propiedad_id
WHERE u.tipo = 'huesped';

-- 3. Propiedades que nunca han sido reservadas:

SELECT p.nombre as propiedad
FROM propiedades p
LEFT JOIN reservas r ON p.propiedad_id = r.propiedad_id
WHERE r.reserva_id IS NULL;

SELECT propiedades.nombre
FROM propiedades
WHERE propiedades.propiedad_id NOT IN (
	SELECT reservas.propiedad_id FROM reservas
);

-- 4. Reseñas de propiedades con puntuación baja:

SELECT p.nombre AS propiedad, AVG(r.calificacion) AS promedio
FROM reseñas r
JOIN propiedades p ON p.propiedad_id = r.propiedad_id
GROUP BY p.nombre
HAVING AVG(r.calificacion) < 5;

-- puntuacion alta

SELECT p.nombre AS propiedad, AVG(r.calificacion) AS promedio
FROM reseñas r
JOIN propiedades p ON p.propiedad_id = r.propiedad_id
GROUP BY p.nombre
HAVING AVG(r.calificacion) = 5;

-- 5. Right Join entre propiedades y reservas:

SELECT p.nombre AS propiedad, r.reserva_id AS reserva
FROM reservas r
RIGHT JOIN propiedades p ON r.propiedad_id = p.propiedad_id;

-- 6. Propiedades con más de 5 reservas confirmadas:

SELECT p.nombre AS propiedad, COUNT(r.reserva_id) AS cantidad_reservas
FROM reservas r
INNER JOIN propiedades p ON p.propiedad_id = r.propiedad_id
WHERE r.estado = 'confirmada'
GROUP BY p.nombre
HAVING cantidad_reservas >= 2;

-- 7. Huéspedes que han reservado en más de una propiedad:

SELECT u.nombre, COUNT(DISTINCT r.propiedad_id) AS propiedades
FROM reservas r
JOIN usuarios u ON u.usuario_id = r.huesped_id
GROUP BY u.nombre
HAVING COUNT(DISTINCT r.propiedad_id) > 1;

-- 8. Disponibilidad de una propiedad específica:

SELECT d.fecha_disponible
FROM disponibilidad d
JOIN propiedades p ON d.propiedad_id = p.propiedad_id
WHERE p.nombre = 'Casa Rural' AND d.disponible = TRUE;

-- 9. Propiedades con servicios específicos:

SELECT p.nombre 
FROM propiedades p
JOIN propiedades_servicios ps ON ps.propiedad_id = p.propiedad_id
JOIN servicios s ON s.servicio_id = ps.servicio_id
WHERE s.nombre = 'Estacionamiento gratuito';