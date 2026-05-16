import * as service from './rentas.service.js';

export const obtenerRentas = async (req, res, next) => {
  try {
    const result = await service.obtenerRentas();

    console.log("resultado de la rentas: ", result);

    if (!result || result.length === 0) {
      return res.status(201).json({ message: 'No se encontraron rentas' });
    }
    
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const obtenerRentaPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerRentaPorId(id);

    if (!result || result.length === 0) {
      return res.status(201).json({ message: 'Renta no encontrada' });
    }
    
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const crearRenta = async (req, res, next) => {
  const datos = req.body;
  try {
    const result = await service.crearRenta(datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const actualizarRenta = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarRenta(id, datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const eliminarRenta = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarRenta(id);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}