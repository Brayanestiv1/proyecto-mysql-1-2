USE parques;

-- Entidad Responsable (5 ejemplos, expande a 50)
INSERT INTO entidad_responsable (ID_Entidad, Nombre_Entidad) VALUES
(1, 'Corporación Ambiental del Norte'),
(2, 'Fundación EcoSur'),
(3, 'Instituto de Conservación Central'),
(4, 'Asociación VerdeVida'),
(5, 'Consejo Ambiental del Este'),
(6, 'Fundación Bosques Vivos'),
(7, 'Corporación Verde Andino'),
(8, 'Instituto EcoPacífico'),
(9, 'Asociación Selva y Río'),
(10, 'Consejo de Sostenibilidad Sur'),
(11, 'Fundación Naturaleza Viva'),
(12, 'Corporación EcoLlanos'),
(13, 'Instituto de Biodiversidad Caribe'),
(14, 'Asociación Protectores del Agua'),
(15, 'Consejo Ambiental Occidental'),
(16, 'Fundación Tierra y Vida'),
(17, 'Corporación Amazónica'),
(18, 'Instituto de Recursos Naturales'),
(19, 'Asociación EcoFuturo'),
(20, 'Consejo Regional del Medio Ambiente'),
(21, 'Fundación EcoRíos'),
(22, 'Corporación Verde Caribe'),
(23, 'Instituto de Fauna Silvestre'),
(24, 'Asociación Amigos de la Selva'),
(25, 'Consejo de Biodiversidad Andina'),
(26, 'Fundación Vida Verde'),
(27, 'Corporación EcoSantander'),
(28, 'Instituto de Protección Amazónica'),
(29, 'AsociaciónGuardianes del Bosque'),
(30, 'Consejo Ambiental del Pacífico'),
(31, 'Fundación Renacer Natural'),
(32, 'Corporación Llanos Verdes'),
(33, 'Instituto de Conservación Costera'),
(34, 'Asociación EcoValle'),
(35, 'Consejo de Recursos Sostenibles'),
(36, 'Fundación Selva Viva'),
(37, 'Corporación Andina Sostenible'),
(38, 'Instituto de Ecosistemas Marinos'),
(39, 'Asociación Protectores del Páramo'),
(40, 'Consejo Ambiental del Suroriente'),
(41, 'Fundación Naturaleza Andina'),
(42, 'Corporación EcoChocó'),
(43, 'Instituto de Restauración Ambiental'),
(44, 'Asociación Verde Amazónico'),
(45, 'Consejo de Gestión Ecológica'),
(46, 'Fundación Bosques del Futuro'),
(47, 'Corporación EcoNorte'),
(48, 'Instituto de Sostenibilidad Regional'),
(49, 'Asociación Amigos del Río'),
(50, 'Consejo Ambiental del Caribe');

-- Departamento (5 ejemplos, expande a 50)
INSERT INTO departamento (ID_Departamento, Nombre_Departamento, ID_Entidad) VALUES
(1, 'Antioquia', 1),
(2, 'Cundinamarca', 3),
(3, 'Chocó', 2),
(4, 'Valle del Cauca', 4),
(5, 'Amazonas', 5),
(6, 'Santander', 6),
(7, 'Boyacá', 7),
(8, 'Nariño', 8),
(9, 'Caquetá', 9),
(10, 'Meta', 10),
(11, 'Atlántico', 11),
(12, 'Bolívar', 12),
(13, 'Caldas', 13),
(14, 'Risaralda', 14),
(15, 'Tolima', 15),
(16, 'Huila', 16),
(17, 'Guaviare', 17),
(18, 'Magdalena', 18),
(19, 'Cesar', 19),
(20, 'Putumayo', 20),
(21, 'Arauca', 21),
(22, 'Casanare', 22),
(23, 'Córdoba', 23),
(24, 'Guainía', 24),
(25, 'La Guajira', 25),
(26, 'Quindío', 26),
(27, 'San Andrés y Providencia', 27),
(28, 'Sucre', 28),
(29, 'Vaupés', 29),
(30, 'Vichada', 30),
(31, 'Bogotá D.C.', 31),
(32, 'Norte de Santander', 32),
(33, 'Cauca', 33),
(34, 'Antioquia Norte', 34),
(35, 'Cundinamarca Sur', 35),
(36, 'Chocó Occidental', 36),
(37, 'Valle del Cauca Norte', 37),
(38, 'Amazonas Sur', 38),
(39, 'Santander Oriente', 39),
(40, 'Boyacá Sur', 40),
(41, 'Nariño Occidental', 41),
(42, 'Caquetá Norte', 42),
(43, 'Meta Occidental', 43),
(44, 'Atlántico Sur', 44),
(45, 'Bolívar Norte', 45),
(46, 'Caldas Oriente', 46),
(47, 'Risaralda Sur', 47),
(48, 'Tolima Norte', 48),
(49, 'Huila Occidental', 49),
(50, 'Magdalena Sur', 50);

-- Parque (5 ejemplos, expande a 50)
INSERT INTO parque (ID_Parque, Nombre_Parque, Fecha_Declaracion, Superficie_Total) VALUES
(1, 'Parque Nacional Natural Tayrona', '1964-04-24', 15000.50),
(2, 'Parque Nacional Natural Los Nevados', '1973-08-15', 58300.00),
(3, 'Parque Nacional Natural Amacayacu', '1975-09-10', 293500.75),
(4, 'Parque Nacional Natural Farallones', '1968-03-01', 20500.25),
(5, 'Parque Nacional Natural Sierra Nevada', '1964-06-12', 383000.00),
(6, 'Parque Nacional Natural Chingaza', '1977-08-01', 76600.00),
(7, 'Parque Nacional Natural El Cocuy', '1977-04-15', 306000.00),
(8, 'Parque Nacional Natural Gorgona', '1984-06-20', 62000.50),
(9, 'Parque Nacional Natural Puracé', '1961-09-10', 83000.25),
(10, 'Parque Nacional Natural Sumapaz', '1977-05-25', 154000.75),
(11, 'Parque Nacional Natural Katíos', '1974-11-30', 72000.00),
(12, 'Parque Nacional Natural Utría', '1987-10-15', 54300.50),
(13, 'Parque Nacional Natural Munchique', '1977-03-05', 44000.25),
(14, 'Parque Nacional Natural Cahuinarí', '1987-09-20', 575500.00),
(15, 'Parque Nacional Natural Tinigua', '1989-08-10', 201875.50),
(16, 'Parque Nacional Natural Macuira', '1977-12-01', 25000.00),
(17, 'Parque Nacional Natural Paramillo', '1977-06-15', 460500.75),
(18, 'Parque Nacional Natural Las Hermosas', '1977-05-30', 125000.25),
(19, 'Parque Nacional Natural Old Providence', '1995-03-15', 98500.50),
(20, 'Parque Nacional Natural Corales del Rosario', '1977-04-25', 120000.00),
(21, 'Parque Nacional Natural Pisba', '1977-07-10', 45000.00),
(22, 'Parque Nacional Natural Serranía de La Macarena', '1989-04-15', 630000.50),
(23, 'Parque Nacional Natural El Tuparro', '1980-08-20', 548000.00),
(24, 'Parque Nacional Natural Isla de Salamanca', '1964-11-05', 56200.25),
(25, 'Parque Nacional Natural Sierra de la Macarena', '1971-06-30', 130000.75),
(26, 'Parque Nacional Natural Tamá', '1977-06-10', 48000.00),
(27, 'Parque Nacional Natural Bahía Portete', '2014-09-25', 14000.50),
(28, 'Parque Nacional Natural Los Flamencos', '1998-02-15', 7000.25),
(29, 'Parque Nacional Natural Sanquianga', '1977-08-05', 80000.00),
(30, 'Parque Nacional Natural Río Puré', '2002-09-10', 999795.50),
(31, 'Parque Nacional Natural Los Katíos Norte', '1980-03-15', 65000.75), -- Ficticio (subdivisión)
(32, 'Parque Nacional Natural Alto Fragua', '2002-02-25', 68000.00),
(33, 'Parque Nacional Natural Yariguíes', '2005-05-20', 78000.25),
(34, 'Parque Nacional Natural Selva de Florencia', '2005-08-15', 10000.50),
(35, 'Parque Nacional Natural Las Orquídeas', '1977-04-20', 32000.00),
(36, 'Parque Nacional Natural Tatamá', '1987-06-10', 51900.75),
(37, 'Parque Nacional Natural Sierra Nevada Sur', '1970-09-05', 250000.00), -- Ficticio (subdivisión)
(38, 'Parque Nacional Natural Puinawai', '1989-09-15', 1092500.25),
(39, 'Parque Nacional Natural Los Picachos', '1977-05-15', 286000.50),
(40, 'Parque Nacional Natural Cordillera de los Picachos', '1977-08-20', 445000.00),
(41, 'Parque Nacional Natural Tayrona Norte', '1975-03-10', 12000.75), -- Ficticio (subdivisión)
(42, 'Parque Nacional Natural Serranía del Baudó', '2000-06-25', 85000.00),
(43, 'Parque Nacional Natural Río Atrato', '1995-11-15', 45000.25), -- Ficticio
(44, 'Parque Nacional Natural Laguna de Sonso', '1985-04-10', 2045.50),
(45, 'Parque Nacional Natural Alto Putumayo', '1990-07-20', 35000.00), -- Ficticio
(46, 'Parque Nacional Natural Bosque Seco del Patía', '1980-12-05', 15000.75), -- Ficticio
(47, 'Parque Nacional Natural Cañón del Chicamocha', '2000-03-15', 25000.00), -- Ficticio
(48, 'Parque Nacional Natural Selva del Darién', '1985-09-25', 72000.50), -- Ficticio
(49, 'Parque Nacional Natural Páramo de Santurbán', '1995-06-10', 65000.25),
(50, 'Parque Nacional Natural Costa del Pacífico', '1980-08-15', 30000.00); -- Ficticio

-- Relación Departamento-Parque (10 ejemplos, expande a 50+)
INSERT INTO departamento_parque (ID_Departamento, ID_Parque) VALUES
(1, 1),   -- Antioquia - Tayrona
(1, 5),   -- Antioquia - Sierra Nevada
(2, 2),   -- Cundinamarca - Los Nevados
(3, 3),   -- Chocó - Amacayacu
(4, 4),   -- Valle del Cauca - Farallones
(5, 3),   -- Amazonas - Amacayacu
(2, 5),   -- Cundinamarca - Sierra Nevada
(3, 4),   -- Chocó - Farallones
(1, 2),   -- Antioquia - Los Nevados
(4, 5),   -- Valle del Cauca - Sierra Nevada
(6, 6),   -- Santander - Chingaza
(7, 7),   -- Boyacá - El Cocuy
(8, 8),   -- Nariño - Gorgona
(9, 9),   -- Caquetá - Puracé
(10, 10), -- Meta - Sumapaz
(11, 11), -- Atlántico - Katíos
(12, 12), -- Bolívar - Utría
(13, 13), -- Caldas - Munchique
(14, 14), -- Risaralda - Cahuinarí
(15, 15), -- Tolima - Tinigua
(16, 16), -- Huila - Macuira
(17, 17), -- Guaviare - Paramillo
(18, 18), -- Magdalena - Las Hermosas
(19, 19), -- Cesar - Old Providence
(20, 20), -- Putumayo - Corales del Rosario
(21, 21), -- Arauca - Pisba
(22, 22), -- Casanare - Serranía de La Macarena
(23, 23), -- Córdoba - El Tuparro
(24, 24), -- Guainía - Isla de Salamanca
(25, 25), -- La Guajira - Sierra de la Macarena
(26, 26), -- Quindío - Tamá
(27, 27), -- San Andrés y Providencia - Bahía Portete
(28, 28), -- Sucre - Los Flamencos
(29, 29), -- Vaupés - Sanquianga
(30, 30), -- Vichada - Río Puré
(31, 31), -- Bogotá D.C. - Los Katíos Norte
(32, 32), -- Norte de Santander - Alto Fragua
(33, 33), -- Cauca - Yariguíes
(34, 34), -- Antioquia Norte - Selva de Florencia
(35, 35), -- Cundinamarca Sur - Las Orquídeas
(36, 36), -- Chocó Occidental - Tatamá
(37, 37), -- Valle del Cauca Norte - Sierra Nevada Sur
(38, 38), -- Amazonas Sur - Puinawai
(39, 39), -- Santander Oriente - Los Picachos
(40, 40), -- Boyacá Sur - Cordillera de los Picachos
(41, 41), -- Nariño Occidental - Tayrona Norte
(42, 42), -- Caquetá Norte - Serranía del Baudó
(43, 43), -- Meta Occidental - Río Atrato
(44, 44), -- Atlántico Sur - Laguna de Sonso
(45, 45), -- Bolívar Norte - Alto Putumayo
(46, 46), -- Caldas Oriente - Bosque Seco del Patía
(47, 47), -- Risaralda Sur - Cañón del Chicamocha
(48, 48), -- Tolima Norte - Selva del Darién
(49, 49), -- Huila Occidental - Páramo de Santurbán
(50, 50); -- Magdalena Sur - Costa del Pacífico

-- Área (10 ejemplos, expande a 50)
INSERT INTO area (ID_Area, Nombre_Area, Extension, ID_Parque) VALUES
(1, 'Zona Costera', 5000.25, 1),           -- Tayrona
(2, 'Bosque Altoandino', 12000.00, 2),     -- Los Nevados
(3, 'Selva Amazónica Norte', 100000.50, 3),-- Amacayacu
(4, 'Zona de Farallones', 8000.75, 4),     -- Farallones
(5, 'Páramo Sierra', 15000.00, 5),         -- Sierra Nevada
(6, 'Playa Central', 3000.10, 1),          -- Tayrona
(7, 'Nevado del Ruiz', 20000.30, 2),       -- Los Nevados
(8, 'Río Amacayacu', 50000.20, 3),         -- Amacayacu
(9, 'Cañón Oeste', 6000.50, 4),            -- Farallones
(10, 'Glaciar Este', 18000.00, 5),         -- Sierra Nevada
(11, 'Laguna de Chingaza', 25000.75, 6),   -- Chingaza
(12, 'Pico El Cocuy', 45000.00, 7),        -- El Cocuy
(13, 'Costa Gorgona', 30000.50, 8),        -- Gorgona
(14, 'Volcán Puracé', 35000.25, 9),        -- Puracé
(15, 'Páramo Sumapaz', 60000.00, 10),      -- Sumapaz
(16, 'Selva Katíos', 40000.75, 11),        -- Katíos
(17, 'Bahía Utría', 20000.50, 12),         -- Utría
(18, 'Bosque Munchique', 15000.25, 13),    -- Munchique
(19, 'Río Cahuinarí', 200000.00, 14),      -- Cahuinarí
(20, 'Llanura Tinigua', 80000.50, 15),     -- Tinigua
(21, 'Bosque Seco', 12000.75, 16),         -- Macuira
(22, 'Llanura Paramillo', 180000.00, 17),  -- Paramillo
(23, 'Cañón Hermosas', 45000.25, 18),      -- Las Hermosas
(24, 'Arrecifes Coralinos', 60000.50, 19), -- Old Providence
(25, 'Manglares Rosario', 35000.00, 20),   -- Corales del Rosario
(26, 'Páramo Pisba', 20000.75, 21),        -- Pisba
(27, 'Selva Macarena', 250000.50, 22),     -- Serranía de La Macarena
(28, 'Río Tuparro', 300000.00, 23),        -- El Tuparro
(29, 'Laguna Salamanca', 40000.25, 24),    -- Isla de Salamanca
(30, 'Sierra Macarena Oeste', 65000.50, 25),-- Sierra de la Macarena
(31, 'Bosque Tamá', 22000.00, 26),         -- Tamá
(32, 'Bahía Portete Norte', 8000.75, 27),  -- Bahía Portete
(33, 'Flamencos Costeros', 5000.25, 28),   -- Los Flamencos
(34, 'Manglares Sanquianga', 45000.50, 29),-- Sanquianga
(35, 'Río Puré Central', 500000.00, 30),   -- Río Puré
(36, 'Selva Katíos Norte', 30000.75, 31),  -- Los Katíos Norte
(37, 'Alto Fragua Central', 35000.25, 32), -- Alto Fragua
(38, 'Yariguíes Occidental', 40000.50, 33),-- Yariguíes
(39, 'Selva Florencia', 7000.00, 34),      -- Selva de Florencia
(40, 'Orquídeas Norte', 15000.25, 35),     -- Las Orquídeas
(41, 'Pico Tatamá', 25000.50, 36),         -- Tatamá
(42, 'Sierra Nevada Sur', 120000.00, 37),  -- Sierra Nevada Sur
(43, 'Puinawai Central', 600000.75, 38),   -- Puinawai
(44, 'Picachos Este', 150000.25, 39),      -- Los Picachos
(45, 'Cordillera Picachos Norte', 200000.50, 40), -- Cordillera de los Picachos
(46, 'Tayrona Occidental', 6000.00, 41),   -- Tayrona Norte
(47, 'Baudó Central', 40000.75, 42),       -- Serranía del Baudó
(48, 'Río Atrato Sur', 20000.25, 43),      -- Río Atrato
(49, 'Laguna Sonso Oeste', 1000.50, 44),   -- Laguna de Sonso
(50, 'Putumayo Alto', 18000.00, 45);       -- Alto Putumayo

-- Especies (10 ejemplos, expande a 50)
INSERT INTO especies (ID_Especie, Denominacion_Cientifica, Denominacion_Vulgar, Tipo) VALUES
(1, 'Panthera onca', 'Jaguar', 'Animal'),
(2, 'Ceiba pentandra', 'Ceiba', 'Vegetal'),
(3, 'Ara macao', 'Guacamaya Roja', 'Animal'),
(4, 'Quercus robur', 'Roble', 'Vegetal'),
(5, 'Puma concolor', 'Puma', 'Animal'),
(6, 'Orchidaceae', 'Orquídea', 'Vegetal'),
(7, 'Caiman crocodilus', 'Caimán', 'Animal'),
(8, 'Ficus carica', 'Higuera', 'Vegetal'),
(9, 'Quartz', 'Cuarzo', 'Mineral'),
(10, 'Tapirus terrestris', 'Tapir', 'Animal'),
(11, 'Eunectes murinus', 'Anaconda', 'Animal'),
(12, 'Cedrela odorata', 'Cedro', 'Vegetal'),
(13, 'Amethyst', 'Amatista', 'Mineral'),
(14, 'Tremarctos ornatus', 'Oso de Anteojos', 'Animal'),
(15, 'Bromelia pinguin', 'Bromelia', 'Vegetal'),
(16, 'Priodontes maximus', 'Armadillo Gigante', 'Animal'),
(17, 'Swietenia macrophylla', 'Caoba', 'Vegetal'),
(18, 'Pyrite', 'Pirita', 'Mineral'),
(19, 'Harpyhaliaetus solitarius', 'Águila Solitaria', 'Animal'),
(20, 'Cattleya trianae', 'Flor de Mayo', 'Vegetal'),
(21, 'Bradypus variegatus', 'Perezoso de Tres Dedos', 'Animal'),
(22, 'Tabebuia rosea', 'Roble Rosado', 'Vegetal'),
(23, 'Crocodylus acutus', 'Cocodrilo Americano', 'Animal'),
(24, 'Calcite', 'Calcita', 'Mineral'),
(25, 'Dendrobates tinctorius', 'Rana Venenosa', 'Animal'),
(26, 'Euterpe oleracea', 'Palma de Açaí', 'Vegetal'),
(27, 'Leopardus pardalis', 'Ocelote', 'Animal'),
(28, 'Hevea brasiliensis', 'Árbol de Caucho', 'Vegetal'),
(29, 'Feldspar', 'Feldespato', 'Mineral'),
(30, 'Ateles geoffroyi', 'Mono Araña', 'Animal'),
(31, 'Heliconia rostrata', 'Platanillo', 'Vegetal'),
(32, 'Boa constrictor', 'Boa', 'Animal'),
(33, 'Guaiacum officinale', 'Guayacán', 'Vegetal'),
(34, 'Magnetite', 'Magnetita', 'Mineral'),
(35, 'Cebus capucinus', 'Mono Cariblanco', 'Animal'),
(36, 'Anthurium andraeanum', 'Anturio', 'Vegetal'),
(37, 'Saimiri sciureus', 'Mono Ardilla', 'Animal'),
(38, 'Miconia albicans', 'Canela de Venado', 'Vegetal'),
(39, 'Gypsum', 'Yeso', 'Mineral'),
(40, 'Morpho peleides', 'Mariposa Morfo', 'Animal'),
(41, 'Pterocarpus officinalis', 'Sangre de Drago', 'Vegetal'),
(42, 'Hydrochoerus hydrochaeris', 'Capybara', 'Animal'),
(43, 'Inga edulis', 'Guaba', 'Vegetal'),
(44, 'Mica', 'Mica', 'Mineral'),
(45, 'Agouti paca', 'Ñeque', 'Animal'),
(46, 'Carapa guianensis', 'Andiroba', 'Vegetal'),
(47, 'Bothrops asper', 'Terciopelo', 'Animal'),
(48, 'Aristolochia grandiflora', 'Flor de Pato', 'Vegetal'),
(49, 'Hematite', 'Hematita', 'Mineral'),
(50, 'Tamandua tetradactyla', 'Oso Hormiguero', 'Animal');

-- Inventario de Especies por Área (10 ejemplos, expande a 50)
INSERT INTO inventario_especies (ID_Inventario, ID_Especie, ID_Area, Numero_Individuos) VALUES
(1, 1, 3, 15),    -- Jaguar en Selva Amazónica Norte
(2, 2, 1, 50),    -- Ceiba en Zona Costera
(3, 3, 5, 30),    -- Guacamaya Roja en Páramo Sierra
(4, 4, 2, 20),    -- Roble en Bosque Altoandino
(5, 5, 4, 10),    -- Puma en Zona de Farallones
(6, 6, 3, 100),   -- Orquídea en Selva Amazónica Norte
(7, 7, 8, 25),    -- Caimán en Río Amacayacu
(8, 8, 9, 15),    -- Higuera en Cañón Oeste
(9, 9, 10, 200),  -- Cuarzo en Glaciar Este
(10, 10, 7, 5),   -- Tapir en Nevado del Ruiz
(11, 11, 16, 8),  -- Anaconda en Selva Katíos
(12, 12, 11, 40), -- Cedro en Laguna de Chingaza
(13, 13, 12, 150),-- Amatista en Bahía Utría
(14, 14, 5, 12),  -- Oso de Anteojos en Páramo Sierra
(15, 15, 15, 60), -- Bromelia en Páramo Sumapaz
(16, 16, 19, 4),  -- Armadillo Gigante en Río Cahuinarí
(17, 17, 18, 25), -- Caoba en Bosque Munchique
(18, 18, 17, 100),-- Pirita en Bahía Utría
(19, 19, 13, 10), -- Águila Solitaria en Costa Gorgona
(20, 20, 14, 80), -- Flor de Mayo en Volcán Puracé
(21, 21, 21, 20),    -- Perezoso de Tres Dedos en Bosque Seco
(22, 22, 22, 35),    -- Roble Rosado en Llanura Paramillo
(23, 23, 23, 8),     -- Cocodrilo Americano en Cañón Hermosas
(24, 24, 24, 300),   -- Calcita en Arrecifes Coralinos
(25, 25, 25, 50),    -- Rana Venenosa en Manglares Rosario
(26, 26, 26, 70),    -- Palma de Açaí en Páramo Pisba
(27, 27, 27, 12),    -- Ocelote en Selva Macarena
(28, 28, 28, 25),    -- Árbol de Caucho en Río Tuparro
(29, 29, 29, 150),   -- Feldespato en Laguna Salamanca
(30, 30, 30, 15),    -- Mono Araña en Sierra Macarena Oeste
(31, 31, 31, 60),    -- Platanillo en Bosque Tamá
(32, 32, 32, 10),    -- Boa en Bahía Portete Norte
(33, 33, 33, 40),    -- Guayacán en Flamencos Costeros
(34, 34, 34, 200),   -- Magnetita en Manglares Sanquianga
(35, 35, 35, 25),    -- Mono Cariblanco en Río Puré Central
(36, 36, 36, 80),    -- Anturio en Selva Katíos Norte
(37, 37, 37, 30),    -- Mono Ardilla en Alto Fragua Central
(38, 38, 38, 45),    -- Canela de Venado en Yariguíes Occidental
(39, 39, 39, 100),   -- Yeso en Selva Florencia
(40, 40, 40, 200),   -- Mariposa Morfo en Orquídeas Norte
(41, 41, 41, 20),    -- Sangre de Drago en Pico Tatamá
(42, 42, 42, 50),    -- Capybara en Sierra Nevada Sur
(43, 43, 43, 30),    -- Guaba en Puinawai Central
(44, 44, 44, 250),   -- Mica en Picachos Este
(45, 45, 45, 15),    -- Ñeque en Cordillera Picachos Norte
(46, 46, 46, 35),    -- Andiroba en Tayrona Occidental
(47, 47, 47, 5),     -- Terciopelo en Baudó Central
(48, 48, 48, 60),    -- Flor de Pato en Río Atrato Sur
(49, 49, 49, 120),   -- Hematita en Laguna Sonso Oeste
(50, 50, 50, 8);     -- Oso Hormiguero en Putumayo Alto

-- Personal (10 ejemplos, expande a 50)
INSERT INTO personal (Numero_Cedula, Nombre, Direccion, Telefono, Telefono_Movil, Sueldo, Tipo_Personal) VALUES
('12345678', 'Juan Pérez', 'Calle 10 #5-20, Medellín', '6041234567', '3101234567', 2500000.00, '001'),
('23456789', 'María Gómez', 'Carrera 15 #22-10, Bogotá', '6012345678', '3202345678', 3000000.00, '002'),
('34567890', 'Carlos López', 'Avenida 5 #8-15, Cali', '6023456789', '3153456789', 2800000.00, '003'),
('45678901', 'Ana Martínez', 'Calle 3 #12-30, Leticia', '6084567890', '3174567890', 3500000.00, '004'),
('56789012', 'Pedro Sánchez', 'Carrera 20 #15-25, Santa Marta', '6055678901', '3185678901', 2600000.00, '001'),
('67890123', 'Laura Ramírez', 'Calle 8 #10-40, Manizales', '6066789012', '3196789012', 3200000.00, '002'),
('78901234', 'Diego Torres', 'Avenida 3 #7-15, Quibdó', '6047890123', '3147890123', 2900000.00, '003'),
('89012345', 'Sofía Díaz', 'Carrera 12 #9-10, Pereira', '6068901234', '3168901234', 3400000.00, '004'),
('90123456', 'Luis Vargas', 'Calle 15 #4-20, Barranquilla', '6059012345', '3139012345', 2700000.00, '001'),
('01234567', 'Clara Rojas', 'Avenida 7 #11-30, Popayán', '6020123456', '3120123456', 3100000.00, '002'),
('11223344', 'Andrés Morales', 'Calle 25 #10-15, Bucaramanga', '6071122334', '3112233445', 2550000.00, '001'),
('22334455', 'Valeria Ortiz', 'Carrera 8 #5-20, Villavicencio', '6082233445', '3223344556', 3050000.00, '002'),
('33445566', 'Felipe Castro', 'Avenida 12 #3-10, Pasto', '6023344556', '3134455667', 2850000.00, '003'),
('44556677', 'Camila Herrera', 'Calle 7 #15-25, Neiva', '6084455667', '3145566778', 3550000.00, '004'),
('55667788', 'Julián Pineda', 'Carrera 20 #9-30, Cartagena', '6055566778', '3156677889', 2650000.00, '001'),
('66778899', 'Natalia Silva', 'Avenida 5 #8-15, Ibagué', '6086677889', '3167788990', 3150000.00, '002'),
('77889900', 'Santiago Mejía', 'Calle 10 #4-20, Armenia', '6067788990', '3178899001', 2950000.00, '003'),
('88990011', 'Isabela Cruz', 'Carrera 15 #12-10, Tunja', '6088899001', '3189900112', 3450000.00, '004'),
('99001122', 'Mateo Rincón', 'Avenida 3 #7-25, Sincelejo', '6059900112', '3190011223', 2750000.00, '001'),
('00112233', 'Paula Escobar', 'Calle 8 #11-30, Florencia', '6080011223', '3101122334', 3250000.00, '002'),
('11113333', 'Diego Salazar', 'Calle 5 #10-15, Valledupar', '6051111333', '3111133334', 2600000.00, '001'),
('22224444', 'Lucía Mendoza', 'Carrera 9 #7-20, Montería', '6042222444', '3222244445', 3100000.00, '002'),
('33335555', 'Gabriel Torres', 'Avenida 6 #12-30, Bucaramanga', '6073333555', '3133355556', 2900000.00, '003'),
('44446666', 'Sara Ramírez', 'Calle 12 #8-25, Villavicencio', '6084444666', '3144466667', 3500000.00, '004'),
('55557777', 'Juan Camilo Díaz', 'Carrera 18 #5-10, Pasto', '6025555777', '3155577778', 2700000.00, '001'),
('66668888', 'Laura Valencia', 'Avenida 4 #9-15, Neiva', '6086666888', '3166688889', 3200000.00, '002'),
('77779999', 'Carlos Gómez', 'Calle 15 #3-20, Cartagena', '6057777999', '3177799990', 3000000.00, '003'),
('88880000', 'Mariana López', 'Carrera 10 #11-30, Ibagué', '6088888000', '3188800001', 3400000.00, '004'),
('99991111', 'Sebastián Pardo', 'Avenida 7 #6-25, Armenia', '6069999111', '3199911112', 2650000.00, '001'),
('00002222', 'Elena Castillo', 'Calle 9 #14-10, Tunja', '6080000222', '3100022223', 3150000.00, '002'),
('11114444', 'Andrés Castillo', 'Calle 20 #5-15, Medellín', '6041111444', '3111144445', 2550000.00, '001'),
('22225555', 'Valentina Muñoz', 'Carrera 7 #10-20, Bogotá', '6012222555', '3222255556', 3050000.00, '002'),
('33336666', 'Felipe Rojas', 'Avenida 8 #4-30, Cali', '6023333666', '3133366667', 2850000.00, '003'),
('44447777', 'Camila Gómez', 'Calle 6 #13-25, Leticia', '6084444777', '3144477778', 3550000.00, '004'),
('55558888', 'Julián Morales', 'Carrera 25 #8-10, Santa Marta', '6055555888', '3155588889', 2750000.00, '001'),
('66669999', 'Natalia Ortiz', 'Avenida 3 #12-15, Manizales', '6066666999', '3166699990', 3250000.00, '002'),
('77770000', 'Santiago Castro', 'Calle 11 #6-20, Quibdó', '6047777000', '3177700001', 2950000.00, '003'),
('88881111', 'Isabela Pineda', 'Carrera 14 #7-30, Pereira', '6068888111', '3188811112', 3450000.00, '004'),
('99992222', 'Mateo Silva', 'Avenida 2 #9-25, Barranquilla', '6059999222', '3199922223', 2600000.00, '001'),
('00003333', 'Paula Mejía', 'Calle 7 #11-10, Popayán', '6020000333', '3100033334', 3100000.00, '002'),
('11115555', 'Diego Ramírez', 'Calle 18 #4-15, Valledupar', '6051111555', '3111155556', 2700000.00, '001'),
('22226666', 'Lucía Torres', 'Carrera 6 #8-20, Montería', '6042222666', '3222266667', 3200000.00, '002'),
('33337777', 'Gabriel Herrera', 'Avenida 5 #10-30, Bucaramanga', '6073333777', '3133377778', 3000000.00, '003'),
('44448888', 'Sara Valencia', 'Calle 13 #9-25, Villavicencio', '6084444888', '3144488889', 3400000.00, '004'),
('55559999', 'Juan Camilo López', 'Carrera 17 #6-10, Pasto', '6025555999', '3155599990', 2650000.00, '001'),
('66660000', 'Laura Pardo', 'Avenida 6 #8-15, Neiva', '6086666000', '3166600001', 3150000.00, '002'),
('77771111', 'Carlos Muñoz', 'Calle 14 #5-20, Cartagena', '6057777111', '3177711112', 2900000.00, '003'),
('88882222', 'Mariana Castillo', 'Carrera 11 #10-30, Ibagué', '6088888222', '3188822223', 3500000.00, '004'),
('99993333', 'Sebastián Gómez', 'Avenida 8 #7-25, Armenia', '6069999333', '3199933334', 2750000.00, '001'),
('00004444', 'Elena Morales', 'Calle 10 #12-10, Tunja', '6080000444', '3100044445', 3250000.00, '002');

-- Vehículos (5 ejemplos para vigilancia, expande a 50)
INSERT INTO vehiculo (ID_Vehiculo, Tipo_Vehiculo, Marca, Numero_Cedula) VALUES
(1, 'Camioneta', 'Toyota', '23456789'),    -- María Gómez (Vigilancia)
(2, 'Moto', 'Yamaha', '67890123'),         -- Laura Ramírez (Vigilancia)
(3, 'Jeep', 'Land Rover', '01234567'),     -- Clara Rojas (Vigilancia)
(4, 'Camioneta', 'Ford', '23456789'),      -- María Gómez (Vigilancia)
(5, 'Moto', 'Honda', '67890123'),          -- Laura Ramírez (Vigilancia)
(6, 'Camioneta', 'Nissan', '22334455'),    -- Valeria Ortiz (Vigilancia)
(7, 'Moto', 'Suzuki', '66778899'),         -- Natalia Silva (Vigilancia)
(8, 'Jeep', 'Jeep', '00112233'),           -- Paula Escobar (Vigilancia)
(9, 'Camioneta', 'Chevrolet', '22334455'), -- Valeria Ortiz (Vigilancia)
(10, 'Moto', 'Kawasaki', '66778899'),      -- Natalia Silva (Vigilancia)
(11, 'Camioneta', 'Toyota', '01234567'),   -- Clara Rojas (Vigilancia)
(12, 'Moto', 'Yamaha', '23456789'),        -- María Gómez (Vigilancia)
(13, 'Jeep', 'Land Rover', '67890123'),    -- Laura Ramírez (Vigilancia)
(14, 'Camioneta', 'Ford', '22334455'),     -- Valeria Ortiz (Vigilancia)
(15, 'Moto', 'Honda', '00112233'),         -- Paula Escobar (Vigilancia)
(16, 'Camioneta', 'Nissan', '66778899'),   -- Natalia Silva (Vigilancia)
(17, 'Moto', 'Suzuki', '01234567'),        -- Clara Rojas (Vigilancia)
(18, 'Jeep', 'Jeep', '23456789'),          -- María Gómez (Vigilancia)
(19, 'Camioneta', 'Chevrolet', '67890123'),-- Laura Ramírez (Vigilancia)
(20, 'Moto', 'Kawasaki', '22334455'),      -- Valeria Ortiz (Vigilancia)
(21, 'Camioneta', 'Toyota', '22224444'),    -- Lucía Mendoza (Vigilancia)
(22, 'Moto', 'Yamaha', '66668888'),         -- Laura Valencia (Vigilancia)
(23, 'Jeep', 'Land Rover', '00002222'),     -- Elena Castillo (Vigilancia)
(24, 'Camioneta', 'Ford', '22225555'),      -- Valentina Muñoz (Vigilancia)
(25, 'Moto', 'Honda', '66669999'),          -- Natalia Ortiz (Vigilancia)
(26, 'Camioneta', 'Nissan', '00003333'),    -- Paula Mejía (Vigilancia)
(27, 'Moto', 'Suzuki', '22226666'),         -- Lucía Torres (Vigilancia)
(28, 'Jeep', 'Jeep', '66660000'),           -- Laura Pardo (Vigilancia)
(29, 'Camioneta', 'Chevrolet', '00004444'), -- Elena Morales (Vigilancia)
(30, 'Moto', 'Kawasaki', '22224444'),       -- Lucía Mendoza (Vigilancia)
(31, 'Camioneta', 'Toyota', '66668888'),    -- Laura Valencia (Vigilancia)
(32, 'Moto', 'Yamaha', '00002222'),         -- Elena Castillo (Vigilancia)
(33, 'Jeep', 'Land Rover', '22225555'),     -- Valentina Muñoz (Vigilancia)
(34, 'Camioneta', 'Ford', '66669999'),      -- Natalia Ortiz (Vigilancia)
(35, 'Moto', 'Honda', '00003333'),          -- Paula Mejía (Vigilancia)
(36, 'Camioneta', 'Nissan', '22226666'),    -- Lucía Torres (Vigilancia)
(37, 'Moto', 'Suzuki', '66660000'),         -- Laura Pardo (Vigilancia)
(38, 'Jeep', 'Jeep', '00004444'),           -- Elena Morales (Vigilancia)
(39, 'Camioneta', 'Chevrolet', '23456789'), -- María Gómez (Vigilancia)
(40, 'Moto', 'Kawasaki', '67890123'),       -- Laura Ramírez (Vigilancia)
(41, 'Camioneta', 'Toyota', '22334455'),    -- Valeria Ortiz (Vigilancia)
(42, 'Moto', 'Yamaha', '66778899'),         -- Natalia Silva (Vigilancia)
(43, 'Jeep', 'Land Rover', '01234567'),     -- Clara Rojas (Vigilancia)
(44, 'Camioneta', 'Ford', '00112233'),      -- Paula Escobar (Vigilancia)
(45, 'Moto', 'Honda', '22224444'),          -- Lucía Mendoza (Vigilancia)
(46, 'Camioneta', 'Nissan', '66668888'),    -- Laura Valencia (Vigilancia)
(47, 'Moto', 'Suzuki', '00002222'),         -- Elena Castillo (Vigilancia)
(48, 'Jeep', 'Jeep', '22225555'),           -- Valentina Muñoz (Vigilancia)
(49, 'Camioneta', 'Chevrolet', '66669999'), -- Natalia Ortiz (Vigilancia)
(50, 'Moto', 'Kawasaki', '00003333');       -- Paula Mejía (Vigilancia)

-- Proyecto de Investigación (5 ejemplos, expande a 50)
INSERT INTO proyecto_investigacion (ID_Proyecto, Presupuesto, Periodo_Realizacion) VALUES
(1, 50000000.00, '2023-01-01 al 2023-12-31'),
(2, 75000000.00, '2024-03-01 al 2025-02-28'),
(3, 30000000.00, '2023-06-01 al 2024-05-31'),
(4, 90000000.00, '2024-01-01 al 2025-12-31'),
(5, 60000000.00, '2023-09-01 al 2024-08-31'),
(6, 45000000.00, '2023-02-01 al 2023-11-30'),
(7, 82000000.00, '2024-05-01 al 2025-04-30'),
(8, 35000000.00, '2023-07-01 al 2024-06-30'),
(9, 67000000.00, '2024-02-01 al 2025-01-31'),
(10, 55000000.00, '2023-10-01 al 2024-09-30'),
(11, 72000000.00, '2023-03-01 al 2024-02-29'),
(12, 40000000.00, '2024-06-01 al 2025-05-31'),
(13, 88000000.00, '2023-08-01 al 2024-07-31'),
(14, 63000000.00, '2024-04-01 al 2025-03-31'),
(15, 49000000.00, '2023-11-01 al 2024-10-31'),
(16, 95000000.00, '2024-07-01 al 2025-06-30'),
(17, 38000000.00, '2023-04-01 al 2024-03-31'),
(18, 70000000.00, '2024-08-01 al 2025-07-31'),
(19, 52000000.00, '2023-12-01 al 2024-11-30'),
(20, 85000000.00, '2024-09-01 al 2025-08-31'),
(21, 47000000.00, '2023-05-01 al 2024-04-30'),
(22, 78000000.00, '2024-10-01 al 2025-09-30'),
(23, 33000000.00, '2023-02-15 al 2024-02-14'),
(24, 91000000.00, '2024-11-01 al 2025-10-31'),
(25, 62000000.00, '2023-07-15 al 2024-07-14'),
(26, 43000000.00, '2023-03-01 al 2024-02-29'),
(27, 84000000.00, '2024-12-01 al 2025-11-30'),
(28, 36000000.00, '2023-08-15 al 2024-08-14'),
(29, 69000000.00, '2024-01-15 al 2025-01-14'),
(30, 58000000.00, '2023-09-15 al 2024-09-14'),
(31, 74000000.00, '2023-04-15 al 2024-04-14'),
(32, 41000000.00, '2024-02-15 al 2025-02-14'),
(33, 86000000.00, '2023-10-15 al 2024-10-14'),
(34, 65000000.00, '2024-03-15 al 2025-03-14'),
(35, 51000000.00, '2023-11-15 al 2024-11-14'),
(36, 97000000.00, '2024-04-15 al 2025-04-14'),
(37, 39000000.00, '2023-12-15 al 2024-12-14'),
(38, 71000000.00, '2024-05-15 al 2025-05-14'),
(39, 53000000.00, '2023-01-15 al 2024-01-14'),
(40, 87000000.00, '2024-06-15 al 2025-06-14'),
(41, 46000000.00, '2023-06-15 al 2024-06-14'),
(42, 79000000.00, '2024-07-15 al 2025-07-14'),
(43, 34000000.00, '2023-02-01 al 2024-01-31'),
(44, 92000000.00, '2024-08-15 al 2025-08-14'),
(45, 61000000.00, '2023-03-15 al 2024-03-14'),
(46, 44000000.00, '2023-04-01 al 2024-03-31'),
(47, 83000000.00, '2024-09-15 al 2025-09-14'),
(48, 37000000.00, '2023-05-15 al 2024-05-14'),
(49, 68000000.00, '2024-10-15 al 2025-10-14'),
(50, 56000000.00, '2023-06-01 al 2024-05-31');

-- Relación Investigador-Proyecto-Especie (10 ejemplos, expande a 50)
INSERT INTO investigador_proyecto_especie (ID_Proyecto, Numero_Cedula, ID_Especie) VALUES
(1, '45678901', 1),   -- Ana Martínez - Jaguar
(1, '89012345', 2),   -- Sofía Díaz - Ceiba
(2, '45678901', 3),   -- Ana Martínez - Guacamaya Roja
(2, '89012345', 4),   -- Sofía Díaz - Roble
(3, '45678901', 5),   -- Ana Martínez - Puma
(4, '89012345', 6),   -- Sofía Díaz - Orquídea
(5, '45678901', 7),   -- Ana Martínez - Caimán
(5, '89012345', 8),   -- Sofía Díaz - Higuera
(3, '45678901', 9),   -- Ana Martínez - Cuarzo
(4, '89012345', 10),  -- Sofía Díaz - Tapir
(6, '44556677', 11),  -- Camila Herrera - Anaconda
(7, '88990011', 12),  -- Isabela Cruz - Cedro
(8, '44556677', 13),  -- Camila Herrera - Amatista
(9, '88990011', 14),  -- Isabela Cruz - Oso de Anteojos
(10, '44556677', 15), -- Camila Herrera - Bromelia
(11, '88990011', 16), -- Isabela Cruz - Armadillo Gigante
(12, '44556677', 17), -- Camila Herrera - Caoba
(13, '88990011', 18), -- Isabela Cruz - Pirita
(14, '44556677', 19), -- Camila Herrera - Águila Solitaria
(15, '88990011', 20), -- Isabela Cruz - Flor de Mayo
(16, '44446666', 21),  -- Sara Ramírez - Perezoso de Tres Dedos
(17, '88882222', 22),  -- Mariana Castillo - Roble Rosado
(18, '44447777', 23),  -- Camila Gómez - Cocodrilo Americano
(19, '88881111', 24),  -- Isabela Pineda - Calcita
(20, '44448888', 25),  -- Sara Valencia - Rana Venenosa
(21, '45678901', 26),  -- Ana Martínez - Palma de Açaí
(22, '89012345', 27),  -- Sofía Díaz - Ocelote
(23, '44556677', 28),  -- Camila Herrera - Árbol de Caucho
(24, '88990011', 29),  -- Isabela Cruz - Feldespato
(25, '44446666', 30),  -- Sara Ramírez - Mono Araña
(26, '88882222', 31),  -- Mariana Castillo - Platanillo
(27, '44447777', 32),  -- Camila Gómez - Boa
(28, '88881111', 33),  -- Isabela Pineda - Guayacán
(29, '44448888', 34),  -- Sara Valencia - Magnetita
(30, '45678901', 35),  -- Ana Martínez - Mono Cariblanco
(31, '89012345', 36),  -- Sofía Díaz - Anturio
(32, '44556677', 37),  -- Camila Herrera - Mono Ardilla
(33, '88990011', 38),  -- Isabela Cruz - Canela de Venado
(34, '44446666', 39),  -- Sara Ramírez - Yeso
(35, '88882222', 40),  -- Mariana Castillo - Mariposa Morfo
(36, '44447777', 41),  -- Camila Gómez - Sangre de Drago
(37, '88881111', 42),  -- Isabela Pineda - Capybara
(38, '44448888', 43),  -- Sara Valencia - Guaba
(39, '45678901', 44),  -- Ana Martínez - Mica
(40, '89012345', 45),  -- Sofía Díaz - Ñeque
(41, '44556677', 46),  -- Camila Herrera - Andiroba
(42, '88990011', 47),  -- Isabela Cruz - Terciopelo
(43, '44446666', 48),  -- Sara Ramírez - Flor de Pato
(44, '88882222', 49),  -- Mariana Castillo - Hematita
(45, '44447777', 50),  -- Camila Gómez - Oso Hormiguero
(46, '88881111', 1),   -- Isabela Pineda - Jaguar
(47, '44448888', 2),   -- Sara Valencia - Ceiba
(48, '45678901', 3),   -- Ana Martínez - Guacamaya Roja
(49, '89012345', 4),   -- Sofía Díaz - Roble
(50, '44556677', 5);   -- Camila Herrera - Puma

-- Visitante (10 ejemplos, expande a 50)
INSERT INTO visitante (Numero_Cedula, Nombre, Direccion, Profesion) VALUES
('11112222', 'Andrés Morales', 'Calle 25 #10-15, Bogotá', 'Ingeniero'),
('22223333', 'Camila Ortiz', 'Carrera 8 #5-20, Medellín', 'Bióloga'),
('33334444', 'Felipe Castro', 'Avenida 12 #3-10, Cali', 'Médico'),
('44445555', 'Valeria Herrera', 'Calle 7 #15-25, Barranquilla', 'Estudiante'),
('55556666', 'Julián Pineda', 'Carrera 20 #9-30, Pereira', 'Fotógrafo'),
('66667777', 'Natalia Silva', 'Avenida 5 #8-15, Manizales', 'Periodista'),
('77778888', 'Santiago Mejía', 'Calle 10 #4-20, Leticia', 'Guía Turístico'),
('88889999', 'Isabela Cruz', 'Carrera 15 #12-10, Santa Marta', 'Abogada'),
('99990000', 'Mateo Rincón', 'Avenida 3 #7-25, Quibdó', 'Arquitecto'),
('00001111', 'Paula Escobar', 'Calle 8 #11-30, Popayán', 'Docente'),
('11113333', 'Diego Salazar', 'Calle 5 #10-15, Valledupar', 'Contador'),
('22224444', 'Lucía Mendoza', 'Carrera 9 #7-20, Montería', 'Enfermera'),
('33335555', 'Gabriel Torres', 'Avenida 6 #12-30, Bucaramanga', 'Diseñador'),
('44446666', 'Sara Ramírez', 'Calle 12 #8-25, Villavicencio', 'Veterinaria'),
('55557777', 'Juan Camilo Díaz', 'Carrera 18 #5-10, Pasto', 'Profesor'),
('66668888', 'Laura Valencia', 'Avenida 4 #9-15, Neiva', 'Psicóloga'),
('77779999', 'Carlos Gómez', 'Calle 15 #3-20, Cartagena', 'Empresario'),
('88880000', 'Mariana López', 'Carrera 10 #11-30, Ibagué', 'Ingeniera Ambiental'),
('99991111', 'Sebastián Pardo', 'Avenida 7 #6-25, Armenia', 'Músico'),
('00002222', 'Elena Castillo', 'Calle 9 #14-10, Tunja', 'Historiadora'),
('11114444', 'Andrés Castillo', 'Calle 20 #5-15, Medellín', 'Geólogo'),
('22225555', 'Valentina Muñoz', 'Carrera 7 #10-20, Bogotá', 'Ecologista'),
('33336666', 'Felipe Rojas', 'Avenida 8 #4-30, Cali', 'Fotógrafo'),
('44447777', 'Camila Gómez', 'Calle 6 #13-25, Barranquilla', 'Bióloga'),
('55558888', 'Julián Morales', 'Carrera 25 #8-10, Pereira', 'Guía Turístico'),
('66669999', 'Natalia Ortiz', 'Avenida 3 #12-15, Manizales', 'Periodista'),
('77770000', 'Santiago Castro', 'Calle 11 #6-20, Leticia', 'Antropólogo'),
('88881111', 'Isabela Pineda', 'Carrera 14 #7-30, Santa Marta', 'Abogada'),
('99992222', 'Mateo Silva', 'Avenida 2 #9-25, Quibdó', 'Ingeniero Forestal'),
('00003333', 'Paula Mejía', 'Calle 7 #11-10, Popayán', 'Docente'),
('11115555', 'Diego Ramírez', 'Calle 18 #4-15, Valledupar', 'Estudiante'),
('22226666', 'Lucía Torres', 'Carrera 6 #8-20, Montería', 'Enfermera'),
('33337777', 'Gabriel Herrera', 'Avenida 5 #10-30, Bucaramanga', 'Diseñador Gráfico'),
('44448888', 'Sara Valencia', 'Calle 13 #9-25, Villavicencio', 'Veterinaria'),
('55559999', 'Juan Camilo López', 'Carrera 17 #6-10, Pasto', 'Profesor'),
('66660000', 'Laura Pardo', 'Avenida 6 #8-15, Neiva', 'Psicóloga'),
('77771111', 'Carlos Muñoz', 'Calle 14 #5-20, Cartagena', 'Empresario'),
('88882222', 'Mariana Castillo', 'Carrera 11 #10-30, Ibagué', 'Ingeniera Ambiental'),
('99993333', 'Sebastián Gómez', 'Avenida 8 #7-25, Armenia', 'Músico'),
('00004444', 'Elena Morales', 'Calle 10 #12-10, Tunja', 'Historiadora'),
('11116666', 'Alejandro Vargas', 'Calle 22 #6-15, Medellín', 'Botánico'),
('22227777', 'Sofía Restrepo', 'Carrera 9 #11-20, Bogotá', 'Socióloga'),
('33338888', 'Luis Fernández', 'Avenida 7 #5-30, Cali', 'Fotógrafo'),
('44449999', 'Clara Sánchez', 'Calle 8 #14-25, Barranquilla', 'Estudiante'),
('55550000', 'Pablo Rodríguez', 'Carrera 23 #7-10, Pereira', 'Guía Turístico'),
('66661111', 'Ana María Gil', 'Avenida 4 #11-15, Manizales', 'Periodista'),
('77772222', 'David Ospina', 'Calle 12 #5-20, Leticia', 'Biólogo'),
('88883333', 'Valeria Díaz', 'Carrera 16 #8-30, Santa Marta', 'Arquitecta'),
('99994444', 'Javier López', 'Avenida 1 #10-25, Quibdó', 'Ingeniero Civil'),
('00005555', 'María Fernanda Cano', 'Calle 6 #13-10, Popayán', 'Docente');

-- Alojamiento (5 ejemplos, expande a 50)
INSERT INTO alojamiento (ID_Alojamiento, ID_Parque, Capacidad, Categoria) VALUES
(1, 1, 20, 'Cabaña'),        -- Tayrona
(2, 2, 15, 'Camping'),       -- Los Nevados
(3, 3, 10, 'Ecohotel'),      -- Amacayacu
(4, 4, 25, 'Cabaña'),        -- Farallones
(5, 5, 30, 'Hostal'),        -- Sierra Nevada
(6, 6, 12, 'Camping'),       -- Chingaza
(7, 7, 18, 'Cabaña'),        -- El Cocuy
(8, 8, 8, 'Ecohotel'),       -- Gorgona
(9, 9, 22, 'Hostal'),        -- Puracé
(10, 10, 15, 'Cabaña'),      -- Sumapaz
(11, 11, 10, 'Camping'),     -- Katíos
(12, 12, 25, 'Ecohotel'),    -- Utría
(13, 13, 20, 'Hostal'),      -- Munchique
(14, 14, 30, 'Cabaña'),      -- Cahuinarí
(15, 15, 12, 'Camping'),     -- Tinigua
(16, 16, 15, 'Ecohotel'),    -- Macuira
(17, 17, 18, 'Hostal'),      -- Paramillo
(18, 18, 10, 'Cabaña'),      -- Las Hermosas
(19, 19, 25, 'Camping'),     -- Old Providence
(20, 20, 20, 'Ecohotel'),    -- Corales del Rosario
(21, 21, 15, 'Hostal'),       -- Pisba
(22, 22, 20, 'Cabaña'),       -- Serranía de La Macarena
(23, 23, 12, 'Camping'),      -- El Tuparro
(24, 24, 10, 'Ecohotel'),     -- Isla de Salamanca
(25, 25, 25, 'Cabaña'),       -- Sierra de la Macarena
(26, 26, 18, 'Hostal'),       -- Tamá
(27, 27, 8, 'Ecohotel'),      -- Bahía Portete
(28, 28, 15, 'Camping'),      -- Los Flamencos
(29, 29, 20, 'Cabaña'),       -- Sanquianga
(30, 30, 30, 'Hostal'),       -- Río Puré
(31, 31, 12, 'Ecohotel'),     -- Los Katíos Norte
(32, 32, 18, 'Camping'),      -- Alto Fragua
(33, 33, 25, 'Cabaña'),       -- Yariguíes
(34, 34, 10, 'Hostal'),       -- Selva de Florencia
(35, 35, 15, 'Ecohotel'),     -- Las Orquídeas
(36, 36, 20, 'Cabaña'),       -- Tatamá
(37, 37, 12, 'Camping'),      -- Sierra Nevada Sur
(38, 38, 30, 'Hostal'),       -- Puinawai
(39, 39, 18, 'Ecohotel'),     -- Los Picachos
(40, 40, 25, 'Cabaña'),       -- Cordillera de los Picachos
(41, 41, 10, 'Camping'),      -- Tayrona Norte
(42, 42, 15, 'Hostal'),       -- Serranía del Baudó
(43, 43, 8, 'Ecohotel'),      -- Río Atrato
(44, 44, 12, 'Cabaña'),       -- Laguna de Sonso
(45, 45, 20, 'Camping'),      -- Alto Putumayo
(46, 46, 15, 'Hostal'),       -- Bosque Seco del Patía
(47, 47, 18, 'Ecohotel'),     -- Cañón del Chicamocha
(48, 48, 25, 'Cabaña'),       -- Selva del Darién
(49, 49, 10, 'Camping'),      -- Páramo de Santurbán
(50, 50, 20, 'Hostal');       -- Costa del Pacífico

-- Registro de Visitantes (10 ejemplos, expande a 50)
INSERT INTO registro_visitantes (ID_Registro, Numero_Cedula, ID_Alojamiento, Fecha_Entrada) VALUES
(1, '11112222', 1, '2025-01-15'),  -- Andrés Morales - Cabaña Tayrona
(2, '22223333', 2, '2025-02-01'),  -- Camila Ortiz - Camping Los Nevados
(3, '33334444', 3, '2025-02-10'),  -- Felipe Castro - Ecohotel Amacayacu
(4, '44445555', 4, '2025-02-15'),  -- Valeria Herrera - Cabaña Farallones
(5, '55556666', 5, '2025-03-01'),  -- Julián Pineda - Hostal Sierra Nevada
(6, '66667777', 1, '2025-03-05'),  -- Natalia Silva - Cabaña Tayrona
(7, '77778888', 2, '2025-03-10'),  -- Santiago Mejía - Camping Los Nevados
(8, '88889999', 3, '2025-03-15'),  -- Isabela Cruz - Ecohotel Amacayacu
(9, '99990000', 4, '2025-03-20'),  -- Mateo Rincón - Cabaña Farallones
(10, '00001111', 5, '2025-03-25'), -- Paula Escobar - Hostal Sierra Nevada
(11, '11113333', 6, '2025-04-01'), -- Diego Salazar - Camping Chingaza
(12, '22224444', 7, '2025-04-05'), -- Lucía Mendoza - Cabaña El Cocuy
(13, '33335555', 8, '2025-04-10'), -- Gabriel Torres - Ecohotel Gorgona
(14, '44446666', 9, '2025-04-15'), -- Sara Ramírez - Hostal Puracé
(15, '55557777', 10, '2025-04-20'),-- Juan Camilo Díaz - Cabaña Sumapaz
(16, '66668888', 11, '2025-04-25'),-- Laura Valencia - Camping Katíos
(17, '77779999', 12, '2025-05-01'),-- Carlos Gómez - Ecohotel Utría
(18, '88880000', 13, '2025-05-05'),-- Mariana López - Hostal Munchique
(19, '99991111', 14, '2025-05-10'),-- Sebastián Pardo - Cabaña Cahuinarí
(20, '00002222', 15, '2025-05-15'),-- Elena Castillo - Camping Tinigua
(21, '11114444', 16, '2025-05-20'), -- Andrés Castillo - Ecohotel Macuira
(22, '22225555', 17, '2025-05-25'), -- Valentina Muñoz - Hostal Paramillo
(23, '33336666', 18, '2025-06-01'), -- Felipe Rojas - Cabaña Las Hermosas
(24, '44447777', 19, '2025-06-05'), -- Camila Gómez - Camping Old Providence
(25, '55558888', 20, '2025-06-10'), -- Julián Morales - Ecohotel Corales del Rosario
(26, '66669999', 21, '2025-06-15'), -- Natalia Ortiz - Hostal Pisba
(27, '77770000', 22, '2025-06-20'), -- Santiago Castro - Cabaña Serranía de La Macarena
(28, '88881111', 23, '2025-06-25'), -- Isabela Pineda - Camping El Tuparro
(29, '99992222', 24, '2025-07-01'), -- Mateo Silva - Ecohotel Isla de Salamanca
(30, '00003333', 25, '2025-07-05'), -- Paula Mejía - Cabaña Sierra de la Macarena
(31, '11115555', 26, '2025-07-10'), -- Diego Ramírez - Hostal Tamá
(32, '22226666', 27, '2025-07-15'), -- Lucía Torres - Ecohotel Bahía Portete
(33, '33337777', 28, '2025-07-20'), -- Gabriel Herrera - Camping Los Flamencos
(34, '44448888', 29, '2025-07-25'), -- Sara Valencia - Cabaña Sanquianga
(35, '55559999', 30, '2025-08-01'), -- Juan Camilo López - Hostal Río Puré
(36, '66660000', 31, '2025-08-05'), -- Laura Pardo - Ecohotel Los Katíos Norte
(37, '77771111', 32, '2025-08-10'), -- Carlos Muñoz - Camping Alto Fragua
(38, '88882222', 33, '2025-08-15'), -- Mariana Castillo - Cabaña Yariguíes
(39, '99993333', 34, '2025-08-20'), -- Sebastián Gómez - Hostal Selva de Florencia
(40, '00004444', 35, '2025-08-25'), -- Elena Morales - Ecohotel Las Orquídeas
(41, '11116666', 36, '2025-09-01'), -- Alejandro Vargas - Cabaña Tatamá
(42, '22227777', 37, '2025-09-05'), -- Sofía Restrepo - Camping Sierra Nevada Sur
(43, '33338888', 38, '2025-09-10'), -- Luis Fernández - Hostal Puinawai
(44, '44449999', 39, '2025-09-15'), -- Clara Sánchez - Ecohotel Los Picachos
(45, '55550000', 40, '2025-09-20'), -- Pablo Rodríguez - Cabaña Cordillera de los Picachos
(46, '66661111', 41, '2025-09-25'), -- Ana María Gil - Camping Tayrona Norte
(47, '77772222', 42, '2025-10-01'), -- David Ospina - Hostal Serranía del Baudó
(48, '88883333', 43, '2025-10-05'), -- Valeria Díaz - Ecohotel Río Atrato
(49, '99994444', 44, '2025-10-10'), -- Javier López - Cabaña Laguna de Sonso
(50, '00005555', 45, '2025-10-15'); -- María Fernanda Cano - Camping Alto Putumayo





-- Consulta para verificar el número de registros en cada tabla
SELECT 
    'entidad_responsable' AS Tabla, COUNT(*) AS Total_Registros FROM entidad_responsable
UNION ALL
SELECT 
    'departamento' AS Tabla, COUNT(*) AS Total_Registros FROM departamento
UNION ALL
SELECT 
    'parque' AS Tabla, COUNT(*) AS Total_Registros FROM parque
UNION ALL
SELECT 
    'departamento_parque' AS Tabla, COUNT(*) AS Total_Registros FROM departamento_parque
UNION ALL
SELECT 
    'area' AS Tabla, COUNT(*) AS Total_Registros FROM area
UNION ALL
SELECT 
    'especies' AS Tabla, COUNT(*) AS Total_Registros FROM especies
UNION ALL
SELECT 
    'inventario_especies' AS Tabla, COUNT(*) AS Total_Registros FROM inventario_especies
UNION ALL
SELECT 
    'personal' AS Tabla, COUNT(*) AS Total_Registros FROM personal
UNION ALL
SELECT 
    'vehiculo' AS Tabla, COUNT(*) AS Total_Registros FROM vehiculo
UNION ALL
SELECT 
    'proyecto_investigacion' AS Tabla, COUNT(*) AS Total_Registros FROM proyecto_investigacion
UNION ALL
SELECT 
    'investigador_proyecto_especie' AS Tabla, COUNT(*) AS Total_Registros FROM investigador_proyecto_especie
UNION ALL
SELECT 
    'visitante' AS Tabla, COUNT(*) AS Total_Registros FROM visitante
UNION ALL
SELECT 
    'alojamiento' AS Tabla, COUNT(*) AS Total_Registros FROM alojamiento
UNION ALL
SELECT 
    'registro_visitantes' AS Tabla, COUNT(*) AS Total_Registros FROM registro_visitantes;
