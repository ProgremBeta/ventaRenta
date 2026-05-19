import express, { Router } from 'express';

import * as controller from './metodos_pagos.controller.js';

console.log("en la ruta de metodos de pagos");

const routes = express.Router();

routes.use('/', controller.obtenerMetodosPagos);

export default routes;