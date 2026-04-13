import * as repository from '../../modules/categorias_dispositivos/categorias_dispositivos.repository.js';

export const obtenerCategoriasDispositivos = async () => {
  const result = await repository.obtenerCategoriasDispositivos();
  return result.rows;
};

export const obtenerCategoriaDispositivoPorId = async (id) => {
  const result = await repository.obtenerCategoriaDispositivoPorId(id);
  return result.rows[0];
};

export const crearCategoriaDispositivo = async (datos) => {
  const result = await repository.crearCategoriaDispositivo(datos);
  return result.rows[0];
};

export const actualizarCategoriaDispositivo = async (id, datos) => {
  const result = await repository.actualizarCategoriaDispositivo(id, datos);
  return result.rows[0];
};

export const eliminarCategoriaDispositivo = async (id) => {
  const result = await repository.eliminarCategoriaDispositivo(id);
  return result.rows[0];
};