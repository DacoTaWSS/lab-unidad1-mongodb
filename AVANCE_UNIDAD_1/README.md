# TechStore 
**Autor:** Guerra Jennifer
**Fecha:** 2 de Noviembre, 2025  
**Proyecto:** Proyecto Avance 1: Arquitectura de Datos Fuente

--- 
## Descripción del Proyecto

TechStore es una cadena minorista de tecnología en rápido crecimiento que enfrenta el desafío de tener sus datos distribuidos en sistemas aislados. La información de inventario y productos se gestiona en una base de datos NoSQL (MongoDB) debido a la naturaleza flexible de los atributos de productos, mientras que las transacciones de ventas, clientes y sucursales se administran en una base de datos relacional (PostgreSQL/MySQL) para garantizar integridad transaccional.

--- 
## Problemática

La gerencia actualmente no puede responder preguntas de negocio fundamentales como:
- ¿Cuál es nuestro producto más vendido en la sucursal de Quito?
- ¿Cómo ha sido la tendencia de ventas de la categoría "Smartphones" en el último trimestre?

## Objetivo

Construir un Data Mart de "Ventas" que integre fuentes de datos heterogéneas (SQL y NoSQL) para proporcionar inteligencia de negocio y facilitar la toma de decisiones estratégicas.

--- 
## Avance 1: Modelado de Sistemas Operacionales (OLTP)

### Enfoque

Este avance se centra en los fundamentos del almacenamiento de datos, explorando la dualidad de los sistemas modernos:
- Bases de Datos Relacionales (SQL): Rigidez y consistencia para transacciones críticas
- Bases de Datos NoSQL: Flexibilidad para datos semi-estructurados y catálogos variables

### Componentes Desarrollados

#### 1. Sistema NoSQL (MongoDB): Catálogo de Productos

Base de datos: `techstore_inventory`

Colección: `productos`

Campos principales:
- sku (identificador único)
- nombre
- precio_unitario
- stock
- especificaciones (documento anidado flexible)

**Características implementadas:**
- Validación con JSON Schema
- Índice único en campo SKU
- Estructura flexible para especificaciones de productos

**Archivo:** `SISTEMA_NOSQL/operaciones_productos.mongodb`

#### 2. Sistema Relacional (SQL): Transacciones de Ventas

Base de datos: `techstore_sales` (MySQL/PostgreSQL)

**Modelo de Datos:**

Tablas principales:
- `Clientes`: Información de clientes registrados
- `Sucursales`: Ubicaciones de tiendas físicas
- `Ventas`: Registro de transacciones de venta
- `Detalle_Ventas`: Productos específicos vendidos en cada transacción

**Relaciones:**
- Un cliente puede realizar múltiples ventas (1:N)
- Una sucursal registra múltiples ventas (1:N)
- Una venta contiene múltiples detalles de productos (1:N)

**Punto de integración:**
El campo `Detalle_Ventas.sku_producto` conecta el sistema SQL con la colección `productos` en MongoDB.

**Archivos:**
- `SISTEMA_SQL/modelo_relacional_ventas.png`: Diagrama Entidad-Relación
- `SISTEMA_SQL/schema_ventas.sql`: Script de creación de base de datos

#### 3. Análisis de Calidad de Datos

**Archivo:** `INFORME_U1.md`

**Contenido:**

1. **Justificación del Modelo Dual**
   - Razones para usar SQL en transacciones de ventas
   - Razones para usar NoSQL en catálogo de productos
   - Estrategia de integración entre ambos sistemas

2. **Problemas Potenciales de Calidad de Datos**
   - Inconsistencia de referencias entre SQL y MongoDB
   - Duplicación de SKU en MongoDB
   - Inconsistencia y falta de estandarización en datos de texto
---
## Estructura del Repositorio
```
AVANCE_UNIDAD_1/
├── INFORME_U1.md
├── SISTEMA_NOSQL/
│   └── operaciones_productos.mongodb
└── SISTEMA_SQL/
    ├── modelo_relacional_ventas.png
    └── schema_ventas.sql
```

## Tecnologías Utilizadas

- MongoDB: Base de datos NoSQL para inventario
- MySQL/PostgreSQL: Base de datos relacional para ventas
- Git/GitHub: Control de versiones


### Prerrequisitos

- MongoDB instalado y en ejecución
- MySQL
