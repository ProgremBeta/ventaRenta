import * as services from './categorias_dispositivos.services.js';

export const obtenerCategoriasDispositivos = async (req, res) => {
  try {
    const categorias = await services.obtenerCategoriasDispositivos();
    res.status(200).json(categorias);
  } catch {
    console.error("Error al obtener las categorias de dispositivos: ", error);
    res.status(500).json({ error: 'Error al obtener las categorias de dispositivos' });
  }
};

export const obtenerCategoriaDispositivoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const categoria = await services.obtenerCategoriaDispositivoPorId(id);
    if (categoria.length === 0) {
      res.status(404).json({ error: 'Categoria de dispositivo no encontrada' });
    } else {
      res.status(200).json(categoria[0]);
    }
  } catch (error) {
    console.error("Error al obtener la categoria de dispositivo: ", error);
    res.status(500).json({ error: 'Error al obtener la categoria de dispositivo' });
  }
};

export const crearCategoriaDispositivo = async (req, res) => {
  const datos = req.body;
  try {
    const nuevaCategoria = await services.crearCategoriaDispositivo(datos);
    res.status(201).json(nuevaCategoria[0]);
  } catch (error) {
    console.error("Error al crear la categoria de dispositivo: ", error);
    res.status(500).json({ error: 'Error al crear la categoria de dispositivo' });
  }
};

export const actualizarCategoriaDispositivo = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const categoriaActualizada = await services.actualizarCategoriaDispositivo(id, datos);
    if (categoriaActualizada.length === 0) {
      res.status(404).json({ error: 'Categoria de dispositivo no encontrada' });
    } else {
      res.status(200).json(categoriaActualizada[0]);
    }
  } catch (error) {
    console.error("Error al actualizar la categoria de dispositivo: ", error);
    res.status(500).json({ error: 'Error al actualizar la categoria de dispositivo' });
  }
};

export const eliminarCategoriaDispositivo = async (req, res) => {
  const { id } = req.params;
  try {
    const categoriaEliminada = await services.eliminarCategoriaDispositivo(id);
    if (categoriaEliminada.length === 0) {
      res.status(404).json({ error: 'Categoria de dispositivo no encontrada' });
    } else {
      res.status(200).json(categoriaEliminada[0]);
    }
  } catch (error) {
    console.error("Error al eliminar la categoria de dispositivo: ", error);
    res.status(500).json({ error: 'Error al eliminar la categoria de dispositivo' });
  }
};