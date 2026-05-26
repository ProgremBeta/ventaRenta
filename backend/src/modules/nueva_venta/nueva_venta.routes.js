import express from 'express';
import * as controller from './nueva_venta.controller.js';

const routes = express.Router();

routes.post('/', controller.nuevaVenta);

export default routes;