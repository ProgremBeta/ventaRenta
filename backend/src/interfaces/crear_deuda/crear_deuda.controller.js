import * as service from './../../core/crear_deuda/crear_deuda.service.js';

export const crearDeuda = async (req, res, next) => {
  const data = req.body;
  try {
    const result = await service.crearDeuda(data);
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}