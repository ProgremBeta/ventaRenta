import * as repositorio from './productos.repository.js';

export const obtenerProductos = async () => {
  const result = await repositorio.obtenerProductos();
  return result.rows;
};

export const obtenerProductoPorId = async (id) => {
  const result = await repositorio.obtenerProductoPorId(id);
  return result.rows;
};

export const crearProducto = async (datos) => {
  const result = await repositorio.crearProducto(datos);
  return result.rows;
};

export const actualizarProducto = async (id, datos) => {
  const result = await repositorio.actualizarProducto(id, datos);
  return result.rows;
};

export const eliminarProducto = async (id) => {
  const result = await repositorio.eliminarProducto(id);
  return result.rows;
};