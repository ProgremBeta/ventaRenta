import * as service from './crear_venta.service.js';

export const nuevaVenta = async (req, res) => {
  const data = req.body;

  try {
    const result = await service.nuevaVenta(data)
    res.status(200).json(result)

  } catch (err) {
    console.error("hubo un error al crear una nueva venta", err)
    res.status(500).json({ mensaje: "error al crear nueva venta" })
  }
}