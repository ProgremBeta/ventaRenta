import express from 'express';
import * as controller from './roles.controller.js';

console.log("Cargando rutas de roles...");

const routes = express.Router();

routes.get('/', controller.obtenerRoles);
routes.get('/:id', controller.obtenerRolPorId);
routes.post('/', controller.crearRol);
routes.put('/:id', controller.actualizarRol);
routes.delete('/:id', controller.eliminarRol);

export default routes;