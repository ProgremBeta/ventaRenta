import * as repository from './inventario_productos.repository.js';

export const obtenerInventarioProductos = async () => {
  const result = await repository.obtenerInventarioProductos();
  return result.rows;
};

export const obtenerInventarioProductoPorId = async (id) => {
  const result = await repository.obtenerInventarioProductoPorId(id);
  return result.rows;
};

export const obtenerInventarioPorProductoId = async (producto_id) => {
  const result = await repository.obtenerInventarioPorProductoId(producto_id);
  return result.rows;
};

export const descontarStock = async (producto_id, cantidad) => {
  const stock = await obtenerInventarioPorProductoId(producto_id);

  const stockActual = stock[0].stock
  const cantidadIngresada = cantidad

  const nuevaCantidad = stockActual - cantidadIngresada; 

  const result = await repository.descontarStock(producto_id, nuevaCantidad);
  return result.rows;
};

export const crearInventarioProducto = async (datos) => {
  const result = await repository.crearInventarioProducto(datos);
  return result.rows;
};

export const actualizarInventarioProducto = async (id, datos) => {
  const result = await repository.actualizarInventarioProducto(id, datos);
  return result.rows;
};

export const eliminarInventarioProducto = async (id) => {
  const result = await repository.eliminarInventarioProducto(id);
  return result.rows;
};