import * as service from './nueva_venta.service.js';

export const nuevaVenta = async (req, res, next) => {
  const datos = req.body;

  try {
    if (!datos) {
      console.log("no ingresastes ningun dato para crear la venta")
      return res.status(400).json({mensaje:"no ingresastes ningun dato para crear la venta"})
    }

    if (!datos.usuario_id) {
      console.log("se requiere el usuario id para crear la venta")
      return res.status(400).json({mensaje:"se requiere el usuario id para crear la venta"})
    }

    if (!datos.metodo_pago) {
      console.log("se requiere metodo de pago para crear la venta")
      return res.status(400).json({mensaje:"se requiere metodo de pago para crear la venta"})
    }

    if (!datos.detalles || datos.detalles.length === 0) {
      console.log("se requieren los detalles para crear la venta")
      return res.status(400).json({mensaje:"se requieren los detalles para crear la venta"})
    }
    
    if (!datos.detalles[0].cantidad) {
      console.log("se requieren la cantidad de detalles para crear la venta")
      return res.status(400).json({mensaje:"se requieren la cantidad de detalles para crear la venta"})
    }

    const result = await service.nuevaVenta(datos)
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}