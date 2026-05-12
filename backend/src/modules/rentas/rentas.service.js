import * as repository from './../../modules/rentas/rentas.repository.js';

export const obtenerRentas = async () => {
  const rentas = await repository.obtenerRentas();
  return rentas[0];
}

export const obtenerRentaPorId = async (id) => {
  const renta = await repository.obtenerRentaPorId(id);
  return renta[0];
}

export const crearRenta = async (datos) => {
  const nuevaRenta = await repository.crearRenta(datos);
  return nuevaRenta[0];
}

export const actualizarRenta = async (id, datos) => {
  const rentaActualizada = await repository.actualizarRenta(id, datos);
  return rentaActualizada[0];
}

export const eliminarRenta = async (id) => {
  const rentaEliminada = await repository.eliminarRenta(id);
  return rentaEliminada[0];
}