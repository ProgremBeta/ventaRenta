import express from 'express';
import * as controller from './crear_venta.controller.js';

const routes = express.Router();

routes.post('/', controller.nuevaVenta);

export default routes;