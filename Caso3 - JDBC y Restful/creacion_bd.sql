-- Valery Carvajal Oreamuno
-- Carné 2022314299

-- Crear BD
CREATE DATABASE IF NOT EXISTS MiBDP;
USE MiBDP;

-- Tablas
CREATE TABLE IF NOT EXISTS Artista (
	id INT PRIMARY KEY NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Genero (
	nombre VARCHAR(100) PRIMARY KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS Pelicula (
	id INT PRIMARY KEY UNIQUE,
    titulo VARCHAR(100) NOT NULL,
    sinopsis VARCHAR(500) NOT NULL,
	estado VARCHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
);

CREATE TABLE IF NOT EXISTS Serie (
	id INT PRIMARY KEY NOT NULL UNIQUE,
    titulo VARCHAR(100) NOT NULL,
    sinopsis VARCHAR(500) NOT NULL,
    total_temporadas INT NOT NULL,
    calificacion INT,
    estado CHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Capitulo (
	id INT PRIMARY KEY UNIQUE,
    serie INT NOT NULL,
    numero_temporada VARCHAR(100) NOT NULL,
    numero_capitulo VARCHAR(100) NOT NULL,
	FOREIGN KEY (serie) REFERENCES Serie(id)
);

CREATE TABLE IF NOT EXISTS Visualizacion (
    fecha DATE NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    duracion TIME NOT NULL,
    calificacion INT,
    pelicula_id INT,
    cap_id INT,
    FOREIGN KEY (pelicula_id) REFERENCES Pelicula(id),
    FOREIGN KEY (cap_id) REFERENCES Capitulo(id)
);

-- Atributo Derivado total_temporadas()
UPDATE Serie
SET total_temporadas = COALESCE((
    SELECT MAX(numero_temporada)
    FROM Capitulo
    WHERE Serie.id = Capitulo.serie
), 0);

-- Relaciones
CREATE TABLE IF NOT EXISTS rolPeli(
	rol CHAR NOT NULL,
    artista INT NOT NULL,
    pelicula INT NOT NULL,
    PRIMARY KEY (rol, artista, pelicula),
    FOREIGN KEY (artista) REFERENCES Artista(id),
	FOREIGN KEY (pelicula) REFERENCES Pelicula(id)
);

CREATE TABLE IF NOT EXISTS rolSerie(
	rol CHAR NOT NULL,
    artista INT NOT NULL,
    serie INT NOT NULL,
    PRIMARY KEY (rol, artista, serie),
    FOREIGN KEY (artista) REFERENCES Artista(id),
	FOREIGN KEY (serie) REFERENCES Serie(id)
);

CREATE TABLE IF NOT EXISTS PeliculaGenero (
    pelicula_id INT NOT NULL,
    genero_nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (pelicula_id, genero_nombre),
    FOREIGN KEY (pelicula_id) REFERENCES Pelicula(id),
    FOREIGN KEY (genero_nombre) REFERENCES Genero(nombre)
);

CREATE TABLE IF NOT EXISTS SerieGenero (
    serie_id INT NOT NULL,
    genero_nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (serie_id, genero_nombre),
    FOREIGN KEY (serie_id) REFERENCES Serie(id),
    FOREIGN KEY (genero_nombre) REFERENCES Genero(nombre)
);

-- Vista
CREATE VIEW PeliculasEnMiCasa AS
SELECT
    P.titulo AS 'Nombre de Película',
    CONCAT(A.nombre, ' ', A.apellido) AS 'Nombre del Director',
    P.sinopsis AS 'Sinopsis de Película'
FROM
    Pelicula P
JOIN
    rolPeli RP ON P.id = RP.pelicula AND RP.rol = 'D'
JOIN
    Artista A ON RP.artista = A.id
JOIN
    Visualizacion V ON P.id = V.pelicula_id
WHERE
    V.ubicacion = 'Casa propia';