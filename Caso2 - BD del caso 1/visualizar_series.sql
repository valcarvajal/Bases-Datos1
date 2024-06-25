-- Valery Carvajal Oreamuno
-- Carné 2022314299

-- Ayuda a visualizar las Series con su calificación, director(es/as) y atrices o actores
SELECT
    S.titulo AS 'Nombre de Serie',
    CONCAT(A.nombre, ' ', A.apellido) AS 'Nombre del Artista',
    RS.rol AS 'Rol del Artista',
    S.total_temporadas AS 'Número Total de Temporadas',
    C.numero_temporada AS 'Número de Temporada del Capítulo',
    C.numero_capitulo AS 'Número de Capítulo',
    VC.calificacion AS 'Calificación del Capítulo',
    S.calificacion AS 'Calificación de la Serie'
FROM
    Serie S
JOIN
    rolSerie RS ON S.id = RS.serie
JOIN
    Artista A ON RS.artista = A.id
JOIN
    Capitulo C ON S.id = C.serie
JOIN
    Visualizacion VC ON C.id = VC.cap_id
WHERE
    VC.calificacion IS NOT NULL AND S.calificacion IS NOT NULL;
