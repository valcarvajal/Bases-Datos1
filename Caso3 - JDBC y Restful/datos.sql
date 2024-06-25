-- Valery Carvajal Oreamuno
-- Carné 2022314299

-- Insertar datos en la tabla Artista
INSERT INTO Artista (id, nombre, apellido)
VALUES 
(1, 'Robert', 'Downey Jr.'),
(2, 'Chris', 'Evans'),
(3, 'Scarlett', 'Johansson'),
(4, 'Chris', 'Hemsworth'),
(5, 'Josh', 'Brolin'),
(6, 'Ellen', 'Pompeo'),
(7, 'Chandra', 'Wilson'),
(8, 'Patrick', 'Dempsey'),
(9, 'Pia', 'Mechler'),
(10, 'Laia', 'Costa'),
(11, 'Anthony', 'Russo'),
(12, 'Joe', 'Russo'),
(13, 'Joss', 'Whedon');

-- Insertar datos en la tabla Genero
INSERT INTO Genero (nombre)
VALUES 
('Drama'),
('Comedia'),
('Acción'),
('Héroes'),
('Fantasía'),
('Aventura'),
('Ciencia Ficción'),
('Novela'),
('Suspenso');

-- Insertar datos en la tabla Pelicula
INSERT INTO Pelicula (id, titulo, sinopsis, estado)
VALUES 
(1, 'Avengers: Endgame', 'Los Vengadores luchan contra Thanos para revertir los efectos devastadores de su chasquido, que eliminó a la mitad del universo. Recurren a viajes en el tiempo para reunir las Gemas del Infinito y restaurar el equilibrio en el universo.',
'V'),
(2, 'Avengers: Infinity War', 'Los Vengadores se enfrentan a Thanos, quien busca las Gemas del Infinito para exterminar la mitad de la vida en el universo. La película culmina en una batalla épica donde los héroes no pueden evitar la victoria de Thanos, lo que lleva a una devastadora desaparición de muchos personajes.',
'V'),
(3, 'Avengers: era de Ultrón', 'Los Vengadores luchan contra Ultrón, una inteligencia artificial decidida a erradicar la humanidad. Los héroes se enfrentan a un enemigo poderoso y deben unir fuerzas para detenerlo. Durante la batalla, surgen tensiones y nuevos aliados, lo que lleva a impactantes eventos y decisiones que afectan al equipo.',
'V');

-- Insertar datos en la tabla Serie
INSERT INTO Serie (id, titulo, sinopsis, total_temporadas, calificacion, estado)
VALUES 
(1, 'Greys Anatomy', 'Serie médica que sigue la vida personal y profesional de los médicos del Grey Sloan Memorial Hospital en Seattle. La trama se centra en la cirujana Meredith Grey y su equipo, explorando relaciones, desafíos médicos, y dilemas éticos mientras enfrentan situaciones emocionales y profesionales en un ambiente hospitalario altamente intenso.',
19, 7, 'V'),
(2, 'Devils', 'Se desarrolla en el mundo financiero de Londres. La trama sigue a un joven banquero, Massimo Ruggero, que se ve envuelto en una red de corrupción y conspiración cuando su mentor es asesinado. Massimo se encuentra en medio de una lucha de poder entre las finanzas internacionales y la política, mientras descubre oscuros secretos y traiciones dentro de su propio banco. La serie explora temas de ambición desenfrenada, engaño y el precio del poder en el mundo de las altas finanzas.',
2, 4, 'V');

-- Insertar datos en la tabla Capitulo
INSERT INTO Capitulo (id, serie, numero_temporada, numero_capitulo)
VALUES 
-- serie 1
(10, 1, 1, 1),
(11, 1, 1, 2), 
(12, 1, 1, 3), 
(13, 1, 1, 4), 
(14, 1, 1, 5),

(15, 1, 2, 1),
(16, 1, 2, 2), 
(17, 1, 2, 3), 
(18, 1, 2, 4), 
(19, 1, 2, 5),

-- serie 2
(20, 2, 1, 1),
(21, 2, 1, 2),
(22, 2, 1, 3),
(23, 2, 1, 4),
(24, 2, 1, 5),

(25, 2, 2, 1),
(26, 2, 2, 2),
(27, 2, 2, 3),
(28, 2, 2, 4),
(29, 2, 2, 5);

-- Insertar datos en la tabla Visualizacion
INSERT INTO Visualizacion (fecha, ubicacion, duracion, calificacion, pelicula_id, cap_id)
VALUES 
-- pelis
('2022-10-02', 'Casa ajena', '03:02:00', 10, 1, NULL),	-- peli 1
('2023-10-02', 'Casa propia', '02:42:00', 9, 2, NULL),	-- peli 2
('2023-10-03', 'Cine', '02:21:00', 7, 3, NULL),	-- peli 3

-- series
-- serie 1
	-- temp 1
('2021-10-01', 'Casa propia', '00:24:00', 10, NULL, 10),
('2021-10-04', 'Casa ajena', '00:22:30', 6, NULL, 11),
('2021-10-05', 'Casa propia', '00:20:15', 4, NULL, 12),
('2021-10-06', 'Casa ajena', '00:21:00', 8, NULL, 13),
('2021-10-07', 'Casa propia', '00:24:30', 9, NULL, 14),
	-- temp 2
('2021-10-08', 'Casa propia', '00:23:00', 10, NULL, 15),
('2021-10-09', 'Casa propia', '00:20:30', 6, NULL, 16),
('2021-10-10', 'Casa propia', '00:21:15', 4, NULL, 17),
('2021-10-11', 'Casa ajena', '00:21:30', 8, NULL, 18),
('2021-10-12', 'Casa ajena', '00:24:00', 9, NULL, 19),

-- serie 2
	-- temp 1
('2023-05-04', 'Casa ajena', '00:25:00', 1, NULL, 20),
('2023-05-05', 'Casa propia', '00:21:30', 3, NULL, 21),
('2023-05-06', 'Casa propia', '00:22:00', 7, NULL, 22),
('2023-05-07', 'Casa propia', '00:23:16', 2, NULL, 23),
('2023-05-08', 'Casa ajena', '00:20:00', 5, NULL, 24),
	-- temp 2
('2023-05-09', 'Casa propia', '00:20:00', 1, NULL, 25),
('2023-05-10', 'Casa propia', '00:22:30', 3, NULL, 26),
('2023-05-11', 'Casa propia', '00:22:30', 7, NULL, 27),
('2023-05-12', 'Casa ajena', '00:23:15', 2, NULL, 28),
('2023-05-13', 'Casa ajena', '00:21:00', 5, NULL, 29);

-- Insertar datos en la tabla rolPeli
INSERT INTO rolPeli (rol, artista, pelicula)
VALUES
-- peli 1
-- directores
('D', 11, 1),
('D', 12, 1),
-- actrices/actores
('A', 1, 1),
('A', 2, 1),
('A', 4, 1),

-- peli 2
-- directores
('D', 11, 2),
('D', 12, 2),
-- actrices/actores
('A', 1, 2),
('A', 3, 2),
('A', 5, 2),

-- peli 3
-- director
('D', 13, 3),
-- actrices/actores
('A', 1, 3),
('A', 2, 3),
('A', 3, 3);

-- Insertar datos en la tabla rolSerie
INSERT INTO rolSerie (rol, artista, serie)
VALUES
-- serie 1
('A', 6, 1),
('A', 7, 1),
('A', 8, 1),
-- serie 2
('A', 8, 2),
('A', 9, 2),
('A', 10, 2);

-- Insertar datos en la tabla PeliculaGenero
INSERT INTO PeliculaGenero (pelicula_id, genero_nombre)
VALUES
-- peli 1
(1, 'Acción'),
(1, 'Héroes'),
(1, 'Ciencia Ficción'),
(1, 'Fantasía'),
(1, 'Aventura'),

-- peli 2
(2, 'Acción'),
(2, 'Héroes'),
(2, 'Ciencia Ficción'),

-- peli 3
(3, 'Acción'),
(3, 'Héroes'),
(3, 'Ciencia Ficción'),
(3, 'Aventura');

-- Insertar datos en la tabla SerieGenero
INSERT INTO SerieGenero (serie_id, genero_nombre)
VALUES
-- serie 1
(1, 'Drama'),
(1, 'Novela'),

-- serie 2
(2, 'Drama'),
(2, 'Suspenso');