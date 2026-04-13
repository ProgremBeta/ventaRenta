import * as services from './../../core/ventas/ventas.service.js';

export const obtenerVentas = async (req, res, next) => {
  try {
    const ventas = await services.obtenerVentas();
    res.status(200).json(ventas);
  } catch (err) {
    next(err);
  }
}

export const obtenerVentaPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const venta = await services.obtenerVentaPorId(id);
    res.status(200).json(venta);
  } catch (err) {
    next(err);
  }
}

export const crearVenta = async (req, res, next) => {
  const datos = req.body;
  try {
    const nuevaVenta = await services.crearVenta(datos);
    res.status(200).json(nuevaVenta);
  } catch (err) {
    next(err);
  }
}

export const actualizarVenta = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const ventaActualizada = await services.actualizarVenta(id, datos);
    res.status(200).json(ventaActualizada);
  } catch (err) {
    next(err);
  }
}

export const eliminarVenta = async (req, res, next) => {
  const { id } = req.params;
  try {
    const ventaEliminada = await services.eliminarVenta(id);
    res.status(200).json(ventaEliminada);
  } catch (err) {
    next(err);
  }
}