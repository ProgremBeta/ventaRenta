import * as services from './detalles_ventas.service.js';

export const obtenerDetallesVentas = async (req, res) => {
  try {
    const result = await services.obtenerDetallesVentas();
    res.status(200).json({ message: "Detalles de ventas obtenido correctamente", result });
  } catch (error) {
    console.error("Error al obtener los detalles de ventas:", error);
    res.status(500).json({ message: "Error al obtener los detalles de ventas" });
  }
};

export const obtenerDetalleVentaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerDetalleVentaPorId(id);
    res.status(200).json({ message: "Detalle de venta por id obtenido correctamente", result });
  } catch (error) {
    console.error(`Error al obtener el detalle de venta con ID ${id}:`, error);
    res.status(404).json({ message: "Detalle de venta no encontrado" });
  }
};

export const crearDetalleVenta = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearDetalleVenta(datos);
    res.status(201).json({ message: "Detalle de venta creado correctamente", result });
  } catch (error) {
    console.error("Error al crear el detalle de venta:", error);
    res.status(400).json({ message: "Error al crear el detalle de venta" });
  }
};

export const actualizarDetalleVenta = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarDetalleVenta(id, datos);
    res.status(200).json({ message: "Detalle de venta actualizado correctamente", result });
  } catch (error) {
    console.error(`Error al actualizar el detalle de venta con ID ${id}:`, error);
    res.status(404).json({ message: "Detalle de venta no encontrado para actualizar" });
  }
};

export const eliminarDetalleVenta = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarDetalleVenta(id);
    res.status(200).json({ message: "Detalle de venta eliminado correctamente", result });
  } catch (error) {
    console.error(`Error al eliminar el detalle de venta con ID ${id}:`, error);
    res.status(404).json({ message: "Detalle de venta no encontrado para eliminar" });
  }
};