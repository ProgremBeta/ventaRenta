import * as respository from './categorias_dispositivos.repository.js';

export const obtenerCategoriasDispositivos = async () => {
  const result = await respository.obtenerCategoriasDispositivos();
  console.log("categorias dispositivos obtenidas: " + result)

  return result.rows
}

export const obtenerCategoriaDispositivoPorId = async (id) => {
  const result = await respository.obtenerCategoriaDispositivoPorId(id);
  console.log("categoria dispositivo obtenida: " + result);

  return result.rows
}

export const crearCategoriaDispositivo = async (datos) => {
  const result = await respository.crearCategoriaDispositivo(datos);
  console.log("categoria dispositivo creada : " + result)

  return result.rows
}

export const actualizarCategoriaDispositivo = async (id, datos) => {
  const result = await respository.actualizarCategoriaDispositivo(id, datos)
  console.log("categoria dispositivo actualizada: " + result)

  return result.rows
}

export const eliminarCategoriaDispositivo = async (id) => {
  const result = await respository.eliminarCategoriaDispositivo(id)
  console.log("categoria dispositivo eliminada: " + result);

  return result.rows
} 