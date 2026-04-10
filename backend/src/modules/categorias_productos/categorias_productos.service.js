import * as repository from './categorias_productos.repository.js';

export const obtenerCategoriasProductos = async () => {
  const result = await repository.obtenerCategoriasProductos();
  console.log("categorias productos obtenidas: ", result)

  return result.rows
}

export const obtenerCategoriaProductoPorId = async (id) => {
  const result = await repository.obtenerCategoriaProductoPorId(id);
  console.log("categoria producto obtenida: ", result);

  return result.rows
}

export const crearCategoriaProducto = async (datos) => {
  const result = await repository.crearCategoriaProducto(datos);
  console.log("categoria producto creada : ", result)

  return result.rows
}

export const actualizarCategoriaProducto = async (id, datos) => {
  const result = await repository.actualizarCategoriaProducto(id, datos)
  console.log("categoria producto actualizada: ", result)

  return result.rows
}

export const eliminarCategoriaProducto = async (id) => {
  const result = await repository.eliminarCategoriaProducto(id)
  console.log("categoria producto eliminada: , result");

  return result.rows
}
