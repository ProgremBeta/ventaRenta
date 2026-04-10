import express from 'express';
import * as controller from './deudas.controller.js';

const router = express.Router();

router.get('/', controller.obtenerDeudas);
router.get('/:id', controller.obtenerDeudaPorId);
router.post('/', controller.crearDeuda);
router.put('/:id', controller.actualizarDeuda);
router.delete('/:id', controller.eliminarDeuda);

export default router;