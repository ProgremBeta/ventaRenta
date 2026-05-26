import * as service from './nueva_deuda.service.js';

export const crearDeuda = async (req, res, next) => {
  const datos = req.body;

  try {
    console.log("datos recibidos: ", datos)

    if (!datos) {
      return res.status(400).json({mensaje:"no ingresastes ningun datos para crear deuda"});
    }

    if (!datos.cliente_id) {
      return res.status(400).json({mensaje:"se requiere el cliente id para crear la deuda"});
    }

    if (!datos.origen_tipo) {
      return res.status(400).json({mensaje:"se requiere si es venta o renta para crear la deuda"});
    }

    if (!datos.origen_id) {
      return res.status(400).json({mensaje:"se requiere el ID origen de la venta o renta para crear la deuda"});
    }

    const result = await service.crearDeuda(datos);

    res.status(201).json(result)
  } catch (err) {
    console.log("error en el controller de crear deuda: ", err)
    next(err);
  }
}