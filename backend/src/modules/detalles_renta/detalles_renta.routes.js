import express from 'express';
import * as controller from './detalles_renta.controller.js';

const router = express.Router();

router.get('/', controller.obtenerRentaDispositivos);
router.get('/:id', controller.obtenerRentaDispositivoPorId);
router.post('/', controller.crearRentaDispositivo);
router.put('/:id', controller.actualizarRentaDispositivo);
router.delete('/:id', controller.eliminarRentaDispositivo);

export default router;