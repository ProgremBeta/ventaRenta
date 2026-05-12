import * as service from './iniciar_renta.service.js';

export const iniciarRentaDispositivos = async (req, res, next) => {
  const data = req.body;
  try {
    const result = await service.iniciarRentaDispositivos(data);
    console.log("el resultado es:", result);
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}