CREATE DATABASE IF NOT EXISTS parques;
USE parques;

-- Entidad Responsable
CREATE TABLE entidad_responsable (
    ID_Entidad INT PRIMARY KEY,
    Nombre_Entidad VARCHAR(100)
);

-- Departamento
CREATE TABLE departamento (
    ID_Departamento INT PRIMARY KEY,
    Nombre_Departamento VARCHAR(100),
    ID_Entidad INT,
    FOREIGN KEY (ID_Entidad) REFERENCES entidad_responsable(ID_Entidad)
);

-- Parque
CREATE TABLE parque (
    ID_Parque INT PRIMARY KEY,
    Nombre_Parque VARCHAR(100),
    Fecha_Declaracion DATE,
    Superficie_Total DECIMAL(15,2)
);

-- Relación Departamento-Parque
CREATE TABLE departamento_parque (
    ID_Departamento INT,
    ID_Parque INT,
    PRIMARY KEY (ID_Departamento, ID_Parque),
    FOREIGN KEY (ID_Departamento) REFERENCES departamento(ID_Departamento),
    FOREIGN KEY (ID_Parque) REFERENCES parque(ID_Parque)
);

-- Área
CREATE TABLE area (
    ID_Area INT PRIMARY KEY,
    Nombre_Area VARCHAR(100),
    Extension DECIMAL(10,2),
    ID_Parque INT,
    FOREIGN KEY (ID_Parque) REFERENCES parque(ID_Parque)
);

-- Especies
CREATE TABLE especies (
    ID_Especie INT PRIMARY KEY,
    Denominacion_Cientifica VARCHAR(100),
    Denominacion_Vulgar VARCHAR(100),
    Tipo ENUM('Vegetal', 'Animal', 'Mineral')
);

-- Inventario de Especies por Área
CREATE TABLE inventario_especies (
    ID_Inventario INT PRIMARY KEY,
    ID_Especie INT,
    ID_Area INT,
    Numero_Individuos INT,
    FOREIGN KEY (ID_Especie) REFERENCES especies(ID_Especie),
    FOREIGN KEY (ID_Area) REFERENCES area(ID_Area)
);

-- Personal
CREATE TABLE personal (
    Numero_Cedula VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion TEXT,
    Telefono VARCHAR(15),
    Telefono_Movil VARCHAR(15),
    Sueldo DECIMAL(10,2),
    Tipo_Personal ENUM('001', '002', '003', '004')
);

-- Vehículos
CREATE TABLE vehiculo (
    ID_Vehiculo INT PRIMARY KEY,
    Tipo_Vehiculo VARCHAR(50),
    Marca VARCHAR(50),
    Numero_Cedula VARCHAR(20),
    FOREIGN KEY (Numero_Cedula) REFERENCES personal(Numero_Cedula)
);

-- Proyecto de Investigación
CREATE TABLE proyecto_investigacion (
    ID_Proyecto INT PRIMARY KEY,
    Presupuesto DECIMAL(15,2),
    Periodo_Realizacion VARCHAR(50)
);

-- Relación Investigador-Proyecto-Especie
CREATE TABLE investigador_proyecto_especie (
    ID_Proyecto INT,
    Numero_Cedula VARCHAR(20),
    ID_Especie INT,
    PRIMARY KEY (ID_Proyecto, Numero_Cedula, ID_Especie),
    FOREIGN KEY (ID_Proyecto) REFERENCES proyecto_investigacion(ID_Proyecto),
    FOREIGN KEY (Numero_Cedula) REFERENCES personal(Numero_Cedula),
    FOREIGN KEY (ID_Especie) REFERENCES especies(ID_Especie)
);

-- Visitante
CREATE TABLE visitante (
    Numero_Cedula VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion TEXT,
    Profesion VARCHAR(100)
);

-- Alojamiento
CREATE TABLE alojamiento (
    ID_Alojamiento INT PRIMARY KEY,
    ID_Parque INT,
    Capacidad INT,
    Categoria VARCHAR(50),
    FOREIGN KEY (ID_Parque) REFERENCES parque(ID_Parque)
);

-- Registro de Visitantes
CREATE TABLE registro_visitantes (
    ID_Registro INT PRIMARY KEY,
    Numero_Cedula VARCHAR(20),
    ID_Alojamiento INT,
    Fecha_Entrada DATE,
    FOREIGN KEY (Numero_Cedula) REFERENCES visitante(Numero_Cedula),
    FOREIGN KEY (ID_Alojamiento) REFERENCES alojamiento(ID_Alojamiento)
);




