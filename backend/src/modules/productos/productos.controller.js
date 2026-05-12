import * as service from './productos.service.js';

export const obtenerProductos = async (req, res, next) => {
  try {
    const result = await service.obtenerProductos();
    res.json(result.rows);
  } catch (error) {
    next(error);
  }
};

export const obtenerProductoPorId = async (req, res, next) => {
  try {
    const id = req.params.id;
    const result = await service.obtenerProductoPorId(id);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

export const crearProducto = async (req, res, next) => {
  try {
    const datos = req.body;
    const result = await service.crearProducto(datos);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

export const actualizarProducto = async (req, res, next) => {
  try {
    const id = req.params.id;
    const datos = req.body;
    const result = await service.actualizarProducto(id, datos);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

export const eliminarProducto = async (req, res, next) => {
  try {
    const id = req.params.id;
    const result = await service.eliminarProducto(id);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.json({ message: 'Producto eliminado exitosamente' });
  } catch (error) {
    next(error);
  }
};