use parques;

-- 1. CalcularSuperficieTotalParque

DELIMITER //

CREATE FUNCTION CalcularSuperficieTotalParque (
    p_ID_Parque INT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_Superficie_Total DECIMAL(15,2);


    SELECT COALESCE(SUM(Extension), 0) INTO v_Superficie_Total
    FROM area
    WHERE ID_Parque = p_ID_Parque;

    RETURN v_Superficie_Total;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Parque, 
    Nombre_Parque, 
    Superficie_Total AS Superficie_Registrada, 
    CalcularSuperficieTotalParque(ID_Parque) AS Superficie_Calculada
FROM parque
WHERE ID_Parque = 1;






-- 2. ContarIndividuosEspecieParque

DELIMITER //

CREATE FUNCTION ContarIndividuosEspecieParque (
    p_ID_Especie INT,
    p_ID_Parque INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Individuos INT;


    SELECT COALESCE(SUM(ie.Numero_Individuos), 0) INTO v_Total_Individuos
    FROM inventario_especies ie
    JOIN area a ON ie.ID_Area = a.ID_Area
    WHERE ie.ID_Especie = p_ID_Especie
    AND a.ID_Parque = p_ID_Parque;

    RETURN v_Total_Individuos;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    e.ID_Especie,
    e.Denominacion_Vulgar,
    p.ID_Parque,
    p.Nombre_Parque,
    ContarIndividuosEspecieParque(e.ID_Especie, p.ID_Parque) AS Total_Individuos
FROM especies e
CROSS JOIN parque p
WHERE e.ID_Especie = 1 AND p.ID_Parque = 1;





-- 3. ObtenerCapacidadDisponibleAlojamiento

DELIMITER //

CREATE FUNCTION ObtenerCapacidadDisponibleAlojamiento (
    p_ID_Alojamiento INT,
    p_Fecha DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Capacidad INT;
    DECLARE v_Ocupados INT;
    DECLARE v_Disponible INT;


    SELECT Capacidad INTO v_Capacidad
    FROM alojamiento
    WHERE ID_Alojamiento = p_ID_Alojamiento;


    SELECT COUNT(*) INTO v_Ocupados
    FROM registro_visitantes
    WHERE ID_Alojamiento = p_ID_Alojamiento
    AND p_Fecha >= Fecha_Entrada;


    IF v_Capacidad IS NULL THEN
        SET v_Disponible = -1; 
    ELSE
        SET v_Disponible = v_Capacidad - COALESCE(v_Ocupados, 0);
    END IF;

    RETURN v_Disponible;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Alojamiento,
    Categoria,
    Capacidad AS Capacidad_Total,
    ObtenerCapacidadDisponibleAlojamiento(ID_Alojamiento, '2025-03-15') AS Capacidad_Disponible
FROM alojamiento
WHERE ID_Alojamiento = 1;





-- 4. CalcularPresupuestoPromedioProyectos

USE parques;

DELIMITER //

CREATE FUNCTION CalcularPresupuestoPromedioProyectos ()
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_Promedio DECIMAL(15,2);

    -- Calcular el promedio de presupuestos de proyectos activos
    SELECT COALESCE(AVG(Presupuesto), 0) INTO v_Promedio
    FROM proyecto_investigacion
    WHERE STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') >= CURDATE();

    RETURN v_Promedio;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    COUNT(*) AS Proyectos_Activos,
    SUM(Presupuesto) AS Total_Presupuesto,
    CalcularPresupuestoPromedioProyectos() AS Promedio_Presupuesto
FROM proyecto_investigacion
WHERE STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d') >= CURDATE();





-- 5. ObtenerPorcentajeOcupacionAlojamiento

DELIMITER //

CREATE FUNCTION ObtenerPorcentajeOcupacionAlojamiento (
    p_ID_Alojamiento INT,
    p_Fecha DATE
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_Capacidad INT;
    DECLARE v_Ocupados INT;
    DECLARE v_Porcentaje DECIMAL(5,2);


    SELECT Capacidad INTO v_Capacidad
    FROM alojamiento
    WHERE ID_Alojamiento = p_ID_Alojamiento;


    SELECT COUNT(*) INTO v_Ocupados
    FROM registro_visitantes
    WHERE ID_Alojamiento = p_ID_Alojamiento
    AND p_Fecha >= Fecha_Entrada;


    IF v_Capacidad IS NULL OR v_Capacidad = 0 THEN
        SET v_Porcentaje = -1;
    ELSE
        SET v_Porcentaje = (COALESCE(v_Ocupados, 0) / v_Capacidad) * 100;
    END IF;

    RETURN v_Porcentaje;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Alojamiento,
    Categoria,
    Capacidad AS Capacidad_Total,
    ObtenerPorcentajeOcupacionAlojamiento(ID_Alojamiento, '2025-03-15') AS Porcentaje_Ocupacion
FROM alojamiento
WHERE ID_Alojamiento = 1;





-- 6. ContarParquesPorDepartamento

DELIMITER //

CREATE FUNCTION ContarParquesPorDepartamento (
    p_ID_Departamento INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Parques INT;

    SELECT COUNT(*) INTO v_Total_Parques
    FROM departamento_parque
    WHERE ID_Departamento = p_ID_Departamento;

    RETURN COALESCE(v_Total_Parques, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Departamento,
    Nombre_Departamento,
    ContarParquesPorDepartamento(ID_Departamento) AS Total_Parques
FROM departamento
WHERE ID_Departamento = 1;





-- 7. ObtenerSueldoPromedioPorTipoPersonal

DELIMITER //

CREATE FUNCTION ObtenerSueldoPromedioPorTipoPersonal (
    p_Tipo_Personal ENUM('001', '002', '003', '004')
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_Promedio DECIMAL(10,2);

    SELECT AVG(Sueldo) INTO v_Promedio
    FROM personal
    WHERE Tipo_Personal = p_Tipo_Personal;

    RETURN COALESCE(v_Promedio, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ObtenerSueldoPromedioPorTipoPersonal('001') AS Sueldo_Promedio_Gestion,
    ObtenerSueldoPromedioPorTipoPersonal('002') AS Sueldo_Promedio_Vigilancia,
    ObtenerSueldoPromedioPorTipoPersonal('003') AS Sueldo_Promedio_Conservacion,
    ObtenerSueldoPromedioPorTipoPersonal('004') AS Sueldo_Promedio_Investigacion;





-- 8. ContarEspeciesPorTipoEnArea

DELIMITER //

CREATE FUNCTION ContarEspeciesPorTipoEnArea (
    p_ID_Area INT,
    p_Tipo ENUM('Vegetal', 'Animal', 'Mineral')
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Especies INT;

    SELECT COUNT(DISTINCT ie.ID_Especie) INTO v_Total_Especies
    FROM inventario_especies ie
    JOIN especies e ON ie.ID_Especie = e.ID_Especie
    WHERE ie.ID_Area = p_ID_Area
    AND e.Tipo = p_Tipo;

    RETURN COALESCE(v_Total_Especies, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    a.ID_Area,
    a.Nombre_Area,
    ContarEspeciesPorTipoEnArea(a.ID_Area, 'Animal') AS Especies_Animales,
    ContarEspeciesPorTipoEnArea(a.ID_Area, 'Vegetal') AS Especies_Vegetales,
    ContarEspeciesPorTipoEnArea(a.ID_Area, 'Mineral') AS Especies_Minerales
FROM area a
WHERE a.ID_Area = 1;




-- 9. CalcularCostoOperativoPersonalParque

DELIMITER //

CREATE FUNCTION CalcularCostoOperativoPersonalParque (
    p_ID_Parque INT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_Costo_Total DECIMAL(15,2);

    SELECT SUM(p.Sueldo) INTO v_Costo_Total
    FROM personal p
    JOIN vehiculo v ON p.Numero_Cedula = v.Numero_Cedula
    JOIN area a ON a.ID_Parque = p_ID_Parque
    WHERE p.Tipo_Personal IN ('002', '003')
    AND EXISTS (
        SELECT 1 
        FROM inventario_especies ie 
        WHERE ie.ID_Area = a.ID_Area
    );

    RETURN COALESCE(v_Costo_Total, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    p.ID_Parque,
    p.Nombre_Parque,
    CalcularCostoOperativoPersonalParque(p.ID_Parque) AS Costo_Personal
FROM parque p
WHERE p.ID_Parque = 1;





-- 10. ObtenerNumeroInvestigadoresProyecto

DELIMITER //

CREATE FUNCTION ObtenerNumeroInvestigadoresProyecto (
    p_ID_Proyecto INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Investigadores INT;

    SELECT COUNT(DISTINCT Numero_Cedula) INTO v_Total_Investigadores
    FROM investigador_proyecto_especie
    WHERE ID_Proyecto = p_ID_Proyecto;

    RETURN COALESCE(v_Total_Investigadores, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Proyecto,
    Presupuesto,
    ObtenerNumeroInvestigadoresProyecto(ID_Proyecto) AS Total_Investigadores
FROM proyecto_investigacion
WHERE ID_Proyecto = 1;




-- 11. ContarVisitantesPorParque

DELIMITER //

CREATE FUNCTION ContarVisitantesPorParque (
    p_ID_Parque INT,
    p_Fecha DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Visitantes INT;

    SELECT COUNT(*) INTO v_Total_Visitantes
    FROM registro_visitantes rv
    JOIN alojamiento al ON rv.ID_Alojamiento = al.ID_Alojamiento
    WHERE al.ID_Parque = p_ID_Parque
    AND rv.Fecha_Entrada <= p_Fecha;

    RETURN COALESCE(v_Total_Visitantes, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    p.ID_Parque,
    p.Nombre_Parque,
    ContarVisitantesPorParque(p.ID_Parque, '2025-03-15') AS Total_Visitantes
FROM parque p
WHERE p.ID_Parque = 1;





-- 12. ObtenerAntiguedadParque

DELIMITER //

CREATE FUNCTION ObtenerAntiguedadParque (
    p_ID_Parque INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Antiguedad INT;

    SELECT TIMESTAMPDIFF(YEAR, Fecha_Declaracion, CURDATE()) INTO v_Antiguedad
    FROM parque
    WHERE ID_Parque = p_ID_Parque;

    RETURN COALESCE(v_Antiguedad, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Parque,
    Nombre_Parque,
    Fecha_Declaracion,
    ObtenerAntiguedadParque(ID_Parque) AS Antiguedad_Anios
FROM parque
WHERE ID_Parque = 1;




-- 13. CalcularDensidadEspeciesArea

DELIMITER //

CREATE FUNCTION CalcularDensidadEspeciesArea (
    p_ID_Area INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_Densidad DECIMAL(10,2);
    DECLARE v_Total_Individuos INT;
    DECLARE v_Extension DECIMAL(10,2);

    SELECT SUM(Numero_Individuos) INTO v_Total_Individuos
    FROM inventario_especies
    WHERE ID_Area = p_ID_Area;

    SELECT Extension INTO v_Extension
    FROM area
    WHERE ID_Area = p_ID_Area;

    IF v_Extension IS NULL OR v_Extension = 0 THEN
        SET v_Densidad = 0;
    ELSE
        SET v_Densidad = COALESCE(v_Total_Individuos, 0) / v_Extension;
    END IF;

    RETURN v_Densidad;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Area,
    Nombre_Area,
    Extension,
    CalcularDensidadEspeciesArea(ID_Area) AS Densidad_Individuos_Por_Unidad
FROM area
WHERE ID_Area = 1;





-- 14. ObtenerNumeroAreasParque

DELIMITER //

CREATE FUNCTION ObtenerNumeroAreasParque (
    p_ID_Parque INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Areas INT;

    SELECT COUNT(*) INTO v_Total_Areas
    FROM area
    WHERE ID_Parque = p_ID_Parque;

    RETURN COALESCE(v_Total_Areas, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Parque,
    Nombre_Parque,
    ObtenerNumeroAreasParque(ID_Parque) AS Total_Areas
FROM parque
WHERE ID_Parque = 1;





-- 15. CalcularCostoPorInvestigador

DELIMITER //

CREATE FUNCTION CalcularCostoPorInvestigador (
    p_ID_Proyecto INT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_Costo_Por_Investigador DECIMAL(15,2);
    DECLARE v_Presupuesto DECIMAL(15,2);
    DECLARE v_Investigadores INT;

    SELECT Presupuesto INTO v_Presupuesto
    FROM proyecto_investigacion
    WHERE ID_Proyecto = p_ID_Proyecto;

    SELECT COUNT(DISTINCT Numero_Cedula) INTO v_Investigadores
    FROM investigador_proyecto_especie
    WHERE ID_Proyecto = p_ID_Proyecto;

    IF v_Investigadores IS NULL OR v_Investigadores = 0 THEN
        SET v_Costo_Por_Investigador = 0;
    ELSE
        SET v_Costo_Por_Investigador = v_Presupuesto / v_Investigadores;
    END IF;

    RETURN COALESCE(v_Costo_Por_Investigador, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Proyecto,
    Presupuesto,
    ObtenerNumeroInvestigadoresProyecto(ID_Proyecto) AS Total_Investigadores,
    CalcularCostoPorInvestigador(ID_Proyecto) AS Costo_Por_Investigador
FROM proyecto_investigacion
WHERE ID_Proyecto = 1;





-- 16. ContarVehiculosPorPersonal

DELIMITER //

CREATE FUNCTION ContarVehiculosPorPersonal (
    p_Numero_Cedula VARCHAR(20)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Vehiculos INT;

    SELECT COUNT(*) INTO v_Total_Vehiculos
    FROM vehiculo
    WHERE Numero_Cedula = p_Numero_Cedula;

    RETURN COALESCE(v_Total_Vehiculos, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    Numero_Cedula,
    Nombre,
    ContarVehiculosPorPersonal(Numero_Cedula) AS Total_Vehiculos
FROM personal
WHERE Numero_Cedula = '23456789';





-- 17. ObtenerDuracionProyecto

DELIMITER //

CREATE FUNCTION ObtenerDuracionProyecto (
    p_ID_Proyecto INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Duracion INT;
    DECLARE v_Fecha_Inicio DATE;
    DECLARE v_Fecha_Fin DATE;

    SELECT 
        STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', 1), '%Y-%m-%d'),
        STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d')
    INTO v_Fecha_Inicio, v_Fecha_Fin
    FROM proyecto_investigacion
    WHERE ID_Proyecto = p_ID_Proyecto;

    SET v_Duracion = TIMESTAMPDIFF(MONTH, v_Fecha_Inicio, v_Fecha_Fin);

    RETURN COALESCE(v_Duracion, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Proyecto,
    Periodo_Realizacion,
    ObtenerDuracionProyecto(ID_Proyecto) AS Duracion_Meses
FROM proyecto_investigacion
WHERE ID_Proyecto = 1;






-- 18. ContarEspeciesInvestigadasPorProyecto

DELIMITER //

CREATE FUNCTION ContarEspeciesInvestigadasPorProyecto (
    p_ID_Proyecto INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Especies INT;

    SELECT COUNT(DISTINCT ID_Especie) INTO v_Total_Especies
    FROM investigador_proyecto_especie
    WHERE ID_Proyecto = p_ID_Proyecto;

    RETURN COALESCE(v_Total_Especies, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Proyecto,
    Presupuesto,
    ContarEspeciesInvestigadasPorProyecto(ID_Proyecto) AS Total_Especies
FROM proyecto_investigacion
WHERE ID_Proyecto = 1;





-- 19. ObtenerNumeroAlojamientosParque

DELIMITER //

CREATE FUNCTION ObtenerNumeroAlojamientosParque (
    p_ID_Parque INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Total_Alojamientos INT;

    SELECT COUNT(*) INTO v_Total_Alojamientos
    FROM alojamiento
    WHERE ID_Parque = p_ID_Parque;

    RETURN COALESCE(v_Total_Alojamientos, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    ID_Parque,
    Nombre_Parque,
    ObtenerNumeroAlojamientosParque(ID_Parque) AS Total_Alojamientos
FROM parque
WHERE ID_Parque = 1;






-- 20. CalcularPromedioIndividuosPorEspecie

DELIMITER //

CREATE FUNCTION CalcularPromedioIndividuosPorEspecie (
    p_ID_Especie INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_Promedio DECIMAL(10,2);

    SELECT AVG(Numero_Individuos) INTO v_Promedio
    FROM inventario_especies
    WHERE ID_Especie = p_ID_Especie;

    RETURN COALESCE(v_Promedio, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT 
    e.ID_Especie,
    e.Denominacion_Vulgar,
    CalcularPromedioIndividuosPorEspecie(e.ID_Especie) AS Promedio_Individuos
FROM especies e
WHERE e.ID_Especie = 1;



