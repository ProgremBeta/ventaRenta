import * as controller from './pagos_deudas.controller.js';

import express from 'express';

const routes = express.Router();

routes.get('/', controller.obtenerPagosDeudas);
routes.get('/:id', controller.obtenerPagoDeudaPorId);
routes.post('/', controller.crearPagoDeuda);
routes.put('/:id', controller.actualizarPagoDeuda);
routes.delete('/:id', controller.eliminarPagoDeuda);

export default routes;