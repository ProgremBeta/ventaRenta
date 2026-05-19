import express from 'express';
import cors from 'cors';

//rutas para los datos que van directamente a la base de datos
import categoriasProductosRoutes from './modules/categorias_productos/categorias_productos.routes.js';
import categoriasDispositivosRoutes from './modules/categorias_dispositivos/categorias_dispositivos.routes.js';
import rolesRoutes from './modules/roles/roles.routes.js';

//rutas del flujo principal de la aplicación
import nuevaVentaRoutes from './modules/crear_venta/crear_venta.routes.js';
import nuevoProductoRoutes from './modules/crear_producto/crear_productos.routes.js';
import nuevoUsuarioRoutes from './modules/crear_usuario/crear_usuario.routes.js';
import inicarRentaRoutes from './modules/iniciar_renta/iniciar_renta.routes.js';
import crearDeudaRoutes from './modules/crear_deuda/crear_deuda.routes.js';
import pagoDeudaRoutes from './modules/pago_deuda/pago_deuda.routes.js';

//flujo segundario
import usuarioRoutes from './modules/usuarios/usuarios.routes.js';
import productosRoutes from './modules/productos/productos.routes.js';
import ventasRoutes from './modules/ventas/ventas.routes.js';
import detallesVentasRoutes from './modules/detalles_ventas/detalles_ventas.routes.js';
import rentasRoutes from './modules/rentas/rentas.routes.js';
import deudasRoutes from './modules/deudas/deudas.routes.js';
import inventarioProductosRoutes from './modules/inventario_productos/inventario_productos.routes.js';
import clientesRoutes from './modules/clientes/clientes.routes.js';
import pagoDeudasRoutes from './modules/pagos_deudas/pagos_deudas.routes.js';
import metodosPagos from './modules/metodos_pagos/metodos_pagos.routes.js'

//rutas de login
import loginRoutes from './modules/login/login.routes.js';

//la autenticacion por JWT
import { verificarToken } from './middlewares/autenticacion_usuarios/autenticacion_usuarios.verificarToken.js';

//importamos el verificador de rol para controller las peticiones
import { verificarOperador } from './middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

//gestor de errores
import { gestorErrores } from './middlewares/gestor_errores/gestor_errores.js';

const app = express();

app.use(express.json());
app.use(cors());

//rutas para los datos que van directamente a la base de datos
app.use('/api/categorias_productos', verificarToken, categoriasProductosRoutes);
app.use('/api/categorias_dispositivos', verificarToken, categoriasDispositivosRoutes);
app.use('/api/roles', rolesRoutes);

//rutas del flujo principal de la aplicación
app.use('/api/nueva_venta', verificarToken, verificarOperador, nuevaVentaRoutes);
app.use('/api/nuevo_producto', verificarToken, verificarOperador, nuevoProductoRoutes);
app.use('/api/nuevo_usuario', nuevoUsuarioRoutes);
app.use('/api/iniciar_renta', verificarToken, verificarOperador, inicarRentaRoutes);
app.use('/api/crear_deuda', verificarToken, verificarOperador, crearDeudaRoutes);
app.use('/api/pago_deuda', verificarToken, verificarOperador, pagoDeudaRoutes);

//flujo segundario
app.use('/api/usuarios', verificarToken, usuarioRoutes);
app.use('/api/productos', verificarToken, productosRoutes);
app.use('/api/ventas', verificarToken ,ventasRoutes);
app.use('/api/detalles_ventas', verificarToken, detallesVentasRoutes);
app.use('/api/rentas', verificarToken, rentasRoutes);
app.use('/api/deudas', verificarToken, deudasRoutes);
app.use('/api/inventario_productos', verificarToken, inventarioProductosRoutes);
app.use('/api/clientes', verificarToken, clientesRoutes);
app.use('/api/pagos_deudas', verificarToken, pagoDeudasRoutes);
app.use('/api/metodos_pagos', verificarToken, metodosPagos);

//rutas de login
app.use('/api/login', loginRoutes);

app.use(gestorErrores);

app.get("/", (req, res) => {
  res.send('Hola bienvenido al backend de mi API para programa de venta y renta');
});

export default app;
