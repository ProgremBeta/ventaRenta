import express from 'express';

import * as controller from './inventario_productos.controller.js';

const router = express.Router();

router.get('/', controller.obtenerInventarioProductos);
router.get('/:id', controller.obtenerInventarioProductoPorId);
router.get('/producto/:id', controller.obtenerInventarioPorProductoId);
router.post('/descontar/:id', controller.descontarStock);
router.post('/', controller.crearInventarioProducto);
router.put('/:id', controller.actualizarInventarioProducto);
router.delete('/:id', controller.eliminarInventarioProducto);

export default router;