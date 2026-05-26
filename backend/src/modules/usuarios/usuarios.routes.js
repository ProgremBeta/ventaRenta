import express from 'express'

import * as controller from './usuario.controller.js'

import { verificarAdmin, verificarOperador } from '../../middlewares/autenticacion_roles/autenticacion_roles.verificar.js';

const router = express.Router();

router.get('/', verificarOperador, controller.obtenerUsuarios);
router.get('/:id', verificarOperador, controller.obtenerUsuarioPorIdentificacion);
router.post('/', verificarOperador, controller.crearUsuario);
router.put('/:id', verificarAdmin, controller.actualizarUsuario);
router.delete('/:id', verificarAdmin, controller.eliminarUsuario);

export default router;