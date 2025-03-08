# Gestión de Parques Naturales

## Descripción del Proyecto

El proyecto "Gestión de Parques Naturales" es un sistema de base de datos diseñado para administrar información sobre parques naturales, incluyendo áreas, especies, personal, proyectos de investigación, visitantes y alojamientos. Su propósito es facilitar el seguimiento de inventarios, la asignación de recursos, la gestión de personal y la ocupación de alojamientos, ofreciendo herramientas para análisis y automatización mediante 65 consultas, 20 eventos, 20 funciones, 20 procedimientos y 20 disparadores implementados.

## Requisitos del Sistema

- **Software necesario**:
  - MySQL 8.0 o superior.
  - Cliente como MySQL Workbench o DBeaver para ejecutar scripts y visualizar datos.
  - Sistema operativo compatible con MySQL (Windows, Linux, macOS).

## Instalación y Configuración

1. **Configurar el entorno**:
   - Instala MySQL Server y un cliente como MySQL Workbench.
   - Inicia el servidor MySQL y crea una base de datos vacía: `CREATE DATABASE parques;`.

2. **Ejecutar el archivo `ddl.sql`**:
   - Abre el cliente MySQL y selecciona la base de datos: `USE parques;`.
   - Copia y pega el contenido del archivo `ddl.sql` (estructura de tablas) y ejecútalo para crear las tablas.

3. **Cargar datos iniciales con `dml.sql`**:
   - Ejecuta el archivo `dml.sql` (datos iniciales) en la misma base de datos para poblar las tablas con información de ejemplo.

4. **Ejecutar scripts adicionales**:
   - Carga los scripts en el siguiente orden:
     1. Consultas (`consultas.sql`): 65 consultas básicas y avanzadas.
     2. Eventos (`eventos.sql`): 20 eventos programados.
     3. Funciones (`funciones.sql`): 20 funciones determinísticas.
     4. Procedimientos (`procedimientos.sql`): 20 procedimientos almacenados.
     5. Disparadores (`triggers.sql`): 20 triggers.
   - Usa el cliente para ejecutar cada archivo: `SOURCE ruta_del_archivo.sql;` o copia y pega el contenido.

## Estructura de la Base de Datos

- **`parque`**: Almacena información de parques (ID, nombre, fecha de declaración, superficie).
- **`area`**: Detalla las áreas dentro de los parques (ID, nombre, extensión, ID_Parque).
- **`especies`**: Registra especies presentes (ID, nombre científico/vulgar, tipo).
- **`inventario_especies`**: Vincula especies a áreas con número de individuos.
- **`departamento` y `departamento_parque`**: Gestiona la relación entre departamentos y parques.
- **`entidad_responsable`**: Entidades que gestionan departamentos.
- **`personal`**: Contiene datos del personal (ID, nombre, tipo, sueldo).
- **`vehiculo`**: Registra vehículos asignados al personal de vigilancia.
- **`proyecto_investigacion`**: Almacena proyectos de investigación (ID, presupuesto, periodo).
- **`investigador_proyecto_especie`**: Relaciona investigadores, proyectos y especies.
- **`visitante`**: Datos de visitantes (ID, nombre, dirección, profesión).
- **`alojamiento`**: Información de alojamientos (ID, capacidad, categoría, ID_Parque).
- **`registro_visitantes`**: Registra entradas de visitantes a alojamientos.

Las tablas están interconectadas mediante claves primarias y foráneas para reflejar relaciones como parques-áreas, especies-inventarios y personal-vehículos.

## Ejemplos de Consultas

- **Básica (Consulta 1)**: Cantidad de parques por departamento.
  ```sql
  SELECT d.Nombre_Departamento, COUNT(dp.ID_Parque) AS Total_Parques
  FROM departamento d
  LEFT JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
  GROUP BY d.Nombre_Departamento;


 Resultado: Lista departamentos con el número de parques asociados.

## Avanzada (Consulta Avanzada 1): Parques con más áreas que el promedio por entidad responsable.

## Avanzada (Consulta Avanzada 1): Parques con más áreas que el promedio por entidad responsable.


 SELECT p.Nombre_Parque, er.Nombre_Entidad, COUNT(a.ID_Area) AS Total_Areas
 FROM parque p
JOIN departamento_parque dp ON p.ID_Parque = dp.ID_Parque
 JOIN departamento d ON dp.ID_Departamento = d.ID_Departamento
JOIN entidad_responsable er ON d.ID_Entidad = er.ID_Entidad
LEFT JOIN area a ON p.ID_Parque = a.ID_Parque
GROUP BY p.Nombre_Parque, er.Nombre_Entidad
HAVING Total_Areas > (SELECT AVG(COUNT(a2.ID_Area)) FROM parque p2 LEFT JOIN area a2 ON p2.ID_Parque = a2.ID_Parque GROUP BY p2.ID_Parque);


Resultado: Identifica parques con alta densidad de áreas.

Total: 100 consultas divididas en 5 categorías (15 sobre parques, 15 sobre inventarios, 15 sobre personal, 15 sobre proyectos, 20 sobre visitantes), incluyendo 20 avanzadas.

 SELECT p.Nombre_Parque, er.Nombre_Entidad, COUNT(a.ID_Area) AS Total_Areas
 FROM parque p
JOIN departamento_parque dp ON p.ID_Parque = dp.ID_Parque
 JOIN departamento d ON dp.ID_Departamento = d.ID_Departamento
JOIN entidad_responsable er ON d.ID_Entidad = er.ID_Entidad
LEFT JOIN area a ON p.ID_Parque = a.ID_Parque
GROUP BY p.Nombre_Parque, er.Nombre_Entidad
HAVING Total_Areas > (SELECT AVG(COUNT(a2.ID_Area)) FROM parque p2 LEFT JOIN area a2 ON p2.ID_Parque = a2.ID_Parque GROUP BY p2.ID_Parque);

Resultado: Identifica parques con alta densidad de áreas.

Total: 100 consultas divididas en 5 categorías (15 sobre parques, 15 sobre inventarios, 15 sobre personal, 15 sobre proyectos, 20 sobre visitantes), incluyendo 20 avanzadas.


# Procedimientos, Funciones, Triggers y Eventos

## Procedimientos (20)
- **RegistrarParque**: Inserta un nuevo parque.  
  Ejemplo: `CALL RegistrarParque(51, 'Parque Nuevo', '2025-03-06', 10000.00);`
- **ActualizarParque**: Actualiza datos de un parque.
- **RegistrarArea**: Registra un área en un parque.
- **RegistrarEspecie**: Inserta una nueva especie.
- **ActualizarInventarioEspecies**: Actualiza o registra individuos en inventario_especies.
- **RegistrarVisitante**: Registra un visitante.
- **AsignarAlojamiento**: Asigna un visitante a un alojamiento con verificación de capacidad.
- **LiberarAlojamiento**: Elimina un registro de visitante.
- **AsignarVehiculoPersonal**: Asigna un vehículo a personal de vigilancia.
- **LiberarVehiculoPersonal**: Libera un vehículo asignado.
- **RegistrarProyectoInvestigacion**: Registra un proyecto de investigación.
- **ActualizarPresupuestoProyecto**: Actualiza el presupuesto de un proyecto.
- **AsignarInvestigadorProyectoEspecie**: Asigna un investigador a un proyecto y especie.
- **ReporteOcupacionAlojamientos**: Reporte de ocupación por parque.
- **RegistrarVehiculoVigilancia**: Registra un vehículo para vigilancia.
- **ActualizarSueldoPersonal**: Actualiza el sueldo de un empleado.
- **ReporteInventarioEspeciesPorArea**: Reporte de especies por área.
- **AsignarPersonalAArea**: Asigna personal de conservación a un área.
- **CalcularCostoTotalProyectos**: Calcula el costo total de proyectos activos.
- **GenerarReporteVehiculosAsignados**: Reporte de vehículos asignados a vigilancia.

## Funciones (20)
- **CalcularSuperficieTotalParque**: Suma la extensión de áreas de un parque.  
  Ejemplo: `SELECT CalcularSuperficieTotalParque(1);`
- **ContarIndividuosEspecieParque**: Cuenta individuos de una especie en un parque.
- **ObtenerCapacidadDisponibleAlojamiento**: Capacidad disponible en un alojamiento.
- **CalcularPresupuestoPromedioProyectos**: Promedio de presupuestos de proyectos activos.
- **ObtenerPorcentajeOcupacionAlojamiento**: Porcentaje de ocupación de un alojamiento.
- **ContarParquesPorDepartamento**: Número de parques por departamento.
- **ObtenerSueldoPromedioPorTipoPersonal**: Sueldo promedio por tipo de personal.
- **ContarEspeciesPorTipoEnArea**: Especies por tipo en un área.
- **CalcularCostoOperativoPersonalParque**: Costo de personal de vigilancia y conservación.
- **ObtenerNumeroInvestigadoresProyecto**: Número de investigadores en un proyecto.
- **ContarVisitantesPorParque**: Visitantes por parque hasta una fecha.
- **ObtenerAntiguedadParque**: Años desde la declaración del parque.
- **CalcularDensidadEspeciesArea**: Densidad de individuos por área.
- **ObtenerNumeroAreasParque**: Número de áreas en un parque.
- **CalcularCostoPorInvestigador**: Costo por investigador en un proyecto.
- **ContarVehiculosPorPersonal**: Vehículos asignados a un empleado.
- **ObtenerDuracionProyecto**: Duración en meses de un proyecto.
- **ContarEspeciesInvestigadasPorProyecto**: Especies estudiadas en un proyecto.
- **ObtenerNumeroAlojamientosParque**: Número de alojamientos en un parque.
- **CalcularPromedioIndividuosPorEspecie**: Promedio de individuos por especie.

## Triggers (20)
- **ActualizarInventarioTrasInsertarArea**: Reduce un 5% los individuos al insertar un área.
- **ActualizarSuperficieParqueTrasInsertarArea**: Actualiza la superficie del parque tras insertar un área.
- **ActualizarSuperficieParqueTrasActualizarArea**: Actualiza la superficie si cambia la extensión de un área.
- **EliminarInventarioTrasEliminarArea**: Elimina inventarios al borrar un área.
- **ActualizarInventarioTrasInsertarEspecie**: Ajusta inventarios al insertar una especie.
- **EliminarVehiculosTrasEliminarPersonal**: Libera vehículos al eliminar personal.
- **LimitarSueldoMaximoTrasInsertar**: Limita sueldos a 10M al insertar personal.
- **ActualizarVehiculoTrasActualizarPersonal**: Reasigna vehículos si el sueldo baja de 2M.
- **ActualizarEstadoProyectoTrasInsertar**: Marca proyectos como "Iniciado" al asignar investigadores.
- **EliminarInvestigadoresTrasEliminarProyecto**: Borra asignaciones al eliminar un proyecto.
- **LimitarPresupuestoTrasInsertarProyecto**: Limita presupuestos a 100M.
- **ActualizarPresupuestoTrasEliminarInvestigador**: Reduce un 10% el presupuesto al eliminar un investigador.
- **ActualizarCapacidadTrasInsertarVisitante**: Reduce la capacidad al registrar un visitante.
- **RestaurarCapacidadTrasEliminarVisitante**: Restaura capacidad al eliminar un visitante.
- **LimitarCapacidadAlojamientoTrasInsertar**: Limita la capacidad de alojamientos a 50.
- **EliminarVisitantesTrasEliminarAlojamiento**: Elimina registros de visitantes al borrar un alojamiento.
- **ActualizarFechaEntradaVisitante**: Ajusta fechas futuras a la actual.
- **ActualizarNumeroIndividuosTrasEliminarEspecie**: Aumenta individuos tras eliminar una especie.
- **BloquearEliminacionAreaConInventario**: Impide eliminar áreas con inventario activo.
- **AjustarInventarioTrasActualizarEspecie**: Aumenta un 5% individuos si una especie pasa a "Vegetal".

## Eventos (20)
- **ActualizarInventarioEspeciesMensual**: Incrementa un 5% los vegetales mensualmente.
- **ReducirInventarioAnimalesMensual**: Reduce un 2% los animales mensualmente.
- **ActualizarSueldosPersonalAnual**: Incrementa sueldos un 3% anualmente.
- **LimpiarRegistrosVisitantesAntiguos**: Borra registros de visitantes de más de un año.
- **ActualizarEstadoProyectosDiario**: Marca proyectos finalizados diariamente.
- **ActualizarCapacidadAlojamientosMensual**: Aumenta un 10% la capacidad de cabañas mensualmente.
- **IncrementarPresupuestoProyectosAnual**: Incrementa un 5% el presupuesto de proyectos activos anualmente.
- **LimpiarInventarioEspeciesNulasMensual**: Elimina inventarios con 0 individuos mensualmente.
- **RotarPersonalVigilanciaSemestral**: Reasigna vehículos de vigilancia cada 6 meses.
- **ActualizarExtensionAreasAnual**: Incrementa un 1% la extensión de áreas anualmente.
- **ActualizarTelefonosPersonalAnual**: Actualiza teléfonos móviles anualmente.
- **LimpiarProyectosFinalizadosAnual**: Borra proyectos finalizados de más de 2 años.
- **SimularCrecimientoEspeciesRarasTrimestral**: Incrementa un 10% especies con menos de 10 individuos cada 3 meses.
- **ActualizarEspeciesEnPeligroTrimestral**: Reduce un 5% especies con menos de 50 individuos cada 3 meses.
- **ActualizarSueldoPorAntiguedadAnual**: Incrementa un 2% sueldos por antigüedad (>5 años).
- **ActualizarPresupuestoProyectosCriticosTrimestral**: Aumenta un 10% presupuestos de proyectos con especies críticas.
- **LimpiarPersonalRetiradoAnual**: Elimina personal con más de 30 años de servicio.
- **ReasignarVehiculosInactivosSemestral**: Reasigna vehículos no asignados cada 6 meses.
- **ReducirExtensionAreasPeligrosasAnual**: Reduce un 5% áreas con menos de 10 individuos.
- **LimpiarAlojamientosInactivosAnual**: Borra alojamientos sin visitas en 3 años.


# Roles de Usuario y Permisos

## Administrador
- **Permisos**: `ALL PRIVILEGES` en `parques.*`.  
- **Ejemplo**:  
  ```sql
  GRANT ALL PRIVILEGES ON parques.* TO 'admin'@'localhost';


## GestorParques
- **Permisos**: `SELECT, INSERT, UPDATE` en `parque, area, departamento.`
- **Ejemplo**:
  ```sql
  GRANT SELECT, INSERT, UPDATE ON parques.parque TO 'gestor'@'localhost';


## Investigador
- **Permisos**: `SELECT, INSERT, UPDATE en proyecto_investigacion, investigador_proyecto_especie, especies.`
- **Ejemplo**:
  ```sql
  GRANT SELECT, INSERT, UPDATE ON parques.proyecto_investigacion TO 'investigador'@'localhost';


## PersonalVigilancia
- **Permisos**: `SELECT` en `vehiculo, personal; UPDATE` en `vehiculo.`
- **Ejemplo**:
  ```sql
  GRANT SELECT ON parques.personal TO 'vigilante'@'localhost';



## Recepcionista
- **Permisos**: `SELECT, INSERT` en `visitante, registro_visitantes, alojamiento.`
- **Ejemplo**:
  ```sql
  GRANT SELECT, INSERT ON parques.visitante TO 'recepcionista'@'localhost';


## Creación de usuarios:
```sql
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON parques.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

## Contribuciones
[Brayan David Vera Mesa]





