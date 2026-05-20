import express from 'express';
import * as controller from './crear_productos.controller.js';

const routes = express.Router();

console.log("en router de categorias id")

routes.post('/', controller.crearProductos);

export default routes;