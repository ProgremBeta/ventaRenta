import * as repository from './pagos_deudas.repository.js';
import { registrarPagoDeuda as registrarPagoDeudaUseCase } from '../../use_cases/pago_deuda/pago_deuda.service.js';

export const obtenerPagosDeudas = async () => {
  const result = await repository.obtenerPagosDeudas();
  console.log("pagos deudas obtenidos: ", result)

  return result.rows
}

export const obtenerPagoDeudaPorId = async (id) => {
  const result = await repository.obtenerPagoDeudaPorId(id);
  console.log("pago de deuda obtenido: ", result);

  return result.rows
}

export const crearPagoDeuda = async (datos) => {
  const result = await registrarPagoDeudaUseCase(datos);
  console.log("pago de deuda creado y deuda actualizada: ", JSON.stringify(result))

  return result
}

export const actualizarPagoDeuda = async (id, datos) => {
  const result = await repository.actualizarPagoDeuda(id, datos)
  console.log("pago de deuda actualizado: ", result)

  return result.rows
}

export const eliminarPagoDeuda = async (id) => {
  const result = await repository.eliminarPagoDeuda(id)
  console.log("pago de deuda eliminado: ", result);

  return result.rows
}