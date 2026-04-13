import express from 'express';

import * as inicarRentaRoutes from './iniciar_renta.controller.js';

const routes = express.Router();

routes.post('/', inicarRentaRoutes.iniciarRentaDispositivos);

export default routes;