import express from 'express';
import * as controller from './categorias_productos.controller.js';

const routes = express.Router();

routes.get('/', controller.obtenerCategoriasProductos);
routes.get('/:id', controller.obtenerCategoriaProductoPorId);
routes.post('/', controller.crearCategoriaProducto);
routes.put('/:id', controller.actualizarCategoriaProducto);
routes.delete('/:id', controller.eliminarCategoriaProducto);

export default routes;