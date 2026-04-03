import express from 'express';
import * as controller from './detalles_ventas.controller.js';

console.log("iniciando rutas de detalles_ventas");

const detallesVentasRouter = express();

detallesVentasRouter.get('/detalle_ventas', controller.obtenerDetallesVentas);
detallesVentasRouter.get('/detalle_ventas/:id', controller.obtenerDetalleVentaPorId);
detallesVentasRouter.post('/detalle_ventas', controller.crearDetalleVenta);
detallesVentasRouter.put('/detalle_ventas/:id', controller.actualizarDetalleVenta);
detallesVentasRouter.delete('/detalle_ventas/:id', controller.eliminarDetalleVenta);

export default detallesVentasRouter;