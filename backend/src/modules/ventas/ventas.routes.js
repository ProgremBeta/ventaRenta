import express from 'express';
import * as controller from './ventas.controller.js';

console.log("Cargando rutas de ventas...");

const router = express.Router();

router.get('/ventas', controller.obtenerVentas);
router.get('/ventas/:id', controller.obtenerVentaPorId);
router.post('/ventas', controller.crearVenta);
router.put('/ventas/:id', controller.actualizarVenta);
router.delete('/ventas/:id', controller.eliminarVenta);

export default router;