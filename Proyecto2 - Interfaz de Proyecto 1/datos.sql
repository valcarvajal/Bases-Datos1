-- Proyecto 1 - Bases de Datos I
-- Valery Carvajal Oreamuno
-- Carné 2022314299
-- Ion Angel Dolanescu Bravo
-- Carné 2022049034

-- Inserción de datos para talleres
INSERT INTO Talleres (NumeroCuenta, NombreTaller, Provincia, Canton, Distrito, UbicacionExacta, CostoOperacionMensual, HorasTrabajoMes, NumeroTelefono, Email, Login, Password)
VALUES
    (1, 'Taller A', 'San José', 'San José', 'Centro', 'Dirección 123', 500000, 166, '12345678', 'correo@ejemplo.com', 'tallerA_login', 'password123'),
    (2, 'Taller B', 'Heredia', 'Heredia', 'Centro', 'Dirección 456', 450000, 160, '98765432', 'correo2@ejemplo.com', 'tallerB_login', 'password456');

-- Inserción de datos para clientes
INSERT INTO Clientes (NumeroCliente, NumeroCedula, TipoCedula, NombreCliente, TelefonoCliente, EmailCliente)
VALUES
    (1, '123456789', 'Fisica', 'Cliente 1', '11111111', 'cliente1@ejemplo.com'),
    (2, '987654321', 'Juridica', 'Cliente 2', '22222222', 'cliente2@ejemplo.com');

-- Inserción de datos para registro (relación entre clientes y talleres)
INSERT INTO Registro (NumeroCliente, NumeroCuenta)
VALUES
    (1, 1),
    (2, 2);

-- Inserción de datos para vehículos
INSERT INTO Vehiculos (NumeroPlaca, Marca, Modelo, AnioFabricacion, NumeroVIN, NumeroCliente)
VALUES
    ('ABC123', 'Toyota', 'Corolla', 2020, 'VIN123456789', 1),
    ('XYZ789', 'Honda', 'Civic', 2018, 'VIN987654321', 2);

-- Inserción de datos para la tabla de servicios
INSERT INTO Servicios (FechaIngreso, FechaConclusion, DescripcionServicio, HorasInvertidas, CostoTotalManoObra, CostoTotalFacturado, PorcentajeUtilidad, NumeroPlaca, NumeroCuenta)
VALUES
    ('2023-10-10', '2023-10-15', 'Reparación de frenos', 6, 25000.00, 0.00, 0.00, 'ABC123', 1),
    ('2023-11-15', '2023-11-18', 'Reparación de motor', 2, 15000.00, 0.00, 0.00, 'ABC123', 1),
    ('2023-11-05', NULL, 'Cambio de neumáticos', 4, 20000.00, 0.00, 0.00, 'XYZ789', 2),
	('2023-11-21', '2023-11-25', 'Cambio de filtro', 3, 60000.00, 0.00, 0.00, 'XYZ789', 2);

-- Inserción de un servicio con costo unitario de mano de obra menor al costo mínimo permitido (activa el trigger)
-- INSERT INTO Servicios (FechaIngreso, FechaConclusion, DescripcionServicio, HorasInvertidas, CostoTotalManoObra, CostoTotalFacturado, PorcentajeUtilidad, NumeroPlaca, NumeroCuenta)
-- VALUES
    -- ('2023-11-20', NULL, 'Cambio de aceite', 5, 10000.00, 10000.00, 0.00, 'ABC123', 1),
    -- ('2023-12-01', NULL, 'Alineación y balanceo', 6, 12000.00, 12000.00, 0.00, 'XYZ789', 2);

-- Inserción de datos para la tabla de piezas
INSERT INTO Piezas (CodigoPieza, DescripcionPieza, CostoVenta)
VALUES
    ('P001', 'Pieza 1', 10000.00),
    ('P002', 'Pieza 2', 15000.00),
    ('P003', 'Pieza 3', 8000.00);

-- Inserción de datos para la tabla de piezas utilizadas en servicios
INSERT INTO PiezasUtilizadas (IDServicio, CodigoPieza, Cantidad, CostoTotal)
VALUES
    (1, 'P001', 2, 20000.00),
    (2, 'P002', 4, 60000.00),
    (2, 'P003', 2, 16000.00);

