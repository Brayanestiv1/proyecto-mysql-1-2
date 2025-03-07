use parques;

-- 1. ActualizarInventarioTrasInsertarArea

DELIMITER //

CREATE TRIGGER ActualizarInventarioTrasInsertarArea
AFTER INSERT ON area
FOR EACH ROW
BEGIN
    UPDATE inventario_especies ie
    JOIN area a ON ie.ID_Area = a.ID_Area
    SET ie.Numero_Individuos = FLOOR(ie.Numero_Individuos * 0.95)
    WHERE a.ID_Parque = NEW.ID_Parque;
END //

DELIMITER ;




-- 2. ActualizarSuperficieParqueTrasInsertarArea

DELIMITER //

CREATE TRIGGER ActualizarSuperficieParqueTrasInsertarArea
AFTER INSERT ON area
FOR EACH ROW
BEGIN
    UPDATE parque
    SET Superficie_Total = CalcularSuperficieTotalParque(NEW.ID_Parque)
    WHERE ID_Parque = NEW.ID_Parque;
END //

DELIMITER ;





-- 3. ActualizarSuperficieParqueTrasActualizarArea

DELIMITER //

CREATE TRIGGER ActualizarSuperficieParqueTrasActualizarArea
AFTER UPDATE ON area
FOR EACH ROW
BEGIN
    IF OLD.Extension != NEW.Extension THEN
        UPDATE parque
        SET Superficie_Total = CalcularSuperficieTotalParque(NEW.ID_Parque)
        WHERE ID_Parque = NEW.ID_Parque;
    END IF;
END //

DELIMITER ;





-- 4. EliminarInventarioTrasEliminarArea

DELIMITER //

CREATE TRIGGER EliminarInventarioTrasEliminarArea
BEFORE DELETE ON area
FOR EACH ROW
BEGIN
    DELETE FROM inventario_especies
    WHERE ID_Area = OLD.ID_Area;
END //

DELIMITER ;





-- 5. ActualizarInventarioTrasInsertarEspecie

DELIMITER //

CREATE TRIGGER ActualizarInventarioTrasInsertarEspecie
AFTER INSERT ON inventario_especies
FOR EACH ROW
BEGIN
    UPDATE inventario_especies ie
    JOIN especies e1 ON ie.ID_Especie = e1.ID_Especie
    JOIN especies e2 ON NEW.ID_Especie = e2.ID_Especie
    SET ie.Numero_Individuos = FLOOR(ie.Numero_Individuos * 0.95)
    WHERE e1.Tipo = e2.Tipo
    AND ie.ID_Area = NEW.ID_Area
    AND ie.ID_Especie != NEW.ID_Especie;
END //

DELIMITER ;



-- 6. EliminarVehiculosTrasEliminarPersonal

DELIMITER //

CREATE TRIGGER EliminarVehiculosTrasEliminarPersonal
AFTER DELETE ON personal
FOR EACH ROW
BEGIN
    UPDATE vehiculo
    SET Numero_Cedula = NULL
    WHERE Numero_Cedula = OLD.Numero_Cedula;
END //

DELIMITER ;





-- 7. LimitarSueldoMaximoTrasInsertar

DELIMITER //

CREATE TRIGGER LimitarSueldoMaximoTrasInsertar
BEFORE INSERT ON personal
FOR EACH ROW
BEGIN
    IF NEW.Sueldo > 10000000 THEN
        SET NEW.Sueldo = 10000000;
    END IF;
END //

DELIMITER ;





-- 8. ActualizarVehiculoTrasActualizarPersonal

DELIMITER //

CREATE TRIGGER ActualizarVehiculoTrasActualizarPersonal
AFTER UPDATE ON personal
FOR EACH ROW
BEGIN
    IF NEW.Sueldo < 2000000 AND OLD.Tipo_Personal = '002' THEN
        UPDATE vehiculo
        SET Numero_Cedula = (
            SELECT Numero_Cedula 
            FROM personal 
            WHERE Tipo_Personal = '002' 
            AND Sueldo >= 2000000 
            LIMIT 1
        )
        WHERE Numero_Cedula = NEW.Numero_Cedula;
    END IF;
END //

DELIMITER ;





-- 9. ActualizarEstadoProyectoTrasInsertar

DELIMITER //

CREATE TRIGGER ActualizarEstadoProyectoTrasInsertar
AFTER INSERT ON investigador_proyecto_especie
FOR EACH ROW
BEGIN
    UPDATE proyecto_investigacion
    SET Periodo_Realizacion = CONCAT(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', 1), ' al ', SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), ' - Iniciado')
    WHERE ID_Proyecto = NEW.ID_Proyecto
    AND Periodo_Realizacion NOT LIKE '%Iniciado';
END //

DELIMITER ;





-- 10. EliminarInvestigadoresTrasEliminarProyecto

DELIMITER //

CREATE TRIGGER EliminarInvestigadoresTrasEliminarProyecto
BEFORE DELETE ON proyecto_investigacion
FOR EACH ROW
BEGIN
    DELETE FROM investigador_proyecto_especie
    WHERE ID_Proyecto = OLD.ID_Proyecto;
END //

DELIMITER ;





-- 11. LimitarPresupuestoTrasInsertarProyecto

DELIMITER //

CREATE TRIGGER LimitarPresupuestoTrasInsertarProyecto
BEFORE INSERT ON proyecto_investigacion
FOR EACH ROW
BEGIN
    IF NEW.Presupuesto > 100000000 THEN
        SET NEW.Presupuesto = 100000000;
    END IF;
END //

DELIMITER ;




-- 12. ActualizarPresupuestoTrasEliminarInvestigador

DELIMITER //

CREATE TRIGGER ActualizarPresupuestoTrasEliminarInvestigador
AFTER DELETE ON investigador_proyecto_especie
FOR EACH ROW
BEGIN
    UPDATE proyecto_investigacion
    SET Presupuesto = Presupuesto * 0.90
    WHERE ID_Proyecto = OLD.ID_Proyecto
    AND STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') >= CURDATE();
END //

DELIMITER ;





-- 13. ActualizarCapacidadTrasInsertarVisitante

DELIMITER //

CREATE TRIGGER ActualizarCapacidadTrasInsertarVisitante
AFTER INSERT ON registro_visitantes
FOR EACH ROW
BEGIN
    UPDATE alojamiento
    SET Capacidad = Capacidad - 1
    WHERE ID_Alojamiento = NEW.ID_Alojamiento
    AND Capacidad > 0;
END //

DELIMITER ;






-- 14. RestaurarCapacidadTrasEliminarVisitante

DELIMITER //

CREATE TRIGGER RestaurarCapacidadTrasEliminarVisitante
AFTER DELETE ON registro_visitantes
FOR EACH ROW
BEGIN
    UPDATE alojamiento
    SET Capacidad = Capacidad + 1
    WHERE ID_Alojamiento = OLD.ID_Alojamiento;
END //

DELIMITER ;





-- 15. LimitarCapacidadAlojamientoTrasInsertar

DELIMITER //

CREATE TRIGGER LimitarCapacidadAlojamientoTrasInsertar
BEFORE INSERT ON alojamiento
FOR EACH ROW
BEGIN
    IF NEW.Capacidad > 50 THEN
        SET NEW.Capacidad = 50;
    END IF;
END //

DELIMITER ;





-- 16. EliminarVisitantesTrasEliminarAlojamiento

DELIMITER //

CREATE TRIGGER EliminarVisitantesTrasEliminarAlojamiento
BEFORE DELETE ON alojamiento
FOR EACH ROW
BEGIN
    DELETE FROM registro_visitantes
    WHERE ID_Alojamiento = OLD.ID_Alojamiento;
END //

DELIMITER ;





-- 17. ActualizarFechaEntradaVisitante

DELIMITER //

CREATE TRIGGER ActualizarFechaEntradaVisitante
BEFORE INSERT ON registro_visitantes
FOR EACH ROW
BEGIN
    IF NEW.Fecha_Entrada > CURDATE() THEN
        SET NEW.Fecha_Entrada = CURDATE();
    END IF;
END //

DELIMITER ;






-- 18. ActualizarNumeroIndividuosTrasEliminarEspecie

DELIMITER //

CREATE TRIGGER ActualizarNumeroIndividuosTrasEliminarEspecie
AFTER DELETE ON inventario_especies
FOR EACH ROW
BEGIN
    UPDATE inventario_especies
    SET Numero_Individuos = Numero_Individuos + 5
    WHERE ID_Area = OLD.ID_Area
    AND ID_Especie != OLD.ID_Especie;
END //

DELIMITER ;




-- 19. BloquearEliminacionAreaConInventario

DELIMITER //

CREATE TRIGGER BloquearEliminacionAreaConInventario
BEFORE DELETE ON area
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM inventario_especies WHERE ID_Area = OLD.ID_Area) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un área con inventario activo';
    END IF;
END //

DELIMITER ;





-- 20. AjustarInventarioTrasActualizarEspecie

DELIMITER //

CREATE TRIGGER AjustarInventarioTrasActualizarEspecie
AFTER UPDATE ON especies
FOR EACH ROW
BEGIN
    IF NEW.Tipo = 'Vegetal' AND OLD.Tipo != 'Vegetal' THEN
        UPDATE inventario_especies
        SET Numero_Individuos = Numero_Individuos * 1.05
        WHERE ID_Especie = NEW.ID_Especie;
    END IF;
END //

DELIMITER ;




