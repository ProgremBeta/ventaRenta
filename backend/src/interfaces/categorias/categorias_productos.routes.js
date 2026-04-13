import express from 'express';

import * as controller from './categorias_productos.controller.js';

import { verificarAdmin, verificarOperador } from '../../middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

const router = express.Router();

router.get('/categorias-productos', controller.obtenerCategoriasProductos);
router.get('/categorias-productos/:id', verificarOperador, controller.obtenerCategoriaProductoPorId);
router.post('/categorias-productos', verificarOperador, controller.crearCategoriaProducto);
router.put('/categorias-productos/:id', verificarAdmin, controller.actualizarCategoriaProducto);
router.delete('/categorias-productos/:id', verificarAdmin, controller.eliminarCategoriaProducto);

export default router;