import express from 'express';
import * as controller from './ventas.controller.js';

console.log("Cargando rutas de ventas...");

const ventaRouter = express.Router();

ventaRouter.get('/', controller.obtenerVentas);
ventaRouter.get('/:id', controller.obtenerVentaPorId);
ventaRouter.post('/', controller.crearVenta);
ventaRouter.put('/:id', controller.actualizarVenta);
ventaRouter.delete('/:id', controller.eliminarVenta);

export default ventaRouter;