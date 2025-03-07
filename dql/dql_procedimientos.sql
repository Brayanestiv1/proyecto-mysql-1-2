USE parques;

-- 1. Registrar un nuevo parque

DELIMITER //

CREATE PROCEDURE RegistrarParque (
    IN ID_Parque INT,
    IN Nombre_Parque VARCHAR(100),
    IN Fecha_Declaracion DATE,
    IN Superficie_Total DECIMAL(15,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo insertar el parque' AS Mensaje;
        ROLLBACK;
    END;

    START transaction;
    INSERT INTO parque (ID_Parque, Nombre_Parque, Fecha_Declaracion, Superficie_Total)
    VALUES (ID_Parque, Nombre_Parque, Fecha_Declaracion, Superficie_Total);
    
    COMMIT;
    SELECT 'Parque registrado exitosamente' AS Mensaje;
END //

DELIMITER ;

CALL RegistrarParque(51, 'Parque Nuevo', '2025-03-06', 10000.00);




-- 2. Actualiza los datos de un parque existente

DELIMITER //

CREATE PROCEDURE ActualizarParque (
    IN p_ID_Parque INT,
    IN p_Nombre_Parque VARCHAR(100),
    IN p_Fecha_Declaracion DATE,
    IN p_Superficie_Total DECIMAL(15,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo actualizar el parque' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;
    UPDATE parque
    SET Nombre_Parque = p_Nombre_Parque,
        Fecha_Declaracion = p_Fecha_Declaracion,
        Superficie_Total = p_Superficie_Total
    WHERE ID_Parque = p_ID_Parque;

    IF ROW_COUNT() = 0 THEN
        SELECT 'Error: No se encontró el parque con ese ID' AS Mensaje;
        ROLLBACK;
    ELSE
        COMMIT;
        SELECT 'Parque actualizado exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;


CALL ActualizarParque(51, 'Parque Nuevo Modificado', '2025-03-07', 12000.00);

select * from parque;




-- 3. Registra una nueva área asociada a un parque

DELIMITER //

CREATE PROCEDURE RegistrarArea (
    IN p_ID_Area INT,
    IN p_Nombre_Area VARCHAR(100),
    IN p_Extension DECIMAL(10,2),
    IN p_ID_Parque INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo insertar el área' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM parque WHERE ID_Parque = p_ID_Parque) THEN
        SELECT 'Error: El parque especificado no existe' AS Mensaje;
        ROLLBACK;
    ELSE
        INSERT INTO area (ID_Area, Nombre_Area, Extension, ID_Parque)
        VALUES (p_ID_Area, p_Nombre_Area, p_Extension, p_ID_Parque);
        COMMIT;
        SELECT 'Área registrada exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;


CALL RegistrarArea(51, 'Zona Nueva', 5000.50, 1);

select * from area;




-- 4. Registra una nueva especie

DELIMITER //

CREATE PROCEDURE RegistrarEspecie (
    IN p_ID_Especie INT,
    IN p_Denominacion_Cientifica VARCHAR(100),
    IN p_Denominacion_Vulgar VARCHAR(100),
    IN p_Tipo ENUM('Vegetal', 'Animal', 'Mineral')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo insertar la especie' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;
    INSERT INTO especies (ID_Especie, Denominacion_Cientifica, Denominacion_Vulgar, Tipo)
    VALUES (p_ID_Especie, p_Denominacion_Cientifica, p_Denominacion_Vulgar, p_Tipo);
    
    COMMIT;
    SELECT 'Especie registrada exitosamente' AS Mensaje;
END //

DELIMITER ;


CALL RegistrarEspecie(51, 'Canis lupus', 'Lobo Gris', 'Animal');

select * from especies;




-- 5. Actualiza o registra el número de individuos de una especie en un área específica en la tabla inventario_especies.

DELIMITER //

CREATE PROCEDURE ActualizarInventarioEspecies (
    IN p_ID_Inventario INT,
    IN p_ID_Especie INT,
    IN p_ID_Area INT,
    IN p_Numero_Individuos INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo actualizar el inventario' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM especies WHERE ID_Especie = p_ID_Especie) THEN
        SELECT 'Error: La especie especificada no existe' AS Mensaje;
        ROLLBACK;
    ELSEIF NOT EXISTS (SELECT 1 FROM area WHERE ID_Area = p_ID_Area) THEN
        SELECT 'Error: El área especificada no existe' AS Mensaje;
        ROLLBACK;
    ELSE

        IF EXISTS (SELECT 1 FROM inventario_especies WHERE ID_Inventario = p_ID_Inventario) THEN
            UPDATE inventario_especies
            SET Numero_Individuos = p_Numero_Individuos
            WHERE ID_Inventario = p_ID_Inventario;
            SELECT 'Inventario actualizado exitosamente' AS Mensaje;
        ELSE
            INSERT INTO inventario_especies (ID_Inventario, ID_Especie, ID_Area, Numero_Individuos)
            VALUES (p_ID_Inventario, p_ID_Especie, p_ID_Area, p_Numero_Individuos);
            SELECT 'Inventario registrado exitosamente' AS Mensaje;
        END IF;
        COMMIT;
    END IF;
END //

DELIMITER ;


CALL ActualizarInventarioEspecies(51, 1, 1, 20);

select * from inventario_especies;




-- 6. Registra un nuevo visitante en la tabla visitante.

DELIMITER //

CREATE PROCEDURE RegistrarVisitante (
    IN p_Numero_Cedula VARCHAR(20),
    IN p_Nombre VARCHAR(100),
    IN p_Direccion TEXT,
    IN p_Profesion VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo registrar el visitante' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;
    INSERT INTO visitante (Numero_Cedula, Nombre, Direccion, Profesion)
    VALUES (p_Numero_Cedula, p_Nombre, p_Direccion, p_Profesion);
    
    COMMIT;
    SELECT 'Visitante registrado exitosamente' AS Mensaje;
END //

DELIMITER ;


CALL RegistrarVisitante('123456789', 'Luis García', 'Calle 50 #20-30, Bogotá', 'Ingeniero');


select * from visitante;





-- 7. Asigna un visitante a un alojamiento, verificando que haya capacidad disponible en la fecha de entrada.

DELIMITER //

CREATE PROCEDURE AsignarAlojamiento (
    IN p_Numero_Cedula VARCHAR(20),
    IN p_ID_Alojamiento INT,
    IN p_Fecha_Entrada DATE
)
BEGIN
    DECLARE v_Capacidad INT;
    DECLARE v_Ocupados INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo asignar el alojamiento' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM visitante WHERE Numero_Cedula = p_Numero_Cedula) THEN
        SELECT 'Error: El visitante especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF NOT EXISTS (SELECT 1 FROM alojamiento WHERE ID_Alojamiento = p_ID_Alojamiento) THEN
        SELECT 'Error: El alojamiento especificado no existe' AS Mensaje;
        ROLLBACK;
    ELSE

        SELECT Capacidad INTO v_Capacidad
        FROM alojamiento
        WHERE ID_Alojamiento = p_ID_Alojamiento;


        SELECT COUNT(*) INTO v_Ocupados
        FROM registro_visitantes
        WHERE ID_Alojamiento = p_ID_Alojamiento
        AND p_Fecha_Entrada >= Fecha_Entrada;


        IF v_Ocupados >= v_Capacidad THEN
            SELECT 'Error: No hay capacidad disponible en el alojamiento' AS Mensaje;
            ROLLBACK;
        ELSE

            INSERT INTO registro_visitantes (ID_Registro, Numero_Cedula, ID_Alojamiento, Fecha_Entrada)
            SELECT COALESCE(MAX(ID_Registro), 0) + 1, p_Numero_Cedula, p_ID_Alojamiento, p_Fecha_Entrada
            FROM registro_visitantes;
            
            COMMIT;
            SELECT 'Alojamiento asignado exitosamente' AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;


CALL AsignarAlojamiento('123456789', 1, '2025-03-10');

select * from registro_visitantes;





-- 8. Registra la salida de un visitante de un alojamiento eliminando su registro activo.

DELIMITER //

CREATE PROCEDURE LiberarAlojamiento (
    IN p_ID_Registro INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo liberar el alojamiento' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM registro_visitantes WHERE ID_Registro = p_ID_Registro) THEN
        SELECT 'Error: El registro especificado no existe' AS Mensaje;
        ROLLBACK;
    ELSE

        DELETE FROM registro_visitantes
        WHERE ID_Registro = p_ID_Registro;

        IF ROW_COUNT() = 0 THEN
            SELECT 'Error: No se pudo eliminar el registro' AS Mensaje;
            ROLLBACK;
        ELSE
            COMMIT;
            SELECT 'Alojamiento liberado exitosamente' AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;


CALL LiberarAlojamiento(51);


select * from registro_visitantes;




-- 9. Asigna un vehículo a un miembro del personal (tipo '002' - Vigilancia) para sus actividades, actualizando la tabla vehiculo.

DELIMITER //

CREATE PROCEDURE AsignarVehiculoPersonal (
    IN p_ID_Vehiculo INT,
    IN p_Numero_Cedula VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo asignar el vehículo' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM vehiculo WHERE ID_Vehiculo = p_ID_Vehiculo) THEN
        SELECT 'Error: El vehículo especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF NOT EXISTS (SELECT 1 FROM personal WHERE Numero_Cedula = p_Numero_Cedula AND Tipo_Personal = '002') THEN
        SELECT 'Error: El personal especificado no existe o no es de vigilancia' AS Mensaje;
        ROLLBACK;

    ELSEIF EXISTS (SELECT 1 FROM vehiculo WHERE ID_Vehiculo = p_ID_Vehiculo AND Numero_Cedula IS NOT NULL AND Numero_Cedula != p_Numero_Cedula) THEN
        SELECT 'Error: El vehículo ya está asignado a otro miembro del personal' AS Mensaje;
        ROLLBACK;
    ELSE

        UPDATE vehiculo
        SET Numero_Cedula = p_Numero_Cedula
        WHERE ID_Vehiculo = p_ID_Vehiculo;
        
        COMMIT;
        SELECT 'Vehículo asignado al personal exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;


CALL AsignarVehiculoPersonal(1, '23456789');




-- 10. Libera un vehículo asignado a un miembro del personal, dejando el campo Numero_Cedula en NULL en la tabla vehiculo.

DELIMITER //

CREATE PROCEDURE LiberarVehiculoPersonal (
    IN p_ID_Vehiculo INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo liberar el vehículo' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM vehiculo WHERE ID_Vehiculo = p_ID_Vehiculo) THEN
        SELECT 'Error: El vehículo especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF (SELECT Numero_Cedula FROM vehiculo WHERE ID_Vehiculo = p_ID_Vehiculo) IS NULL THEN
        SELECT 'Error: El vehículo no está asignado a ningún personal' AS Mensaje;
        ROLLBACK;
    ELSE

        UPDATE vehiculo
        SET Numero_Cedula = NULL
        WHERE ID_Vehiculo = p_ID_Vehiculo;
        
        COMMIT;
        SELECT 'Vehículo liberado exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;


CALL LiberarVehiculoPersonal(1);

select * from vehiculo;




-- 11. Asignar Personal a un Área Específica

DELIMITER //

CREATE PROCEDURE RegistrarProyectoInvestigacion (
    IN p_ID_Proyecto INT,
    IN p_Presupuesto DECIMAL(15,2),
    IN p_Periodo_Realizacion VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo registrar el proyecto de investigación' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF EXISTS (SELECT 1 FROM proyecto_investigacion WHERE ID_Proyecto = p_ID_Proyecto) THEN
        SELECT 'Error: Ya existe un proyecto con ese ID' AS Mensaje;
        ROLLBACK;

    ELSEIF p_Presupuesto <= 0 THEN
        SELECT 'Error: El presupuesto debe ser mayor a cero' AS Mensaje;
        ROLLBACK;

    ELSEIF p_Periodo_Realizacion IS NULL OR TRIM(p_Periodo_Realizacion) = '' THEN
        SELECT 'Error: El periodo de realización no puede estar vacío' AS Mensaje;
        ROLLBACK;
    ELSE

        INSERT INTO proyecto_investigacion (ID_Proyecto, Presupuesto, Periodo_Realizacion)
        VALUES (p_ID_Proyecto, p_Presupuesto, p_Periodo_Realizacion);
        
        COMMIT;
        SELECT 'Proyecto de investigación registrado exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;


CALL RegistrarProyectoInvestigacion(51, 65000000.00, '2025-04-01 al 2026-03-31');

SELECT * FROM proyecto_investigacion WHERE ID_Proyecto = 51;





-- 12. Actualizar el Presupuesto de un Proyecto de Investigación

DELIMITER //

CREATE PROCEDURE ActualizarPresupuestoProyecto (
    IN p_ID_Proyecto INT,
    IN p_Nuevo_Presupuesto DECIMAL(15,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo actualizar el presupuesto del proyecto' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM proyecto_investigacion WHERE ID_Proyecto = p_ID_Proyecto) THEN
        SELECT 'Error: El proyecto especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF p_Nuevo_Presupuesto <= 0 THEN
        SELECT 'Error: El presupuesto debe ser mayor a cero' AS Mensaje;
        ROLLBACK;
    ELSE

        UPDATE proyecto_investigacion
        SET Presupuesto = p_Nuevo_Presupuesto
        WHERE ID_Proyecto = p_ID_Proyecto;

        IF ROW_COUNT() = 0 THEN
            SELECT 'Error: No se pudo actualizar el presupuesto' AS Mensaje;
            ROLLBACK;
        ELSE
            COMMIT;
            SELECT 'Presupuesto del proyecto actualizado exitosamente' AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;

CALL ActualizarPresupuestoProyecto(51, 70000000.00);

SELECT * FROM proyecto_investigacion WHERE ID_Proyecto = 51;




-- 13. Asignar un Investigador a un Proyecto y una Especie

DELIMITER //

CREATE PROCEDURE AsignarInvestigadorProyectoEspecie (
    IN p_ID_Proyecto INT,
    IN p_Numero_Cedula VARCHAR(20),
    IN p_ID_Especie INT
)
BEGIN
    DECLARE v_Tipo_Personal ENUM('001', '002', '003', '004');

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo asignar el investigador al proyecto y especie' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM proyecto_investigacion WHERE ID_Proyecto = p_ID_Proyecto) THEN
        SELECT 'Error: El proyecto especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF NOT EXISTS (SELECT 1 FROM personal WHERE Numero_Cedula = p_Numero_Cedula) THEN
        SELECT 'Error: El personal especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF NOT EXISTS (SELECT 1 FROM especies WHERE ID_Especie = p_ID_Especie) THEN
        SELECT 'Error: La especie especificada no existe' AS Mensaje;
        ROLLBACK;
    ELSE

        SELECT Tipo_Personal INTO v_Tipo_Personal
        FROM personal
        WHERE Numero_Cedula = p_Numero_Cedula;


        IF v_Tipo_Personal != '004' THEN
            SELECT 'Error: El personal especificado no es un investigador' AS Mensaje;
            ROLLBACK;

        ELSEIF EXISTS (SELECT 1 FROM investigador_proyecto_especie 
                       WHERE ID_Proyecto = p_ID_Proyecto 
                       AND Numero_Cedula = p_Numero_Cedula 
                       AND ID_Especie = p_ID_Especie) THEN
            SELECT 'Error: Esta asignación ya existe' AS Mensaje;
            ROLLBACK;
        ELSE

            INSERT INTO investigador_proyecto_especie (ID_Proyecto, Numero_Cedula, ID_Especie)
            VALUES (p_ID_Proyecto, p_Numero_Cedula, p_ID_Especie);
            
            COMMIT;
            SELECT 'Investigador asignado al proyecto y especie exitosamente' AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;

CALL AsignarInvestigadorProyectoEspecie(51, '45678901', 1);

SELECT * FROM investigador_proyecto_especie WHERE ID_Proyecto = 51 AND Numero_Cedula = '45678901' AND ID_Especie = 1;




-- 14. Generar Reporte de Ocupación de Alojamientos por Parque


DELIMITER //

CREATE PROCEDURE ReporteOcupacionAlojamientos (
    IN p_ID_Parque INT,
    IN p_Fecha DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo generar el reporte de ocupación' AS Mensaje;
    END;


    IF NOT EXISTS (SELECT 1 FROM parque WHERE ID_Parque = p_ID_Parque) THEN
        SELECT 'Error: El parque especificado no existe' AS Mensaje;
    ELSE

        SELECT 
            p.Nombre_Parque,
            a.ID_Alojamiento,
            a.Capacidad,
            a.Categoria,
            COUNT(rv.ID_Registro) AS Ocupados,
            (a.Capacidad - COUNT(rv.ID_Registro)) AS Disponibles,
            ROUND((COUNT(rv.ID_Registro) / a.Capacidad) * 100, 2) AS Porcentaje_Ocupacion
        FROM 
            parque p
            LEFT JOIN alojamiento a ON p.ID_Parque = a.ID_Parque
            LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento 
                AND p_Fecha >= rv.Fecha_Entrada
        WHERE 
            p.ID_Parque = p_ID_Parque
        GROUP BY 
            p.Nombre_Parque, a.ID_Alojamiento, a.Capacidad, a.Categoria
        ORDER BY 
            a.ID_Alojamiento;
    END IF;
END //

DELIMITER ;

CALL ReporteOcupacionAlojamientos(1, '2025-03-10');





-- 15.Registrar un Nuevo Vehículo para Vigilancia


DELIMITER //

CREATE PROCEDURE RegistrarVehiculoVigilancia (
    IN p_ID_Vehiculo INT,
    IN p_Tipo_Vehiculo VARCHAR(50),
    IN p_Marca VARCHAR(50),
    IN p_Numero_Cedula VARCHAR(20)
)
BEGIN
    DECLARE v_Tipo_Personal ENUM('001', '002', '003', '004');

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo registrar el vehículo' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF EXISTS (SELECT 1 FROM vehiculo WHERE ID_Vehiculo = p_ID_Vehiculo) THEN
        SELECT 'Error: Ya existe un vehículo con ese ID' AS Mensaje;
        ROLLBACK;

    ELSEIF p_Tipo_Vehiculo IS NULL OR TRIM(p_Tipo_Vehiculo) = '' THEN
        SELECT 'Error: El tipo de vehículo no puede estar vacío' AS Mensaje;
        ROLLBACK;
    ELSEIF p_Marca IS NULL OR TRIM(p_Marca) = '' THEN
        SELECT 'Error: La marca del vehículo no puede estar vacía' AS Mensaje;
        ROLLBACK;
    ELSE

        IF p_Numero_Cedula IS NOT NULL THEN
            IF NOT EXISTS (SELECT 1 FROM personal WHERE Numero_Cedula = p_Numero_Cedula) THEN
                SELECT 'Error: El personal especificado no existe' AS Mensaje;
                ROLLBACK;
            ELSE
                SELECT Tipo_Personal INTO v_Tipo_Personal
                FROM personal
                WHERE Numero_Cedula = p_Numero_Cedula;

                IF v_Tipo_Personal != '002' THEN
                    SELECT 'Error: El personal especificado no es de vigilancia' AS Mensaje;
                    ROLLBACK;
                END IF;
            END IF;
        END IF;


        INSERT INTO vehiculo (ID_Vehiculo, Tipo_Vehiculo, Marca, Numero_Cedula)
        VALUES (p_ID_Vehiculo, p_Tipo_Vehiculo, p_Marca, p_Numero_Cedula);
        
        COMMIT;
        SELECT 'Vehículo para vigilancia registrado exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;

-- Ejemplo de uso (con asignación a personal de vigilancia)
CALL RegistrarVehiculoVigilancia(51, 'Camioneta', 'Toyota', '23456789');

-- Ejemplo de uso (sin asignación inicial)
CALL RegistrarVehiculoVigilancia(52, 'Moto', 'Honda', NULL);

-- Verificar resultados
SELECT * FROM vehiculo WHERE ID_Vehiculo IN (51, 52);





-- 16. ActualizarSueldoPersonal

DELIMITER //

CREATE PROCEDURE ActualizarSueldoPersonal (
    IN p_Numero_Cedula VARCHAR(20),
    IN p_Nuevo_Sueldo DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo actualizar el sueldo del personal' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM personal WHERE Numero_Cedula = p_Numero_Cedula) THEN
        SELECT 'Error: El personal especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF p_Nuevo_Sueldo <= 0 THEN
        SELECT 'Error: El sueldo debe ser mayor a cero' AS Mensaje;
        ROLLBACK;
    ELSE

        UPDATE personal
        SET Sueldo = p_Nuevo_Sueldo
        WHERE Numero_Cedula = p_Numero_Cedula;


        IF ROW_COUNT() = 0 THEN
            SELECT 'Error: No se pudo actualizar el sueldo' AS Mensaje;
            ROLLBACK;
        ELSE
            COMMIT;
            SELECT 'Sueldo del personal actualizado exitosamente' AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;


CALL ActualizarSueldoPersonal('12345678', 2800000.00);


SELECT Numero_Cedula, Nombre, Sueldo FROM personal WHERE Numero_Cedula = '12345678';





-- 17. ReporteInventarioEspeciesPorArea

DELIMITER //

CREATE PROCEDURE ReporteInventarioEspeciesPorArea (
    IN p_ID_Area INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo generar el reporte de inventario de especies' AS Mensaje;
    END;

    -- Validar que el área exista
    IF NOT EXISTS (SELECT 1 FROM area WHERE ID_Area = p_ID_Area) THEN
        SELECT 'Error: El área especificada no existe' AS Mensaje;
    ELSE
        -- Generar el reporte
        SELECT 
            a.Nombre_Area,
            a.Extension,
            p.Nombre_Parque,
            e.Tipo,
            COUNT(ie.ID_Especie) AS Total_Especies,
            SUM(ie.Numero_Individuos) AS Total_Individuos,
            GROUP_CONCAT(CONCAT(e.Denominacion_Vulgar, ': ', ie.Numero_Individuos) SEPARATOR ', ') AS Detalle_Especies
        FROM 
            area a
            JOIN parque p ON a.ID_Parque = p.ID_Parque
            LEFT JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
            LEFT JOIN especies e ON ie.ID_Especie = e.ID_Especie
        WHERE 
            a.ID_Area = p_ID_Area
        GROUP BY 
            a.Nombre_Area, a.Extension, p.Nombre_Parque, e.Tipo
        ORDER BY 
            e.Tipo;
    END IF;
END //

DELIMITER ;

-- Ejemplo de uso
CALL ReporteInventarioEspeciesPorArea(1);

-- Nota: No requiere SELECT adicional para verificar porque el procedimiento ya muestra el resultado





-- 18. AsignarPersonalAArea

DELIMITER //

CREATE PROCEDURE AsignarPersonalAArea (
    IN p_Numero_Cedula VARCHAR(20),
    IN p_ID_Area INT,
    IN p_Fecha_Asignacion DATE
)
BEGIN
    DECLARE v_Tipo_Personal ENUM('001', '002', '003', '004');
    DECLARE v_ID_Inventario INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo asignar el personal al área' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;


    IF NOT EXISTS (SELECT 1 FROM personal WHERE Numero_Cedula = p_Numero_Cedula) THEN
        SELECT 'Error: El personal especificado no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF NOT EXISTS (SELECT 1 FROM area WHERE ID_Area = p_ID_Area) THEN
        SELECT 'Error: El área especificada no existe' AS Mensaje;
        ROLLBACK;

    ELSEIF p_Fecha_Asignacion IS NULL OR p_Fecha_Asignacion < CURDATE() THEN
        SELECT 'Error: La fecha de asignación no puede ser nula ni anterior a la fecha actual' AS Mensaje;
        ROLLBACK;
    ELSE

        SELECT Tipo_Personal INTO v_Tipo_Personal
        FROM personal
        WHERE Numero_Cedula = p_Numero_Cedula;


        IF v_Tipo_Personal != '003' THEN
            SELECT 'Error: Solo el personal de conservación (003) puede ser asignado a un área' AS Mensaje;
            ROLLBACK;
        ELSE

            SELECT COALESCE(MAX(ID_Inventario), 0) + 1 INTO v_ID_Inventario
            FROM inventario_especies;


            INSERT INTO inventario_especies (ID_Inventario, ID_Especie, ID_Area, Numero_Individuos)
            SELECT v_ID_Inventario, 
                   (SELECT ID_Especie FROM especies WHERE Denominacion_Vulgar = 'Control Mantenimiento' 
                    UNION SELECT 1 LIMIT 1), -- Usa una especie ficticia o la primera si no existe
                   p_ID_Area,
                   0; -- 0 individuos para indicar que es un control

            COMMIT;
            SELECT CONCAT('Personal ', p_Numero_Cedula, ' asignado al área ', p_ID_Area, ' exitosamente en fecha ', p_Fecha_Asignacion) AS Mensaje;
        END IF;
    END IF;
END //

DELIMITER ;

-- Ejemplo de uso
CALL AsignarPersonalAArea('34567890', 1, '2025-03-15'); -- Carlos López (003) asignado a Zona Costera

-- Verificar resultados
SELECT ie.*, p.Nombre AS Nombre_Personal, a.Nombre_Area
FROM inventario_especies ie
JOIN personal p ON p.Numero_Cedula = '34567890'
JOIN area a ON ie.ID_Area = a.ID_Area
WHERE ie.ID_Area = 1 AND ie.Numero_Individuos = 0;






-- 19. CalcularCostoTotalProyectos

DELIMITER //

CREATE PROCEDURE CalcularCostoTotalProyectos ()
BEGIN
    DECLARE v_Total DECIMAL(15,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo calcular el costo total de los proyectos' AS Mensaje;
    END;


    SELECT SUM(Presupuesto) INTO v_Total
    FROM proyecto_investigacion
    WHERE STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') >= CURDATE();


    IF v_Total IS NULL THEN
        SELECT 'No hay proyectos activos en este momento' AS Mensaje, 0.00 AS Costo_Total;
    ELSE
        SELECT 'Costo total de proyectos activos calculado exitosamente' AS Mensaje, v_Total AS Costo_Total;
    END IF;
END //

DELIMITER ;


CALL CalcularCostoTotalProyectos();




select * from investigador_proyecto_especie ipe ;

-- 20. GenerarReporteVehiculosAsignados

USE parques;

DELIMITER //

CREATE PROCEDURE GenerarReporteVehiculosAsignados ()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: No se pudo generar el reporte de vehículos asignados' AS Mensaje;
    END;

    SELECT 
        v.ID_Vehiculo,
        v.Tipo_Vehiculo,
        v.Marca,
        p.Numero_Cedula,
        p.Nombre AS Nombre_Personal,
        p.Telefono_Movil,
        GROUP_CONCAT(DISTINCT par.Nombre_Parque SEPARATOR ', ') AS Parques_Asociados
    FROM 
        vehiculo v
        JOIN personal p ON v.Numero_Cedula = p.Numero_Cedula
        LEFT JOIN inventario_especies ie ON p.Numero_Cedula = (
            SELECT Numero_Cedula 
            FROM personal 
            WHERE Numero_Cedula = p.Numero_Cedula AND Tipo_Personal = '002'
        )
        LEFT JOIN area a ON ie.ID_Area = a.ID_Area
        LEFT JOIN parque par ON a.ID_Parque = par.ID_Parque
    WHERE 
        v.Numero_Cedula IS NOT NULL
        AND p.Tipo_Personal = '002' -- Solo personal de vigilancia
    GROUP BY 
        v.ID_Vehiculo, v.Tipo_Vehiculo, v.Marca, p.Numero_Cedula, p.Nombre, p.Telefono_Movil
    ORDER BY 
        v.ID_Vehiculo;
END //

DELIMITER ;

CALL GenerarReporteVehiculosAsignados();



