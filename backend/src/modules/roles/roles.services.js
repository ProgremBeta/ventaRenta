import * as repository from './roles.repository.js';

export const obtenerRoles = async () => {
  const result = await repository.obtenerRoles();
  console.log("roles obtenidos: " + result)

  return result.rows
}

export const obtenerRolPorId = async (id) => {
  const result = await repository.obtenerRolPorId(id);
  console.log("rol obtenido: " + result);

  return result.rows
}

export const crearRol = async (datos) => {
  const result = await repository.crearRol(datos);
  console.log("rol creado : " + result)

  return result.rows
}

export const actualizarRol = async (id, datos) => {
  const result = await repository.actualizarRol(id, datos)
  console.log("rol actualizado: " + result)

  return result.rows
}

export const eliminarRol = async (id) => {
  const result = await repository.eliminarRol(id)
  console.log("rol eliminado: " + result);

  return result.rows
}