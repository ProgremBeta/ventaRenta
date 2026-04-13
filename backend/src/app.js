import express from 'express';
import cors from 'cors';

//rutas para los datos que van directamente a la base de datos
import categoriasProductosRoutes from './interfaces/categorias/categorias_productos.routes.js';
import categoriasDispositivosRoutes from './interfaces/categorias/categorias_dispositivos.routes.js';
import rolesRoutes from './interfaces/roles/roles.routes.js';

//rutas del flujo principal de la aplicación
import nuevaVentaRoutes from './interfaces/crear_venta/crear_venta.routes.js';
import nuevoProductoRoutes from './interfaces/crear_producto/crear_productos.routes.js';
import nuevoUsuarioRoutes from './interfaces/crear_usuario/crear_usuario.routes.js';
import inicarRentaRoutes from './interfaces/iniciar_renta/iniciar_renta.routes.js';
import crearDeudaRoutes from './interfaces/crear_deuda/crear_deuda.routes.js';
import pagoDeudaRoutes from './interfaces/pago_deuda/pago_deuda.routes.js';

//flujo segundario
import usuarioRoutes from './interfaces/usuarios/usuarios.routes.js';
import ventasRoutes from './interfaces/ventas/ventas.routes.js';
import rentasRoutes from './interfaces/rentas/rentas.routes.js';

//rutas de login
import loginRoutes from './interfaces/login/login.routes.js';

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
app.use('/api/roles', verificarToken, rolesRoutes);

//rutas del flujo principal de la aplicación
app.use('/api/nueva_venta', verificarToken, verificarOperador, nuevaVentaRoutes);
app.use('/api/nuevo_producto', verificarToken, verificarOperador, nuevoProductoRoutes);
app.use('/api/nuevo_usuario', verificarToken, verificarOperador, nuevoUsuarioRoutes);
app.use('/api/iniciar_renta', verificarToken, verificarOperador, inicarRentaRoutes);
app.use('/api/crear_deuda', verificarToken, verificarOperador, crearDeudaRoutes);
app.use('/api/pago_deuda', verificarToken, verificarOperador, pagoDeudaRoutes);

//flujo segundario
app.use('/api/usuarios', verificarToken, usuarioRoutes);
app.use('/api/ventas', verificarToken, ventasRoutes);
app.use('/api/rentas', verificarToken, rentasRoutes);

//rutas de login
app.use('/api/login', loginRoutes);

app.use(gestorErrores);

app.get("/", (req, res) => {
  res.send('Hola bienvenido al backend de mi API para programa de venta y renta');
});

export default app;