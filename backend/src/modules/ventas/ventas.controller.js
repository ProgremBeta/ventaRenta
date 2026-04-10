import * as services from './ventas.service.js';
import { nuevaVenta } from '../../use_cases/crear_venta/crear_venta.service.js';

console.log("Cargando controladores de ventas...");

export const obtenerVentas = async (req, res) => {
  try {
    const ventas = await services.obtenerVentas();
    res.status(200).json(ventas);
  } catch (err) {
    console.error("Error al obtener las ventas:", err);
    res.status(400).json({ message: "Error al obtener las ventas" });
  }
};

export const obtenerVentaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const venta = await services.obtenerVentaPorId(id);
    res.status(200).json(venta);
  } catch (err) {
    console.error(`Error al obtener la venta con ID ${id}:`, err);
    res.status(400).json({ message: "Venta no encontrada" });
  }
};

export const crearVenta = async (req, res) => {
  const datos = req.body;
  try {
    const nuevaVenta = await services.crearVenta(datos);
    res.status(201).json(nuevaVenta);
  } catch (err) {
    console.error("Error al crear la venta:", err);
    res.status(400).json({ message: "Error al crear la venta" });
  }
};

export const actualizarVenta = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const ventaActualizada = await services.actualizarVenta(id, datos);
    res.status(200).json(ventaActualizada);
  } catch (err) {
    console.error(`Error al actualizar la venta con ID ${id}:`, err);
    res.status(400).json({ message: "Venta no encontrada para actualizar" });
  }
};

export const eliminarVenta = async (req, res) => {
  const { id } = req.params;
  try {
    await services.eliminarVenta(id);
    res.status(200).json({ message: "Venta eliminada correctamente" });
  } catch (err) {
    console.error(`Error al eliminar la venta con ID ${id}:`, err);
    res.status(400).json({ message: "Venta no encontrada para eliminar" });
  }
};