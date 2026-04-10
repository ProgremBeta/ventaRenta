import * as services from './detalles_renta.service.js';

export const obtenerRentaDispositivos = async (req, res) => {
  try {
    const result = await services.obtenerRentaDispositivos();
    res.status(200).json(result);
  } catch (err) {
    console.error('Error al obtener las rentas de dispositivos:', err);
    res.status(400).json({ error: 'Error al obtener las rentas de dispositivos' });
  }
}

export const obtenerRentaDispositivoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerRentaDispositivoPorId(id);

    if (result.length === 0) {
      res.status(404).json({ error: 'detalle de venta no encontrado' });
    } else {
      res.status(200).json(result[0]);
    }
  } catch (err) {
    console.error(`Error al obtener la renta de dispositivo con ID ${id}:`, err);
    res.status(400).json({ error: 'Error al obtener la renta de dispositivo por ID' });
  }
}

export const crearRentaDispositivo = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearRentaDispositivo(datos);
    res.status(201).json(result[0]);
  } catch (err) {
    console.error('Error al crear la renta de dispositivo:', err);
    res.status(400).json({ error: 'Error al crear la renta de dispositivo' });
  }
}

export const actualizarRentaDispositivo = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarRentaDispositivo(id, datos);
    res.status(200).json(result[0]);
  } catch (err) {
    console.error(`Error al actualizar la renta de dispositivo con ID ${id}:`, err);
    res.status(400).json({ error: 'Error al actualizar la renta de dispositivo' });
  }
}

export const eliminarRentaDispositivo = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarRentaDispositivo(id);
    res.status(200).json(result[0]);
  } catch (err) {
    console.error(`Error al eliminar la renta de dispositivo con ID ${id}:`, err);
    res.status(400).json({ error: 'Error al eliminar la renta de dispositivo' });
  }
}