import * as repository from './dispositivos.repository.js';

export const obtenerDispositivos = async () => {
  const result = await repository.obtenerDispositivos();
  console.log("dispositivos obtenidos: ", result)

  return result.rows
}

export const obtenerDispositivoPorId = async (id) => {
  const result = await repository.obtenerDispositivoPorId(id);
  console.log("dispositivo obtenido: ", result);

  return result.rows
}

export const crearDispositivo = async (datos) => {
  const result = await repository.crearDispositivo(datos);
  console.log("dispositivo creado : ", result)

  return result.rows
}

export const actualizarDispositivo = async (id, datos) => {
  const result = await repository.actualizarDispositivo(id, datos)
  console.log("dispositivo actualizado: ", result)

  return result.rows
}

export const eliminarDispositivo = async (id) => {
  const result = await repository.eliminarDispositivo(id)
  console.log("dispositivo eliminado: ", result);

  return result.rows
}