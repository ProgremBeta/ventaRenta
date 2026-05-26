import * as repository from './../../modules/rentas/rentas.repository.js';

export const obtenerRentas = async () => {
  const result = await repository.obtenerRentas();
  return result.rows;
}

export const obtenerRentaPorId = async (id) => {
  const result = await repository.obtenerRentaPorId(id);
  return result.rows;
}

export const crearRenta = async (datos) => {
  const result = await repository.crearRenta(datos);
  return result.rows;
}

export const actualizarRenta = async (id, datos) => {
  const result = await repository.actualizarRenta(id, datos);
  return result.rows;
}

export const eliminarRenta = async (id) => {
  const result = await repository.eliminarRenta(id);
  return result.rows;
}