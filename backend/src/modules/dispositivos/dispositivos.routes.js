import express from 'express';
import * as controller from './dispositivos.controller.js';

console.log("iniciando rutas de dispositivos");

const Router = express();

Router.get('/dispositivos', controller.obtenerDispositivos);
Router.get('/dispositivos/:id', controller.obtenerDispositivoPorId);
Router.post('/dispositivos', controller.crearDispositivo);
Router.put('/dispositivos/:id', controller.actualizarDispositivo);
Router.delete('/dispositivos/:id', controller.eliminarDispositivo);

export default Router;