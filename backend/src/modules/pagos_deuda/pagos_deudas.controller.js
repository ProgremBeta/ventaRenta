import * as services from './pagos_deudas.services.js';

export const obtenerPagosDeudas = async (req, res) => {
  try {
    const pagosDeudas = await services.obtenerPagosDeudas();
    res.status(200).json(pagosDeudas);
  } catch (error) {
    console.error('Error al obtener los pagos de deudas:', error);
    res.status(500).json({ error: 'Error al obtener los pagos de deudas' });
  }
};

export const obtenerPagoDeudaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const pagoDeuda = await services.obtenerPagoDeudaPorId(id);
    if (pagoDeuda.length === 0) {
      return res.status(404).json({ error: 'Pago de deuda no encontrado' });
    }
    res.status(200).json(pagoDeuda);
  } catch (error) {
    console.error('Error al obtener el pago de deuda:', error);
    res.status(500).json({ error: 'Error al obtener el pago de deuda' });
  }
};

export const crearPagoDeuda = async (req, res) => {
  const datos = req.body;
  try {
    const nuevoPagoDeuda = await services.crearPagoDeuda(datos);
    res.status(201).json(nuevoPagoDeuda);
  } catch (error) {
    console.error('Error al crear el pago de deuda:', error);
    res.status(500).json({ error: 'Error al crear el pago de deuda' });
  }
};

export const actualizarPagoDeuda = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const pagoDeudaActualizado = await services.actualizarPagoDeuda(id, datos);
    if (pagoDeudaActualizado.length === 0) {
      return res.status(404).json({ error: 'Pago de deuda no encontrado' });
    }
    res.status(200).json(pagoDeudaActualizado);
  } catch (error) {
    console.error('Error al actualizar el pago de deuda:', error);
    res.status(500).json({ error: 'Error al actualizar el pago de deuda' });
  }
};

export const eliminarPagoDeuda = async (req, res) => {
  const { id } = req.params;
  try {
    const pagoDeudaEliminado = await services.eliminarPagoDeuda(id);
    if (pagoDeudaEliminado.length === 0) {
      return res.status(404).json({ error: 'Pago de deuda no encontrado' });
    }
    res.status(200).json(pagoDeudaEliminado);
  } catch (error) {
    console.error('Error al eliminar el pago de deuda:', error);
    res.status(500).json({ error: 'Error al eliminar el pago de deuda' });
  }
};