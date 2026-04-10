import * as repository from './ventas.repository.js';

export const obtenerVentas = async () => {
  const result = await repository.obtenerVentas();
  console.log("Ventas obtenidas:", result);

  return result.rows;
};

export const obtenerVentaPorId = async (id) => {
  const result = await repository.obtenerVentaPorId(id);
  console.log("Venta obtenida por ID:", result);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró la venta" });
  }

  return result.rows;
};

export const crearVenta = async (datos) => {
  const result = await repository.crearVenta(datos);
  console.log("Venta creada:", result);

  return result.rows;
};

export const actualizarVenta = async (id, datos) => {
  const result = await repository.actualizarVenta(id, datos);
  console.log("Venta actualizada:", result);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró la venta para actualizar" });
  }

  return result.rows;
};

export const eliminarVenta = async (id) => {
  const result = await repository.eliminarVenta(id);
  console.log("Venta eliminada:", result);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró la venta para eliminar" });
  }

  return result.rows;
};