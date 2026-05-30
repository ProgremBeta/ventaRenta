import * as pagoDeudaService from './pago_deuda.service.js';

export const pagoDeudas = async (req, res, next) => {
  const data = req.body;
  try {
    const result = await pagoDeudaService.pagoDeudas(data)
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}