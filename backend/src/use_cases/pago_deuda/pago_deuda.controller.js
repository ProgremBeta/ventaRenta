import * as pagoDeudaService from './pago_deuda.service.js';

export const pagoDeudas = async (req, res) => {
  const data = req.body;
  try {
    const result = await pagoDeudaService.pagoDeudas(data)
    res.status(200).json(result)
  } catch (err) {
    console.error("no se pudo hacer el pago del servicio", err);
    res.status(500).json({ mensaje: "error no se pudo realizar el pago de la deuda" })
  }
}