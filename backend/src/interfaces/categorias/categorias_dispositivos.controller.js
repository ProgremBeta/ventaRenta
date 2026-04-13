import * as service from '../../core/categorias/categorias_dispositivos.service.js';

export const obtenerCategoriasDispositivos = async (req, res, next) => {
  try {
    const result = await service.obtenerCategoriasDispositivos();
    if (result.rows.length === 0) {
      console.warn('No se encontraron categorías de dispositivos en la base de datos');
      return res.status(404).json({ error: "Categoría de dispositivo no encontrada" });
    }
    console.log("Categorías de dispositivos obtenidas:", result.rows);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const obtenerCategoriaDispositivoPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerCategoriaDispositivoPorId(id);
    if (result.rows.length === 0) {
      console.warn(`No se encontró la categoría de dispositivo con ID ${id}`);
      return res.status(404).json({ error: "Categoría de dispositivo no encontrada" });
    }
    console.log("Categoría de dispositivo obtenida:", result.rows[0]);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const crearCategoriaDispositivo = async (req, res, next) => {
  const datos = req.body;
  try {
    const result = await service.crearCategoriaDispositivo(datos);
    console.log("Categoría de dispositivo creada:", result.rows[0]);
    res.status(201).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const actualizarCategoriaDispositivo = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarCategoriaDispositivo(id, datos);
    if (result.rows.length === 0) {
      console.warn(`No se encontró la categoría de dispositivo con ID ${id}`);
      return res.status(404).json({ error: "Categoría de dispositivo no encontrada" });
      next(err);
    }
    console.log("Categoría de dispositivo actualizada:", result.rows[0]);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const eliminarCategoriaDispositivo = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarCategoriaDispositivo(id);
    if (result.rowCount === 0) {
      console.warn(`No se encontró la categoría de dispositivo con ID ${id} para eliminar`);
      return res.status(404).json({ error: "Categoría de dispositivo no encontrada" });
      next(err);
    }
    console.log("Categoría de dispositivo eliminada:", result.rows[0]);
    res.status(204).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};