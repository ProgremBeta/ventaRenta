import express from 'express';

import * as controller from './categorias_productos.controller.js';

import { verificarAdmin, verificarOperador } from '../../middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

const router = express.Router();

router.get('/', controller.obtenerCategoriasProductos);
router.get('/:id', verificarOperador, controller.obtenerCategoriaProductoPorId);
router.post('/', verificarOperador, controller.crearCategoriaProducto);
router.put('/:id', verificarAdmin, controller.actualizarCategoriaProducto);
router.delete('/:id', verificarAdmin, controller.eliminarCategoriaProducto);

export default router;