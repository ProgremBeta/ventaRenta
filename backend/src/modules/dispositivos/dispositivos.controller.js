import * as services from './dispositivos.service.js';

export const obtenerDispositivos = async (req, res) => {
  try {
    const result = await services.obtenerDispositivos();
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener los dispositivos: ", err);
    res.status(400).json({ message: "Error al obtener los dispositivos" });
  }
}

export const obtenerDispositivoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerDispositivoPorId(id);
    if (result.length === 0) {
      res.status(404).json({ message: "Dispositivo no encontrado" });
    } else {
      res.status(200).json(result[0]);
    }
  } catch (err) {
    console.error("Error al obtener el dispositivo: ", err);
    res.status(400).json({ message: "Error al obtener el dispositivo" });
  }
}

export const crearDispositivo = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearDispositivo(datos);
    res.status(201).json(result[0]);
  } catch (err) {
    console.error("Error al crear el dispositivo: ", err);
    res.status(400).json({ message: "Error al crear el dispositivo" });
  }
}

export const actualizarDispositivo = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarDispositivo(id, datos);
    if (result.length === 0) {
      res.status(404).json({ message: "Dispositivo no encontrado" });
    } else {
      res.status(200).json(result[0]);
    }
  } catch (err) {
    console.error("Error al actualizar el dispositivo: ", err);
    res.status(400).json({ message: "Error al actualizar el dispositivo" });
  }
}

export const eliminarDispositivo = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarDispositivo(id);
    if (result.length === 0) {
      res.status(404).json({ message: "Dispositivo no encontrado" });
    } else {
      res.status(200).json({ message: "Dispositivo eliminado correctamente" });
    }
  } catch (err) {
    console.error("Error al eliminar el dispositivo: ", err);
    res.status(400).json({ message: "Error al eliminar el dispositivo" });
  }
}