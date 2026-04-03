import * as repository from './alertas.repository.js';

export const obtenerAlertas = async () => {
  const result = await repository.obtenerAlertas();
  console.log("alertas obtenidas: " + result)

  return result.rows
}

export const obtenerAlertasPorId = async (id) => {
  const result = await repository.obtenerAlertasPorId(id);
  console.log("alerta obtenida: " + result);

  return result.rows
}

export const crearAlertas = async (datos) => {
  const result = await repository.crearAlertas(datos);
  console.log("alerta creada : " + result)

  return result.rows
}

export const actualizarAlerta = async (id, datos) => {
  const result = await repository.actualizarAlerta(id, datos)
  console.log("alerta actualizada: " + result)

  return result.rows
}

export const eliminarAlerta = async (id) => {
  const result = await repository.eliminarAlerta(id)
  console.log("alerta eliminada: " + result);

  return result.rows
}