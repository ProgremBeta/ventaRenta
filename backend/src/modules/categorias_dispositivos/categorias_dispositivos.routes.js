import express from 'express';
import * as controller from './categorias_dispositivos.controller.js';

console.log("iniciando rutas de categorias_dispositivos");

const categoriasDispositivosRouter = express();

categoriasDispositivosRouter.get('/categorias_dispositivos', controller.obtenerCategoriasDispositivos);
categoriasDispositivosRouter.get('/categorias_dispositivos/:id', controller.obtenerCategoriaDispositivoPorId);
categoriasDispositivosRouter.post('/categorias_dispositivos', controller.crearCategoriaDispositivo);
categoriasDispositivosRouter.put('/categorias_dispositivos/:id', controller.actualizarCategoriaDispositivo);
categoriasDispositivosRouter.delete('/categorias_dispositivos/:id', controller.eliminarCategoriaDispositivo);

export default categoriasDispositivosRouter;