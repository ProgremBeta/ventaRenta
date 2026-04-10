import express from 'express';
import * as controller from './logs.controller.js';

const router = express.Router();

router.get('/', controller.obtenerLogs);
router.get('/:id', controller.obtenerLogPorId);
router.post('/', controller.crearLog);
router.put('/:id', controller.actualizarLog);
router.delete('/:id', controller.eliminarLog);

export default router;