import * as repository from './inventario_productos.repository.js';

export const obtenerInventarioProductos = async () => {
  const result = await repository.obtenerInventarioProductos();
  return result[0];
};

export const obtenerInventarioProductoPorId = async (id) => {
  const result = await repository.obtenerInventarioProductoPorId(id);
  return result[0];
};

export const obtenerInventarioPorProductoId = async (producto_id) => {
  const result = await repository.obtenerInventarioPorProductoId(producto_id);
  return result[0];
};

export const descontarStock = async (producto_id, cantidad) => {
  const result = await repository.descontarStock(producto_id, cantidad);
  return result[0];
};

export const crearInventarioProducto = async (datos) => {
  const result = await repository.crearInventarioProducto(datos);
  return result[0];
};

export const actualizarInventarioProducto = async (id, datos) => {
  const result = await repository.actualizarInventarioProducto(id, datos);
  return result[0];
};

export const eliminarInventarioProducto = async (id) => {
  const result = await repository.eliminarInventarioProducto(id);
  return result[0];
};