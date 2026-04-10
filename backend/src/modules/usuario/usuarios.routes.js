import expres from 'express';
import * as controller from './usuarios.controller.js';

const router = expres.Router();

router.get('/', controller.obtenerUsuarios);
router.get('/:id', controller.obtenerUsuarioPorId);
router.post('/', controller.crearUsuario);
router.put('/:id', controller.actualizarUsuario);
router.delete('/:id', controller.eliminarUsuario);

export default router;