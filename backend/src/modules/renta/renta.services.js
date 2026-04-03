import * as repository from './renta.repository.js';

export const obtenerRentas = async () => {
  const result = await repository.obtenerRentas();
  console.log("rentas obtenidos: " + result)

  return result.rows
}

export const obtenerRentaPorId = async (id) => {
  const result = await repository.obtenerRentaPorId(id);
  console.log("renta obtenido: " + result);

  return result.rows
}

export const crearRenta = async (datos) => {
  const result = await repository.crearRenta(datos);
  console.log("renta creado : " + result)

  return result.rows
}

export const actualizarRenta = async (id, datos) => {
  const result = await repository.actualizarRenta(id, datos)
  console.log("renta actualizado: " + result)

  return result.rows
}

export const eliminarRenta = async (id) => {
  const result = await repository.eliminarRenta(id)
  console.log("renta eliminado: " + result);

  return result.rows
}