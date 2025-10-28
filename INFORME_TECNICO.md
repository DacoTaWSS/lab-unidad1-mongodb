# Informe Técnico 
---

**Autor:** Guerra Jennifer
**Fecha:** 28 de octubre, 2025  
**Proyecto:** Tarea 2 Individual: El Cronista de Datos NoSQL

---

###   Laboratorio práctico 1: Modelado e Implementación NoSQL (MongoDB)

####  1. 	Análisis Comparativo (SQL vs NoSQL) para el caso "TechStore".


| Criterio | Solución Relacional (SQL) | Solución NoSQL (MongoDB) | Justificación para "TechStore" |
|----------|---------------------------|--------------------------|--------------------------------|
| **Flexibilidad de Esquema** | Rígido (requiere ALTER TABLE o tablas EAV). | Flexible (documentos JSON/BSON). | _En tiendas donde se manejan varios tipos de productos que se separan por ejemplo por su categoria, en este caso tiendas como TechStore que se plantea tiene productos como laptops, smartphones, tablets, accesorios; Los cuales tienen atributos distintos, son ideales para base de datos no relacionales, ya que este les va permitir almacenar los productos con sus respectivas caracteristicas sin tener que alterar o agregar campos, es decir que se adaptan mejor a los documentos flexibles que el esquema rígido que caracteriza a tablas SQL._|
| **Modelo de Datos** | Tablas normalizadas (ej: productos, detalles_laptop). | Colección de documentos (ej: productos). | _Si se utiliza una base de datos relacional, se necesitaria varias tablas para para normalizar con el fin de mantener un modelado limpio que evite por ejemplo relaciones muchos a muchos. Pero al utilizar NoSQL, se permite crear productos en una misma colección con documentos únicos, manteniendo información especifica para cada producto según sus caracteristicas sin la necesidad de dividir sus datos en disitntas tablas como SQL._ |
| **Consulta de Datos** | Requiere JOINs complejos para obtener detalles. | Consulta simple a un único documento. | _En caso de utilizar base de datos SQL, al normalizar las tablas, implicaria el uso constante de JOINS entre las distintas tablas del sistema, que esto asu vez implica hacer la compración de tablas de forma constante, teniendo un costo computacional mucho mas alto, por el contrario con NoSQL simplemente se utiliziaria una unica conulta con ayuda de funciones como .finOne(), el cual accede de forma directa al documento buscado sin necesidad de hacer más  uniones entre tablas como el uso de un join, lo que cuesta menos computacionalmente, reduciendo la carga de los servidores de base de datosy haciendo más rápida la consulta ._ |


---
1. Diseño del Modelo NoSQL (MongoDB)


```javascript
{
  "_id": "ObjectId('507f1f77bcf86cd799439011')",
  "nombre": "Dell XPS 15",
  "sku": "LAPTOP-DELL-XPS15-001",
  "precio": 1500.00,
  "stock": 15,
  "Categoria": "Laptop",
  "marca": "Asus",
  "fecha_llegada": "2024-10-15T10:30:00Z",
  "especificaciones": {
    "cpu": "Intel Core i7-12700H",
    "ram": 16,
    "almacenamiento": "1TB SSD",
    "tarjeta_grafica": "NVIDIA RTX 3050 4GB",
    "pantalla": "15.6\" FHD (1920x1080)",
    "sistema_operativo": "Windows 7",
    "bateria": "86 WHr",
    "puertos": ["2x USB-C Thunderbolt 4", "1x USB-A 3.2", "HDMI 2.1", "Audio Jack"],
    "dimensiones": {
      "alto_cm": 1.8,
      "ancho_cm": 34.4,
      "profundidad_cm": 23.0,
      "peso_kg": 1.86
    }
  },
  "garantia_meses": 10,
}
{
  "nombre": "Samsung Galaxy S23 Ultra",
  "sku": "PHONE-SAMSUNG-S23U-001",
  "precio": 1199.00,
  "stock": 25,
  "marca": "Samsung",
  "tipo_producto": "Smartphone",
  "especificaciones": {
    "pantalla": {
      "tamaño": "6.8\"",
      "tipo": "Dynamic AMOLED 2X",
      "resolucion": "3088 x 1440 (QHD+)"
    },
    "procesador": {
      "modelo": "Snapdragon 8 Gen 2 for Galaxy",
      "nucleos": 8
    },
    "ram_gb": 12,
    "almacenamiento": {
      "capacidad": "512GB"
    },
    "bateria": {
      "capacidad_mah": 5000,
      "carga_rapida": "45W"
    },
    "sistema_operativo": {
      "nombre": "Android 13"
    }
  },
  "colores_disponibles": [
    "Phantom Black",
    "Cream"
  ],
  "etiquetas": ["flagship", "5g", "camara-profesional"],
  "fecha_lanzamiento": "2023-02-17T00:00:00Z"
}

```
---
### 8. Resultados de la Ejecución

1. **Consultas de Lectura (Read):**  

## Consulta
// Consulta 1: Mostrar todos los productos en la colección
db.productos.find();

## Ejecución

![Mostrar todos los productos](images/Lectura_1.png)
![](images/Lectura_2.png)
![](images/Lectura_3.png)


## Consulta
// Consulta 2: Mostrar solo los productos que sean de tipo "Laptop"
db.productos.find({ tipo_producto: "Laptop" });

## Ejecución

![Mostrar Laptops](images/Consulta_2.png)
---
## Consulta
// Consulta 3: Mostrar los productos que tengan más de 10 unidades en stock Y un precio menor a 1000
db.productos.find({ 
  stock: { $gt: 10 }, 
  precio: { $lt: 1000 } 
});

## Ejecución

![Mostrar Laptops](images/Consulta_3.png)

---
## Consulta

// Consulta 4: Mostrar solo el nombre, precio y stock de los "Smartphone" (Proyección)
db.productos.find(
  { tipo_producto: "Smartphone" },
  { nombre: 1, precio: 1, stock: 1, _id: 0 }
);

## Ejecución

![Mostrar Laptops](images/Consulta_4.png)
---
## Consulta

db.productos.updateOne(
  { sku: "PHONE-SAMSUNG-S23U-001" },
  { $inc: { stock: -1 } }
);

## Ejecución

![Mostrar Laptops](images/Consulta_5.png)
---
## Consulta

// Operación 2: El precio de la Laptop ha subido. Actualice su precio y añada el campo ultima_revision
db.productos.updateOne(
  { sku: "LAPTOP-DELL-XPS15-001" },
  {
    $set: {
      precio: 1600.00,
      ultima_revision: new Date()
    }
  }
);


## Ejecución
![Mostrar Laptops](images/Consulta_6.png)
---
###  9. Análisis Reflexivo y responda de forma técnica y fundamentada a las siguientes preguntas


#### Pregunta 1: ¿Cuál fue la ventaja más significativa de usar un modelo de documento (MongoDB) para el caso "TechStore" en comparación con el modelo relacional que diseñó?

Una de sus ventajas es que solo se necesito un unico documento para definir las distintas caracteristicas o atributos que tenía cada producto, en el modelo relacional se necesitaria normalizar ciertos campos como  la categoria, marca, modelo ya que al ser tan repetitivos se deben separar en tablas,haciendo el diseño de la base de datos más complejo.

 Otra ventaja, es cuando los productos poseen distintos atributos entre ellos, en un modelo relacional, esto implicaria añadir más campos lo que a su vez implica tener muchos campos vacíos o sumar más tablas, afectando el esquema y haciendolo menos eficiente. Gracias a NoSQL en este clase de casos hace que el modelado y la estructura sea más fácil de adaptar y a su vez más flexible. 

#### Pregunta 2: ¿Cómo facilita el anidamiento de documentos (el campo especificaciones) la gestión de datos heterogéneos (diferentes atributos por producto)?

Este campo nos va a permitir almacenar atributos o detalles importantes de cada producto, al ser anidado en este mismo campo se podrán guardar varios atributos incluso si son distintos entre cada producto. Esto es mejor ya que facilitara la gestión de los datos heterogéneos, sin crear la necesidad de crear tablas adicionales o nuevos campos según los tipos de productos.

Esto da la ventaja de que cada producto tenga su conjunto de caracteristicas organizados y que se pueden encontrar en el mismo campo en este caso el campo 'especificaciones', permitiendo que todos los productos esten en una misma colección sin campos vaciós ni relaciones con otras tablas. 

#### Pregunta 3: ¿Qué problemas potenciales podría enfrentar esta base de datos a futuro si no se controla la flexibilidad del esquema (es decir, si se permite insertar cualquier dato)?

Una de sus desventajas podría ser los datos incosistentes es decir, campos con nombres distintos que guardan la misma infromación, con el tiempo esto podría retrasar consultas y hacer análisis de datos incorrectos. 

Tambien, al ser documentos con atributos distintos complica la implementación de validaciones, análisis o generación de reportes o hacer actualizaciones de foma másiva con ciertos atributos por lo que se complicaria la escalabilidad de la base de datos además que podría afectar el rendimiento y por ende consumir más recursos. 

#### Pregunta 4: ¿Qué paso técnico recomendaría a continuación para "profesionalizar" esta base de datos? (Piense en rendimiento e integridad de datos que no cubrimos en este laboratorio).

Con el fin de garantizar la integridad de los datos y evitar las inconsistencias mencionadas para evitar errores o duplicaciones, se recomienda añadir esquemás de validación mediante JSON Schema, que ayudaría a definir campos obligatorios y tipos de datos.

Tambien se podría añadir indices en campos que podrían ser más consultados para acelearar las busquedas y consultas. 

---
🐉✨