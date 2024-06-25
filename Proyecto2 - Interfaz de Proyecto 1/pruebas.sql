-- PRUEBA TRIGGER
-- Verificar si los servicios se han insertado correctamente (prueba trigger)
-- SELECT * FROM Servicios; -- Muestra Tabla Servicios
-- SELECT * FROM talleres; -- Muestra Tabla Talleres
-- SHOW TRIGGERS LIKE 'Servicios'; -- Muestra Triggers Activos de la Tabla Servicios
-- SELECT * FROM information_schema.triggers WHERE trigger_schema = 'tallercr'; -- Muestra Triggers Activos de la BD TallerCR

-- PRUEBA PROCEDIMIENTO ALMACENADO
-- CALL calcular_datos_financieros(1); -- Servicio 1 (Reparación de frenos)
-- CALL calcular_datos_financieros(2); -- Servicio 2 (Reparación de motor)
-- CALL calcular_datos_financieros(3); -- Servicio 3 (Cambio de neumáticos)
-- CALL calcular_datos_financieros(4); -- Servicio 4 (Cambio de filtro)
-- CALL calcular_datos_financieros(5); -- No existe, no afecta a la tabla