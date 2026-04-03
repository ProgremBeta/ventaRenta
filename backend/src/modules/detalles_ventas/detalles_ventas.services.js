import * as repository from './detalles_ventas.repository.js';

export const obtenerDetallesVentas = async () => {
  const result = await repository.obtenerDetallesVentas();
  console.log("detalles ventas obtenidos: " + result)

  return result.rows
}

export const obtenerDetalleVentaPorId = async (id) => {
  const result = await repository.obtenerDetalleVentaPorId(id);
  console.log("detalle venta obtenido: " + result);

  return result.rows
}

export const crearDetalleVenta = async (datos) => {
  const result = await repository.crearDetalleVenta(datos);
  console.log("detalle venta creado : " + result)

  return result.rows
}

export const actualizarDetalleVenta = async (id, datos) => {
  const result = await repository.actualizarDetalleVenta(id, datos)
  console.log("detalle venta actualizado: " + result)

  return result.rows
}

export const eliminarDetalleVenta = async (id) => {
  const result = await repository.eliminarDetalleVenta(id)
  console.log("detalle venta eliminado: " + result);

  return result.rows
}