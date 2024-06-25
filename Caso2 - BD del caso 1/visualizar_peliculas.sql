-- Valery Carvajal Oreamuno
-- Carné 2022314299

-- Ayuda a visualizar las Películas con su calificación, director(es/as) y atrices o actores
SELECT 
    P.titulo AS 'Título de Película',
    V.calificacion AS 'Calificación',
    CONCAT(A.nombre, ' ', A.apellido) AS 'Nombre del Artista',
    RP.rol AS 'Rol del Artista en la Película'
FROM 
    Pelicula P
LEFT JOIN 
    Visualizacion V ON P.id = V.pelicula_id
LEFT JOIN 
    rolPeli RP ON P.id = RP.pelicula
LEFT JOIN 
    Artista A ON RP.artista = A.id;
