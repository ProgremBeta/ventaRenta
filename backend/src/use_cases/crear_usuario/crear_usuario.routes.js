import express from 'express';
import * as controller from './crear_usuario.controller.js';

const routes = express.Router();

routes.post('/', controller.crearNuevoUsuario)

export default routes;