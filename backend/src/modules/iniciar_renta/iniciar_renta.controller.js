import * as service from './iniciar_renta.service.js';

export const iniciarRentaDispositivos = async (req, res, next) => {
  const datos = req.body;
  try {
    if (!datos) {
      console.log("no ingresastes ningun dato")
      return res.status(400).json({mensaje:"no ingresastes ningun dato"})
    }
  
    if (!datos.usuario_id) {
      console.log("se requiere un usuario para iniciar la renta")
      return res.status(400).json({mensaje:"se requiere un usuario para iniciar la renta"})
    }
  
    if (!datos.duracion) {
      console.log("se requiere un la duracion ")
      return res.status(400).json({mensaje:"se requiere un la duracion "})
    }
  
    if (!datos.metodo_pago) {
      console.log("se requiere un metodo de pago")
      return res.status(400).json({mensaje:"se requiere un metodo de pago"})
    }
  
    if (!datos.dispositivo_id) {
      console.log("se requiere un dispositivo")
      return res.status(400).json({mensaje:"se requiere un dispositivo"})
    }

    const result = await service.iniciarRentaDispositivos(datos);
    res.status(200).json(result)
  } catch (err) {
    console.log("error al iniciar renta controller ", err)
    next(err);
  }
}