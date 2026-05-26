import express from 'express';
import * as controller from './nueva_deuda.controller.js';

const routes = express.Router();

routes.post('/', controller.crearDeuda)

export default routes;