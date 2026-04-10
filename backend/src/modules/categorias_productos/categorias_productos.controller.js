import * as services from './categorias_productos.service.js';

export const obtenerCategoriasProductos = async (req, res) => {
  try {
    const result = await services.obtenerCategoriasProductos();
    res.json(result);
  } catch (err) {
    console.error("Error al obtener las categorias de productos: ", err);
    res.status(400).json({ error: 'Error al obtener las categorias de productos' });
  }
};

export const obtenerCategoriaProductoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerCategoriaProductoPorId(id);
    if (result.length === 0) {
      res.status(404).json({ error: 'Categoria de producto no encontrada' });
    } else {
      res.json(result[0]);
    }
  } catch (err) {
    console.error("Error al obtener la categoria de producto: ", err);
    res.status(400).json({ error: 'Error al obtener la categoria de producto' });
  }
};

export const crearCategoriaProducto = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearCategoriaProducto(datos);
    res.status(201).json(result[0]);
  } catch (err) {
    console.error("Error al crear la categoria de producto: ", err);
    res.status(400).json({ error: 'Error al crear la categoria de producto' });
  }
};

export const actualizarCategoriaProducto = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarCategoriaProducto(id, datos);
    if (result.length === 0) {
      res.status(404).json({ error: 'Categoria de producto no encontrada' });
    } else {
      res.json(result[0]);
    }
  } catch (err) {
    console.error("Error al actualizar la categoria de producto: ", err);
    res.status(400).json({ error: 'Error al actualizar la categoria de producto' });
  }
};

export const eliminarCategoriaProducto = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarCategoriaProducto(id);
    if (result.length === 0) {
      res.status(404).json({ error: 'Categoria de producto no encontrada' });
    } else {
      res.json(result[0]);
    }
  } catch (err) {
    console.error("Error al eliminar la categoria de producto: ", err);
    res.status(400).json({ error: 'Error al eliminar la categoria de producto' });
  }
};