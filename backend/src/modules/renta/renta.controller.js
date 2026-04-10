import * as services from './renta.service.js';

export const obtenerRentas = async (req, res) => {
  try {
    const result = await services.obtenerRentas();
    res.status(200).json(result);
  } catch (err) {
    console.error('Error al obtener las rentas:', err);
    res.status(400).json({ error: 'Error al obtener las rentas' });
  }
}

export const obtenerRentaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerRentaPorId(id);
    res.status(200).json(result);
  } catch (err) {
    console.error(`Error al obtener la renta con ID ${id}:`, err);
    res.status(400).json({ error: 'Error al obtener la renta por ID' });
  }
}

export const crearRenta = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearRenta(datos);
    res.status(201).json(result);
  } catch (err) {
    console.error('Error al crear la renta:', err);
    res.status(400).json({ error: 'Error al crear la renta' });
  }
}

export const actualizarRenta = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarRenta(id, datos);
    res.status(200).json(result);
  } catch (err) {
    console.error(`Error al actualizar la renta con ID ${id}:`, err);
    res.status(400).json({ error: 'Error al actualizar la renta' });
  }
}

export const eliminarRenta = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarRenta(id);
    res.status(200).json(result);
  } catch (err) {
    console.error(`Error al eliminar la renta con ID ${id}:`, err);
    res.status(400).json({ error: 'Error al eliminar la renta' });
  }
}