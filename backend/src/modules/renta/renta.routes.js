import express from 'express';
import * as controller from './renta.controller.js';

console.log("Cargando rutas de renta...");

const router = express.Router();

router.get('/', controller.obtenerRentas);
router.get('/:id', controller.obtenerRentaPorId);
router.post('/', controller.crearRenta);
router.put('/:id', controller.actualizarRenta);
router.delete('/:id', controller.eliminarRenta);

export default router;