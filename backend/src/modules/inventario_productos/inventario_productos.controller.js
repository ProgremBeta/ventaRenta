import * as services from './inventario_productos.service.js';

console.log("Cargando controladores de inventario...");

export const obtenerInventarioProductos = async (req, res) => {
  try {
    const inventario = await services.obtenerInventarioProductos();
    res.status(200).json(inventario);
  } catch (error) {
    console.error("Error al obtener el inventario:", error);
    res.status(400).json({ message: "Error al obtener el inventario" });
  }
};

export const obtenerInventarioProductoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const inventario = await services.obtenerInventarioProductoPorId(id);
    res.status(200).json(inventario);
  } catch (error) {
    console.error(`Error al obtener el inventario con ID ${id}:`, error);
    res.status(404).json({ message: "Inventario no encontrado" });
  }
};

export const crearInventarioProducto = async (req, res) => {
  const datos = req.body;
  try {
    const nuevoInventario = await services.crearInventarioProducto(datos);
    res.status(201).json(nuevoInventario);
  } catch (error) {
    console.error("Error al crear el inventario:", error);
    res.status(400).json({ message: "Error al crear el inventario" });
  }
};

export const actualizarInventarioProducto = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const inventarioActualizado = await services.actualizarInventarioProducto(id, datos);
    res.status(200).json(inventarioActualizado);
  } catch (error) {
    console.error(`Error al actualizar el inventario con ID ${id}:`, error);
    res.status(400).json({ message: "Inventario no encontrado para actualizar" });
  }
};

export const eliminarInventarioProducto = async (req, res) => {
  const { id } = req.params;
  try {
    await services.eliminarInventarioProducto(id);
    res.status(200).json({ message: "Inventario eliminado correctamente" });
  } catch (error) {
    console.error(`Error al eliminar el inventario con ID ${id}:`, error);
    res.status(400).json({ message: "Inventario no encontrado para eliminar" });
  }
};