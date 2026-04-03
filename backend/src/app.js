import express from 'express';
import connectDB from './config/db.conexion.js';
import cors from 'cors';

import alertasRoutes from './modules/alertas/alertas.routes.js';
import categoriasDispositivosRoutes from './modules/categorias_dispositivos/categorias_dispositivos.routes.js';
import categoriasProductosRoutes from './modules/categorias_productos/categorias_productos.routes.js';
import clienteRoutes from './modules/clientes/clientes.routes.js';
import detallesVentasRouter from './modules/detalles_ventas/detalles_ventas.routes.js';
import deudasRoutes from './modules/deudas/deudas.routes.js';
import dispositivosRoutes from './modules/dispositivos/dispositivos.routes.js';
import inventarioProductosRoutes from './modules/inventario_productos/inventario_productos.routes.js';
import logsRoutes from './modules/logs/logs.routes.js';
import pagoDeudaRoutes from './modules/pagos_deuda/pagos_deudas.routes.js';
import productosRoutes from './modules/productos/productos.routes.js';
import rentaRoutes from './modules/renta/renta.routes.js';
import rentaDispositivosRoutes from './modules/renta_dispositivos/renta_dispositivos.routes.js';
import rolesRoutes from './modules/roles/roles.routes.js';
import usuarioRoutes from './modules/usuario/usuarios.routes.js';
import ventasRoutes from './modules/ventas/ventas.routes.js';

connectDB();

const app = express();

app.use(express.json());
app.use(cors());

//Rutas
app.use('/api', alertasRoutes);
app.use('/api', categoriasDispositivosRoutes);
app.use('/api', categoriasProductosRoutes);
app.use('/api', clienteRoutes);
app.use('/api', detallesVentasRouter);
app.use('/api', dispositivosRoutes);
app.use('/api', deudasRoutes);
app.use('/api', inventarioProductosRoutes);
app.use('/api', logsRoutes);
app.use('/api', pagoDeudaRoutes);
app.use('/api', productosRoutes);
app.use('/api', rentaRoutes);
app.use('/api', rentaDispositivosRoutes);
app.use('/api', rolesRoutes);
app.use('/api', usuarioRoutes);
app.use('/api', ventasRoutes);

app.get("/", (req, res) => {
  res.send('Hola bienvenido al backend de mi API para programa de venta y renta');
});

export default app;