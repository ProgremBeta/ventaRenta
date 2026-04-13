import * as crearProductosServices from '../../core/crear_producto/crear_productos.service.js';

export const crearProductos = async (req, res, next) => {
  const data = req.body;
  try {
    const result = await crearProductosServices.crearProductos(data);
    res.status(200).json(result.rows)
  } catch (error) {
    next(error);
  }
}