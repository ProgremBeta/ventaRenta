import express from 'express';
import * as controller from './pagos_deudas.controller.js';

console.log("Cargando rutas de pagos deudas...");

const Router = express.Router();

Router.get('/pagos_deuda', controller.obtenerPagosDeudas);
Router.get('/pagos_deuda/:id', controller.obtenerPagoDeudaPorId);
Router.post('/pagos_deuda', controller.crearPagoDeuda);
Router.put('/pagos_deuda/:id', controller.actualizarPagoDeuda);
Router.delete('/pagos_deuda/:id', controller.eliminarPagoDeuda);

export default Router;