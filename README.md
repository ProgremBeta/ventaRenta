# Proyecto Venta Renta

> [!NOTE]
> Este proyecto combina backend en Node.js con Express y PostgreSQL, y frontend en Flutter.

## Estructura de carpeta

> [!WARNING]
> Como este proyecto esta actualmente en desarrollo, puede que no este actualizada la estructura de carpetas del proyecto

#### backend

## Paquetes usados

> [!TIP]
> Instala las dependencias ejecutando `npm install` en el directorio backend.

  * expres
  * dotenv
  * pg
  * cors

### Esquema para crear la tabla en la base de datos

> [!WARNING]
> Asegúrate de tener PostgreSQL configurado y una base de datos creada antes de ejecutar este esquema. Esta no va ser la estructura final, durante el desarrollo va cambiar deacuerdo a las necesidades del proyecto.

> [!NOTE]
> estructura de la base de datos V1

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
      sub_total DECIMAL(10, 2)
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

> [!NOTE]
> estructura de la base de datos V2

    CREATE TABLE roles(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL UNIQUE,
      activo BOOLEAN DEFAULT TRUE,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE usuarios(
      id SERIAL PRIMARY KEY,
      identificacion VARCHAR(20) UNIQUE NOT NULL, 
      nombre VARCHAR(150) NOT NULL,
      email VARCHAR(150) NOT NULL UNIQUE,
      telefono VARCHAR(30),
      contrasena_hash TEXT NOT NULL,
      rol_id INT NOT NULL REFERENCES roles(id),
      activo BOOLEAN DEFAULT TRUE,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE clientes(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(150) NOT NULL,
      email VARCHAR(150) NOT NULL,
      telefono VARCHAR(30),
      puntos INT DEFAULT 0,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE categorias_productos(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(150) NOT NULL,
      descripcion TEXT,
      activo BOOLEAN DEFAULT TRUE,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE categorias_dispositivos(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(150),
      descripcion TEXT,
      activo BOOLEAN DEFAULT TRUE,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE productos(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(150) NOT NULL,
      descripcion TEXT,
      precio DECIMAL(10, 2) NOT NULL,
      categoria_id INT NOT NULL REFERENCES categorias_productos(id),
      activo BOOLEAN DEFAULT TRUE,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE inventario_productos(
      id SERIAL PRIMARY KEY,
      producto_id INT UNIQUE REFERENCES productos(id) ON DELETE CASCADE,
      stock INTEGER NOT NULL,
      stock_minimo INT DEFAULT 0,
      activo BOOLEAN DEFAULT TRUE,
      fecha_actualizacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE ventas(
      id SERIAL PRIMARY KEY,
      usuario_id INT REFERENCES usuarios(id),
      cliente_id INT REFERENCES clientes(id),
      total DECIMAL(10, 2) NOT NULL,
      metodo_pago_id INT REFERENCES metodos_pagos(id),
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE detalles_ventas(
      id SERIAL PRIMARY KEY,
      venta_id INT REFERENCES ventas(id) ON DELETE CASCADE,
      producto_id INT REFERENCES productos(id),
      cantidad INT NOT NULL,
      precio_unitario DECIMAL(10, 2) NOT NULL,
      sub_total DECIMAL(10, 2) NOT NULL,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE dispositivos(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(150),
      categoria_id INT NOT NULL REFERENCES categorias_dispositivos(id),
      precio_hora DECIMAL(10, 2),
      estado VARCHAR(50),
      activo BOOLEAN DEFAULT TRUE,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE rentas(
      id SERIAL PRIMARY KEY,
      usuario_id INT REFERENCES usuarios(id),
      cliente_id INT REFERENCES clientes(id),
      fecha_inicio TIMESTAMP WITH TIME ZONE,
      fecha_fin TIMESTAMP WITH TIME ZONE,
      tiempo_total INTERVAL,
      precio_total DECIMAL(10, 2),
      metodo_pago_id INT REFERENCES metodos_pagos(id),
      estado VARCHAR(50),
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE detalles_rentas(
      id SERIAL PRIMARY KEY,
      renta_id INT REFERENCES rentas(id) ON DELETE CASCADE,
      dispositivo_id INT REFERENCES dispositivos(id),
      precio_hora DECIMAL(10, 2) NOT NULL,
      tiempo_total INTERVAL NOT NULL,
      sub_total DECIMAL(10, 2) NOT NULL,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE deudas(
      id SERIAL PRIMARY KEY,
      cliente_id INT REFERENCES clientes(id),
      monto_total DECIMAL(10, 2),
      monto_pagado DECIMAL(10, 2) DEFAULT 0,
      saldo DECIMAL(10, 2),
      estado VARCHAR(50),
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE detalles_deudas(
      id SERIAL PRIMARY KEY,
      deuda_id INT REFERENCES deudas(id) ON DELETE CASCADE,
      origen_tipo VARCHAR(50),
      origen_id INT,
      descripcion text,
      monto_pagado DECIMAL(10, 2) DEFAULT 0,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE pagos_deudas(
      id SERIAL PRIMARY KEY,
      deuda_id INT REFERENCES deudas(id) ON DELETE CASCADE,
      monto DECIMAL(10, 2),
      metodo_pago_id INT REFERENCES metodos_pagos(id),
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
      accion VARCHAR(150) NOT NULL,
      descripcion TEXT,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE metodos_pagos(
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL UNIQUE,
      descripcion TEXT,
      fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP      
    );

  >[!NOTE]
  > Esto se usa para hacer busquedas con mas eficiencia, buscando directamente donde estan los datos
  

    -- LOGIN
    CREATE INDEX idx_usuarios_email ON usuarios(email);
    CREATE INDEX idx_usuarios_identificacion ON usuarios(identificacion);

    -- VENTAS
    CREATE INDEX idx_ventas_fecha ON ventas(fecha_creacion);
    CREATE INDEX idx_ventas_usuario ON ventas(usuario_id);
    CREATE INDEX idx_ventas_cliente ON ventas(cliente_id);

    -- DETALLES
    CREATE INDEX idx_detalles_ventas_venta ON detalles_ventas(venta_id);

    -- RENTAS
    CREATE INDEX idx_rentas_fecha ON rentas(fecha_inicio);
    CREATE INDEX idx_rentas_usuario ON rentas(usuario_id);
    CREATE INDEX idx_rentas_cliente ON rentas(cliente_id);

    CREATE INDEX idx_detalles_rentas_renta ON detalles_rentas(renta_id);

    -- PRODUCTOS
    CREATE INDEX idx_productos_categoria ON productos(categoria_id);
    CREATE INDEX idx_inventario_producto ON inventario_productos(producto_id);

    -- DEUDAS
    CREATE INDEX idx_deudas_cliente ON deudas(cliente_id);
    CREATE INDEX idx_pagos_deuda ON pagos_deudas(deuda_id);

    -- DISPOSITIVOS
    CREATE INDEX idx_dispositivos_categoria ON dispositivos(categoria_id);

    -- LOGS
    CREATE INDEX idx_logs_usuario ON logs(usuario_id);



### Notas de desarrollo

>[!WARNING]
> Estas notas de desarrollo estan para tener encuenta los cosas que me falta implementar o cosas que me resultaron utiles en el desarrollo, dicho esto, este apartado se eliminara o va ir cambiendo deacuerdo al desarrollo o al finalizarlo el mismo.

  * la mayoria de request necesitan condicionales pues muestran errores generales y quiero que el usuario sepa en que esta equivocado y corregir la falla o saber si fue un problema de entrada de datos o del sistema.

  * al intentar crear algunos valores a la base de datos no deja, por que se declaro cuando se creo la base de datos como valores en las tablas que dependen de otros valores de otras tablas o que estan limitados hasta cierta cantidad de caracteres. Entonces voy a cambiar en algunos valores de algunas tablas el limite de caracteres permitidos.

  *entonces hay que tener en cuenta que cuando sale un valor null o salga con errores de "tipo de datos incorrectos" mayormente se debe a la cantidad de caracteres permitidos

  * en el backend hay un archivo PruebasREST.http que la uso con la extension en visual studio code https://marketplace.visualstudio.com/items?itemName=humao.rest-client para hacer las pruebas rapidas.

  * la estructura de la base de datos hace falta actualizar algunos casos para se adecuen al proposito del programa, tener mas control y mejorar los registros.

  * en shared esta el archivo de transicion que es para evitar errores al hacer las peticiones, en si entra en un estado de transicion que inicia con BEGIN, si no hay errores hace el COMMIT y si hay algun fallo hacer un ROCKBALL que revierte los cambios hechos durante ese estado. Esto no esta completamente implementado ya que con las condicionales no han habido mayores problemas pero de igual forma lo quiero implementar para tener mas seguridad y no tener fallos.

  * uufff el abrir el visual con los 2 repositorios el del backend y frontend que es un repo monolib parece que se va estallar mi pc

  * unos de los cambios drastricos en la base de datos va ser en rentas, renta_dispositivos, dispositivos ya que no tiene un flujo correcto y me equivoque al asignarlos para que tenga un coerenci entre el nombre y su proposito. De momento tengo pensado en hacer cambios a :
    * renta
    * renta_dispositivos

  * la tabla de usuarios necesita una columna que sea de ID o cambiarlo para que al ingresar el usuario el identificador sea un numero que vaya aumentando, si no, con el numero de identificacion para que funcione el login, de momento voy hacer el login con el numero de identificacion para cuando realize la restructuracion de la base de datos no cambie la logica.

  * estaba tratando de manejar esta estructura de carpetas de una forma que pense que estaba correcto pero me di cuenta de que no la supe manejar o no la entendi, entonces voy hacer otro gran cambio ya que lo que estaba haciendo ya me parecia enredando, los archivos que estaba haciendo y la gran parte de los endpoints no los voy a usar, entonces estoy optando por dejar solo lo que se necesita y se va a usar.