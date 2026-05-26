import * as ventaService from '../ventas/ventas.service.js';
import * as detalleVentaService from '../detalles_ventas/detalles_ventas.service.js';
import * as productosService from '../productos/productos.service.js';
import * as inventarioService from '../inventario_productos/inventario_productos.service.js';
import * as clientesService from '../clientes/clientes.service.js';

export const nuevaVenta = async (datos) => {

  const clienteId = datos.cliente_id || null;

  if (clienteId) {
    const cliente = await clientesService.obtenerClientePorId(clienteId);
    if (!cliente || cliente) {
      throw new Error(`Cliente con id ${clienteId} no encontrado`);
    }
  }

  let total = 0;

  for (const detalle of datos.detalles) {
    const producto = await productosService.obtenerProductoPorId(detalle.producto_id);
    if (!producto) {
      throw new Error(`Producto con id ${detalle.producto_id} no encontrado`);
    }

    const inventario = await inventarioService.obtenerInventarioPorProductoId(detalle.producto_id);
    if (!inventario) {
      throw new Error(`No hay inventario para el producto con id ${detalle.producto_id}`);
    }

    if (inventario[0].stock < detalle.cantidad) {
      throw new Error(`Stock insuficiente para el producto ${producto.rows[0].nombre}. Stock disponible: ${inventario.rows[0].stock}, Solicitado: ${detalle.cantidad}`);
    }

    const precio_unitario = producto[0].precio;
    total += detalle.cantidad * precio_unitario;
  }

  const datosVenta = {
    usuario_id: datos.usuario_id,
    cliente_id: clienteId,
    total: total,
    metodo_pago: datos.metodo_pago
  };

  const venta = await ventaService.crearVenta(datosVenta);

  for (const detalle of datos.detalles) {
    const producto = await productosService.obtenerProductoPorId(detalle.producto_id);
    const precio_unitario = producto[0].precio;
    const subtotal = detalle.cantidad * precio_unitario;
    await detalleVentaService.crearDetalleVenta({
      venta_id: venta[0].id,
      producto_id: detalle.producto_id,
      cantidad: detalle.cantidad,
      precio_unitario: precio_unitario,
      sub_total: subtotal
    });

    await inventarioService.descontarStock(detalle.producto_id, detalle.cantidad);
  }

  if (clienteId) {
    const puntosGanados = Math.max(1, Math.floor(total / 100));
    await clientesService.sumarPuntosCliente(clienteId, puntosGanados);
    console.log(`Cliente ${clienteId} recibió ${puntosGanados} puntos`);
  }

  return venta;
}