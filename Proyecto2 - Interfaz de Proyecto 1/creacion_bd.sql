-- Proyecto 1 - Bases de Datos I
-- Valery Carvajal Oreamuno
-- Carné 2022314299
-- Ion Angel Dolanescu Bravo
-- Carné 2022049034

-- Crear la base de datos TallerCR
CREATE DATABASE IF NOT EXISTS TallerCR;

-- Seleccionar la base de datos
USE TallerCR;

-- Crear tabla de talleres
CREATE TABLE Talleres (
    NumeroCuenta INT PRIMARY KEY,
    NombreTaller VARCHAR(255) NOT NULL,
    Provincia VARCHAR(255) NOT NULL,
    Canton VARCHAR(255) NOT NULL,
    Distrito VARCHAR(255) NOT NULL,
    UbicacionExacta VARCHAR(255),
    NumeroTelefono VARCHAR(15) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Login VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    
    -- Usados en el trigger
    CostoOperacionMensual DECIMAL(10, 2) NOT NULL,
    HorasTrabajoMes INT DEFAULT 166
);

-- Crear tabla de clientes
CREATE TABLE Clientes (
    NumeroCliente INT PRIMARY KEY,
    NumeroCedula VARCHAR(20) NOT NULL,
    TipoCedula ENUM('Fisica', 'Juridica') NOT NULL,
    NombreCliente VARCHAR(255) NOT NULL,
    TelefonoCliente VARCHAR(15) NOT NULL,
    EmailCliente VARCHAR(255) NOT NULL
);

-- Crear tabla de relacion cliente con taller
CREATE TABLE Registro (
    NumeroCliente INT,
    NumeroCuenta INT,
    PRIMARY KEY (NumeroCliente,NumeroCuenta),
    FOREIGN KEY (NumeroCliente) REFERENCES Clientes(NumeroCliente),
    FOREIGN KEY (NumeroCuenta) REFERENCES Talleres(NumeroCuenta)
);

-- Crear tabla de vehiculos
CREATE TABLE Vehiculos (
    NumeroPlaca VARCHAR(20) PRIMARY KEY,
    Marca VARCHAR(255) NOT NULL,
    Modelo VARCHAR(255) NOT NULL,
    AnioFabricacion INT NOT NULL,
    NumeroVIN VARCHAR(50) NOT NULL,
    NumeroCliente INT NOT NULL,
    FOREIGN KEY (NumeroCliente) REFERENCES Clientes(NumeroCliente)
);

-- Crear tabla de servicios
CREATE TABLE Servicios (
    IDServicio INT PRIMARY KEY AUTO_INCREMENT,
    FechaIngreso DATE NOT NULL,
    FechaConclusion DATE,
    DescripcionServicio TEXT NOT NULL,
    NumeroPlaca VARCHAR(20) NOT NULL,
    NumeroCuenta INT NOT NULL,
    
	-- Usados en el procedimiento almacenado y el trigger
    HorasInvertidas DECIMAL(5, 2) NOT NULL,
    CostoTotalManoObra DECIMAL(10, 2) NOT NULL,
    
    -- Se actualizan en el procedimiento almacenado
    CostoTotalFacturado DECIMAL(10, 2) NOT NULL, -- Incluye servicio y piezas
    PorcentajeUtilidad DECIMAL(5, 2) NOT NULL,
    
    FOREIGN KEY (NumeroPlaca) REFERENCES Vehiculos(NumeroPlaca),
    FOREIGN KEY (NumeroCuenta) REFERENCES Talleres(NumeroCuenta)
);

-- Crear tabla de piezas
CREATE TABLE Piezas (
    CodigoPieza VARCHAR(50) PRIMARY KEY,
    DescripcionPieza VARCHAR(255) NOT NULL,
    CostoVenta DECIMAL(10, 2) NOT NULL
);

-- Crear tabla de piezas utilizadas en servicios
CREATE TABLE PiezasUtilizadas (
    IDPiezaUtilizada INT PRIMARY KEY AUTO_INCREMENT,
    IDServicio INT,
    CodigoPieza VARCHAR(50),
    Cantidad INT,
    CostoTotal DECIMAL(10, 2),
    FOREIGN KEY (IDServicio) REFERENCES Servicios(IDServicio),
    FOREIGN KEY (CodigoPieza) REFERENCES Piezas(CodigoPieza)
);

-- Crear trigger para validar el costo unitario de mano de obra por hora
DELIMITER //
CREATE TRIGGER CambiarNull
BEFORE INSERT ON Servicios
FOR EACH ROW
BEGIN
	IF(NEW.HorasInvertidas IS NULL) THEN
     SET NEW.HorasInvertidas = 0;
	END IF;
    IF(NEW.CostoTotalManoObra IS NULL) THEN
     SET NEW.CostoTotalManoObra = 0;
	END IF;
    IF(NEW.PorcentajeUtilidad IS NULL) THEN
     SET NEW.PorcentajeUtilidad = 0;
     END IF;
	IF(NEW.CostoTotalFacturado IS NULL) THEN
     SET NEW.CostoTotalFacturado = 0;
     END IF;
END;
// DELIMITER;

DELIMITER //
CREATE TRIGGER ValidarCostoUnitario
BEFORE INSERT ON Servicios
FOR EACH ROW
BEGIN
    DECLARE CostoMinimo DECIMAL(10, 2);
    DECLARE CostoUnitario DECIMAL(10, 2);
    
	IF (NEW.HorasInvertidas > 0) THEN 
		-- Obtener el costo mínimo de operación por hora para validar
		SELECT CostoOperacionMensual / HorasTrabajoMes INTO CostoMinimo FROM Talleres WHERE NumeroCuenta = NEW.NumeroCuenta;
		
		-- Calcular el costo unitario de mano de obra
		SET CostoUnitario = NEW.CostoTotalManoObra / NEW.HorasInvertidas;
		
		-- Verificar si el costo unitario es menor al costo mínimo permitido
		IF CostoUnitario < CostoMinimo THEN
			SIGNAL SQLSTATE '45000' -- Generic “unhandled user-defined exception.”
			SET MESSAGE_TEXT = 'Error: El costo unitario de mano de obra por hora es menor al costo mínimo permitido.';
		END IF;
    END IF;
END;
// DELIMITER ;




DELIMITER //
CREATE PROCEDURE calcular_datos_financieros(IN servicio_ID INT)
BEGIN
    DECLARE CostoManoObra DECIMAL(10, 2);
    DECLARE CostoPiezas DECIMAL(10, 2);
    DECLARE Utilidad DECIMAL(5, 2);
    DECLARE TotalFacturado DECIMAL(10, 2);
	DECLARE CostoUnitario DECIMAL(10, 2);

    -- Guardar el costo total por mano de obra del servicio
    SELECT CostoTotalManoObra INTO CostoManoObra
    FROM Servicios
    WHERE IDServicio = servicio_ID;

    -- Calcular la sumatoria del valor "costo total" para todas las piezas utilizadas en el servicio
    SELECT IFNULL(SUM(CostoTotal), 0) INTO CostoPiezas
    FROM PiezasUtilizadas
    WHERE IDServicio = servicio_ID;
    
    -- Calcular el Costo Unitario de Mano de Obra por Hora Cobrado
	SELECT CostoTotalManoObra / HorasInvertidas INTO CostoUnitario FROM Servicios WHERE IDServicio = servicio_ID;

    -- Calcular el costo total facturado
    SET TotalFacturado = CostoManoObra + CostoPiezas;

    -- Calcular el porcentaje de utilidad
    SET Utilidad = ((CostoUnitario / (SELECT CostoOperacionMensual / HorasTrabajoMes FROM Talleres WHERE NumeroCuenta =
						(SELECT NumeroCuenta FROM Servicios WHERE IDServicio = servicio_ID))) - 1) * 100;

    -- Verificar si el porcentaje de utilidad es negativo y ajustarlo a cero
    IF Utilidad < 0 THEN
        SET Utilidad = 0;
    END IF;

    -- Actualizar los valores en la tabla de Servicios
    UPDATE Servicios
    SET CostoTotalFacturado = TotalFacturado,
        PorcentajeUtilidad = Utilidad
    WHERE IDServicio = servicio_ID;
END
// DELIMITER ;

