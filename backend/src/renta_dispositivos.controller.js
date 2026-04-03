import * as services from './renta_dispositivos.services.js';

export const obtenerRentaDispositivos = async (req, res) => {
  try {
    const result = await services.obtenerRentaDispositivos();
    res.status(200).json(result);
  } catch (error) {
    console.error('Error al obtener las rentas de dispositivos:', error);
    res.status(500).json({ error: 'Error al obtener las rentas de dispositivos' });
  }
}

export const obtenerRentaDispositivoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerRentaDispositivoPorId(id);
    res.status(200).json(result);
  } catch (error) {
    console.error(`Error al obtener la renta de dispositivo con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al obtener la renta de dispositivo por ID' });
  }
}

export const crearRentaDispositivo = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearRentaDispositivo(datos);
    res.status(201).json(result);
  } catch (error) {
    console.error('Error al crear la renta de dispositivo:', error);
    res.status(500).json({ error: 'Error al crear la renta de dispositivo' });
  }
}

export const actualizarRentaDispositivo = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarRentaDispositivo(id, datos);
    res.status(200).json(result);
  } catch (error) {
    console.error(`Error al actualizar la renta de dispositivo con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al actualizar la renta de dispositivo' });
  }
}

export const eliminarRentaDispositivo = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarRentaDispositivo(id);
    res.status(200).json(result);
  } catch (error) {
    console.error(`Error al eliminar la renta de dispositivo con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al eliminar la renta de dispositivo' });
  }
}