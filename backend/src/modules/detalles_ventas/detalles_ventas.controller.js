import * as services from './detalles_ventas.services.js';

export const obtenerDetallesVentas = async (req, res) => {
  try {
    const detallesVentas = await services.obtenerDetallesVentas();
    res.status(200).json(detallesVentas);
  } catch (error) {
    console.error("Error al obtener los detalles de ventas:", error);
    res.status(500).json({ message: "Error al obtener los detalles de ventas" });
  }
};

export const obtenerDetalleVentaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const detalleVenta = await services.obtenerDetalleVentaPorId(id);
    res.status(200).json(detalleVenta);
  } catch (error) {
    console.error(`Error al obtener el detalle de venta con ID ${id}:`, error);
    res.status(404).json({ message: "Detalle de venta no encontrado" });
  }
};

export const crearDetalleVenta = async (req, res) => {
  const datos = req.body;
  try {
    const nuevoDetalleVenta = await services.crearDetalleVenta(datos);
    res.status(201).json(nuevoDetalleVenta);
  } catch (error) {
    console.error("Error al crear el detalle de venta:", error);
    res.status(400).json({ message: "Error al crear el detalle de venta" });
  }
};

export const actualizarDetalleVenta = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const detalleVentaActualizado = await services.actualizarDetalleVenta(id, datos);
    res.status(200).json(detalleVentaActualizado);
  } catch (error) {
    console.error(`Error al actualizar el detalle de venta con ID ${id}:`, error);
    res.status(404).json({ message: "Detalle de venta no encontrado para actualizar" });
  }
};

export const eliminarDetalleVenta = async (req, res) => {
  const { id } = req.params;
  try {
    await services.eliminarDetalleVenta(id);
    res.status(200).json({ message: "Detalle de venta eliminado correctamente" });
  } catch (error) {
    console.error(`Error al eliminar el detalle de venta con ID ${id}:`, error);
    res.status(404).json({ message: "Detalle de venta no encontrado para eliminar" });
  }
};