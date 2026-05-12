import * as service from './categorias_productos.service.js';

export const obtenerCategoriasProductos = async (req, res, next) => {
  try {
    const result = await service.obtenerCategoriasProductos();

    console.log("Resultado de la consulta de categorías de productos:", result);

    if (result.length === 0) {
      console.log('No se encontraron categorías de productos en la base de datos');
      return res.status(404).json({ "mensaje": "Categoría de producto no encontrada" });
    }
    
    console.log("Categorías de productos obtenidas:", result.rows);
    res.status(200).json(result);

  } catch (err) {
    console.error("Error al obtener categorías de productos:", err);
    next(err);
  }
};

export const obtenerCategoriaProductoPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerCategoriaProductoPorId(id);
    
    if (result.rows.length === 0) {
      console.warn(`No se encontró la categoría de producto con ID ${id}`);
      return res.status(404).json({ error: "Categoría de producto no encontrada" });
    }
    
    console.log("Categoría de producto obtenida:", result.rows[0]);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const crearCategoriaProducto = async (req, res, next) => {
  const datos = req.body;
  try {
    const result = await service.crearCategoriaProducto(datos);
    
    if (result.rows.length === 0) {
      console.warn('No se pudo crear la categoría de producto');
      return res.status(400).json({ error: "No se pudo crear la categoría de producto" });
    }
    
    console.log("Categoría de producto creada:", result.rows[0]);
    res.status(201).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const actualizarCategoriaProducto = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarCategoriaProducto(id, datos);
    
    if (result.rows.length === 0) {
      console.warn(`No se encontró la categoría de producto con ID ${id} para actualizar`);
      return res.status(404).json({ error: "Categoría de producto no encontrada" });
    }
    
    console.log("Categoría de producto actualizada:", result.rows[0]);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const eliminarCategoriaProducto = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarCategoriaProducto(id);
    
    if (result.rowCount === 0) {
      console.warn(`No se encontró la categoría de producto con ID ${id} para eliminar`);
      return res.status(404).json({ error: "Categoría de producto no encontrada" });
    }
    
    console.log("Categoría de producto eliminada:", result.rows[0]);
    res.status(204).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};