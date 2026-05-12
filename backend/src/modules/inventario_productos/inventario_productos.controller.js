import * as service from './inventario_productos.service.js';

export const obtenerInventarioProductos = async (req, res, next) => {
  try {
    const result = await service.obtenerInventarioProductos();
    
    if (!result || result.length === 0) {
      res.status(200).json({ message: "No se encontraron productos en el inventario" });
    }
    
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const obtenerInventarioProductoPorId = async (req, res, next) => {
  try {
    const { id } = req.params;
    const result = await service.obtenerInventarioProductoPorId(id);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const obtenerInventarioPorProductoId = async (req, res, next) => {
  try {
    const { id } = req.params;
    const result = await service.obtenerInventarioPorProductoId(id);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const descontarStock = async (req, res, next) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    const result = await service.descontarStock(id, datos.cantidad);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const crearInventarioProducto = async (req, res, next) => {
  try {
    const datos = req.body;
    const result = await service.crearInventarioProducto(datos);
    res.status(201).json(result);
  }catch (err) {
    next(err);
  }
};

export const actualizarInventarioProducto = async (req, res, next) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    const result = await service.actualizarInventarioProducto(id, datos);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};

export const eliminarInventarioProducto = async (req, res, next) => {
  try {
    const { id } = req.params;
    const result = await service.eliminarInventarioProducto(id);
    res.status(200).json(result);
  }catch (err) {
    next(err);
  }
};