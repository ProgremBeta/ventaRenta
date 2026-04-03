import express from 'express';
import * as controller from './clientes.controller.js';

console.log("iniciando rutas de clientes");

const clientesRouter = express();

clientesRouter.get('/clientes', controller.obtenerClientes);
clientesRouter.get('/clientes/:id', controller.obtenerClientePorId);
clientesRouter.post('/clientes', controller.crearCliente);
clientesRouter.put('/clientes/:id', controller.actualizarCliente);
clientesRouter.delete('/clientes/:id', controller.eliminarCliente);

export default clientesRouter;