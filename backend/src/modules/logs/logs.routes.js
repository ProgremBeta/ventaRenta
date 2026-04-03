import express from 'express';
import * as controller from './logs.controller.js';

console.log("iniciando rutas de logs");

const Router = express();

Router.get('/logs', controller.obtenerLogs);
Router.get('/logs/:id', controller.obtenerLogPorId);
Router.post('/logs', controller.crearLog);
Router.put('/logs/:id', controller.actualizarLog);
Router.delete('/logs/:id', controller.eliminarLog);

export default Router;