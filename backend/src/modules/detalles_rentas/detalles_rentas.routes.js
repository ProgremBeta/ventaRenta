import express from 'express';

import * as controller from './detalles_rentas.controller.js';

const route = express.Router();

route.get('/',controller.obtenerRenta);
route.get('/:id',controller.obtenerRentaPorId);
route.post('/',controller.crearRenta);
route.put('/:id',controller.actualizarRenta);
route.delete('/:id',controller.eliminarRenta);

export default route;