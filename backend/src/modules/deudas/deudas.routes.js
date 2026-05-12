import express from 'express';

import * as controller from './deudas.controller.js';

const routes = express.Router();

routes.get('/', controller.obtenerDeudas);

export default routes;