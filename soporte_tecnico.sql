-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-10-2025 a las 05:03:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `soporte_tecnico`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_equipo`
--

CREATE TABLE `categoria_equipo` (
  `Id_Categoria` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `Id_Cliente` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Telefono` varchar(12) DEFAULT NULL,
  `Direccion` text DEFAULT NULL,
  `Fecha_Registro` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id_Cliente`, `Nombre`, `Email`, `Telefono`, `Direccion`, `Fecha_Registro`) VALUES
(1, 'Ana García', 'ana.garcia@email.com', '600123456', 'Calle Principal 123, Madrid', '2025-10-15'),
(2, 'Carlos López', 'carlos.lopez@email.com', '600234567', 'Avenida Central 45, Barcelona', '2025-10-15'),
(3, 'María Rodríguez', 'maria.rodriguez@email.com', '600345678', 'Plaza Mayor 67, Valencia', '2025-10-15'),
(4, 'Javier Martínez', 'javier.martinez@email.com', '600456789', 'Calle Secundaria 89, Sevilla', '2025-10-15'),
(5, 'Laura Fernández', 'laura.fernandez@email.com', '600567890', 'Avenida Norte 12, Bilbao', '2025-10-15'),
(6, 'David Sánchez', 'david.sanchez@email.com', '600678901', 'Calle Este 34, Málaga', '2025-10-15'),
(7, 'Elena Pérez', 'elena.perez@email.com', '600789012', 'Plaza Sur 56, Zaragoza', '2025-10-15'),
(8, 'Miguel Torres', 'miguel.torres@email.com', '600890123', 'Avenida Oeste 78, Murcia', '2025-10-15'),
(9, 'Sofía Ramírez', 'sofia.ramirez@email.com', '600901234', 'Calle Central 90, Palma', '2025-10-15'),
(10, 'Daniel Castro', 'daniel.castro@email.com', '601012345', 'Paseo Marítimo 23, Las Palmas', '2025-10-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `Id_empleado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Email` varchar(150) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`Id_empleado`, `nombre`, `Especialidad`, `Email`, `Telefono`, `Activo`) VALUES
(1, 'Roberto Jiménez', 'Hardware', 'roberto.jimenez@empresa.com', '610123456', 1),
(2, 'Sara Morales', 'Software', 'sara.morales@empresa.com', '610234567', 1),
(3, 'Pablo Ortega', 'Redes', 'pablo.ortega@empresa.com', '610345678', 1),
(4, 'Carmen Vega', 'Base de Datos', 'carmen.vega@empresa.com', '610456789', 1),
(5, 'Alejandro Ruiz', 'Seguridad', 'alejandro.ruiz@empresa.com', '610567890', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `Id_Equipo` int(11) NOT NULL,
  `Id_Cliente` int(11) DEFAULT NULL,
  `Id_Categoria` int(11) DEFAULT NULL,
  `Modelo` varchar(100) DEFAULT NULL,
  `Numero_Serie` varchar(100) DEFAULT NULL,
  `Fecha_Compra` date DEFAULT NULL,
  `Garantia_Hasta` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_soporte`
--

CREATE TABLE `informes_soporte` (
  `Id_informe` int(11) NOT NULL,
  `Titulo` varchar(200) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Tipo_Informe` enum('Diario','Semanal','Mensual','Anual') DEFAULT NULL,
  `Fecha_Generacion` datetime DEFAULT current_timestamp(),
  `Datos_Informe` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`Datos_Informe`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `Id_Item` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Categoria` varchar(100) DEFAULT NULL,
  `Stock` int(11) DEFAULT 0,
  `Stock_Minimo` int(11) DEFAULT 5,
  `Precio_Unitario` decimal(10,2) DEFAULT NULL,
  `Ubicacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte_tickets`
--

CREATE TABLE `soporte_tickets` (
  `Id_ticket` int(11) NOT NULL,
  `Id_Cliente` int(11) DEFAULT NULL,
  `Id_Equipo` int(11) DEFAULT NULL,
  `Id_Empleado` int(11) DEFAULT NULL,
  `Titulo` varchar(200) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Prioridad` enum('Baja','Media','Alta','Crítica') DEFAULT 'Media',
  `Estado` enum('Abierto','En Progreso','Espera Repuesto','Cerrado') DEFAULT 'Abierto',
  `Fecha_apertura` datetime DEFAULT current_timestamp(),
  `Fecha_cierre` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_detalles`
--

CREATE TABLE `ticket_detalles` (
  `Id_Detalle` int(11) NOT NULL,
  `Id_Ticket` int(11) DEFAULT NULL,
  `Id_Empleado` int(11) DEFAULT NULL,
  `Descripcion` text NOT NULL,
  `Fecha_Hora` datetime DEFAULT current_timestamp(),
  `Horas_Trabajadas` decimal(4,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria_equipo`
--
ALTER TABLE `categoria_equipo`
  ADD PRIMARY KEY (`Id_Categoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Id_Cliente`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`Id_empleado`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`Id_Equipo`),
  ADD UNIQUE KEY `Numero_Serie` (`Numero_Serie`),
  ADD KEY `Id_Cliente` (`Id_Cliente`),
  ADD KEY `Id_Categoria` (`Id_Categoria`);

--
-- Indices de la tabla `informes_soporte`
--
ALTER TABLE `informes_soporte`
  ADD PRIMARY KEY (`Id_informe`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`Id_Item`);

--
-- Indices de la tabla `soporte_tickets`
--
ALTER TABLE `soporte_tickets`
  ADD PRIMARY KEY (`Id_ticket`),
  ADD KEY `Id_Cliente` (`Id_Cliente`),
  ADD KEY `Id_Equipo` (`Id_Equipo`),
  ADD KEY `Id_Empleado` (`Id_Empleado`);

--
-- Indices de la tabla `ticket_detalles`
--
ALTER TABLE `ticket_detalles`
  ADD PRIMARY KEY (`Id_Detalle`),
  ADD KEY `Id_Ticket` (`Id_Ticket`),
  ADD KEY `Id_Empleado` (`Id_Empleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria_equipo`
--
ALTER TABLE `categoria_equipo`
  MODIFY `Id_Categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `Id_Cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `Id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `Id_Equipo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `informes_soporte`
--
ALTER TABLE `informes_soporte`
  MODIFY `Id_informe` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `Id_Item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `soporte_tickets`
--
ALTER TABLE `soporte_tickets`
  MODIFY `Id_ticket` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ticket_detalles`
--
ALTER TABLE `ticket_detalles`
  MODIFY `Id_Detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`Id_Cliente`) REFERENCES `clientes` (`Id_Cliente`),
  ADD CONSTRAINT `equipos_ibfk_2` FOREIGN KEY (`Id_Categoria`) REFERENCES `categoria_equipo` (`Id_Categoria`);

--
-- Filtros para la tabla `soporte_tickets`
--
ALTER TABLE `soporte_tickets`
  ADD CONSTRAINT `soporte_tickets_ibfk_1` FOREIGN KEY (`Id_Cliente`) REFERENCES `clientes` (`Id_Cliente`),
  ADD CONSTRAINT `soporte_tickets_ibfk_2` FOREIGN KEY (`Id_Equipo`) REFERENCES `equipos` (`Id_Equipo`),
  ADD CONSTRAINT `soporte_tickets_ibfk_3` FOREIGN KEY (`Id_Empleado`) REFERENCES `empleados` (`Id_empleado`);

--
-- Filtros para la tabla `ticket_detalles`
--
ALTER TABLE `ticket_detalles`
  ADD CONSTRAINT `ticket_detalles_ibfk_1` FOREIGN KEY (`Id_Ticket`) REFERENCES `soporte_tickets` (`Id_ticket`),
  ADD CONSTRAINT `ticket_detalles_ibfk_2` FOREIGN KEY (`Id_Empleado`) REFERENCES `empleados` (`Id_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
