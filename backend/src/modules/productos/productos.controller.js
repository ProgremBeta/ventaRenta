import * as service from './productos.service.js';

export const obtenerProductos = async (req, res, next) => {
  try {
    const result = await service.obtenerProductos();

    if (!result || result.length === 0) {
        console.log("no ingresastes datos para crear un pago de deuda")
        return res.status(400).json({mensaje:"no ingresastes datos para crear un pago de deuda"})
    }

    res.status(200).json(result);
  } catch (err) {
    console.log("error en obtener productos ", err)
    next(err);
  }
};

export const obtenerProductoPorId = async (req, res, next) => {
  const { id }= req.params;

  try {
    const result = await service.obtenerProductoPorId(id);

    if (result.length === 0) {
      console.log(`no se encontro datos de productos con el id: ${id}`)
      return res.status(404).json({ mensaje: `no se encontro datos de productos con el id: ${id}` });
    }
    res.status(200).json(result);
  } catch (err) {
    console.log(`error en obtener productos con el id ${id} `, err)
    next(err);
  }
};

export const crearProducto = async (req, res, next) => {
  const datos = req.body
  try {
    if (!datos) {
      console.log("no ingresastes ningun datos para crear un nuevo producto")
      return res.status(400).json({ mensaje: "no ingresastes ningun datos para crear un nuevo producto" });
    }

    if (!datos.nombre) {
      console.log("se requiere un nombre para crear un nuevo producto")
      return res.status(400).json({ mensaje: "se requiere un nombre para crear un nuevo producto" });
    }

    if (!datos.precio) {
      console.log("se requiere un precio para crear un nuevo producto")
      return res.status(400).json({ mensaje: "se requiere un precio para crear un nuevo producto" });
    }

    if (!datos.precio) {
      console.log("se requiere un precio para crear un nuevo producto")
      return res.status(400).json({ mensaje: "se requiere un precio para crear un nuevo producto" });
    }
    if (!datos.categoria_id) {
      console.log("se requiere un categoria id para crear un nuevo producto")
      return res.status(400).json({ mensaje: "se requiere un categoria id para crear un nuevo producto" });
    }

    const result = await service.crearProducto(datos);
    res.status(201).json(result);
  } catch (err) {
    console.log("error al crear productos ", err)
    next(err);
  }
};

export const actualizarProducto = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;

  try {
    const result = await service.actualizarProducto(id, datos);

    if (result.length === 0) {
      console.log(`no se encontro datos del producto con el id: ${id}`)
      return res.status(404).json({ mensaje: `no se encontro datos del producto con el id: ${id}` });
    }
    res.status(200).json(result);
  } catch (err) {
    console.log(`error en actualizar el productos con el id ${id} `, err)
    next(err);
  }
};

export const eliminarProducto = async (req, res, next) => {
  const { id } = req.params;

  try {
    const result = await service.eliminarProducto(id);

    if (!result || result.length === 0) {
      console.log("los datos no existen o ya fue eliminado")
      return res.status(400).json({mensaje:"los datos no existen o ya fue eliminado"})
    }

    res.status(200).json(result);
  } catch (err) {
    console.log("error al eliminar un producto ", err)
    next(err);
  }
};