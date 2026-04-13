import express from 'express'

import * as controller from './ventas.controller.js'

import { verificarAdmin, verificarOperador } from '../../middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

const router = express.Router();

router.get('/', verificarOperador, controller.obtenerVentas);
router.get('/:id', verificarOperador, controller.obtenerVentaPorId);
router.post('/', verificarOperador, controller.crearVenta);
router.put('/:id', verificarAdmin, controller.actualizarVenta);
router.delete('/:id', verificarAdmin, controller.eliminarVenta);

export default router;