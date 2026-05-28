import * as controller from './dispositivos.controller.js';

import express from 'express';

const routes = express.Router()

routes.get('/',controller.obtenerDispositivos)
routes.get('/:id',controller.obtenerDispositivoPorId)
routes.post('/',controller.crearDispositivo)
routes.put('/:id',controller.actualizarDispositivo)
routes.delete('/:id',controller.eliminarDispositivo)

export default routes;