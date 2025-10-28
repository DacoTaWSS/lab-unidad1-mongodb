## Laboratorio Unidad 1: Modelado e Implementación NoSQL (TechStore)

Práctica de laboratorio enfocada en la comparativa de modelos de bases de datos, utilizando el caso de estudio **"TechStore"**. El objetivo es justificar la elección de MongoDB frente al modelo relacional.

---

## Objetivos de la Actividad

| Componente | Descripción Detallada |
| :--- | :--- |
| **Objetivo General** | **Evaluar y justificar la superioridad arquitectónica del Modelado NoSQL (MongoDB)** frente al modelo Relacional (SQL) para sistemas de catálogos dinámicos con esquemas flexibles, estableciendo el criterio de selección basado en la adecuación técnica al problema planteado. |
| **Objetivo Específico 1** | Diseñar y modelar una estructura de datos basada en documentos JSON con anidamiento, implementando operaciones CRUD para validar la funcionalidad del diseño en MongoDB. |
| **Objetivo Específico 2** | Analizar la ganancia de rendimiento al evitar *JOINs* versus la potencial pérdida de integridad de datos, proponiendo soluciones técnicas para profesionalizar la base de datos (validación de esquema e indexación). |

---

## Estructura del Repositorio

El repositorio está organizado en torno a los artefactos requeridos para la evaluación:

| Archivo/Carpeta | Contenido | Propósito |
| :--- | :--- | :--- |
| **`INFORME_TECNICO.md`** | Contiene el análisis comparativo, el diseño del modelo JSON, las capturas de resultados y el Análisis Reflexivo. | Documentación y justificación técnica del proyecto. |
| **`operaciones.mongodb`** | Script completo con todos los comandos de MongoDB para CRUD. | Implementación práctica del modelo de datos. |
| **`modelo_relacional.png`** | Diagrama Entidad-Relación (DER) de la solución SQL. | Comparación visual con el modelo NoSQL. |

---

## Instrucciones de Ejecución


### 1. Requisitos Previos

* Tener acceso a una instancia de **MongoDB** (local o Atlas).
* Tener **VS Code** con la extensión **MongoDB for VS Code** o acceso a la herramienta **mongosh**.

### 2. Ejecución del Script de MongoDB

1.  Asegúrese de que el servidor de MongoDB esté en ejecución.
2.  archivo **`operaciones.mongodb`**.
3.  Ejecute el script completo.

El script realiza la siguiente secuencia de comandos: **Limpieza inicial**, **Inserción** de los tres productos, **Lectura** con cuatro consultas de filtrado y proyección, y **Actualización** de datos utilizando comandos atómicos (`$inc`, `$set`).

---

## Resumen del Análisis Técnico

La elección de MongoDB para "TechStore" se fundamenta en la necesidad de gestionar **esquemas flexibles**. El modelo aplica la **desnormalización intencional** y el **anidamiento de documentos** (`especificaciones`) para optimizar la velocidad de lectura. Esto elimina la necesidad de múltiples *JOINs* que serían obligatorios en el modelo SQL para cumplir con la normalización, traduciéndose en una **ganancia de rendimiento** crucial para el catálogo. La flexibilidad, no obstante, debe ser gestionada mediante la implementación de **validación de esquema JSON** para mitigar la potencial inconsistencia de datos a futuro.

### Palabras Clave

* **NoSQL**
* **Desnormalización**
* **Esquema Flexible**