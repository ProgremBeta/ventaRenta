import * as service from './crear_deuda.service.js';

export const crearDeuda = async (req, res) => {
  const data = req.body;
  try {
    const result = await service.crearDeuda(data);
    res.status(200).json(result)
  } catch (err) {
    console.error("error al crear la deuda: ", err);
    res.status(500).json({ mensaje: "hubo un error al crear la deuda" })
  }
}