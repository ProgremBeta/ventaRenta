import * as Repositorio from './productos.repository.js';

export const obtenerProductos = async () => {
  const result = await Repositorio.obtenerProductos();
  return result;
};

export const obtenerProductoPorId = async (id) => {
  const result = await Repositorio.obtenerProductoPorId(id);
  return result;
};

export const crearProducto = async (datos) => {
  const result = await Repositorio.crearProducto(datos);
  return result;
};

export const actualizarProducto = async (id, datos) => {
  const result = await Repositorio.actualizarProducto(id, datos);
  return result;
};

export const eliminarProducto = async (id) => {
  const result = await Repositorio.eliminarProducto(id);
  return result;
};