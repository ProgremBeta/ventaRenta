import * as crearProductosServices from './crear_productos.service.js';

export const crearProductos = async (req, res) => {
  const data = req.body;
  try {
    const result = await crearProductosServices.crearProductos(data);
    res.status(200).json(result.rows)
  } catch (error) {
    console.error("error al crear un nuevo producto: ", error);
    res.status(500).json({ mensaje: "no se pudo crear un nuevo producto" })
  }
}