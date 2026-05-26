import express from 'express';

import * as controller from './deudas.controller.js';

const routes = express.Router();

routes.get('/', controller.obtenerDeudas);
routes.get('/:id', controller.obtenerDeudaPorId);
routes.post('/', controller.crearDeuda);
routes.put('/:id', controller.actualizarDeuda);
routes.delete('/:id', controller.eliminarDeuda);

export default routes;