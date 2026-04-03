import * as services from './deudas.services.js';

console.log("Cargando controladores de deudas...");

export const obtenerDeudas = async (req, res) => {
  try {
    const deudas = await services.obtenerDeudas();
    res.status(200).json(deudas);
  } catch (error) {
    console.error("Error al obtener las deudas:", error);
    res.status(500).json({ message: "Error al obtener las deudas" });
  }
};

export const obtenerDeudaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const deuda = await services.obtenerDeudaPorId(id);
    res.status(200).json(deuda);
  } catch (error) {
    console.error(`Error al obtener la deuda con ID ${id}:`, error);
    res.status(404).json({ message: "Deuda no encontrada" });
  }
};

export const crearDeuda = async (req, res) => {
  const datos = req.body;
  try {
    const nuevaDeuda = await services.crearDeuda(datos);
    res.status(201).json(nuevaDeuda);
  } catch (error) {
    console.error("Error al crear la deuda:", error);
    res.status(400).json({ message: "Error al crear la deuda" });
  }
};

export const actualizarDeuda = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const deudaActualizada = await services.actualizarDeuda(id, datos);
    res.status(200).json(deudaActualizada);
  } catch (error) {
    console.error(`Error al actualizar la deuda con ID ${id}:`, error);
    res.status(404).json({ message: "Deuda no encontrada para actualizar" });
  }
};

export const eliminarDeuda = async (req, res) => {
  const { id } = req.params;
  try {
    const deudaEliminada = await services.eliminarDeuda(id);
    res.status(200).json(deudaEliminada[0]);
  } catch (error) {
    console.error(`Error al eliminar la deuda con ID ${id}:`, error);
    res.status(404).json({ message: "Deuda no encontrada para eliminar" });
  }
};