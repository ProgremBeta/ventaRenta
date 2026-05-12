import * as repository from './roles.repository.js';

export const obtenerRoles = async () => {
  const result = await repository.obtenerRoles();

  return result;
};

export const obtenerRolPorId = async (id) => {
  const result = await repository.obtenerRolPorId(id);

  return result;
};

export const crearRol = async (datos) => {
  const result = await repository.crearRol(datos);

  return result;
};

export const actualizarRol = async (id, datos) => {
  const result = await repository.actualizarRol(id, datos);

  return result;
};

export const eliminarRol = async (id) => {
  const result = await repository.eliminarRol(id);

  return result;
};