# Proyecto Venta Renta

## Estructura inicial del proyecto

* ventaRenta
  * backend/
    * package.json
    * src/
      * config/
      * modules/
      * shared/
      * app.js
      * server.js
  * frontend
    * ("En desarrollo")
* .env
* .gitignore
* Reame.md

## Paquetes usados

  * expres
  * dotenv
  * pg
  * cors

### Esquema para crear la tabla en la base de datos

  CREATE TABLE roles(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
  );
  CREATE TABLE usuarios(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL,
    contrasena_hash TEXT NOT NULL,
    rol_id INT NOT NULL REFERENCES roles(id),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE clientes(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    telefono VARCHAR(20),
    puntos INT DEFAULT 0,
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE categorias_producto(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
  );
  CREATE TABLE productos(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    categoria_id INT NOT NULL REFERENCES categorias_producto(id),
    activo BOOLEAN DEFAULT TRUE
  );
  CREATE TABLE inventario_productos(
    id SERIAL PRIMARY KEY,
    producto_id INT UNIQUE REFERENCES productos(id) ON DELETE CASCADE,
    stock INTEGER NOT NULL,
    fecha_actualizacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE ventas(
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    cliente_id INT REFERENCES clientes(id),
    total DECIMAL(10, 2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE detalle_ventas(
    id SERIAL PRIMARY KEY,
    venta_id INT REFERENCES ventas(id) ON DELETE CASCADE,
    producto_id INT REFERENCES productos(id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2),
    subtotal DECIMAL(10, 2)
  );
  CREATE TABLE categorias_dispositivo(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
  );
  CREATE TABLE dispositivos(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150),
    categoria_id INT NOT NULL REFERENCES categorias_dispositivo(id),
    precio_hora DECIMAL(10, 2),
    estado VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE
  );
  CREATE TABLE rentas(
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    usuario_id INT REFERENCES usuarios(id),
    fecha_inicio TIMESTAMP WITH TIME ZONE,
    fecha_fin TIMESTAMP WITH TIME ZONE,
    tiempo_total INTERVAL,
    precio_total DECIMAL(10, 2),
    metodo_pago VARCHAR(50),
    estado VARCHAR(50)
  );
  CREATE TABLE renta_dispositivos(
    id SERIAL PRIMARY KEY,
    renta_id INT REFERENCES rentas(id) ON DELETE CASCADE,
    dispositivo_id INT REFERENCES dispositivos(id),
    precio_hora DECIMAL(10, 2)
  );
  CREATE TABLE deudas(
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    origen_tipo VARCHAR(50),
    origen_id INT,
    monto_total DECIMAL(10, 2),
    monto_pagado DECIMAL(10, 2) DEFAULT 0,
    saldo DECIMAL(10, 2),
    estado VARCHAR(50),
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE pagos_deuda(
    id SERIAL PRIMARY KEY,
    deuda_id INT REFERENCES deudas(id) ON DELETE CASCADE,
    monto DECIMAL(10, 2),
    metodo_pago VARCHAR(50),
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE alertas(
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    tipo VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    leida BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE logs(
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    accion VARCHAR(100),
    descripcion TEXT,
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );


### Notas de desarrollo

  * a la mayoria de request necesitan condicionales pues muestran errores generales y quiero que el usuario sepa en que esta equivocado y solucionar o corregir el error.

  * al intentar crear un valor algunos datos no deja por que como ya se declaro en la creacion de la base de datos hay tablas que dependen de otros datos, como en la tabla cliente necesita un producto_id pero si no existe salta error.

  * al hacer peticiones la estructura de las tablas de la bse de datos salen con algunos errores o con un tipo diferente y salen nulos o que no acepta tantos valores

  * en el backend hay un archivo PruebasREST.http que la uso con la extension https://marketplace.visualstudio.com/items?itemName=humao.rest-client para hacer las pruebas de las rest y saber que de momento todo esta correcto o funcional.