import express from 'express';
import * as controller from './clientes.controller.js';

const router = express.Router();

router.get('/', controller.obtenerClientes);
router.get('/:id', controller.obtenerClientePorId);
router.post('/', controller.crearCliente);
router.put('/:id', controller.actualizarCliente);
router.delete('/:id', controller.eliminarCliente);

export default router;