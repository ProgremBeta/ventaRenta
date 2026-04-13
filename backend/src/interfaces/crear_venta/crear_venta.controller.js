import * as service from './../../core/crear_venta/crear_venta.service.js';

export const nuevaVenta = async (req, res, next) => {
  const data = req.body;

  try {
    const result = await service.nuevaVenta(data)
    res.status(200).json(result)

  } catch (err) {
    next(err);
  }
}