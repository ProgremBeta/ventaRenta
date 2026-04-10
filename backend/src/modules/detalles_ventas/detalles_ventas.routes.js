import express from 'express';
import * as controller from './detalles_ventas.controller.js';

console.log("iniciando rutas de detalles_ventas");

const router = express.Router();

router.get('/', controller.obtenerDetallesVentas);
router.get('/:id', controller.obtenerDetalleVentaPorId);
router.post('/', controller.crearDetalleVenta);
router.put('/:id', controller.actualizarDetalleVenta);
router.delete('/:id', controller.eliminarDetalleVenta);

export default router;