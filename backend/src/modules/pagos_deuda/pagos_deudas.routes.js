import express from 'express';
import * as controller from './pagos_deudas.controller.js';

console.log("Cargando rutas de pagos deudas...");

const router = express.Router();

router.get('/', controller.obtenerPagosDeudas);
router.get('/:id', controller.obtenerPagoDeudaPorId);
router.post('/', controller.crearPagoDeuda);
router.put('/:id', controller.actualizarPagoDeuda);
router.delete('/:id', controller.eliminarPagoDeuda);

export default router;