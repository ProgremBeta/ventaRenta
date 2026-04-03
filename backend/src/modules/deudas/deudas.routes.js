import express from 'express';
import * as controller from './deudas.controller.js';

console.log("Cargando rutas de deudas...");

const deudasrouter = express.Router();

deudasrouter.get('/deudas', controller.obtenerDeudas);
deudasrouter.get('/deudas/:id', controller.obtenerDeudaPorId);
deudasrouter.post('/deudas', controller.crearDeuda);
deudasrouter.put('/deudas/:id', controller.actualizarDeuda);
deudasrouter.delete('/deudas/:id', controller.eliminarDeuda);

export default deudasrouter;