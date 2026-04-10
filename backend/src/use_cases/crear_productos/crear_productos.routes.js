import express from 'express';
import * as controller from './crear_productos.controller.js';

const routes = express.Router();

routes.post('/', controller.crearProductos);

export default routes;