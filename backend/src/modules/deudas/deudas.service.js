import * as repository from './deudas.repository.js';
import { crearDeuda as crearDeudaUseCase } from '../../use_cases/crear_deuda/crear_deuda.service.js';

export const obtenerDeudas = async () => {
  const result = await repository.obtenerDeudas();
  console.log("Deudas obtenidas:", result);

  return result.rows;
}

export const obtenerDeudaPorId = async (id) => {
  const result = await repository.obtenerDeudaPorId(id);
  console.log("Deuda obtenida por ID:", result);

  return result.rows;
};

export const crearDeuda = async (datos) => {
  const result = await crearDeudaUseCase(datos);
  console.log("Deuda creada:", result);

  return result.rows;
};

export const actualizarDeuda = async (id, datos) => {
  const result = await repository.actualizarDeuda(id, datos);
  console.log("Deuda actualizada:", result);

  return result.rows;
};

export const eliminarDeuda = async (id) => {
  const result = await repository.eliminarDeuda(id);
  console.log("Deuda eliminada:", result);

  return result.rows;
};