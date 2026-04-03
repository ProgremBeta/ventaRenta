import express from 'express';
import * as controller from './productos.controller.js';

console.log("Cargando rutas de productos...");

const Router = express.Router();

Router.get('/productos', controller.obtenerProductos);
Router.get('/productos/:id', controller.obtenerProductoPorId);
Router.post('/productos', controller.crearProducto);
Router.put('/productos/:id', controller.actualizarProducto);
Router.delete('/productos/:id', controller.eliminarProducto);

export default Router;