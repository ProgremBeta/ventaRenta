import * as service from './iniciar_renta.service.js';

export const iniciarRentaDispositivos = async (req, res) => {
  const data = req.body;
  try {
    const result = await service.iniciarRentaDispositivos(data);
    res.status(200).json(result)
  } catch (err) {
    console.error("error al iniciar la renta del dispositivo", err);
    res.status(500).json({ messaje: "no se ha podido iniciar la renta de esta dispositivo" })
  }
}