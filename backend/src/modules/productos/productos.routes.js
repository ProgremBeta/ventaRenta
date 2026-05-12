import express from 'express';

import * as controller from './productos.controller.js';

const router = express.Router();

router.get('/', controller.obtenerProductos);
router.get('/:id', controller.obtenerProductoPorId);
router.post('/', controller.crearProducto);
router.put('/:id', controller.actualizarProducto);
router.delete('/:id', controller.eliminarProducto);

export default router;