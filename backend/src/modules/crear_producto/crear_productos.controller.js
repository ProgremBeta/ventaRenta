import * as crearProductosService from './crear_productos.service.js';

export const crearProductos = async (req, res, next) => {
  
  try {
    const data = req.body;
    console.log("datos entregados en controller: ", data)
    const result = await crearProductosService.crearProductos(data);
    res.status(200).json(result.rows)
  } catch (err) {
    next(err);
  }
}