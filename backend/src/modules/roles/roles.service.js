import * as repository from './roles.repository.js';

export const obtenerRoles = async () => {
  const result = await repository.obtenerRoles();

  return result.rows;
};

export const obtenerRolPorId = async (id) => {
  const result = await repository.obtenerRolPorId(id);

  return result.rows;
};

export const crearRol = async (datos) => {
  const result = await repository.crearRol(datos);

  return result.rows;
};

export const actualizarRol = async (id, datos) => {
  const result = await repository.actualizarRol(id, datos);

  return result.rows;
};

export const eliminarRol = async (id) => {
  const result = await repository.eliminarRol(id);

  return result.rows;
};