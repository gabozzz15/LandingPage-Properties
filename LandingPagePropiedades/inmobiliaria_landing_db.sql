-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Base de datos: `inmobiliaria_landing_db`
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inmobiliaria_landing_db`
--
CREATE DATABASE IF NOT EXISTS `inmobiliaria_landing_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `inmobiliaria_landing_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propiedades`
--

CREATE TABLE `propiedades` (
  `id_propiedad` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text,
  `tipo` enum('casa','departamento','terreno','oficina','local','edificio') NOT NULL,
  `operacion` enum('venta','renta') NOT NULL,
  `estado` enum('disponible','vendida','rentada','inactiva') NOT NULL DEFAULT 'disponible',
  `precio` decimal(12,2) NOT NULL,
  `moneda` enum('VES','USD') DEFAULT 'USD',
  `superficie_total` decimal(10,2) DEFAULT NULL,
  `superficie_construida` decimal(10,2) DEFAULT NULL,
  `habitaciones` int DEFAULT NULL,
  `banos` decimal(3,1) DEFAULT NULL,
  `direccion` varchar(255) NOT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `imagen_principal` varchar(255) DEFAULT NULL,
  `imagenes_adicionales` text,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estudio` enum('0','1') DEFAULT '0',
  `sala_tv` enum('0','1') DEFAULT '0',
  `cuarto_servicio` enum('0','1') DEFAULT '0',
  `sala_juntas` enum('0','1') DEFAULT '0',
  `bodega` enum('0','1') DEFAULT '0',
  `cisterna` enum('0','1') DEFAULT '0',
  `alberca` enum('0','1') DEFAULT '0',
  `jacuzzi` enum('0','1') DEFAULT '0',
  `gimnasio` enum('0','1') DEFAULT '0',
  `salon_eventos` enum('0','1') DEFAULT '0',
  `garage` enum('0','1') DEFAULT '0',
  `rampas` enum('0','1') DEFAULT '0',
  `asador` enum('0','1') DEFAULT '0',
  `aire_acondicionado` enum('0','1') DEFAULT '0',
  `ventiladores` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`id_propiedad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `propiedades`
--

INSERT INTO `propiedades` (`titulo`, `descripcion`, `tipo`, `operacion`, `estado`, `precio`, `moneda`, `superficie_total`, `superficie_construida`, `habitaciones`, `banos`, `direccion`, `latitud`, `longitud`, `imagen_principal`, `imagenes_adicionales`, `fecha_publicacion`, `estudio`, `sala_tv`, `cuarto_servicio`, `sala_juntas`, `bodega`, `cisterna`, `alberca`, `jacuzzi`, `gimnasio`, `salon_eventos`, `garage`, `rampas`, `asador`, `aire_acondicionado`, `ventiladores`) VALUES
('Casa Moderna en El Hatillo', 'Hermosa casa con acabados de lujo y excelente ubicación. Perfecta para familias que buscan comodidad y elegancia en una de las mejores zonas de Caracas.', 'casa', 'venta', 'disponible', 250000.00, 'USD', 200.00, 180.00, 3, 3.0, 'Calle Los Robles, El Hatillo, Caracas', 10.42260000, -66.82320000, 'css/img/casa1.jpg', NULL, '2024-12-22 20:58:35', '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '1', '0', '1', '1', '1'),
('Departamento con Vista Panorámica', 'Moderno departamento con increíbles vistas a la ciudad. Espacios amplios y luminosos con acabados de primera calidad.', 'departamento', 'renta', 'disponible', 1800.00, 'USD', 120.00, 120.00, 2, 2.0, 'Av. Francisco de Miranda, Los Palos Grandes, Caracas', 10.49660000, -66.85610000, 'css/img/casa2.jpg', NULL, '2024-12-22 20:58:35', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '1', '1'),
('Terreno en Zona Residencial', 'Excelente terreno en esquina con todos los servicios. Ideal para construir la casa de sus sueños en una de las mejores zonas de la ciudad.', 'terreno', 'venta', 'disponible', 150000.00, 'USD', 500.00, 0.00, 0, 0.0, 'Urbanización El Castaño, Maracay', 10.27170000, -67.62240000, 'css/img/casa3.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('Casa Moderna en Valle Arriba', 'Hermosa casa moderna con acabados de lujo. Amplios espacios, iluminación natural y diseño contemporáneo.', 'casa', 'venta', 'disponible', 280000.00, 'USD', 250.00, 200.00, 3, 2.5, 'Urbanización Valle Arriba, Guatire', 10.47860000, -66.54560000, 'css/img/casa4.jpg', NULL, '2024-12-22 20:58:35', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0', '1', '1', '1', '1', '1'),
('Departamento Centro', 'Céntrico departamento remodelado. Ubicación privilegiada con acceso a todos los servicios y transporte público.', 'departamento', 'renta', 'disponible', 1200.00, 'USD', 85.00, 85.00, 2, 2.0, 'Av. Bolívar, Valencia', 10.16490000, -68.00820000, 'css/img/casa5.jpg', NULL, '2024-12-22 20:58:35', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '1', '1'),
('Terreno en El Morro', 'Excelente terreno con vista panorámica al mar. Oportunidad única para inversión o desarrollo de proyecto residencial.', 'terreno', 'venta', 'disponible', 180000.00, 'USD', 500.00, 0.00, 0, 0.0, 'El Morro, Puerto La Cruz', 10.21340000, -64.63530000, 'css/img/casa6.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('Casa de Lujo en Country Club', 'Espectacular residencia con acabados de lujo. Diseño arquitectónico único con espacios amplios y confortables.', 'casa', 'venta', 'disponible', 850000.00, 'USD', 600.00, 450.00, 5, 5.5, 'Urbanización Country Club, Caracas', 10.48330000, -66.86020000, 'css/img/casa7.jpg', 'css/img/casa10.2.jpg,css/img/casa10.3.jpg', '2024-12-22 20:58:35', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
('Departamento Amueblado', 'Moderno departamento completamente amueblado. Listo para habitar con todos los servicios incluidos.', 'departamento', 'renta', 'disponible', 2500.00, 'USD', 120.00, 120.00, 3, 2.0, 'Av. Las Delicias, Maracaibo', 10.67140000, -71.62940000, 'css/img/casa8.jpg', NULL, '2024-12-22 20:58:35', '1', '1', '0', '0', '1', '0', '0', '0', '0', '0', '1', '0', '0', '1', '1'),
('Terreno Comercial', 'Excelente ubicación para desarrollo comercial. Zona de alto tráfico peatonal y vehicular, ideal para negocio.', 'terreno', 'venta', 'disponible', 500000.00, 'USD', 1000.00, NULL, 0, 0.0, 'Av. Intercomunal, Barcelona', 10.12960000, -64.68390000, 'css/img/casa9.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('Casa en Conjunto Cerrado', 'Hermosa casa en conjunto cerrado con seguridad 24/7. Ambiente familiar y tranquilo con áreas verdes y recreativas.', 'casa', 'venta', 'disponible', 320000.00, 'USD', 280.00, 230.00, 4, 3.0, 'Urbanización La Tahona, Caracas', 10.43530000, -66.87170000, 'css/img/casa10.jpeg', 'css/img/casa10.2.jpg,css/img/casa10.3.jpg', '2024-12-22 20:58:35', '1', '1', '1', '0', '1', '1', '1', '0', '0', '0', '1', '1', '1', '1', '1'),
('Departamento Nuevo', 'Estrena departamento con excelente ubicación. Acabados modernos y distribución optimizada para aprovechar cada espacio.', 'departamento', 'renta', 'disponible', 1800.00, 'USD', 95.00, 95.00, 2, 2.0, 'Av. Guayana, Puerto Ordaz', 8.29050000, -62.74670000, 'css/img/casa11.jpg', 'css/img/casa11.2.jpg', '2024-12-22 20:58:35', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '1', '1'),
('Terreno Residencial', 'Terreno ideal para casa de descanso. Ubicado en zona de crecimiento con plusvalía garantizada.', 'terreno', 'venta', 'disponible', 220000.00, 'USD', 800.00, 0.00, 0, 0.0, 'Sector Playa El Agua, Isla de Margarita', 11.15180000, -63.86780000, 'css/img/casa3.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('Oficina Moderna en Zona Financiera', 'Espaciosa oficina con diseño contemporáneo, ideal para empresas en crecimiento. Ubicada en el corazón del distrito financiero.', 'oficina', 'renta', 'disponible', 3500.00, 'USD', 150.00, 150.00, 0, 2.0, 'Torre Empresarial, El Rosal, Caracas', 10.49750000, -66.85780000, 'css/img/casa4.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '1', '0', '1', '0'),
('Local Comercial en Centro Comercial', 'Estratégico local comercial con alto flujo de clientes potenciales. Excelente oportunidad para iniciar o expandir su negocio.', 'local', 'renta', 'disponible', 2800.00, 'USD', 80.00, 80.00, 0, 1.0, 'C.C. Sambil, Chacao, Caracas', 10.48680000, -66.85780000, 'css/img/casa5.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0'),
('Edificio Corporativo', 'Imponente edificio ideal para sede corporativa. Instalaciones modernas con todos los servicios y amenidades para sus colaboradores.', 'edificio', 'venta', 'disponible', 2500000.00, 'USD', 2000.00, 1800.00, 0, 10.0, 'Av. Libertador, Caracas', 10.50560000, -66.89120000, 'css/img/casa6.jpg', NULL, '2024-12-22 20:58:35', '0', '0', '0', '1', '1', '1', '0', '0', '1', '1', '1', '1', '0', '1', '1');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;