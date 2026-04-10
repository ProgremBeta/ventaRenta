import express from 'express';
import * as controller from './categorias_dispositivos.controller.js';

const router = express.Router();

router.get('/', controller.obtenerCategoriasDispositivos);
router.get('/:id', controller.obtenerCategoriaDispositivoPorId);
router.post('/', controller.crearCategoriaDispositivo);
router.put('/:id', controller.actualizarCategoriaDispositivo);
router.delete('/:id', controller.eliminarCategoriaDispositivo);

export default router;