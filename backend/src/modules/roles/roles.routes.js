import express from 'express';

import * as controller from './roles.controller.js';

const router = express.Router();

router.get('/',controller.obtenerRoles);
router.get('/:id', controller.obtenerRolPorId);
router.post('/', controller.crearRol);
router.put('/:id', controller.actualizarRol);
router.delete('/:id', controller.eliminarRol);

export default router;