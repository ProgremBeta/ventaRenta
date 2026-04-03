import express from 'express';
import * as controller from './inventario_productos.controller.js';

console.log("Cargando rutas de inventario productos...");

const router = express.Router();

router.get('/inventario_productos', controller.obtenerInventarioProductos);
router.get('/inventario_productos/:id', controller.obtenerInventarioProductoPorId);
router.post('/inventario_productos', controller.crearInventarioProducto);
router.put('/inventario_productos/:id', controller.actualizarInventarioProducto);
router.delete('/inventario_productos/:id', controller.eliminarInventarioProducto);

export default router;