import express from 'express'

import * as controller from './rentas.controller.js'

import { verificarAdmin, verificarOperador } from '../../middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

const router = express.Router();

router.get('/', verificarOperador, controller.obtenerRentas);
router.get('/:id', verificarOperador, controller.obtenerRentaPorId);
router.post('/', verificarOperador, controller.crearRenta);
router.put('/:id', verificarAdmin, controller.actualizarRenta);
router.delete('/:id', verificarAdmin, controller.eliminarRenta);

export default router;