import * as repository from '../../modules/categorias_productos/categorias_productos.repository.js';

export const obtenerCategoriasProductos = async () => {
  const result = await repository.obtenerCategoriasProductos();
  return result.rows;
};

export const obtenerCategoriaProductoPorId = async (id) => {
  const result = await repository.obtenerCategoriaProductoPorId(id);
  return result.rows[0];
};

export const crearCategoriaProducto = async (datos) => {
  const result = await repository.crearCategoriaProducto(datos);
  return result.rows[0];
};

export const actualizarCategoriaProducto = async (id, datos) => {
  const result = await repository.actualizarCategoriaProducto(id, datos);
  return result.rows[0];
};

export const eliminarCategoriaProducto = async (id) => {
  const result = await repository.eliminarCategoriaProducto(id);
  return result.rows[0];
};