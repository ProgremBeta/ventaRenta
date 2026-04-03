import * as repository from './renta_dispositivos.repository.js';

export const obtenerRentaDispositivos = async () => {
  const result = await repository.obtenerRentaDispositivos();
  console.log("renta dispositivos obtenidos: " + result)

  return result.rows
}

export const obtenerRentaDispositivoPorId = async (id) => {
  const result = await repository.obtenerRentaDispositivoPorId(id);
  console.log("renta dispositivo obtenido: " + result);

  return result.rows
}

export const crearRentaDispositivo = async (datos) => {
  const result = await repository.crearRentaDispositivo(datos);
  console.log("renta dispositivo creado : " + result)

  return result.rows
}

export const actualizarRentaDispositivo = async (id, datos) => {
  const result = await repository.actualizarRentaDispositivo(id, datos)
  console.log("renta dispositivo actualizado: " + result)

  return result.rows
}

export const eliminarRentaDispositivo = async (id) => {
  const result = await repository.eliminarRentaDispositivo(id)
  console.log("renta dispositivo eliminado: " + result);

  return result.rows
}