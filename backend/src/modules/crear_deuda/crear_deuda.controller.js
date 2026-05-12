import * as service from './crear_deuda.service.js';

export const crearDeuda = async (req, res, next) => {
  const data = req.body;
  try {
    const result = await service.crearDeuda(data);
    console.log("el resultado es:", result);
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}