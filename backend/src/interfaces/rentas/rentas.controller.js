import * as service from './../../core/rentas/rentas.service.js';

export const obtenerRentas = async (req, res, next) => {
  try {
    const rentas = await service.obtenerRentas();
    res.status(200).json(rentas);
  } catch (err) {
    next(err);
  }
}

export const obtenerRentaPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const renta = await service.obtenerRentaPorId(id);
    res.status(200).json(renta);
  } catch (err) {
    next(err);
  }
}

export const crearRenta = async (req, res, next) => {
  const datos = req.body;
  try {
    const nuevaRenta = await service.crearRenta(datos);
    res.status(200).json(nuevaRenta);
  } catch (err) {
    next(err);
  }
}

export const actualizarRenta = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const rentaActualizada = await service.actualizarRenta(id, datos);
    res.status(200).json(rentaActualizada);
  } catch (err) {
    next(err);
  }
}

export const eliminarRenta = async (req, res, next) => {
  const { id } = req.params;
  try {
    const rentaEliminada = await service.eliminarRenta(id);
    res.status(200).json(rentaEliminada);
  } catch (err) {
    next(err);
  }
}