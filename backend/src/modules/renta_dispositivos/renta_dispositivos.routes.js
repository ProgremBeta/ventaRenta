import express from 'express';
import * as controller from './renta_dispositivos.controller.js';

const Router = express();

Router.get('/renta_dispositivos', controller.obtenerRentaDispositivos);
Router.get('/renta_dispositivos/:id', controller.obtenerRentaDispositivoPorId);
Router.post('/renta_dispositivos', controller.crearRentaDispositivo);
Router.put('/renta_dispositivos/:id', controller.actualizarRentaDispositivo);
Router.delete('/renta_dispositivos/:id', controller.eliminarRentaDispositivo);

export default Router;