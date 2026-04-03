import express from 'express';
import * as controller from './renta.controller.js';

console.log("Cargando rutas de renta...");

const Router = express();

Router.get('/rentas', controller.obtenerRentas);
Router.get('/rentas/:id', controller.obtenerRentaPorId);
Router.post('/rentas', controller.crearRenta);
Router.put('/rentas/:id', controller.actualizarRenta);
Router.delete('/rentas/:id', controller.eliminarRenta);

export default Router;