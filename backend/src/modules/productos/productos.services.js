import * as repository from './productos.repository.js';

export const obtenerProductos = async () => {
  const result = await repository.obtenerProductos();
  console.log("productos obtenidos: " + result)

  return result.rows
}

export const obtenerProductoPorId = async (id) => {
  const result = await repository.obtenerProductoPorId(id);
  console.log("producto obtenido: " + result);

  return result.rows
}

export const crearProducto = async (datos) => {
  const result = await repository.crearProducto(datos);
  console.log("producto creado : " + result)

  return result.rows
}

export const actualizarProducto = async (id, datos) => {
  const result = await repository.actualizarProducto(id, datos)
  console.log("producto actualizado: " + result)

  return result.rows
}

export const eliminarProducto = async (id) => {
  const result = await repository.eliminarProducto(id)
  console.log("producto eliminado: " + result);

  return result.rows
}