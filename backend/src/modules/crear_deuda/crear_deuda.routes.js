import express from 'express';
import * as controller from './crear_deuda.controller.js';

const routes = express.Router();

routes.post('/', controller.crearDeuda)

export default routes;