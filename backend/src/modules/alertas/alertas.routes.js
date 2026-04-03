import express from 'express';
import * as controller from './alertas.controller.js';

console.log("iniciando rutas de alertas");

const Router = express();

Router.get('/alertas', controller.obtenerAlertas);
Router.get('/alertas/:id', controller.obtenerAlertaPorId);
Router.post('/alertas', controller.crearAlerta);
Router.put('/alertas/:id', controller.actualizarAlerta);
Router.delete('/alertas/:id', controller.eliminarAlerta);

export default Router;