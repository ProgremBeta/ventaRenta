import express from 'express';
import * as controller from './categorias_productos.controller.js';

console.log("iniciando rutas de categorias_productos");

const categoriasProductosRouter = express();

categoriasProductosRouter.get('/categorias_productos', controller.obtenerCategoriasProductos);
categoriasProductosRouter.get('/categorias_productos/:id', controller.obtenerCategoriaProductoPorId);
categoriasProductosRouter.post('/categorias_productos', controller.crearCategoriaProducto);
categoriasProductosRouter.put('/categorias_productos/:id', controller.actualizarCategoriaProducto);
categoriasProductosRouter.delete('/categorias_productos/:id', controller.eliminarCategoriaProducto);

export default categoriasProductosRouter;