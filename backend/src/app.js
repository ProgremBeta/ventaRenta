import express from 'express';
import cors from 'cors';

import alertasRoutes from './modules/alertas/alertas.routes.js';
import categoriasDispositivosRoutes from './modules/categorias_dispositivos/categorias_dispositivos.routes.js';
import categoriasProductosRoutes from './modules/categorias_productos/categorias_productos.routes.js';
import clienteRoutes from './modules/clientes/clientes.routes.js';
import detallesVentasRouter from './modules/detalles_ventas/detalles_ventas.routes.js';
import detallesRentaRouter from './modules/detalles_renta/detalles_renta.routes.js';
import deudasRoutes from './modules/deudas/deudas.routes.js';
import dispositivosRoutes from './modules/dispositivos/dispositivos.routes.js';
import inventarioProductosRoutes from './modules/inventario_productos/inventario_productos.routes.js';
import logsRoutes from './modules/logs/logs.routes.js';
import pagosDeudaRoutes from './modules/pagos_deuda/pagos_deudas.routes.js';
import productosRoutes from './modules/productos/productos.routes.js';
import rentaRoutes from './modules/renta/renta.routes.js';
import rolesRoutes from './modules/roles/roles.routes.js';
import usuarioRoutes from './modules/usuario/usuarios.routes.js';
import ventasRoutes from './modules/ventas/ventas.routes.js';

import nuevaVentaRoutes from './use_cases/crear_venta/crear_venta.routes.js';
import nuevoProductoRoutes from './use_cases/crear_productos/crear_productos.routes.js';
import nuevoUsuarioRoutes from './use_cases/crear_usuario/crear_usuario.routes.js';
import inicarRentaRoutes from './use_cases/iniciar_renta/iniciar_renta.routes.js';
import crearDeudaRoutes from './use_cases/crear_deuda/crear_deuda.routes.js';
import pagoDeudaRoutes from './use_cases/pago_deuda/pago_deuda.routes.js';

const app = express();

app.use(express.json());
app.use(cors());

//Rutas
app.use('/api/alertas', alertasRoutes);
app.use('/api/categorias_dispositivos', categoriasDispositivosRoutes);
app.use('/api/categorias_productos', categoriasProductosRoutes);
app.use('/api/clientes', clienteRoutes);
app.use('/api/detalles_renta', detallesRentaRouter);
app.use('/api/detalles_venta', detallesVentasRouter);
app.use('/api/dispositivos', dispositivosRoutes);
app.use('/api/deudas', deudasRoutes);
app.use('/api/inventario_productos', inventarioProductosRoutes);
app.use('/api/logs', logsRoutes);
app.use('/api/pago_deuda', pagosDeudaRoutes);
app.use('/api/productos', productosRoutes);
app.use('/api/renta', rentaRoutes);
app.use('/api/roles', rolesRoutes);
app.use('/api/usuarios', usuarioRoutes);
app.use('/api/ventas', ventasRoutes);

app.use('/api/nueva_venta', nuevaVentaRoutes);
app.use('/api/nuevo_producto', nuevoProductoRoutes);
app.use('/api/nuevo_usuario', nuevoUsuarioRoutes);
app.use('/api/iniciar_renta', inicarRentaRoutes);
app.use('/api/crear_deuda', crearDeudaRoutes);
app.use('/api/pago_deuda', pagoDeudaRoutes);

app.get("/", (req, res) => {
  res.send('Hola bienvenido al backend de mi API para programa de venta y renta');
});

export default app;