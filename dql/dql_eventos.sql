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





-- 11. ActualizarTelefonosPersonalAnual

DELIMITER //

CREATE EVENT ActualizarTelefonosPersonalAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    UPDATE personal
    SET Telefono_Movil = CONCAT('31', FLOOR(RAND() * 9000000) + 1000000);
END //

DELIMITER ;





-- 12. LimpiarProyectosFinalizadosAnual

DELIMITER //

CREATE EVENT LimpiarProyectosFinalizadosAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    DELETE FROM proyecto_investigacion
    WHERE Periodo_Realizacion LIKE '%Finalizado'
    AND STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
END //

DELIMITER ;





-- 13. SimularCrecimientoEspeciesRarasTrimestral

DELIMITER //

CREATE EVENT SimularCrecimientoEspeciesRarasTrimestral
ON SCHEDULE EVERY 3 MONTH
STARTS '2025-06-01 00:00:00'
DO
BEGIN
    UPDATE inventario_especies
    SET Numero_Individuos = Numero_Individuos * 1.10
    WHERE Numero_Individuos < 10;
END //

DELIMITER ;





-- 14. ActualizarEspeciesEnPeligroTrimestral

DELIMITER //

CREATE EVENT ActualizarEspeciesEnPeligroTrimestral
ON SCHEDULE EVERY 3 MONTH
STARTS '2025-06-01 00:00:00'
DO
BEGIN
    UPDATE inventario_especies
    SET Numero_Individuos = FLOOR(Numero_Individuos * 0.95)
    WHERE Numero_Individuos < 50;
END //

DELIMITER ;





-- 15. ActualizarSueldoPorAntiguedadAnual

DELIMITER //

CREATE EVENT ActualizarSueldoPorAntiguedadAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    UPDATE personal
    SET Sueldo = Sueldo * 1.02
    WHERE DATEDIFF(CURDATE(), Fecha_Inicio) / 365 > 5;
END //

DELIMITER ;





-- 16. ActualizarPresupuestoProyectosCriticosTrimestral

/*Descripción: Incrementa en un 10% el presupuesto de proyectos que investigan especies con menos de 20 individuos cada trimestre para priorizar su conservación.*/

DELIMITER //

CREATE EVENT ActualizarPresupuestoProyectosCriticosTrimestral
ON SCHEDULE EVERY 3 MONTH
STARTS '2025-06-01 00:00:00'
DO
BEGIN
    UPDATE proyecto_investigacion pi
    SET Presupuesto = Presupuesto * 1.10
    WHERE EXISTS (
        SELECT 1 
        FROM investigador_proyecto_especie ipe
        JOIN inventario_especies ie ON ipe.ID_Especie = ie.ID_Especie
        WHERE ipe.ID_Proyecto = pi.ID_Proyecto
        AND ie.Numero_Individuos < 20
    )
    AND STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') >= CURDATE();
END //

DELIMITER ;






-- 17. LimpiarPersonalRetiradoAnual

DELIMITER //

CREATE EVENT LimpiarPersonalRetiradoAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    DELETE FROM personal
    WHERE DATEDIFF(CURDATE(), Fecha_Inicio) / 365 > 30;
END //

DELIMITER ;






-- 18. ReasignarVehiculosInactivosSemestral

DELIMITER //

CREATE EVENT ReasignarVehiculosInactivosSemestral
ON SCHEDULE EVERY 6 MONTH
STARTS '2025-07-01 00:00:00'
DO
BEGIN
    UPDATE vehiculo v
    SET Numero_Cedula = (
        SELECT Numero_Cedula 
        FROM personal 
        WHERE Tipo_Personal = '002' 
        AND Numero_Cedula NOT IN (SELECT Numero_Cedula FROM vehiculo WHERE Numero_Cedula IS NOT NULL)
        LIMIT 1
    )
    WHERE v.Numero_Cedula IS NULL;
END //

DELIMITER ;






-- 19. ReducirExtensionAreasPeligrosasAnual

DELIMITER //

CREATE EVENT ReducirExtensionAreasPeligrosasAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    UPDATE area a
    SET Extension = Extension * 0.95
    WHERE (SELECT SUM(Numero_Individuos) FROM inventario_especies ie WHERE ie.ID_Area = a.ID_Area) < 10;
END //

DELIMITER ;






-- 20. LimpiarAlojamientosInactivosAnual

DELIMITER //

CREATE EVENT LimpiarAlojamientosInactivosAnual
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
BEGIN
    DELETE FROM alojamiento
    WHERE ID_Alojamiento NOT IN (
        SELECT ID_Alojamiento 
        FROM registro_visitantes 
        WHERE Fecha_Entrada >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
    );
END //

DELIMITER ;



