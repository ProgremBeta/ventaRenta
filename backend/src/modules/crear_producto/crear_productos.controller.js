import * as crearProductosService from './crear_productos.service.js';

export const crearProductos = async (req, res, next) => {
  const data = req.body;
  console.log("datos entregados: ", data)
  try {
    const result = await crearProductosService.crearProductos(data);
    res.status(200).json(result.rows)
  } catch (err) {
    next(err);
  }
}