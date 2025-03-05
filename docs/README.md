# proyecto-mysql Parques

"Parques" es una base de datos relacional diseñada para gestionar de manera eficiente todas las operaciones relacionadas con los parques naturales bajo la supervisión del Ministerio del Medio Ambiente en Colombia. El sistema abarca la administración de departamentos, parques, áreas, especies, personal, proyectos de investigación, visitantes y alojamientos. Su propósito es proporcionar una solución robusta y optimizada que facilite consultas críticas para la toma de decisiones, como el estado de los parques, inventarios de especies, actividades del personal, estadísticas de proyectos y gestión de visitantes.

El proyecto incluye la creación de la estructura de la base de datos, la inserción de datos realistas, 100 consultas SQL, 20 procedimientos almacenados, 20 funciones, 20 eventos, 20 triggers y la definición de 5 roles de usuario con permisos específicos. Todo esto se entrega en un repositorio organizado en GitHub.

---

## Requisitos del Sistema

- **Software necesario**:
  - MySQL Server (versión 8.0 o superior).
  - Cliente MySQL Workbench (o cualquier cliente SQL compatible).
  - Git (para clonar el repositorio).
- **Sistema Operativo**: Compatible con Windows, macOS o Linux.
- **Espacio en disco**: Al menos 500 MB para la base de datos y scripts.

---

## Instalación y Configuración

Sigue estos pasos para configurar y ejecutar la base de datos:

1. **Clonar el Repositorio**:
   ```bash
   git clone <https://github.com/Brayanestiv1/proyecto-mysql-1-2>
   cd proyecto-mysql-1-2
   ```
   - Nota: Asegúrate de tener permisos de acceso al repositorio.

2. **Configurar MySQL**:
   - Inicia tu servidor MySQL.
   - Crea una base de datos vacía:
     ```sql
     CREATE DATABASE parques;
     ```

3. **Ejecutar los Scripts SQL**:
   - **Estructura (DDL)**: Ejecuta el archivo `ddl.sql` para crear las tablas y relaciones.
     ```bash
     mysql -u <usuario> -p parques < ddl.sql
     ```
   - **Datos Iniciales (DML)**: Carga los datos con `dml.sql`.
     ```bash
     mysql -u <usuario> -p parques < dml.sql
     ```
   - **Consultas**: Usa `dql_select.sql` para probar las consultas.
   - **Procedimientos**: Ejecuta `dql_procedimientos.sql` para crear los procedimientos almacenados.
   - **Funciones**: Ejecuta `dql_funciones.sql` para las funciones.
   - **Triggers**: Ejecuta `dql_triggers.sql` para los triggers.
   - **Eventos**: Ejecuta `dql_eventos.sql` para los eventos (asegúrate de habilitar el scheduler con `SET GLOBAL event_scheduler = ON;`).

4. **Verificar Instalación**:
   - Conéctate a la base de datos con MySQL Workbench y ejecuta:
     ```sql
     USE parques;
     SHOW TABLES;
     ```
   - Deberías ver las 14 tablas creadas.

---

## Estructura de la Base de Datos

La base de datos consta de 14 tablas interrelacionadas:

- **`entidad_responsable`**: Entidades que gestionan parques (ejemplo: "Fundación EcoSur").
- **`departamento`**: Departamentos con parques, vinculados a una entidad responsable.
- **`parque`**: Parques naturales con nombre, fecha de declaración y superficie.
- **`departamento_parque`**: Relación muchos a muchos entre departamentos y parques.
- **`area`**: Áreas específicas dentro de los parques (ejemplo: "Zona Costera").
- **`especies`**: Especies (animales, vegetales, minerales) con nombres científicos y vulgares.
- **`inventario_especies`**: Conteo de especies por área.
- **`personal`**: Empleados con roles (gestión, vigilancia, conservación, investigación).
- **`vehiculo`**: Vehículos asignados a vigilantes.
- **`proyecto_investigacion`**: Proyectos con presupuesto y periodo.
- **`investigador_proyecto_especie`**: Relación muchos a muchos entre investigadores, proyectos y especies.
- **`visitante`**: Visitantes con datos personales.
- **`alojamiento`**: Alojamientos en los parques (cabañas, camping, etc.).
- **`registro_visitantes`**: Registro de visitantes en alojamientos.

**Diagrama**: Consulta `Diagrama.jpg` en el repositorio para ver el modelo entidad-relación.

---

## Ejemplos de Consultas

1. **Número de Parques por Departamento**:
   ```sql
   SELECT d.Nombre_Departamento, COUNT(dp.ID_Parque) as Num_Parques
   FROM departamento d
   LEFT JOIN departamento_parque dp ON d.ID_Departamento = dp.ID_Departamento
   GROUP BY d.Nombre_Departamento;
   ```
   - **Resultado**: Lista departamentos y cuántos parques tienen.

2. **Inventario de Especies por Área (Avanzada)**:
   ```sql
   SELECT a.Nombre_Area, e.Tipo, SUM(ie.Numero_Individuos) as Total
   FROM area a
   JOIN inventario_especies ie ON a.ID_Area = ie.ID_Area
   JOIN especies e ON ie.ID_Especie = e.ID_Especie
   GROUP BY a.Nombre_Area, e.Tipo
   HAVING Total > 50;
   ```
   - **Resultado**: Áreas con más de 50 individuos por tipo de especie.

Consulta `dql_select.sql` para las 100 consultas implementadas.

---

## Procedimientos, Funciones, Triggers y Eventos

### **Procedimientos Almacenados**
- **Ejemplo**: `registrar_visitante`
  ```sql
  DELIMITER //
  CREATE PROCEDURE registrar_visitante(
      IN cedula VARCHAR(20), IN nombre VARCHAR(100), IN direccion TEXT, IN profesion VARCHAR(100)
  )
  BEGIN
      INSERT INTO visitante (Numero_Cedula, Nombre, Direccion, Profesion)
      VALUES (cedula, nombre, direccion, profesion);
  END //
  DELIMITER ;
  ```
  - **Uso**: `CALL registrar_visitante('12345678', 'Juan Pérez', 'Calle 10, Bogotá', 'Ingeniero');`

- Total: 20 en `dql_procedimientos.sql`.

### **Funciones**
- **Ejemplo**: `superficie_por_departamento`
  ```sql
  DELIMITER //
  CREATE FUNCTION superficie_por_departamento(dep_id INT) RETURNS DECIMAL(15,2)
  BEGIN
      DECLARE total DECIMAL(15,2);
      SELECT SUM(p.Superficie_Total) INTO total
      FROM parque p
      JOIN departamento_parque dp ON p.ID_Parque = dp.ID_Parque
      WHERE dp.ID_Departamento = dep_id;
      RETURN IFNULL(total, 0);
  END //
  DELIMITER ;
  ```
  - **Uso**: `SELECT superficie_por_departamento(1);` (Superficie total en Antioquia).

- Total: 20 en `dql_funciones.sql`.

### **Triggers**
- **Ejemplo**: `actualizar_inventario`
  ```sql
  DELIMITER //
  CREATE TRIGGER actualizar_inventario AFTER INSERT ON inventario_especies
  FOR EACH ROW
  BEGIN
      INSERT INTO log_cambios (Tabla, Accion, Fecha)
      VALUES ('inventario_especies', 'INSERT', NOW());
  END //
  DELIMITER ;
  ```
  - **Uso**: Registra cambios en inventarios automáticamente.

- Total: 20 en `dql_triggers.sql`.

### **Eventos**
- **Ejemplo**: `reporte_semanal_visitantes`
  ```sql
  DELIMITER //
  CREATE EVENT reporte_semanal_visitantes
  ON SCHEDULE EVERY 1 WEEK STARTS '2025-01-01 00:00:00'
  DO
  BEGIN
      INSERT INTO reportes (Reporte, Fecha)
      SELECT CONCAT('Visitantes: ', COUNT(*)), NOW()
      FROM registro_visitantes
      WHERE Fecha_Entrada >= DATE_SUB(NOW(), INTERVAL 7 DAY);
  END //
  DELIMITER ;
  ```
  - **Uso**: Genera reportes automáticos cada semana.

- Total: 20 en `dql_eventos.sql`.

---

## Roles de Usuario y Permisos

Se definieron 5 roles con permisos específicos:

1. **Administrador**:
   - Permisos: Acceso total (SELECT, INSERT, UPDATE, DELETE, EXECUTE en todas las tablas y objetos).
   - Creación:
     ```sql
     CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
     GRANT ALL PRIVILEGES ON parques.* TO 'admin'@'localhost';
     ```

2. **Gestor de Parques**:
   - Permisos: Gestión de parques, áreas y especies (SELECT, INSERT, UPDATE en tablas relacionadas).
   - Creación:
     ```sql
     CREATE USER 'gestor'@'localhost' IDENTIFIED BY 'gestor123';
     GRANT SELECT, INSERT, UPDATE ON parques.parque TO 'gestor'@'localhost';
     GRANT SELECT, INSERT, UPDATE ON parques.area TO 'gestor'@'localhost';
     GRANT SELECT, INSERT, UPDATE ON parques.especies TO 'gestor'@'localhost';
     ```

3. **Investigador**:
   - Permisos: Acceso a proyectos y especies (SELECT en `proyecto_investigacion`, `especies`, etc.).
   - Creación:
     ```sql
     CREATE USER 'investigador'@'localhost' IDENTIFIED BY 'inv123';
     GRANT SELECT ON parques.proyecto_investigacion TO 'investigador'@'localhost';
     GRANT SELECT ON parques.especies TO 'investigador'@'localhost';
     ```

4. **Auditor**:
   - Permisos: Acceso a reportes financieros (SELECT en `proyecto_investigacion`, `personal` para sueldos).
   - Creación:
     ```sql
     CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'audit123';
     GRANT SELECT ON parques.proyecto_investigacion TO 'auditor'@'localhost';
     GRANT SELECT ON parques.personal TO 'auditor'@'localhost';
     ```

5. **Encargado de Visitantes**:
   - Permisos: Gestión de visitantes y alojamientos (SELECT, INSERT, UPDATE en `visitante`, `alojamiento`, `registro_visitantes`).
   - Creación:
     ```sql
     CREATE USER 'encargado'@'localhost' IDENTIFIED BY 'visit123';
     GRANT SELECT, INSERT, UPDATE ON parques.visitante TO 'encargado'@'localhost';
     GRANT SELECT, INSERT, UPDATE ON parques.alojamiento TO 'encargado'@'localhost';
     GRANT SELECT, INSERT, UPDATE ON parques.registro_visitantes TO 'encargado'@'localhost';
     ```

- **Nota**: Ejecuta `FLUSH PRIVILEGES;` después de crear los usuarios.

---

## Contribucion individual

- **[Brayan David Vera Mesa]**: Diseño de la base de datos, creación de tablas, inserción de datos, consultas SQL.

---

## Licencia y Contacto

- **Licencia**: Este proyecto es de uso académico y no tiene licencia comercial. Contacta al equipo para permisos adicionales.

---


### **Instrucciones para Usar la Plantilla**
1. Copia este contenido en un archivo llamado `README.md` en la raíz de tu repositorio.
2. Personaliza las secciones con tu información:
   - Reemplaza `<URL_del_repositorio_privado>` con la URL real.
   - Actualiza los nombres de los integrantes en "Contribuciones".
   - Añade tu correo en "Contacto".
3. Asegúrate de que los archivos SQL (`ddl.sql`, `dml.sql`, etc.) estén en las carpetas correspondientes y mencionados en las instrucciones.
4. Incluye el diagrama entidad-relación como `Diagrama.jpg` (puedes generarlo con MySQL Workbench o herramientas como Draw.io).
