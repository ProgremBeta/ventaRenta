import express, { Router } from 'express';

import * as controller from './metodos_pagos.controller.js';

console.log("en la ruta de metodos de pagos");

const routes = express.Router();

routes.get('/', controller.obtenerMetodosPagos);
routes.get('/:id', controller.obtenerMetodoPagoPorId);
routes.post('/', controller.crearMetodoPago);
routes.put('/:id', controller.actualizarMetodoPago);
routes.delete('/:id', controller.eliminarMetodoPago);


export default routes;