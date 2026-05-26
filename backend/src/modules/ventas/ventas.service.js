import * as repository from './../../modules/ventas/ventas.repository.js';

export const obtenerVentas = async () => {
  const ventas = await repository.obtenerVentas();
  return ventas.rows;
}

export const obtenerVentaPorId = async (id) => {
  const venta = await repository.obtenerVentaPorId(id);
  return venta.rows;
}

export const crearVenta = async (datos) => {
  const nuevaVenta = await repository.crearVenta(datos);
  return nuevaVenta.rows;
}

export const actualizarVenta = async (id, datos) => {
  const ventaActualizada = await repository.actualizarVenta(id, datos);
  return ventaActualizada.rows;
}

export const eliminarVenta = async (id) => {
  const ventaEliminada = await repository.eliminarVenta(id);
  return ventaEliminada.rows;
}