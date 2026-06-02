import express from 'express';
import cors from 'cors';

import categoriasProductosRoutes from './modules/categorias_productos/categorias_productos.routes.js';
import categoriasDispositivosRoutes from './modules/categorias_dispositivos/categorias_dispositivos.routes.js';
import rolesRoutes from './modules/roles/roles.routes.js';

import nuevaVentaRoutes from './modules/nueva_venta/nueva_venta.routes.js';
import nuevoProductoRoutes from './modules/nuevo_producto/nuevo_producto.routes.js';
import nuevoUsuarioRoutes from './modules/nuevo_usuario/nuevo_usuario.routes.js';
import inicarRentaRoutes from './modules/iniciar_renta/iniciar_renta.routes.js';
import nuevaDeudaRoutes from './modules/nueva_deuda/nueva_deuda.routes.js';
import pagoDeudaRoutes from './modules/pago_deuda/pago_deuda.routes.js';

import usuarioRoutes from './modules/usuarios/usuarios.routes.js';
import productosRoutes from './modules/productos/productos.routes.js';
import ventasRoutes from './modules/ventas/ventas.routes.js';
import detallesRentasRoutes from './modules/detalles_rentas/detalles_rentas.routes.js';
import detallesVentasRoutes from './modules/detalles_ventas/detalles_ventas.routes.js';
import rentasRoutes from './modules/rentas/rentas.routes.js';
import deudasRoutes from './modules/deudas/deudas.routes.js';
import dispositivosRoutes from './modules/dispositivos/dispositivos.routes.js';
import inventarioProductosRoutes from './modules/inventario_productos/inventario_productos.routes.js';
import clientesRoutes from './modules/clientes/clientes.routes.js';
import pagoDeudasRoutes from './modules/pagos_deudas/pagos_deudas.routes.js';
import metodosPagos from './modules/metodos_pagos/metodos_pagos.routes.js'

import loginRoutes from './modules/login/login.routes.js';

import { verificarToken } from './middlewares/autenticacion_usuarios/autenticacion_usuarios.verificarToken.js';

import { verificarOperador } from './middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

import { gestorErrores } from './middlewares/gestor_errores/gestor_errores.js';

const app = express();

app.use(express.json());
app.use(cors());

app.use('/api/categorias_productos', verificarToken, categoriasProductosRoutes);
app.use('/api/categorias_dispositivos', verificarToken, categoriasDispositivosRoutes);
app.use('/api/roles', rolesRoutes);

app.use('/api/nueva_deuda', verificarToken, verificarOperador, nuevaDeudaRoutes);
app.use('/api/nueva_venta', verificarToken, verificarOperador, nuevaVentaRoutes);
app.use('/api/nuevo_producto', verificarToken, verificarOperador, nuevoProductoRoutes);
app.use('/api/nuevo_usuario', nuevoUsuarioRoutes);
app.use('/api/iniciar_renta', verificarToken, verificarOperador, inicarRentaRoutes);
app.use('/api/pago_deuda', verificarToken, verificarOperador, pagoDeudaRoutes);

app.use('/api/usuarios', usuarioRoutes);
app.use('/api/productos', verificarToken, productosRoutes);
app.use('/api/ventas', verificarToken ,ventasRoutes);
app.use('/api/detalles_rentas',verificarToken, detallesRentasRoutes);
app.use('/api/detalles_ventas',verificarToken, detallesVentasRoutes);
app.use('/api/rentas', verificarToken, rentasRoutes);
app.use('/api/deudas', verificarToken, deudasRoutes);
app.use('/api/dispositivos', verificarToken, dispositivosRoutes);
app.use('/api/inventario_productos', verificarToken, inventarioProductosRoutes);
app.use('/api/clientes', verificarToken, clientesRoutes);
app.use('/api/pagos_deudas', verificarToken, pagoDeudasRoutes);
app.use('/api/metodos_pagos', verificarToken, metodosPagos);

app.use('/api/login', loginRoutes);

app.use(gestorErrores);

app.get("/", (req, res) => {
  res.send('Hola bienvenido al backend de mi API para programa de venta y renta');
});

export default app;
