import expres from 'express';
import * as controller from './usuarios.controller.js';

console.log("Cargando rutas de usuarios...");

const router = expres.Router();

router.get('/usuarios', controller.obtenerUsuarios);
router.get('/usuarios/:id', controller.obtenerUsuarioPorId);
router.post('/usuarios', controller.crearUsuario);
router.put('/usuarios/:id', controller.actualizarUsuario);
router.delete('/usuarios/:id', controller.eliminarUsuario);

export default router;