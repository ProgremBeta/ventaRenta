import * as pagoDeudaRepository from './../../modules/pagos_deudas/pagos_deudas.repository.js';
import * as deudaRepository from './../../modules/deudas/deudas.repository.js';

export const pagoDeudas = async (data) => {
  const deudaId = data.deuda_id;
  const monto = parseFloat(data.monto);
  const metodoPago = data.metodo_pago;

  // Validaciones basicas
  if (!deudaId) {
    throw new Error('no se ingresó deuda_id');
  }

  if (!monto || monto <= 0) {
    throw new Error('monto debe ser un valor mayor a cero');
  }

  if (!metodoPago) {
    throw new Error('no se ingresó metodo_pago');
  }

  // consulta para obtener las deudas
  const deudaResult = await deudaRepository.obtenerDeudaPorId(deudaId);
  const deuda = deudaResult.rows[0];

  //valida que existe la deuda
  if (!deuda) {
    throw new Error(`Deuda con id ${deudaId} no encontrada`);
  }

  // Validar que la deuda no esté completamente pagada
  if (deuda.estado === 'pagado') {
    throw new Error(`La deuda con id ${deudaId} ya está pagada`);
  }

  // Validar que el monto de pago no exceda el saldo
  const saldoActual = parseFloat(deuda.saldo);
  if (monto > saldoActual) {
    throw new Error(`Monto de pago (${monto}) no puede ser mayor al saldo (${saldoActual})`);
  }

  // Crear registro de pago
  const pagoResult = await pagoDeudaRepository.crearPagoDeuda({
    deuda_id: deudaId,
    monto: monto,
    metodo_pago: metodoPago
  });

  // guarda los datos en constantes
  const montoPagadoAnterior = parseFloat(deuda.monto_pagado || 0);
  const montoPagadoNuevo = montoPagadoAnterior + monto;
  const saldoNuevo = parseFloat(deuda.monto_total) - montoPagadoNuevo;
  const estadoNuevo = saldoNuevo <= 0 ? 'pagado' : 'pendiente';

  // asigna los datos a la base de datos
  const deudaActualizada = await deudaRepository.actualizarDeuda(deudaId, {
    cliente_id: deuda.cliente_id,
    origen_tipo: deuda.origen_tipo,
    origen_id: deuda.origen_id,
    monto_total: deuda.monto_total,
    monto_pagado: montoPagadoNuevo,
    saldo: saldoNuevo,
    estado: estadoNuevo
  });

  console.log(`Pago de ${monto} registrado para deuda ${deudaId}. Saldo actualizado: ${saldoNuevo}, Estado: ${estadoNuevo}`);

  return {
    pago: pagoResult.rows[0],
    deuda: deudaActualizada.rows[0]
  };
};