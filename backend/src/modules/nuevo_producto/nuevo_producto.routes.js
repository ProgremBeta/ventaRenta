import express from 'express';
import * as controller from './nuevo_producto.controller.js';

const routes = express.Router();

console.log("en router de categorias id")

routes.post('/', controller.crearProductos);

export default routes;