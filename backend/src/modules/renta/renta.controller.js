import * as services from './renta.services.js';

export const obtenerRentas = async (req, res) => {
  try {
    const result = await services.obtenerRentas();
    res.status(200).json(result);
  } catch (error) {
    console.error('Error al obtener las rentas:', error);
    res.status(500).json({ error: 'Error al obtener las rentas' });
  }
}

export const obtenerRentaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerRentaPorId(id);
    res.status(200).json(result);
  } catch (error) {
    console.error(`Error al obtener la renta con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al obtener la renta por ID' });
  }
}

export const crearRenta = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearRenta(datos);
    res.status(201).json(result);
  } catch (error) {
    console.error('Error al crear la renta:', error);
    res.status(500).json({ error: 'Error al crear la renta' });
  }
}

export const actualizarRenta = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarRenta(id, datos);
    res.status(200).json(result);
  } catch (error) {
    console.error(`Error al actualizar la renta con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al actualizar la renta' });
  }
}

export const eliminarRenta = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarRenta(id);
    res.status(200).json(result);
  } catch (error) {
    console.error(`Error al eliminar la renta con ID ${id}:`, error);
    res.status(500).json({ error: 'Error al eliminar la renta' });
  }
}