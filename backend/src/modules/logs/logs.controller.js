import * as services from './logs.services.js';

export const obtenerLogs = async (req, res) => {
  try {
    const logs = await services.obtenerLogs();
    res.status(200).json(logs);
  } catch (error) {
    console.error('Error al obtener los logs:', error);
    res.status(500).json({ error: 'Error al obtener los logs' });
  }
};

export const obtenerLogPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const log = await services.obtenerLogPorId(id);
    if (log.length === 0) {
      return res.status(404).json({ error: 'Log no encontrado' });
    }
    res.status(200).json(log);
  } catch (error) {
    console.error(`Error al obtener el log con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al obtener el log' });
  }
};

export const crearLog = async (req, res) => {
  const datos = req.body;
  try {
    const nuevoLog = await services.crearLog(datos);
    res.status(201).json(nuevoLog);
  } catch (error) {
    console.error('Error al crear el log:', error);
    res.status(500).json({ error: 'Error al crear el log' });
  }
};

export const actualizarLog = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const logActualizado = await services.actualizarLog(id, datos);
    if (logActualizado.length === 0) {
      return res.status(404).json({ error: 'Log no encontrado' });
    }
    res.status(200).json(logActualizado);
  } catch (error) {
    console.error(`Error al actualizar el log con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al actualizar el log' });
  }
};

export const eliminarLog = async (req, res) => {
  const { id } = req.params;
  try {
    const logEliminado = await services.eliminarLog(id);
    if (logEliminado.length === 0) {
      return res.status(404).json({ error: 'Log no encontrado' });
    }
    res.status(200).json(logEliminado);
  } catch (error) {
    console.error(`Error al eliminar el log con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al eliminar el log' });
  }
};