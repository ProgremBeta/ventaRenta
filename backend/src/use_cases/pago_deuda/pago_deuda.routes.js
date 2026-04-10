import express from 'express';
import * as controller from './pago_deuda.controller.js';

const routes = express.Router();

routes.post('/', controller.pagoDeudas);

export default routes;