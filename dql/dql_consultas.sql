/*-------------------------------Estado actual de los parques (15 consultas)-------------------------------*/

-- 1. Cantidad de parques por departamento


SELECT d.Nombre_Departamento, COUNT(dp.ID_Parque) AS Total_Parques
FROM departamento d
LEFT JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
GROUP BY d.Nombre_Departamento
ORDER BY Total_Parques DESC;


-- 2. Superficie total declarada por parque



SELECT Nombre_Parque, Superficie_Total
FROM parque
ORDER BY Superficie_Total DESC;



-- 3. Departamentos con más de un parque compartido

SELECT d.Nombre_Departamento, COUNT(dp.ID_Parque) AS Parques_Compartidos
FROM departamento d
JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
GROUP BY d.Nombre_Departamento
HAVING COUNT(dp.ID_Parque) > 1;



-- 4. Parques declarados antes de 1980

SELECT Nombre_Parque, Fecha_Declaracion, Superficie_Total
FROM parque
WHERE Fecha_Declaracion < '1980-01-01'
ORDER BY Fecha_Declaracion;



-- 5. Parques con mayor superficie por departamento

SELECT d.Nombre_Departamento, p.Nombre_Parque, p.Superficie_Total
FROM departamento d
JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
JOIN parque p ON dp.ID_Parque = p.ID_Parque
WHERE p.Superficie_Total = (
    SELECT MAX(p2.Superficie_Total)
    FROM parque p2
    JOIN departamento_parque dp2 ON p2.ID_Parque = dp2.ID_Parque
    WHERE dp2.ID_Departamento = d.ID_Departamento
)
ORDER BY p.Superficie_Total DESC;



-- 6. Número de áreas por parque

SELECT p.Nombre_Parque, COUNT(a.ID_Area) AS Total_Areas
FROM parque p
LEFT JOIN area a ON p.ID_Parque = a.ID_Parque
GROUP BY p.Nombre_Parque
ORDER BY Total_Areas DESC;



-- 7. Parques sin áreas asignadas

SELECT p.Nombre_Parque
FROM parque p
LEFT JOIN area a ON p.ID_Parque = a.ID_Parque
WHERE a.ID_Area IS NULL;



-- 8. Entidades responsables con más parques

SELECT er.Nombre_Entidad, COUNT(dp.ID_Parque) AS Total_Parques
FROM entidad_responsable er
JOIN departamento d ON er.ID_Entidad = d.ID_Entidad
JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
GROUP BY er.Nombre_Entidad
ORDER BY Total_Parques DESC
LIMIT 5;




-- 9. Superficie promedio por parque por entidad responsable

SELECT er.Nombre_Entidad, AVG(p.Superficie_Total) AS Superficie_Promedio
FROM entidad_responsable er
JOIN departamento d ON er.ID_Entidad = d.ID_Entidad
JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
JOIN parque p ON dp.ID_Parque = p.ID_Parque
GROUP BY er.Nombre_Entidad;




-- 10. Parques declarados en el siglo XXI

SELECT Nombre_Parque, Fecha_Declaracion
FROM parque
WHERE Fecha_Declaracion >= '2000-01-01'
ORDER BY Fecha_Declaracion;




-- 11. Departamentos sin parques asignados

SELECT d.Nombre_Departamento
FROM departamento d
LEFT JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
WHERE dp.ID_Parque IS NULL;




-- 12. Parques con más de 100,000 hectáreas

SELECT Nombre_Parque, Superficie_Total
FROM parque
WHERE Superficie_Total > 100000
ORDER BY Superficie_Total DESC;



-- 13. Parques compartidos por más de un departamento

SELECT p.Nombre_Parque, COUNT(dp.ID_Departamento) AS Departamentos
FROM parque p
JOIN departamento_parque dp ON p.ID_Parque = dp.ID_Parque
GROUP BY p.Nombre_Parque
HAVING COUNT(dp.ID_Departamento) > 1;




-- 14. Entidades responsables con parques en más de 3 departamentos

SELECT er.Nombre_Entidad, COUNT(DISTINCT d.ID_Departamento) AS Total_Departamentos
FROM entidad_responsable er
JOIN departamento d ON er.ID_Entidad = d.ID_Entidad
GROUP BY er.Nombre_Entidad
HAVING Total_Departamentos > 3;



-- 15. Superficie total por departamento

SELECT d.Nombre_Departamento, SUM(p.Superficie_Total) AS Superficie_Total
FROM departamento d
JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
JOIN parque p ON dp.ID_Parque = p.ID_Parque
GROUP BY d.Nombre_Departamento
ORDER BY Superficie_Total DESC;



/*----------------------------Inventarios de especies por áreas y tipos (15 consultas)----------------------------*/


-- 16. Número de especies por tipo en cada área

SELECT a.Nombre_Area, e.Tipo, COUNT(ie.ID_Especie) AS Total_Especies
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
GROUP BY a.Nombre_Area, e.Tipo
ORDER BY a.Nombre_Area, e.Tipo;



-- 17. Área con más de 50 individuos de especies animales

SELECT a.Nombre_Area, SUM(ie.Numero_Individuos) AS Total_Animales
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
WHERE e.Tipo = 'Animal'
GROUP BY a.Nombre_Area
HAVING Total_Animales > 50;



-- 18. Especies con mayor número de individuos en todas la áreas

SELECT e.Denominacion_Vulgar, SUM(ie.Numero_Individuos) AS Total_Individuos
FROM especies e
JOIN inventario_especies ie ON e.ID_Especie = ie.ID_Especie
GROUP BY e.Denominacion_Vulgar
ORDER BY Total_Individuos DESC
LIMIT 5;



-- 19. Áreas con especies minerales

SELECT a.Nombre_Area, COUNT(ie.ID_Especie) AS Total_Minerales
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
WHERE e.Tipo = 'Mineral'
GROUP BY a.Nombre_Area;



-- 20. Parques con más especies vegetales

SELECT p.Nombre_Parque, COUNT(ie.ID_Especie) AS Total_Vegetales
FROM parque p
JOIN area a ON p.ID_Parque = a.ID_Parque
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
WHERE e.Tipo = 'Vegetal'
GROUP BY p.Nombre_Parque
ORDER BY Total_Vegetales DESC
LIMIT 5;



-- 21. Especies no presentes en ninguna área

SELECT e.Denominacion_Vulgar
FROM especies e
LEFT JOIN inventario_especies ie ON e.ID_Especie = ie.ID_Especie
WHERE ie.ID_Inventario IS NULL;



-- 22. Áreas con mayor densidad de individuos por hectárea(agregación avanzada)

SELECT a.Nombre_Area, SUM(ie.Numero_Individuos) / a.Extension AS Densidad
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
GROUP BY a.Nombre_Area, a.Extension
ORDER BY Densidad DESC
LIMIT 5;



-- 23. Especies animales con menos de 10 individuos

SELECT e.Denominacion_Vulgar, SUM(ie.Numero_Individuos) AS Total_Individuos
FROM especies e
JOIN inventario_especies ie ON e.ID_Especie = ie.ID_Especie
WHERE e.Tipo = 'Animal'
GROUP BY e.Denominacion_Vulgar
HAVING Total_Individuos < 10;



-- 24. Áreas sin especies registradas

SELECT a.Nombre_Area
FROM area a
LEFT JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
WHERE ie.ID_Inventario IS NULL;



-- 25. Especies con más áreas de presencia

SELECT e.Denominacion_Vulgar, COUNT(ie.ID_Area) AS Total_Areas
FROM especies e
JOIN inventario_especies ie ON e.ID_Especie = ie.ID_Especie
GROUP BY e.Denominacion_Vulgar
ORDER BY Total_Areas DESC
LIMIT 5;



-- 26. Áreas con más de 100 individuos en total

SELECT a.Nombre_Area, SUM(ie.Numero_Individuos) AS Total_Individuos
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
GROUP BY a.Nombre_Area
HAVING Total_Individuos > 100;



-- 27. Especies vegetales más comunes por parque

SELECT p.Nombre_Parque, e.Denominacion_Vulgar, SUM(ie.Numero_Individuos) AS Total_Individuos
FROM parque p
JOIN area a ON p.ID_Parque = a.ID_Parque
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
WHERE e.Tipo = 'Vegetal'
GROUP BY p.Nombre_Parque, e.Denominacion_Vulgar
ORDER BY Total_Individuos DESC
LIMIT 5;



-- 28. Áreas con mayor variedad de especies

SELECT a.Nombre_Area, COUNT(DISTINCT ie.ID_Especie) AS Variedad_Especies
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
GROUP BY a.Nombre_Area
ORDER BY Variedad_Especies DESC
LIMIT 5;



-- 29. Promedio de individuos por tipo de especie

SELECT e.Tipo, AVG(ie.Numero_Individuos) AS Promedio_Individuos
FROM especies e
JOIN inventario_especies ie ON e.ID_Especie = ie.ID_Especie
GROUP BY e.Tipo;



-- 30. Parques con especies de todos los tipos

SELECT p.Nombre_Parque
FROM parque p
JOIN area a ON p.ID_Parque = a.ID_Parque
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
GROUP BY p.Nombre_Parque
HAVING COUNT(DISTINCT e.Tipo) = 3;



/*----------------------------Actividades del personal según tipo, áreas asignadas y sueldos (15 consultas)-----------------------*/

-- 31. Sueldo promedio por tipo de persona

SELECT Tipo_Personal, AVG(Sueldo) AS Sueldo_Promedio
FROM personal
GROUP BY Tipo_Personal;

-- 32. Personal de vigilancia con más de un vehiculo

SELECT p.Nombre, COUNT(v.ID_Vehiculo) AS Total_Vehiculos
FROM personal p
JOIN vehiculo v ON p.Numero_Cedula = v.Numero_Cedula
WHERE p.Tipo_Personal = '002'
GROUP BY p.Nombre
HAVING Total_Vehiculos > 1;

-- 33. Personal con sueldo superior al promedio de su tipo (subconsulta)

SELECT Nombre, Tipo_Personal, Sueldo
FROM personal p
WHERE Sueldo > (
    SELECT AVG(Sueldo)
    FROM personal
    WHERE Tipo_Personal = p.Tipo_Personal
)
ORDER BY Tipo_Personal, Sueldo DESC;

-- 34. Cantidad de personal por tipo

SELECT Tipo_Personal, COUNT(*) AS Total_Personal
FROM personal
GROUP BY Tipo_Personal;

-- 35. Personal de conservación con sueldo más alto

SELECT Nombre, Sueldo
FROM personal
WHERE Tipo_Personal = '003'
ORDER BY Sueldo DESC
LIMIT 1;

-- 36. Personal sin vehiculos asignados

SELECT p.Nombre, p.Tipo_Personal
FROM personal p
LEFT JOIN vehiculo v ON p.Numero_Cedula = v.Numero_Cedula
WHERE v.ID_Vehiculo IS NULL AND p.Tipo_Personal = '002';


-- 37. Sueldo total por tipo de personal

SELECT Tipo_Personal, SUM(Sueldo) AS Sueldo_Total
FROM personal
GROUP BY Tipo_Personal;


-- 38. Personal con teléfono móvil registrado

SELECT Nombre, Telefono_Movil
FROM personal
WHERE Telefono_Movil IS NOT NULL
ORDER BY Nombre;


-- 39. Marcas de vehiculos más usadas por vigilancia

SELECT v.Marca, COUNT(v.ID_Vehiculo) AS Total_Vehiculos
FROM vehiculo v
JOIN personal p ON v.Numero_Cedula = p.Numero_Cedula
WHERE p.Tipo_Personal = '002'
GROUP BY v.Marca
ORDER BY Total_Vehiculos DESC;


-- 40. Personal con sueldo menor a 3 millones

SELECT Nombre, Tipo_Personal, Sueldo
FROM personal
WHERE Sueldo < 3000000
ORDER BY Sueldo;


-- 41. Personal de gestión por ciudad

SELECT SUBSTRING_INDEX(Direccion, ',', -1) AS Ciudad, COUNT(*) AS Total_Gestion
FROM personal
WHERE Tipo_Personal = '001'
GROUP BY Ciudad;


-- 42. Investigadores con más proyectos asignados

SELECT p.Nombre, COUNT(ipe.ID_Proyecto) AS Total_Proyectos
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
WHERE p.Tipo_Personal = '004'
GROUP BY p.Nombre
ORDER BY Total_Proyectos DESC
LIMIT 5;


-- 43. Vehículos asignados por tipo

SELECT v.Tipo_Vehiculo, COUNT(v.ID_Vehiculo) AS Total
FROM vehiculo v
JOIN personal p ON v.Numero_Cedula = p.Numero_Cedula
WHERE p.Tipo_Personal = '002'
GROUP BY v.Tipo_Vehiculo;


-- 44. Personal con sueldo más bajo por tipo

SELECT p.Nombre, p.Tipo_Personal, p.Sueldo
FROM personal p
WHERE p.Sueldo = (
    SELECT MIN(Sueldo)
    FROM personal p2
    WHERE p2.Tipo_Personal = p.Tipo_Personal
);



-- 45. Personal de vigilacia por parque (subconsulta avanzada)

SELECT DISTINCT p.Nombre_Parque, COUNT(v.Numero_Cedula) AS Total_Vigilantes
FROM parque p
JOIN area a ON p.ID_Parque = a.ID_Parque
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN investigador_proyecto_especie ipe ON ie.ID_Especie = ipe.ID_Especie
JOIN personal per ON ipe.Numero_Cedula = per.Numero_Cedula
JOIN vehiculo v ON per.Numero_Cedula = v.Numero_Cedula
WHERE per.Tipo_Personal = '002'
GROUP BY p.Nombre_Parque;



/*------------------------------------Estadísticas de proyectos de investigación (20 consultas)------------------------------------*/


-- 46. Costo total de proyectos por investigador

SELECT p.Nombre, SUM(pi.Presupuesto) AS Costo_Total
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
JOIN proyecto_investigacion pi ON ipe.ID_Proyecto = pi.ID_Proyecto
WHERE p.Tipo_Personal = '004'
GROUP BY p.Nombre
ORDER BY Costo_Total DESC;


-- 47. Proyectos con presupuesto superior al promedio(subconsulta)

SELECT ID_Proyecto, Presupuesto, Periodo_Realizacion
FROM proyecto_investigacion
WHERE Presupuesto > (SELECT AVG(Presupuesto) FROM proyecto_investigacion)
ORDER BY Presupuesto DESC;


-- 48. Especies más estudiadas en proyectos

SELECT e.Denominacion_Vulgar, COUNT(ipe.ID_Proyecto) AS Total_Proyectos
FROM especies e
JOIN investigador_proyecto_especie ipe ON e.ID_Especie = ipe.ID_Especie
GROUP BY e.Denominacion_Vulgar
ORDER BY Total_Proyectos DESC
LIMIT 5;

-- 49. Investigadores que trabajan en más de 5 proyectos (agregación avanzada)

SELECT p.Nombre, COUNT(ipe.ID_Proyecto) AS Total_Proyectos
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
WHERE p.Tipo_Personal = '004'
GROUP BY p.Nombre
HAVING Total_Proyectos > 5;


-- 50. Proyectos activos en 2025

SELECT ID_Proyecto, Presupuesto, Periodo_Realizacion
FROM proyecto_investigacion
WHERE Periodo_Realizacion LIKE '%2025%';



-- 51. Presupuesto total por año

SELECT SUBSTRING(Periodo_Realizacion, -4) AS Año, SUM(Presupuesto) AS Total_Presupuesto
FROM proyecto_investigacion
GROUP BY Año;

-- 52. Proyectos con más de una especie estudiada

SELECT pi.ID_Proyecto, COUNT(ipe.ID_Especie) AS Total_Especies
FROM proyecto_investigacion pi
JOIN investigador_proyecto_especie ipe ON pi.ID_Proyecto = ipe.ID_Proyecto
GROUP BY pi.ID_Proyecto
HAVING Total_Especies > 1;



-- 53. Investigadores sin proyectos asignados

SELECT p.Nombre
FROM personal p
LEFT JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
WHERE p.Tipo_Personal = '004' AND ipe.ID_Proyecto IS NULL;


-- 54. Proyectos con mayor presupuesto

SELECT ID_Proyecto, Presupuesto, Periodo_Realizacion
FROM proyecto_investigacion
ORDER BY Presupuesto DESC
LIMIT 5;


-- 55. Especies estudiadas por más de un investigador

SELECT e.Denominacion_Vulgar, COUNT(DISTINCT ipe.Numero_Cedula) AS Total_Investigadores
FROM especies e
JOIN investigador_proyecto_especie ipe ON e.ID_Especie = ipe.ID_Especie
GROUP BY e.Denominacion_Vulgar
HAVING Total_Investigadores > 1;


-- 56. Promedio de presupuesto por proyecto

SELECT AVG(Presupuesto) AS Presupuesto_Promedio
FROM proyecto_investigacion;


-- 57. Proyectos finalizados antes de 2024

SELECT ID_Proyecto, Periodo_Realizacion
FROM proyecto_investigacion
WHERE SUBSTRING(Periodo_Realizacion, -10) < '2024-01-01';


-- 58. Investigadores con proyectos de alto presupuesto (subconsulta)

SELECT DISTINCT p.Nombre
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
JOIN proyecto_investigacion pi ON ipe.ID_Proyecto = pi.ID_Proyecto
WHERE pi.Presupuesto > (SELECT AVG(Presupuesto) * 1.5 FROM proyecto_investigacion);


-- 59. Especies no estudiadas en proyectos

SELECT e.Denominacion_Vulgar
FROM especies e
LEFT JOIN investigador_proyecto_especie ipe ON e.ID_Especie = ipe.ID_Especie
WHERE ipe.ID_Proyecto IS NULL;



-- 60. Proyectos con especies animales

SELECT pi.ID_Proyecto, COUNT(e.ID_Especie) AS Total_Animales
FROM proyecto_investigacion pi
JOIN investigador_proyecto_especie ipe ON pi.ID_Proyecto = ipe.ID_Proyecto
JOIN especies e ON ipe.ID_Especie = e.ID_Especie
WHERE e.Tipo = 'Animal'
GROUP BY pi.ID_Proyecto;


-- 61. Presupuesto total por investigador

SELECT p.Nombre, SUM(pi.Presupuesto) AS Total_Presupuesto
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
JOIN proyecto_investigacion pi ON ipe.ID_Proyecto = pi.ID_Proyecto
WHERE p.Tipo_Personal = '004'
GROUP BY p.Nombre;


-- 62. Proyectos con duración mayor a un año

SELECT ID_Proyecto, Periodo_Realizacion
FROM proyecto_investigacion
WHERE DATEDIFF(
    STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d'),
    STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', 1), '%Y-%m-%d')
) > 365;



-- 63. Investigadores con mayor diversidad de especies estudiadas

SELECT p.Nombre, COUNT(DISTINCT ipe.ID_Especie) AS Total_Especies
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
WHERE p.Tipo_Personal = '004'
GROUP BY p.Nombre
ORDER BY Total_Especies DESC
LIMIT 5;



-- 64. Proyectos con presupuesto menor a 40 millones

SELECT ID_Proyecto, Presupuesto, Periodo_Realizacion
FROM proyecto_investigacion
WHERE Presupuesto < 40000000;



-- 65. Proyectos por tipo de especie estudiada

SELECT e.Tipo, COUNT(DISTINCT ipe.ID_Proyecto) AS Total_Proyectos
FROM especies e
JOIN investigador_proyecto_especie ipe ON e.ID_Especie = ipe.ID_Especie
GROUP BY e.Tipo;




/*-----------------------------------------Gestión de visitantes y ocupación de alojamientos (20 consultas)------------------------------------------*/


-- 66. Visitantes por parque en 2025

SELECT p.Nombre_Parque, COUNT(rv.ID_Registro) AS Total_Visitantes
FROM parque p
JOIN alojamiento a ON p.ID_Parque = a.ID_Parque
JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
WHERE rv.Fecha_Entrada BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY p.Nombre_Parque
ORDER BY Total_Visitantes DESC;



-- 67. Alojamientos con mayor ocupación

SELECT a.ID_Alojamiento, a.Categoria, COUNT(rv.ID_Registro) AS Total_Visitas
FROM alojamiento a
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY a.ID_Alojamiento, a.Categoria
ORDER BY Total_Visitas DESC
LIMIT 5;


-- 68. Visitantes que han estado en más de un alojamiento (subconsulta)

SELECT v.Nombre, v.Numero_Cedula
FROM visitante v
WHERE v.Numero_Cedula IN (
    SELECT Numero_Cedula
    FROM registro_visitantes
    GROUP BY Numero_Cedula
    HAVING COUNT(ID_Alojamiento) > 1
);



-- 69. Ocupación promedio por categoría de alojamiento

SELECT a.Categoria, COUNT(rv.ID_Registro) AS Ocupacion_Por_Categoria
FROM alojamiento a
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY a.Categoria;

-- 70. Visitantes por profesión

SELECT v.Profesion, COUNT(rv.ID_Registro) AS Total_Visitas
FROM visitante v
JOIN registro_visitantes rv ON v.Numero_Cedula = rv.Numero_Cedula
GROUP BY v.Profesion
ORDER BY Total_Visitas DESC;



-- 71. Alojamientos sin visitantes

SELECT a.ID_Alojamiento, a.Categoria
FROM alojamiento a
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
WHERE rv.ID_Registro IS NULL;



-- 72. Visitantes en alojamientos de capacidad mayor a 20

SELECT v.Nombre, a.Categoria, a.Capacidad
FROM visitante v
JOIN registro_visitantes rv ON v.Numero_Cedula = rv.Numero_Cedula
JOIN alojamiento a ON rv.ID_Alojamiento = a.ID_Alojamiento
WHERE a.Capacidad > 20;



-- 73. Parques con mayor ocupación en verano (junio-agosto)

SELECT p.Nombre_Parque, COUNT(rv.ID_Registro) AS Total_Visitantes
FROM parque p
JOIN alojamiento a ON p.ID_Parque = a.ID_Parque
JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
WHERE rv.Fecha_Entrada BETWEEN '2025-06-01' AND '2025-08-31'
GROUP BY p.Nombre_Parque
ORDER BY Total_Visitantes DESC;



-- 74. Visitantes por mes en 2025

SELECT MONTH(rv.Fecha_Entrada) AS Mes, COUNT(rv.ID_Registro) AS Total_Visitantes
FROM registro_visitantes rv
WHERE YEAR(rv.Fecha_Entrada) = 2025
GROUP BY Mes
ORDER BY Mes;



-- 75. Alojamientos con ocupación completa (subconsulta avanzada)

SELECT a.ID_Alojamiento, a.Categoria, a.Capacidad
FROM alojamiento a
WHERE a.Capacidad = (
    SELECT COUNT(rv.ID_Registro)
    FROM registro_visitantes rv
    WHERE rv.ID_Alojamiento = a.ID_Alojamiento
);



-- 76. Visitantes por ciudad de origen

SELECT SUBSTRING_INDEX(v.Direccion, ',', -1) AS Ciudad, COUNT(rv.ID_Registro) AS Total_Visitantes
FROM visitante v
JOIN registro_visitantes rv ON v.Numero_Cedula = rv.Numero_Cedula
GROUP BY Ciudad
ORDER BY Total_Visitantes DESC;



-- 77. Alojamientos más populares por categoría

SELECT a.Categoria, a.ID_Alojamiento, COUNT(rv.ID_Registro) AS Total_Visitas
FROM alojamiento a
JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY a.Categoria, a.ID_Alojamiento
ORDER BY a.Categoria, Total_Visitas DESC;



-- 78. Visitantes que llegaron después de septiembre

SELECT v.Nombre, rv.Fecha_Entrada
FROM visitante v
JOIN registro_visitantes rv ON v.Numero_Cedula = rv.Numero_Cedula
WHERE rv.Fecha_Entrada > '2025-09-01';



-- 79. Parques con menos de 5 visitantes

SELECT p.Nombre_Parque, COUNT(rv.ID_Registro) AS Total_Visitantes
FROM parque p
LEFT JOIN alojamiento a ON p.ID_Parque = a.ID_Parque
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY p.Nombre_Parque
HAVING Total_Visitantes < 5;



-- 80. Promedio de visitantes por alojamiento

SELECT a.ID_Alojamiento, a.Categoria, AVG(COUNT(rv.ID_Registro)) OVER (PARTITION BY a.Categoria) AS Promedio_Visitantes
FROM alojamiento a
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY a.ID_Alojamiento, a.Categoria;



/*-------------------------20 consultas avanzadas------------------------*/

/*--------------Estado actual de parques (4 consultas)--------------------*/

-- 1. Parques con más áreas que el promedio por entidad responsable

SELECT p.Nombre_Parque, er.Nombre_Entidad, COUNT(a.ID_Area) AS Total_Areas
FROM parque p
JOIN departamento_parque dp ON p.ID_Parque = dp.ID_Parque
JOIN departamento d ON dp.ID_Departamento = d.ID_Departamento
JOIN entidad_responsable er ON d.ID_Entidad = er.ID_Entidad
LEFT JOIN area a ON p.ID_Parque = a.ID_Parque
GROUP BY p.Nombre_Parque, er.Nombre_Entidad
HAVING Total_Areas > (
    SELECT AVG(Total_Areas)
    FROM (
        SELECT p2.ID_Parque, COUNT(a2.ID_Area) AS Total_Areas
        FROM parque p2
        LEFT JOIN area a2 ON p2.ID_Parque = a2.ID_Parque
        GROUP BY p2.ID_Parque
    ) AS Subquery
)
ORDER BY Total_Areas DESC;



-- 2. Departamentos con parques cuya superficie total excede el promedio nacional

SELECT d.Nombre_Departamento, SUM(p.Superficie_Total) AS Superficie_Total
FROM departamento d
JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
JOIN parque p ON dp.ID_Parque = p.ID_Parque
GROUP BY d.Nombre_Departamento
HAVING Superficie_Total > (
    SELECT AVG(suma_superficie)
    FROM (
        SELECT SUM(p2.Superficie_Total) AS suma_superficie
        FROM parque p2
        JOIN departamento_parque dp2 ON p2.ID_Parque = dp2.ID_Parque
        GROUP BY dp2.ID_Departamento
    ) AS subconsulta
);



-- 3. Ranking de parques por superficie dentro de cada entidad responsable

SELECT p.Nombre_Parque, er.Nombre_Entidad, p.Superficie_Total,
       RANK() OVER (PARTITION BY er.Nombre_Entidad ORDER BY p.Superficie_Total DESC) AS Ranking
FROM parque p
JOIN departamento_parque dp ON p.ID_Parque = dp.ID_Parque
JOIN departamento d ON dp.ID_Departamento = d.ID_Departamento
JOIN entidad_responsable er ON d.ID_Entidad = er.ID_Entidad;


-- 4. Parques con superficies mayores al promedio de su año de declaración

SELECT p.Nombre_Parque, p.Superficie_Total, YEAR(p.Fecha_Declaracion) AS Año_Declaracion
FROM parque p
WHERE p.Superficie_Total > (
    SELECT AVG(p2.Superficie_Total)
    FROM parque p2
    WHERE YEAR(p2.Fecha_Declaracion) = YEAR(p.Fecha_Declaracion)
)
ORDER BY Año_Declaracion, Superficie_Total DESC;





/*-------------------Inventarios de especies por áreas y tipos (4 consultas)-----------------------*/


-- 5. Consulta para mostrar parques con el total de especies distintas y su promedio de individuos por área, ordenados por el total de especies

SELECT p.Nombre_Parque, COUNT(DISTINCT ie.ID_Especie) AS Total_Especies, AVG(ie.Numero_Individuos) AS Promedio_Individuos_Por_Area
FROM parque p
JOIN area a ON p.ID_Parque = a.ID_Parque
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
GROUP BY p.Nombre_Parque
ORDER BY Total_Especies DESC;



-- 6. Consulta para mostrar tipos de especies con el total de individuos y el área con más individuos por tipo, ordenados por total de individuos

SELECT e.Tipo, SUM(ie.Numero_Individuos) AS Total_Individuos, 
       MAX(a.Nombre_Area) AS Area_Mayor_Concentracion
FROM especies e
JOIN inventario_especies ie ON e.ID_Especie = ie.ID_Especie
JOIN area a ON ie.ID_Area = a.ID_Area
GROUP BY e.Tipo
HAVING SUM(ie.Numero_Individuos) > 100
ORDER BY Total_Individuos DESC;


-- 7. Ranking de áreas por diversidad de especies dentro de cada parque

SELECT a.Nombre_Area, p.Nombre_Parque, COUNT(DISTINCT ie.ID_Especie) AS Diversidad_Especies,
       DENSE_RANK() OVER (PARTITION BY p.Nombre_Parque ORDER BY COUNT(DISTINCT ie.ID_Especie) DESC) AS Ranking
FROM area a
JOIN parque p ON a.ID_Parque = p.ID_Parque
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
GROUP BY a.Nombre_Area, p.Nombre_Parque;



-- 8. Áreas con especies raras (menos de 5 individuos en total)

SELECT a.Nombre_Area, e.Denominacion_Vulgar, ie.Numero_Individuos
FROM area a
JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
JOIN especies e ON ie.ID_Especie = e.ID_Especie
WHERE ie.ID_Especie IN (
    SELECT ID_Especie
    FROM inventario_especies
    GROUP BY ID_Especie
    HAVING SUM(Numero_Individuos) < 5
)
ORDER BY a.Nombre_Area, ie.Numero_Individuos;



/*-----------------------------Actividades del personal según tipo, áreas asignadas y sueldos (4 consultas)-------------------------------*/


-- 9. Personal con sueldo superior al promedio de su ciudad

SELECT p.Nombre, p.Tipo_Personal, p.Sueldo, SUBSTRING_INDEX(p.Direccion, ',', -1) AS Ciudad
FROM personal p
WHERE p.Sueldo > (
    SELECT AVG(p2.Sueldo)
    FROM personal p2
    WHERE SUBSTRING_INDEX(p2.Direccion, ',', -1) = SUBSTRING_INDEX(p.Direccion, ',', -1)
)
ORDER BY Ciudad, p.Sueldo DESC;


-- 10. Ranking de personal por sueldo dentro de cada tipo

SELECT p.Nombre, p.Tipo_Personal, p.Sueldo,
       ROW_NUMBER() OVER (PARTITION BY p.Tipo_Personal ORDER BY p.Sueldo DESC) AS Ranking
FROM personal p;


-- 11. Personal de vigilancia con más vehículos que el promedio

SELECT p.Nombre, COUNT(v.ID_Vehiculo) AS Total_Vehiculos
FROM personal p
JOIN vehiculo v ON p.Numero_Cedula = v.Numero_Cedula
WHERE p.Tipo_Personal = '002'
GROUP BY p.Nombre
HAVING COUNT(v.ID_Vehiculo) > (
    SELECT AVG(conteo_vehiculos)
    FROM (
        SELECT COUNT(ID_Vehiculo) AS conteo_vehiculos
        FROM vehiculo
        JOIN personal p2 ON vehiculo.Numero_Cedula = p2.Numero_Cedula
        WHERE p2.Tipo_Personal = '002'
        GROUP BY p2.Numero_Cedula
    ) AS subconsulta
)
ORDER BY Total_Vehiculos DESC;



-- 12. Personal con sueldo máximo por tipo y su asignación a proyectos o vehículos

SELECT p.Nombre, p.Tipo_Personal, p.Sueldo,
       COUNT(DISTINCT v.ID_Vehiculo) AS Vehiculos,
       COUNT(DISTINCT ipe.ID_Proyecto) AS Proyectos
FROM personal p
LEFT JOIN vehiculo v ON p.Numero_Cedula = v.Numero_Cedula
LEFT JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
WHERE p.Sueldo IN (
    SELECT MAX(Sueldo)
    FROM personal p2
    GROUP BY p2.Tipo_Personal
)
GROUP BY p.Nombre, p.Tipo_Personal, p.Sueldo;



/*-----------------------------Estadísticas de proyectos de investigación (4 consultas)-------------------------------*/

-- 13. Proyectos con más especies estudiadas que el promedio

SELECT pi.ID_Proyecto, pi.Presupuesto, COUNT(ipe.ID_Especie) AS Total_Especies
FROM proyecto_investigacion pi
JOIN investigador_proyecto_especie ipe ON pi.ID_Proyecto = ipe.ID_Proyecto
GROUP BY pi.ID_Proyecto, pi.Presupuesto
HAVING COUNT(ipe.ID_Especie) > (
    SELECT AVG(conteo_especies)
    FROM (
        SELECT COUNT(ID_Especie) AS conteo_especies
        FROM investigador_proyecto_especie
        GROUP BY ID_Proyecto
    ) AS subconsulta
)
ORDER BY Total_Especies DESC;



-- 14. Investigadores con proyectos de mayor duración que el promedio

SELECT p.Nombre, pi.ID_Proyecto, pi.Periodo_Realizacion,
       DATEDIFF(STR_TO_DATE(SUBSTRING_INDEX(pi.Periodo_Realizacion, ' al ', -1), '%Y-%m-%d'),
                STR_TO_DATE(SUBSTRING_INDEX(pi.Periodo_Realizacion, ' al ', 1), '%Y-%m-%d')) AS Duracion_Dias
FROM personal p
JOIN investigador_proyecto_especie ipe ON p.Numero_Cedula = ipe.Numero_Cedula
JOIN proyecto_investigacion pi ON ipe.ID_Proyecto = pi.ID_Proyecto
WHERE DATEDIFF(STR_TO_DATE(SUBSTRING_INDEX(pi.Periodo_Realizacion, ' al ', -1), '%Y-%m-%d'),
               STR_TO_DATE(SUBSTRING_INDEX(pi.Periodo_Realizacion, ' al ', 1), '%Y-%m-%d')) > (
    SELECT AVG(DATEDIFF(STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', -1), '%Y-%m-%d'),
                        STR_TO_DATE(SUBSTRING_INDEX(Periodo_Realizacion, ' al ', 1), '%Y-%m-%d')))
    FROM proyecto_investigacion
)
ORDER BY Duracion_Dias DESC;




-- 15. Ranking de especies por número de proyectos dentro de cada tipo

SELECT e.Denominacion_Vulgar, e.Tipo, COUNT(ipe.ID_Proyecto) AS Total_Proyectos,
       RANK() OVER (PARTITION BY e.Tipo ORDER BY COUNT(ipe.ID_Proyecto) DESC) AS Ranking
FROM especies e
JOIN investigador_proyecto_especie ipe ON e.ID_Especie = ipe.ID_Especie
GROUP BY e.Denominacion_Vulgar, e.Tipo;




-- 16. Proyectos con costos superiores al promedio de su investigador

SELECT pi.ID_Proyecto, p.Nombre, pi.Presupuesto
FROM proyecto_investigacion pi
JOIN investigador_proyecto_especie ipe ON pi.ID_Proyecto = ipe.ID_Proyecto
JOIN personal p ON ipe.Numero_Cedula = p.Numero_Cedula
WHERE pi.Presupuesto > (
    SELECT AVG(pi2.Presupuesto)
    FROM proyecto_investigacion pi2
    JOIN investigador_proyecto_especie ipe2 ON pi2.ID_Proyecto = ipe2.ID_Proyecto
    WHERE ipe2.Numero_Cedula = p.Numero_Cedula
)
ORDER BY pi.Presupuesto DESC;




/*------------------------------Gestión de visitantes y ocupación de alojamientos (4 consultas)-------------------------------*/


-- 17. Parques con más alojamientos que el promedio y su total de visitantes

SELECT p.Nombre_Parque, COUNT(a.ID_Alojamiento) AS Total_Alojamientos, COUNT(rv.ID_Registro) AS Total_Visitantes
FROM parque p
LEFT JOIN alojamiento a ON p.ID_Parque = a.ID_Parque
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY p.Nombre_Parque
HAVING COUNT(a.ID_Alojamiento) > (
    SELECT AVG(conteo_alojamientos)
    FROM (
        SELECT COUNT(ID_Alojamiento) AS conteo_alojamientos
        FROM alojamiento
        GROUP BY ID_Parque
    ) AS subconsulta
)
ORDER BY Total_Visitantes DESC;




-- 18. Visitantes que han visitado más parques que el promedio

SELECT v.Nombre, COUNT(DISTINCT a.ID_Parque) AS Total_Parques_Visitados
FROM visitante v
JOIN registro_visitantes rv ON v.Numero_Cedula = rv.Numero_Cedula
JOIN alojamiento a ON rv.ID_Alojamiento = a.ID_Alojamiento
GROUP BY v.Nombre
HAVING COUNT(DISTINCT a.ID_Parque) > (
    SELECT AVG(conteo_parques)
    FROM (
        SELECT COUNT(DISTINCT a2.ID_Parque) AS conteo_parques
        FROM registro_visitantes rv2
        JOIN alojamiento a2 ON rv2.ID_Alojamiento = a2.ID_Alojamiento
        GROUP BY rv2.Numero_Cedula
    ) AS subconsulta
)
ORDER BY Total_Parques_Visitados DESC;




-- 19. Ranking de alojamientos por ocupación dentro de cada categoría

SELECT a.ID_Alojamiento, a.Categoria, COUNT(rv.ID_Registro) AS Total_Visitantes,
       DENSE_RANK() OVER (PARTITION BY a.Categoria ORDER BY COUNT(rv.ID_Registro) DESC) AS Ranking
FROM alojamiento a
LEFT JOIN registro_visitantes rv ON a.ID_Alojamiento = rv.ID_Alojamiento
GROUP BY a.ID_Alojamiento, a.Categoria;




-- 20. Visitantes con más visitas en alojamientos de alta capacidad

SELECT v.Nombre, COUNT(rv.ID_Registro) AS Total_Visitas
FROM visitante v
JOIN registro_visitantes rv ON v.Numero_Cedula = rv.Numero_Cedula
JOIN alojamiento a ON rv.ID_Alojamiento = a.ID_Alojamiento
WHERE a.Capacidad > (
    SELECT AVG(Capacidad)
    FROM alojamiento
)
GROUP BY v.Nombre
ORDER BY Total_Visitas DESC
LIMIT 5;






