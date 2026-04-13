import * as service from './../../core/iniciar_renta/iniciar_renta.service.js';

export const iniciarRentaDispositivos = async (req, res, next) => {
  const data = req.body;
  try {
    const result = await service.iniciarRentaDispositivos(data);
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}