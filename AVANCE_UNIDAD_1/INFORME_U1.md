# Informe Técnico 
---

**Autor:** Guerra Jennifer
**Fecha:** 2 de Noviembre, 2025  
**Proyecto:** Proyecto Avance 1: Arquitectura de Datos Fuente

---

###   Proyecto Macro: Solución de Business Intelligence para "TechStore"

#### 1.    Justificación del Modelo Dual

##### Uso de SQL para manejar sistema de ventas

El lenguaje SQL trabaja con datos estructurados, que se caracterizan por estar organizados en formatos ordenados, congruentes y predefinidos. Este tipo de datos pueden ser transacciones financieras, registros de inventario o listas de clientes que frecuentemente son manejados en base de datos SQL.

Las bases de datos SQL son base de datos relacionales que como se mencionó anteriormente trabajan con datos estructurados que son almacenados dentro de filas y columnas para crear tablas. Son relacionales por que a través de claves foráneas se crean relaciones entre dos o más tablas.

--- 

En el presente proyecto techstore_sales, se utilizó MySQL (Base de datos relacional) para manejar el sistema de ventas. Esta elección fue tomada por: 

* Las ventas se caracterizan por tener: clientes, sucursales y detalles de la venta, las cuales son relaciones. Con ayuda de las Foreign Keys se puede asegurar que no haya ventas a las que le falten datos críticos como una venta sin cliente o sucursal. 
  
* Otra cosa que lo caracteriza, es que la estructura de una venta es siempre la misma es decir que es predecible y estable. En este caso, siempre se van a ingresar los mismos datos: cliente, sucursal, fecha, productos. Es decir que estos no cambian de forma frecuente. Al ser de esquema rígido se previenen errores y se mantiene la consistencia. 

* Además las bases de datos relacionales son más usadas como base de datos transaccionales, ya que son usadas para registrar transacciones, garantizar la integridad de los datos y aplicar el modelo ACID:             
    - Atomicidad: Si la venta no se ejecuta de forma completa no se ejecuta, lo que evita registros parciales. 
    - Consistencia:  Las llaves foráneas aseguran que los datos esten relacionados entre sí cumpliendo con las restricciones del modelo y las reglas de integrodad.
    - Aislamiento: Puedan ocurrir múltiples ventas al mismo tiempo, sin que afecten el resultado entre sí. 
    - Durabilidad: Datos que se guarden de forma permanentes y que se han resistente ante fallos del sistema. 

Lo que los hace perfecto para sistemas que requieren exactitud como el sistema de ventas de TechStore. 

* Las bases de datos SQL tambien priorizan la Consistencia y la Disponibilidad (CA), garantizando los resultados precisos y confiables en cada transacción, ideal para un sistema de ventas, donde los errores o datos duplicados no pueden permitirse. 
##### Uso de NoSQL para manejar Productos

Las bases de datos NoSQL, poseen un esquema mucho más flexible, se caracterizan por trabajar con datos no estructurados o semi estructurado. NoSQL almacenan datos que pueden tener diferentes estructuras de datos que pueden estar dentro de la misma colección. 

Existen distintos tipos de bases de datos NoSQL como de documentos, las cuales almacenan objetos tipo JSON. Cada documento es parecido a un registro y puede tener valores que incluyen números, matrices, objetos, cadenas o incluso caracteres booleanos. Pueden tener pares clave-valor, documentos anidados u otros datos estructurados. 



---

Para el proyecto techstore_inventory, se utilizó MongoDB la cual es una Base de Datos NoSQL Documental que se rige por el modelo BASE, el cual prioriza la disponibilidad y la escabilidad frente a la consistencia inmediata, ya que el sistema puede responder aunque una paste del cluster este fallando, los datos pueden estar en transacciones incluso si se estuvieran actualizando, además que se pueden ver los datos actualizados con el tiempo, es decir que todos los nodos se sincronizan y terminan mostrando el mismo valor.

Mongo DB se clasifica como una base AP en la perspectiva del teormea CAP, ya que puede sacrificar la consistencia estricta a cambio de rendimiento y flexibilidad.


La elección de SQL para el manejo de productos fue tomada por: 

* Cada uno de los productos, poseía especificaciones y características distintas, al tener productos como laptops, monitores o Smartphones que cuentan con atributos diferentes en una base de datos SQL se debe buscar opciones distintas como por ejemplo crear una tabla para cada uno, mientras que en una base de datos NoSQL se pueden almacenar todos en una misma colección a pesar de cada documento tenga valores distintos. Es decir que no se tiene una estructura rígida predefinida para todos los productos y permite almacenar documentos con estructuras variadas.
  
* Un catálogo de productos se suele consultar de forma frecuente, por lo que al no tener varias tablas el tiempo de consulta es mucho más rápido. 
  
* Si se quiere añadir nuevas categorías algún producto no requiere modificar el esquema ni requiere ALTER TABLE como se haría en SQL, por lo que es más flexible en cambios. 




---

####  2.    Informe de Calidad de Datos

##### Integración entre Ambos Sistemas

* En este proyecto se realiza la integración de NoSQL y SQL a través del campo sku_productos donde: 

* SQL (Detalle_Ventas): Almacena sku_producto como referencia
NoSQL (productos): Almacena el documento completo del producto con su sku

##### Problemas potenciales de calidad de datos en los sistemas de origen

**1. Inconsistencia en la integridad referencial**

Uno de los problemas que se puede presentar es un problema de integridad, donde Detalle_Ventas.sku_producto (SQL) podría almacenarse un SKU que no existe en la colección productos, esto puede tener varias causas como:
   
   * Productos eliminado en MongoDB
   * Ingreso erróneo de SKU 

Esto puede hacer que haya errores como reportes incompletos o erróneos, no poder obtener detalles del producto, entre otros. 

Una forma de evitarlo es añadir validaciones o funciones que verifique que el producto exista en MongoDB antes de insertarlo en SQL. 

**2. Mismo SKU para distintos productos en MongoDB**

Si no se aplica una validación correcta a nivel de mongo db, dos o más productos podrían tener un mismo SKU, lo que causaría que: 

   * No se sabría cuál de los 2 productos se vendió
   * Inventario descuadrado
   * Consultas finOne() impredecibles, ya que lanzaría cualquiera de los dos productos.  

Esto se puede arreglar, creando un índice único en el campo sku haciendo que MongoDB rechace duplicados, además se puede incluir una función que antes de insertar verifique que existe un sku igual.

**3. Inconsistencia y Falta de Estandarización en Datos de Texto**

Otro problema puede ser la falta de normalización y validación consistente. En el caso de SQL se podrían insertar datos incorrectos como por ejemplo un formato de a-mail invalido, múltiples ingresos de una misma ciudad con formato distintos como “Quito", "quito", "QUITO", "Kito". Nombres con espacios extras, números, caracteres especiales, etc. O incluso números con formatos variados. Mientras que en NoSQL también se podrían tener mismas Marcas, modelos iguales pero con distintos formatos. 

Esto se debe a: 

 * Validación insuficiente en la capa de aplicación
 * Formularios sin validación frontend/backend
 * Entrada manual de datos sin restricciones
 * Falta de catálogos o listas desplegables para campos repetitivos

Esto se puede arreglar añadiendo funciones de normalización de texto como poner todo en mayúscula o minúscula, validaciones o constraint para emails, en mongo db el uso de JSON Schema Validator. 

--- 
### Referencia

**MongoDB, (d.f.)**, Descripción de las bases de datos SQL frente a NoSQL. https://www.mongodb.com/es/resources/basics/databases/nosql-explained/nosql-vs-sql 
