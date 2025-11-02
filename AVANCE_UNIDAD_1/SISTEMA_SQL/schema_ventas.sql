
CREATE DATABASE IF NOT EXISTS techstore_sales;

USE techstore_sales;

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_venta DECIMAL(10, 2),
    
    CONSTRAINT fk_venta_cliente 
        FOREIGN KEY (id_cliente) 
        REFERENCES Clientes(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_venta_sucursal 
        FOREIGN KEY (id_sucursal) 
        REFERENCES Sucursales(id_sucursal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Detalle_Ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    sku_producto INT NOT NULL,  -- MongoDB productos.sku
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_venta_momento DECIMAL(10, 2) NOT NULL CHECK (precio_venta_momento > 0),
    subtotal DECIMAL(10, 2) AS (cantidad * precio_venta_momento) STORED,
    
    CONSTRAINT fk_detalle_venta 
        FOREIGN KEY (id_venta) 
        REFERENCES Ventas(id_venta)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Inserts
INSERT INTO Clientes (nombre, email, ciudad) VALUES
('Jennifer Guerra', 'jjguerra5@espe.edu.ec', 'Quito'),
('Marco Peralvo', 'mark@gmail.com', 'Pillaro'),
('Mariuxi Rivera', 'mariuxrivera31@gmail.com', 'Cuenca');

INSERT INTO Sucursales (nombre_sucursal, ciudad, direccion, telefono) VALUES
('TechStore Quito Centro', 'Quito', 'Av. Amazonas N24-03', '02-2345678'),
('TechStore Guayaquil Mall', 'Pillaro', 'Mall del Sol, Local 205', '02-2876543'),
('TechStore Cuenca Norte', 'Cuenca', 'Av. Ordóñez Lasso', '02-2987654');

INSERT INTO Ventas (id_cliente, id_sucursal, fecha_venta) VALUES
(1, 1, '2024-11-01 14:30:00');

INSERT INTO Detalle_Ventas (id_venta, sku_producto, cantidad, precio_venta_momento) VALUES
(1, 1, 1, 1500.00);

