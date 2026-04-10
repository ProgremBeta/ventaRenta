import express from 'express';
import * as controller from './alertas.controller.js';

console.log("iniciando rutas de alertas");

const router = express.Router();

router.get('/', controller.obtenerAlertas);
router.get('/:id', controller.obtenerAlertaPorId);
router.post('/', controller.crearAlerta);
router.put('/:id', controller.actualizarAlerta);
router.delete('/:id', controller.eliminarAlerta);

export default router;