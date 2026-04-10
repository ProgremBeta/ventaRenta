import * as services from './deudas.service.js';

console.log("Cargando controladores de deudas...");

export const obtenerDeudas = async (req, res) => {
  try {
    const result = await services.obtenerDeudas();
    res.status(200).json({ mensaje: "deudas obtenidas correctament: ", result });
  } catch (err) {
    console.error("Error al obtener las deudas:", err);
    res.status(400).json({ message: "Error al obtener las deudas" });
  }
};

export const obtenerDeudaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerDeudaPorId(id);
    res.status(200).json({ mensaje: `deuda por ${id} obtenida correctamente: `, result });
  } catch (err) {
    console.error(`Error al obtener la deuda con ID ${id}:`, err);
    res.status(404).json({ message: "Deuda no encontrada" });
  }
};

export const crearDeuda = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearDeuda(datos);
    res.status(201).json({ mensaje: "deuda creada correctamente", result });
  } catch (err) {
    console.error("Error al crear la deuda: ", err);
    res.status(400).json({ message: "Error al crear la deuda" });
  }
};

export const actualizarDeuda = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarDeuda(id, datos);
    res.status(200).json({ mensaje: "deuda actualizada correctamente", result });
  } catch (err) {
    console.error(`Error al actualizar la deuda: `, err);
    res.status(400).json({ message: "Deuda no encontrada para actualizar" });
  }
};

export const eliminarDeuda = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarDeuda(id);
    res.status(200).json({ mensaje: "deuda eliminada correctamente", result });
  } catch (err) {
    console.error(`Error al eliminar la deuda: `, err);
    res.status(400).json({ message: "Deuda no encontrada para eliminar" });
  }
};