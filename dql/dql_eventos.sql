use parques;


-- 1. ActualizarInventarioEspeciesMensual

DELIMITER //

CREATE EVENT ActualizarInventarioEspeciesMensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    UPDATE inventario_especies ie
    JOIN especies e ON ie.ID_Especie = e.ID_Especie
    SET ie.Numero_Individuos = ie.Numero_Individuos * 1.05
    WHERE e.Tipo = 'Vegetal';
END //

DELIMITER ;





-- 2. ReducirInventarioAnimalesMensual

DELIMITER //

CREATE EVENT ReducirInventarioAnimalesMensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    UPDATE inventario_especies ie
    JOIN especies e ON ie.ID_Especie = e.ID_Especie
    SET ie.Numero_Individuos = FLOOR(ie.Numero_Individuos * 0.98)
    WHERE e.Tipo = 'Animal';
END //

DELIMITER ;





-- 3. ActualizarSueldosPersonalAnual

DELIMITER //

CREATE EVENT ActualizarSueldosPersonalAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    UPDATE personal
    SET Sueldo = Sueldo * 1.03;
END //

DELIMITER ;




-- 4. LimpiarRegistrosVisitantesAntiguos

DELIMITER //

CREATE EVENT LimpiarRegistrosVisitantesAntiguos
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    DELETE FROM registro_visitantes
    WHERE Fecha_Entrada < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END //

DELIMITER ;





-- 5. ActualizarEstadoProyectosDiario

DELIMITER //

CREATE EVENT ActualizarEstadoProyectosDiario
ON SCHEDULE EVERY 1 DAY
STARTS '2025-03-06 00:00:00'
DO
BEGIN
    UPDATE proyecto_investigacion
    SET Periodo_Realizacion = CONCAT(Periodo_Realizacion, ' - Finalizado')
    WHERE STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') < CURDATE()
    AND Periodo_Realizacion NOT LIKE '%Finalizado';
END //

DELIMITER ;






-- 6. ActualizarCapacidadAlojamientosMensual

DELIMITER //

CREATE EVENT ActualizarCapacidadAlojamientosMensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    UPDATE alojamiento
    SET Capacidad = Capacidad * 1.10
    WHERE Categoria = 'Cabaña';
END //

DELIMITER ;






-- 7. IncrementarPresupuestoProyectosAnual

DELIMITER //

CREATE EVENT IncrementarPresupuestoProyectosAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    UPDATE proyecto_investigacion
    SET Presupuesto = Presupuesto * 1.05
    WHERE STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') >= CURDATE();
END //

DELIMITER ;





-- 8. LimpiarInventarioEspeciesNulasMensual

DELIMITER //

CREATE EVENT LimpiarInventarioEspeciesNulasMensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    DELETE FROM inventario_especies
    WHERE Numero_Individuos = 0;
END //

DELIMITER ;






-- 9. RotarPersonalVigilanciaSemestral

DELIMITER //

CREATE EVENT RotarPersonalVigilanciaSemestral
ON SCHEDULE EVERY 6 MONTH
STARTS '2025-07-01 00:00:00'
DO
BEGIN
    UPDATE personal p
    JOIN vehiculo v ON p.Numero_Cedula = v.Numero_Cedula
    SET v.Numero_Cedula = (
        SELECT Numero_Cedula 
        FROM personal 
        WHERE Tipo_Personal = '002' 
        ORDER BY RAND() 
        LIMIT 1
    )
    WHERE p.Tipo_Personal = '002';
END //

DELIMITER ;






-- 10. ActualizarExtensionAreasAnual

DELIMITER //

CREATE EVENT ActualizarExtensionAreasAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    UPDATE area
    SET Extension = Extension * 1.01;
END //

DELIMITER ;






















































































