-- CreateTable
CREATE TABLE "alertas" (
    "id" SERIAL NOT NULL,
    "usuario_id" INTEGER,
    "tipo" VARCHAR(50) NOT NULL,
    "descripcion" TEXT NOT NULL,
    "visto" BOOLEAN DEFAULT false,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "alertas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categorias_dispositivos" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(150),
    "descripcion" TEXT,
    "activo" BOOLEAN DEFAULT true,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "categorias_dispositivos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categorias_productos" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "descripcion" TEXT,
    "activo" BOOLEAN DEFAULT true,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "categorias_productos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clientes" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "email" VARCHAR(150) NOT NULL,
    "telefono" VARCHAR(30),
    "puntos" INTEGER DEFAULT 0,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "clientes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalles_deudas" (
    "id" SERIAL NOT NULL,
    "deuda_id" INTEGER,
    "origen_tipo" VARCHAR(50),
    "origen_id" INTEGER,
    "descripcion" TEXT,
    "monto_pagado" DECIMAL(10,2) DEFAULT 0,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "detalles_deudas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalles_rentas" (
    "id" SERIAL NOT NULL,
    "renta_id" INTEGER,
    "dispositivo_id" INTEGER,
    "precio_hora" DECIMAL(10,2) NOT NULL,
    "tiempo_total" interval NOT NULL,
    "sub_total" DECIMAL(10,2) NOT NULL,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "detalles_rentas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalles_ventas" (
    "id" SERIAL NOT NULL,
    "venta_id" INTEGER,
    "producto_id" INTEGER,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DECIMAL(10,2) NOT NULL,
    "sub_total" DECIMAL(10,2) NOT NULL,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "detalles_ventas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deudas" (
    "id" SERIAL NOT NULL,
    "cliente_id" INTEGER,
    "monto_total" DECIMAL(10,2),
    "monto_pagado" DECIMAL(10,2) DEFAULT 0,
    "saldo" DECIMAL(10,2),
    "estado" VARCHAR(50),
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "deudas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dispositivos" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(150),
    "categoria_id" INTEGER NOT NULL,
    "precio_hora" DECIMAL(10,2),
    "estado" VARCHAR(50),
    "activo" BOOLEAN DEFAULT true,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "dispositivos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventario_productos" (
    "id" SERIAL NOT NULL,
    "producto_id" INTEGER,
    "stock" INTEGER NOT NULL,
    "stock_minimo" INTEGER DEFAULT 0,
    "activo" BOOLEAN DEFAULT true,
    "fecha_actualizacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "inventario_productos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "logs" (
    "id" SERIAL NOT NULL,
    "usuario_id" INTEGER,
    "accion" VARCHAR(150) NOT NULL,
    "descripcion" TEXT,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "metodos_pagos" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "descripcion" TEXT,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "metodos_pagos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pagos_deudas" (
    "id" SERIAL NOT NULL,
    "deuda_id" INTEGER,
    "monto" DECIMAL(10,2),
    "metodo_pago" INTEGER,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pagos_deudas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "productos" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "descripcion" TEXT,
    "precio" DECIMAL(10,2) NOT NULL,
    "categoria_id" INTEGER NOT NULL,
    "activo" BOOLEAN DEFAULT true,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "productos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rentas" (
    "id" SERIAL NOT NULL,
    "usuario_id" INTEGER,
    "cliente_id" INTEGER,
    "fecha_inicio" TIMESTAMPTZ(6),
    "fecha_fin" TIMESTAMPTZ(6),
    "tiempo_total" interval,
    "precio_total" DECIMAL(10,2),
    "metodo_pago" INTEGER,
    "estado" VARCHAR(50),
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "rentas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "activo" BOOLEAN DEFAULT true,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usuarios" (
    "id" SERIAL NOT NULL,
    "identificacion" VARCHAR(20) NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "email" VARCHAR(150) NOT NULL,
    "telefono" VARCHAR(30),
    "contrasena_hash" TEXT NOT NULL,
    "rol_id" INTEGER NOT NULL,
    "activo" BOOLEAN DEFAULT true,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ventas" (
    "id" SERIAL NOT NULL,
    "usuario_id" INTEGER,
    "cliente_id" INTEGER,
    "total" DECIMAL(10,2) NOT NULL,
    "metodo_pago" INTEGER,
    "fecha_creacion" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ventas_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_detalles_rentas_renta" ON "detalles_rentas"("renta_id");

-- CreateIndex
CREATE INDEX "idx_detalles_ventas_venta" ON "detalles_ventas"("venta_id");

-- CreateIndex
CREATE INDEX "idx_deudas_cliente" ON "deudas"("cliente_id");

-- CreateIndex
CREATE INDEX "idx_dispositivos_categoria" ON "dispositivos"("categoria_id");

-- CreateIndex
CREATE UNIQUE INDEX "inventario_productos_producto_id_key" ON "inventario_productos"("producto_id");

-- CreateIndex
CREATE INDEX "idx_inventario_producto" ON "inventario_productos"("producto_id");

-- CreateIndex
CREATE INDEX "idx_logs_usuario" ON "logs"("usuario_id");

-- CreateIndex
CREATE UNIQUE INDEX "metodos_pagos_nombre_key" ON "metodos_pagos"("nombre");

-- CreateIndex
CREATE INDEX "idx_pagos_deuda" ON "pagos_deudas"("deuda_id");

-- CreateIndex
CREATE INDEX "idx_productos_categoria" ON "productos"("categoria_id");

-- CreateIndex
CREATE INDEX "idx_rentas_cliente" ON "rentas"("cliente_id");

-- CreateIndex
CREATE INDEX "idx_rentas_fecha" ON "rentas"("fecha_inicio");

-- CreateIndex
CREATE INDEX "idx_rentas_usuario" ON "rentas"("usuario_id");

-- CreateIndex
CREATE UNIQUE INDEX "roles_nombre_key" ON "roles"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_identificacion_key" ON "usuarios"("identificacion");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE INDEX "idx_usuarios_email" ON "usuarios"("email");

-- CreateIndex
CREATE INDEX "idx_usuarios_identificacion" ON "usuarios"("identificacion");

-- CreateIndex
CREATE INDEX "idx_ventas_cliente" ON "ventas"("cliente_id");

-- CreateIndex
CREATE INDEX "idx_ventas_fecha" ON "ventas"("fecha_creacion");

-- CreateIndex
CREATE INDEX "idx_ventas_usuario" ON "ventas"("usuario_id");

-- AddForeignKey
ALTER TABLE "alertas" ADD CONSTRAINT "alertas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_deudas" ADD CONSTRAINT "detalles_deudas_deuda_id_fkey" FOREIGN KEY ("deuda_id") REFERENCES "deudas"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_rentas" ADD CONSTRAINT "detalles_rentas_dispositivo_id_fkey" FOREIGN KEY ("dispositivo_id") REFERENCES "dispositivos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_rentas" ADD CONSTRAINT "detalles_rentas_renta_id_fkey" FOREIGN KEY ("renta_id") REFERENCES "rentas"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_ventas" ADD CONSTRAINT "detalles_ventas_producto_id_fkey" FOREIGN KEY ("producto_id") REFERENCES "productos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_ventas" ADD CONSTRAINT "detalles_ventas_venta_id_fkey" FOREIGN KEY ("venta_id") REFERENCES "ventas"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "deudas" ADD CONSTRAINT "deudas_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "clientes"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dispositivos" ADD CONSTRAINT "dispositivos_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categorias_dispositivos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventario_productos" ADD CONSTRAINT "inventario_productos_producto_id_fkey" FOREIGN KEY ("producto_id") REFERENCES "productos"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "logs" ADD CONSTRAINT "logs_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos_deudas" ADD CONSTRAINT "pagos_deudas_deuda_id_fkey" FOREIGN KEY ("deuda_id") REFERENCES "deudas"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos_deudas" ADD CONSTRAINT "pagos_deudas_metodo_pago_fkey" FOREIGN KEY ("metodo_pago") REFERENCES "metodos_pagos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "productos" ADD CONSTRAINT "productos_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categorias_productos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rentas" ADD CONSTRAINT "rentas_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "clientes"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rentas" ADD CONSTRAINT "rentas_metodo_pago_fkey" FOREIGN KEY ("metodo_pago") REFERENCES "metodos_pagos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rentas" ADD CONSTRAINT "rentas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_rol_id_fkey" FOREIGN KEY ("rol_id") REFERENCES "roles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ventas" ADD CONSTRAINT "ventas_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "clientes"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ventas" ADD CONSTRAINT "ventas_metodo_pago_fkey" FOREIGN KEY ("metodo_pago") REFERENCES "metodos_pagos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ventas" ADD CONSTRAINT "ventas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
