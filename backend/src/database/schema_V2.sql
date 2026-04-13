CREATE TABLE roles(
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  activo BOOLEAN DEFAULT TRUE,
  fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE metodos_pagos(
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  descripcion TEXT,
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

CREATE TABLE usuarios(
  id SERIAL PRIMARY KEY,
  identificacion VARCHAR(20) NOT NULL UNIQUE, 
  nombre VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  telefono VARCHAR(30),
  contrasena_hash TEXT NOT NULL,
  rol_id INT NOT NULL REFERENCES roles(id),
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
  metodo_pago INT REFERENCES metodos_pagos(id),
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
  metodo_pago INT REFERENCES metodos_pagos(id),
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
  metodo_pago INT REFERENCES metodos_pagos(id),
  fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alertas(
  id SERIAL PRIMARY KEY,
  usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
  tipo VARCHAR(50) NOT NULL,
  descripcion TEXT NOT NULL,
  visto BOOLEAN DEFAULT FALSE,
  fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs(
  id SERIAL PRIMARY KEY,
  usuario_id INT REFERENCES usuarios(id),
  accion VARCHAR(150) NOT NULL,
  descripcion TEXT,
  fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


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