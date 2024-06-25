-- Proyecto 1 - Bases de Datos I
-- Valery Carvajal Oreamuno
-- Carné 2022314299

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
    CostoOperacionMensual DECIMAL(10, 2) NOT NULL,
    HorasTrabajoMes INT DEFAULT 166,
    NumeroTelefono VARCHAR(15) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Login VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL
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

-- Crear tabla de vehiculos
CREATE TABLE Vehiculos (
    NumeroPlaca VARCHAR(20) PRIMARY KEY,
    Marca VARCHAR(255) NOT NULL,
    Modelo VARCHAR(255) NOT NULL,
    AnioFabricacion INT NOT NULL,
    NumeroVIN VARCHAR(50) NOT NULL,
    NumeroCliente INT,
    FOREIGN KEY (NumeroCliente) REFERENCES Clientes(NumeroCliente)
);

-- Crear tabla de servicios
CREATE TABLE Servicios (
    IDServicio INT PRIMARY KEY AUTO_INCREMENT,
    FechaIngreso DATE NOT NULL,
    FechaConclusion DATE NOT NULL,
    DescripcionServicio TEXT NOT NULL,
    HorasInvertidas DECIMAL(5, 2) NOT NULL,
    CostoTotalManoObra DECIMAL(10, 2) NOT NULL,
    CostoTotalFacturado DECIMAL(10, 2),
    PorcentajeUtilidad DECIMAL(5, 2),
    NumeroPlaca VARCHAR(20),
    NumeroCuenta INT,
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
CREATE TRIGGER ValidarCostoUnitario
BEFORE INSERT ON Servicios
FOR EACH ROW
BEGIN
    DECLARE CostoMinimo DECIMAL(10, 2);
    DECLARE CostoUnitario DECIMAL(10, 2);
    
    SELECT CostoOperacionMensual / HorasTrabajoMes INTO CostoMinimo FROM Talleres WHERE NumeroCuenta = NEW.NumeroCuenta;
    SET CostoUnitario = NEW.HorasInvertidas / NEW.CostoTotalManoObra;
    
    IF CostoUnitario < CostoMinimo THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El costo unitario de mano de obra por hora es menor al costo mínimo permitido.';
    END IF;
END;
//
DELIMITER ;

-- Crear procedimiento almacenado para calcular datos financieros
DELIMITER //
CREATE PROCEDURE CalcularDatosFinancieros(IN ServicioID INT)
BEGIN
    DECLARE CostoManoObra DECIMAL(10, 2);
    DECLARE CostoPiezas DECIMAL(10, 2);
    DECLARE Utilidad DECIMAL(5, 2);
    
    SELECT SUM(CostoTotal) INTO CostoPiezas FROM PiezasUtilizadas WHERE IDServicio = ServicioID;
    SELECT CostoTotalManoObra INTO CostoManoObra FROM Servicios WHERE IDServicio = ServicioID;
    
    SET Utilidad = (CostoUnitario / CostoMinimo - 1) * 100;
    
    UPDATE Servicios
    SET CostoTotalFacturado = CostoManoObra + CostoPiezas,
        PorcentajeUtilidad = Utilidad
    WHERE IDServicio = ServicioID;
END;
//
DELIMITER ;
