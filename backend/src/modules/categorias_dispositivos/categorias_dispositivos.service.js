import * as repository from '../../modules/categorias_dispositivos/categorias_dispositivos.repository.js';

export const obtenerCategoriasDispositivos = async () => {
  const result = await repository.obtenerCategoriasDispositivos();
  return result.rows;
};

export const obtenerCategoriaDispositivoPorId = async (id) => {
  const result = await repository.obtenerCategoriaDispositivoPorId(id);
  return result.rows;
};

export const crearCategoriaDispositivo = async (datos) => {
  
  if (!datos || datos.length === 0) {
    console.log("no ingresastes datos")
    throw new Error("no ingresastes datos")
  }

  if (!datos.nombre) {
    console.log("no ingresastes nombres")
    throw new Error("no ingresastes nombres")
  }
  
  if (!datos.activo) {
    datos.activo = true
  }

  const result = await repository.crearCategoriaDispositivo(datos);
  return result.rows;
};

export const actualizarCategoriaDispositivo = async (id, datos) => {

  /*
  ### esto es para agregarlo a las busquedas

  const datosDB = await obtenerCategoriaDispositivoPorId(id);

  console.log("datos a actualizar: ", datosDB);

  if (!datos.nombre) { datos.nombre = datosDB.nombre}
  if (!datos.descripcion) { datos.descripcion = datosDB.descripcion}
  if (!datos.activo) { datos.activo = datosDB.activo}
  */

  const result = await repository.actualizarCategoriaDispositivo(id, datos);
  return result.rows;
};

export const eliminarCategoriaDispositivo = async (id) => {
  const result = await repository.eliminarCategoriaDispositivo(id);
  return result.rows;
};
