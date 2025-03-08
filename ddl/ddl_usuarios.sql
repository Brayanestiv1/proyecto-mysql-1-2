USE parques;


-- Crear usuario Administrador
CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'AdminParques2025';

-- Otorgar permisos completos
GRANT ALL PRIVILEGES ON parques.* TO 'administrador'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;




-- Crear usuario Gestor de Parques
CREATE USER 'gestor_parques'@'localhost' IDENTIFIED BY 'GestorP2025';

-- Otorgar permisos específicos
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.parque TO 'gestor_parques'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.area TO 'gestor_parques'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.especies TO 'gestor_parques'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.inventario_especies TO 'gestor_parques'@'localhost';

-- Permitir acceso a funciones relacionadas
GRANT EXECUTE ON FUNCTION parques.CalcularSuperficieTotalParque TO 'gestor_parques'@'localhost';
GRANT EXECUTE ON FUNCTION parques.ContarIndividuosEspecieParque TO 'gestor_parques'@'localhost';
GRANT EXECUTE ON FUNCTION parques.CalcularDensidadEspeciesArea TO 'gestor_parques'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;



-- Crear usuario Investigador
CREATE USER 'investigador'@'localhost' IDENTIFIED BY 'Invest2025';

-- Otorgar permisos específicos
GRANT SELECT ON parques.parque TO 'investigador'@'localhost';
GRANT SELECT ON parques.area TO 'investigador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.especies TO 'investigador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.inventario_especies TO 'investigador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.proyecto_investigacion TO 'investigador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.investigador_proyecto_especie TO 'investigador'@'localhost';

-- Permitir acceso a funciones relacionadas
GRANT EXECUTE ON FUNCTION parques.ContarIndividuosEspecieParque TO 'investigador'@'localhost';
GRANT EXECUTE ON FUNCTION parques.CalcularDensidadEspeciesArea TO 'investigador'@'localhost';
GRANT EXECUTE ON FUNCTION parques.ObtenerNumeroInvestigadoresProyecto TO 'investigador'@'localhost';
GRANT EXECUTE ON FUNCTION parques.ContarEspeciesInvestigadasPorProyecto TO 'investigador'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;




-- Crear usuario Auditor
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'Audit2025';

-- Otorgar permisos específicos
GRANT SELECT ON parques.personal TO 'auditor'@'localhost'; -- Para sueldos
GRANT SELECT ON parques.proyecto_investigacion TO 'auditor'@'localhost'; -- Para presupuestos
GRANT SELECT ON parques.parque TO 'auditor'@'localhost'; -- Contexto de parques
GRANT SELECT ON parques.alojamiento TO 'auditor'@'localhost'; -- Contexto financiero de alojamientos

-- Permitir acceso a funciones relacionadas
GRANT EXECUTE ON FUNCTION parques.ObtenerSueldoPromedioPorTipoPersonal TO 'auditor'@'localhost';
GRANT EXECUTE ON FUNCTION parques.CalcularPresupuestoPromedioProyectos TO 'auditor'@'localhost';
GRANT EXECUTE ON FUNCTION parques.CalcularCostoOperativoPersonalParque TO 'auditor'@'localhost';
GRANT EXECUTE ON FUNCTION parques.CalcularCostoPorInvestigador TO 'auditor'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;



-- Crear usuario Encargado de Visitantes
CREATE USER 'encargado_visitantes'@'localhost' IDENTIFIED BY 'Visit2025';

-- Otorgar permisos específicos
GRANT SELECT ON parques.parque TO 'encargado_visitantes'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.alojamiento TO 'encargado_visitantes'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parques.registro_visitantes TO 'encargado_visitantes'@'localhost';

-- Permitir acceso a funciones relacionadas
GRANT EXECUTE ON FUNCTION parques.ObtenerCapacidadDisponibleAlojamiento TO 'encargado_visitantes'@'localhost';
GRANT EXECUTE ON FUNCTION parques.ObtenerPorcentajeOcupacionAlojamiento TO 'encargado_visitantes'@'localhost';
GRANT EXECUTE ON FUNCTION parques.ContarVisitantesPorParque TO 'encargado_visitantes'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;