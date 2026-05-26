import * as service from './inventario_productos.service.js';

export const obtenerInventarioProductos = async (req, res, next) => {
  try {
    const result = await service.obtenerInventarioProductos();
    
    if (!result || result.length === 0) {
      console.log("no existen datos de inventario de productos")
      res.status(404).json({ message: "no existen datos de inventario de productos" });
    }
    
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const obtenerInventarioProductoPorId = async (req, res, next) => {
  const { id } = req.params;

  try {

    console.log("daton recibidos: ", id)

    const result = await service.obtenerInventarioProductoPorId(id);

    console.log("resultado de la peticion: ", result)

    if (!result || result.length === 0) {
      console.log(`no existe inventario del producto con el id: ${id}`)
      return res.status(400).json({mensaje:`no existe inventario del producto con el id: ${id}`})
    }

    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const obtenerInventarioPorProductoId = async (req, res, next) => {
  const { id } = req.params;

  try {
    const result = await service.obtenerInventarioPorProductoId(id);

    if (!result || result.length === 0) {
      console.log(`no existe inventario del producto con id del producto: ${id}`)
      return res.status(400).json({mensaje:`no existe inventario del producto con id del producto: ${id}`})
    }

    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const descontarStock = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;

  try {
    const result = await service.descontarStock(id, datos);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const crearInventarioProducto = async (req, res, next) => {
  const datos = req.body;

  try {
    if (!datos) {
      console.log("no ingresastes datos para crear inventario")
      return res.status(400).json({mensaje:"no ingresastes datos para crear inventario"})
    }

    if (!datos.producto_id) {
      console.log("se requieren los datos del producto id")
      return res.status(400).json({mensaje:"se requieren los datos del producto id"})
    }

    if (!datos.stock) {
      console.log("se requieren los datos de stock")
      return res.status(400).json({mensaje:"se requieren los datos de stock"})
    }

    if (!datos.stock_minimo) {
      console.log("se requiere establecer un stock minimo")
      return res.status(400).json({mensaje:"se requiere establecer un stock minimo"})
    }

    if (!datos.activo) {
      datos.activo = true
    }

    const result = await service.crearInventarioProducto(datos);

    console.log(`el resultado es ${result}`)

    res.status(201).json(result);
  }catch (err) {
    console.log("el error es: ", err)
    next(err);
  }
};

export const actualizarInventarioProducto = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;

  try {
    const result = await service.actualizarInventarioProducto(id, datos);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const eliminarInventarioProducto = async (req, res, next) => {
  const { id } = req.params;

  try {
    const result = await service.eliminarInventarioProducto(id);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};