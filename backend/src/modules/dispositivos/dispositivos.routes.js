import express from 'express';
import * as controller from './dispositivos.controller.js';

const router = express.Router();

router.get('/', controller.obtenerDispositivos);
router.get('/:id', controller.obtenerDispositivoPorId);
router.post('/', controller.crearDispositivo);
router.put('/:id', controller.actualizarDispositivo);
router.delete('/:id', controller.eliminarDispositivo);

export default router;