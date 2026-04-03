import * as services from './categorias_productos.services.js';

export const obtenerCategoriasProductos = async (req, res) => {
  try {
    const categorias = await services.obtenerCategoriasProductos();
    res.json(categorias);
  } catch (error) {
    console.error("Error al obtener las categorias de productos: ", error);
    res.status(500).json({ error: 'Error al obtener las categorias de productos' });
  }
};

export const obtenerCategoriaProductoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const categoria = await services.obtenerCategoriaProductoPorId(id);
    if (categoria.length === 0) {
      res.status(404).json({ error: 'Categoria de producto no encontrada' });
    } else {
      res.json(categoria[0]);
    }
  } catch (error) {
    console.error("Error al obtener la categoria de producto: ", error);
    res.status(500).json({ error: 'Error al obtener la categoria de producto' });
  }
};

export const crearCategoriaProducto = async (req, res) => {
  const datos = req.body;
  try {
    const nuevaCategoria = await services.crearCategoriaProducto(datos);
    res.status(201).json(nuevaCategoria[0]);
  } catch (error) {
    console.error("Error al crear la categoria de producto: ", error);
    res.status(500).json({ error: 'Error al crear la categoria de producto' });
  }
};

export const actualizarCategoriaProducto = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const categoriaActualizada = await services.actualizarCategoriaProducto(id, datos);
    if (categoriaActualizada.length === 0) {
      res.status(404).json({ error: 'Categoria de producto no encontrada' });
    } else {
      res.json(categoriaActualizada[0]);
    }
  } catch (error) {
    console.error("Error al actualizar la categoria de producto: ", error);
    res.status(500).json({ error: 'Error al actualizar la categoria de producto' });
  }
};

export const eliminarCategoriaProducto = async (req, res) => {
  const { id } = req.params;
  try {
    const categoriaEliminada = await services.eliminarCategoriaProducto(id);
    if (categoriaEliminada.length === 0) {
      res.status(404).json({ error: 'Categoria de producto no encontrada' });
    } else {
      res.json(categoriaEliminada[0]);
    }
  } catch (error) {
    console.error("Error al eliminar la categoria de producto: ", error);
    res.status(500).json({ error: 'Error al eliminar la categoria de producto' });
  }
};