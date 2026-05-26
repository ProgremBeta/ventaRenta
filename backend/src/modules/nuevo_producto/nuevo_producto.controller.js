import * as service from './nuevo_producto.service.js';

export const crearProductos = async (req, res, next) => {
  const datos = req.body;
  
  try {
    if (!datos) {
      console.log("no ingresastes ningun dato para crear un nuevo producto")
      return res.status(400).json({mensaje:"no ingresastes ningun dato para crear un nuevo producto"})
    }

    if (!datos.categoria_id) {
      console.log("se require la categoria id para crear un producto")
      return res.status(400).json({mensaje:"se require la categoria id para crear un producto"})
    }

    if (!datos.nombre) {
      console.log("se require el nombre para crear un producto")
      return res.status(400).json({mensaje:"se require el nombre para crear un producto"})
    }

    if (!datos.precio) {
      console.log("se require el precio para crear un producto")
      return res.status(400).json({mensaje:"se require el precio para crear un producto"})
    }

    const result = await service.crearProductos(datos);
    res.status(200).json(result)
  } catch (err) {
    next(err);
  }
}