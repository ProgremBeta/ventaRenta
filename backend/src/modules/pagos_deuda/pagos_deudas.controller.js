import * as services from './pagos_deudas.service.js';

export const obtenerPagosDeudas = async (req, res) => {
  try {
    const result = await services.obtenerPagosDeudas();
    res.status(200).json(result);
  } catch (err) {
    console.error('Error al obtener los pagos de deudas:', err);
    res.status(400).json({ error: 'Error al obtener los pagos de deudas' });
  }
};

export const obtenerPagoDeudaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerPagoDeudaPorId(id);
    if (result.length === 0) {
      return res.status(404).json({ error: 'Pago de deuda no encontrado' });
    }
    res.status(200).json(result);
  } catch (err) {
    console.error('Error al obtener el pago de deuda:', err);
    res.status(400).json({ error: 'Error al obtener el pago de deuda' });
  }
};

export const crearPagoDeuda = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearPagoDeuda(datos);
    res.status(201).json(result);
  } catch (err) {
    console.error('Error al crear el pago de deuda:', err);
    res.status(400).json({ error: 'Error al crear el pago de deuda' });
  }
};

export const actualizarPagoDeuda = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarPagoDeuda(id, datos);
    if (result.length === 0) {
      return res.status(404).json({ error: 'Pago de deuda no encontrado' });
    }
    res.status(200).json(result);
  } catch (err) {
    console.error('Error al actualizar el pago de deuda:', err);
    res.status(400).json({ error: 'Error al actualizar el pago de deuda' });
  }
};

export const eliminarPagoDeuda = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarPagoDeuda(id);
    if (result.length === 0) {
      return res.status(404).json({ error: 'Pago de deuda no encontrado' });
    }
    res.status(200).json(result);
  } catch (err) {
    console.error('Error al eliminar el pago de deuda:', err);
    res.status(400).json({ error: 'Error al eliminar el pago de deuda' });
  }
};