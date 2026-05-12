import express from 'express';

import * as controller from './roles.controller.js';

import { verificarAdmin, verificarOperador } from '../../middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

const router = express.Router();

router.get('/',controller.obtenerRoles);
router.get('/:id', controller.obtenerRolPorId);
router.post('/', verificarOperador, controller.crearRol);
router.put('/:id', verificarOperador, controller.actualizarRol);
router.delete('/:id', verificarOperador, controller.eliminarRol);

export default router;