import express from 'express';
import * as controller from './roles.controller.js';

console.log("Cargando rutas de roles...");

const Router = express.Router();

Router.get('/roles', controller.obtenerRoles);
Router.get('/roles/:id', controller.obtenerRolPorId);
Router.post('/roles', controller.crearRol);
Router.put('/roles/:id', controller.actualizarRol);
Router.delete('/roles/:id', controller.eliminarRol);

export default Router;