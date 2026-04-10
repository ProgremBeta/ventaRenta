import * as services from './productos.service.js';

export const obtenerProductos = async (req, res) => {
  try {
    const result = await services.obtenerProductos();
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener los productos: ", err);
    res.status(400).json({ error: 'Error al obtener los productos' });
  }
};

export const obtenerProductoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerProductoPorId(id);
    if (result.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener el producto: ", err);
    res.status(400).json({ error: 'Error al obtener el producto' });
  }
};

export const crearProducto = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearProducto(datos);
    res.status(201).json(result);
  } catch (err) {
    console.error("Error al crear el producto: ", err);
    res.status(400).json({ error: 'Error al crear el producto' });
  }
};

export const actualizarProducto = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarProducto(id, datos);
    if (result.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al actualizar el producto: ", err);
    res.status(400).json({ error: 'Error al actualizar el producto' });
  }
};

export const eliminarProducto = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarProducto(id);
    if (result.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al eliminar el producto: ", err);
    res.status(400).json({ error: 'Error al eliminar el producto' });
  }
};