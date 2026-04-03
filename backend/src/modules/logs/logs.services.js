import * as repository from './logs.repository.js';

export const obtenerLogs = async () => {
  const result = await repository.obtenerLogs();
  console.log("logs obtenidos: " + result)

  return result.rows
}

export const obtenerLogPorId = async (id) => {
  const result = await repository.obtenerLogPorId(id);
  console.log("log obtenido: " + result);

  return result.rows
}

export const crearLog = async (datos) => {
  const result = await repository.crearLog(datos);
  console.log("log creado : " + result)

  return result.rows
}

export const actualizarLog = async (id, datos) => {
  const result = await repository.actualizarLog(id, datos)
  console.log("log actualizado: " + result)

  return result.rows
}

export const eliminarLog = async (id) => {
  const result = await repository.eliminarLog(id)
  console.log("log eliminado: " + result);

  return result.rows
}