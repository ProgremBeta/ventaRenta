import * as repository from './deudas.repository.js';

console.log("Cargando servicios de deudas...");

export const obtenerDeudas = async () => {
  const result = await repository.obtenerDeudas();
  console.log("Deudas obtenidas:", result.rows);

  return result.rows;
}

export const obtenerDeudaPorId = async (id) => {
  const result = await repository.obtenerDeudaPorId(id);
  console.log("Deuda obtenida por ID:", result.rows);

  return result.rows;
};

export const crearDeuda = async (datos) => {
  const result = await repository.crearDeuda(datos);
  console.log("Deuda creada:", result.rows);

  return result.rows;
};

export const actualizarDeuda = async (id, datos) => {
  const result = await repository.actualizarDeuda(id, datos);
  console.log("Deuda actualizada:", result.rows);

  return result.rows;
};

export const eliminarDeuda = async (id) => {
  const result = await repository.eliminarDeuda(id);
  console.log("Deuda eliminada:", result.rows);

  return result.rows;
};