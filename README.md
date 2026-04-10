# Proyecto Venta Renta

> [!NOTE]
> Este proyecto combina backend en Node.js con Express y PostgreSQL, y frontend en Flutter.

## Estructura inicial del proyecto

> [!WARNING]
> Como este proyecto esta actualmente en desarrollo, puede que no este actualizada la estructura de carpetas del proyecto

* .env
* package.json
* package-lock.json
* PruebasREST.http
* server.js
* src
    * app.js
    * config
      * db.config.js
    * database
      * schema.sql
    * modules
      * alertas
        * alertas.controller.js
        * alertas.repository.js
        * alertas.routes.js
        * alertas.service.js
      * categorias_dispositivos
        * categorias_dispositivos.controller.js
        * categorias_dispositivos.repository.js
        * categorias_dispositivos.routes.js
        * categorias_dispositivos.service.js
      * categorias_productos
        * categorias_productos.controller.js
        * categorias_productos.repository.js
        * categorias_productos.routes.js
        * categorias_productos.service.js
      * clientes
        * clientes.controller.js
        * clientes.repositorys.js
        * clientes.routes.js
        * clientes.service.js
      * detalles_renta
        * detalles_renta.controller.js
        * detalles_renta.repository.js
        * detalles_renta.routes.js
        * detalles_renta.service.js
      * detalles_ventas
        * detalles_ventas.controller.js
        * detalles_ventas.repository.js
        * detalles_ventas.routes.js
        * detalles_ventas.service.js
      * deudas
        * deudas.controller.js
        * deudas.repository.js
        * deudas.routes.js
        * deudas.service.js
      * dispositivos
        * dispositivos.controller.js
        * dispositivos.repository.js
        * dispositivos.routes.js
        * dispositivos.service.js
      * inventario_productos
        * inventario_productos.controller.js
        * inventario_productos.repository.js
        * inventario_productos.routes.js
        * inventario_productos.service.js
      * logs
        * logs.controller.js
        * logs.repository.js
        * logs.routes.js
        * logs.service.js
      * pagos_deuda
        * pagos_deudas.controller.js
        * pagos_deudas.repository.js
        * pagos_deudas.routes.js
        * pagos_deudas.service.js
      * productos
        * productos.controller.js
        * productos.repository.js
        * productos.routes.js
        * productos.service.js
      * renta
        * renta.controller.js
        * renta.repository.js
        * renta.routes.js
        * renta.service.js
      * renta_dispositivos
        * renta_dispositivos.repository.js
      * roles
        * roles.controller.js
        * roles.repository.js
        * roles.routes.js
        * roles.service.js
      * usuario
        * usuarios.controller.js
        * usuarios.repository.js
        * usuarios.routes.js
        * usuarios.service.js
      * ventas
        * ventas.controller.js
        * ventas.repository.js
        * ventas.routes.js
        * ventas.service.js
    * shared
      * utils
        * transicion.js
    * use_cases
        * crear_productos
          * crear_productos.controller.js
          * crear_productos.routes.js
          * crear_productos.service.js
        * crear_usuario
          * crear_usuario.controller.js
          * crear_usuario.routes.js
          * crear_usuario.service.js
        * crear_venta
          * crear_venta.controller.js
          * crear_venta.routes.js
          * crear_venta.service.js
        * iniciar_renta
          * iniciar_renta.service.js

## Paquetes usados

> [!TIP]
> Instala las dependencias ejecutando `npm install` en el directorio backend.

  * expres
  * dotenv
  * pg
  * cors

### Esquema para crear la tabla en la base de datos

> [!WARNING]
> Asegúrate de tener PostgreSQL configurado y una base de datos creada antes de ejecutar este esquema.

> Esta no va ser la estructura final, durante el desarrollo va cambiar deacuerdo a las necesidades del proyecto.

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

>[!WARNING]
> Estas notas de desarrollo estan para tener encuenta los cosas que me falta implementar o cosas que me resultaron utiles en el desarrollo, dicho esto, este apartado se eliminara o va ir cambiendo deacuerdo al desarrollo o al finalizarlo el mismo.

  * a la mayoria de request necesitan condicionales pues muestran errores generales y quiero que el usuario sepa en que esta equivocado y solucionar o corregir el error.

  * al intentar crear un valor algunos datos no deja por que como ya se declaro en la creacion de la base de datos hay tablas que dependen de otros datos, como en la tabla cliente necesita un producto_id pero si no existe salta error.

  * al hacer peticiones la estructura de las tablas de la bse de datos salen con algunos errores o con un tipo diferente y salen nulos o que no acepta tantos valores

  * en el backend hay un archivo PruebasREST.http que la uso con la extension https://marketplace.visualstudio.com/items?itemName=humao.rest-client para hacer las pruebas de las rest y saber que de momento todo esta correcto o funcional.

  * la estructura de la base de datos hace falta actualizar algunos casos para se adecuen al proposito del programa, tener mas control y mejorar los registros.

  * la estructura de archivos tiene el moduls que tiene modulos que manejar REST hacia la base de datos y en use_cases estan los modulos que tiene el flujo de negocio para que al hacer un peticion de venta hacer la venta, hacer el detalle de venta, saber si existe el producto, descontar el inventario y si existe el cliente dar puntos.

  * en shared esta el archivo de transicion que es para evitar errores al hacer las peticiones, en si entra en un estado de transicion que inicia con BEGIN, si no hay errores hace el COMMIT y si hay algun fallo hacer un ROCKBALL que revierte los cambios hechos durante ese estado. Esto no esta completamente implementado ya que con las condicionales no han habido mayores problemas pero de igual forma lo quiero implementar para tener mas seguridad y no tener fallos.

  * uufff el abrir el visual con los 2 repositorios el del backend y frontend que es un repo monolib parece que se va estallar mi pc

  * unos de los cambios drastricos en la base de datos va ser en rentas, renta_dispositivos, dispositivos ya que no tiene un flujo correcto y me equivoque al asignarle los nombre. primero - en renta es como los datos principales como el cliente, usuario, tiempo total, precio total, metodo de pago. segundo - en renta_dispositivos le queda mejor detalles_renta y que este tenga bien resgistrado los detalles los cuales no he definido.