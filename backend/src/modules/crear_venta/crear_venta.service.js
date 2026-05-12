import * as ventaRepository from './../../modules/ventas/ventas.repository.js';
import * as detalleVentaRepository from './../../modules/detalles_ventas/detalles_ventas.repository.js';
import * as productosRepository from './../../modules/productos/productos.repository.js';
import * as inventarioRepository from './../../modules/inventario_productos/inventario_productos.repository.js';
import * as clientesRepository from './../../modules/clientes/clientes.repository.js';

export const nuevaVenta = async (data) => {

  // guardo el valor del ID del cliente en una constante
  const clienteId = data.cliente_id || null;

  // condicionales para asegurarnos que existan estos datos
  if (!data.metodo_pago) {
    throw new Error("no se ingreso metodo de pago que es necesario para mantener el registro")
  }
  if (!data.detalles || data.detalles.length === 0) {
    throw new Error("no se ingresaron detalles de la venta")
  }

  //condicional para aseguranos que exista el ID del cliente en la base de datos
  if (clienteId) {
    const cliente = await clientesRepository.obtenerClientePorId(clienteId);
    if (!cliente.rows[0]) {
      throw new Error(`Cliente con id ${clienteId} no encontrado`);
    }
  }

  // este bloque se encarga de obtener el id del producto y el stock del inventario
  let total = 0;

  //consulta si existe el producto 
  for (const detalle of data.detalles) {
    const producto = await productosRepository.obtenerProductoPorId(detalle.producto_id);
    if (!producto.rows[0]) {
      throw new Error(`Producto con id ${detalle.producto_id} no encontrado`);
    }

    // consulta que si exista y haya stock
    const inventario = await inventarioRepository.obtenerInventarioPorProductoId(detalle.producto_id);
    if (!inventario.rows[0]) {
      throw new Error(`No hay inventario para el producto con id ${detalle.producto_id}`);
    }

    // se asegura que el stock no sea menor a la cantidad de la compra
    if (inventario.rows[0].stock < detalle.cantidad) {
      throw new Error(`Stock insuficiente para el producto ${producto.rows[0].nombre}. Stock disponible: ${inventario.rows[0].stock}, Solicitado: ${detalle.cantidad}`);
    }

    // operaciones para separar el precio de cada producto con el total
    const precio_unitario = producto.rows[0].precio;
    // operacion para calcular el total teniendo encuenta la cantidad y el precio de cada producto
    total += detalle.cantidad * precio_unitario;
  }

  // Crear la venta con el total calculadonueva_
  const datosVenta = {
    usuario_id: data.usuario_id,
    cliente_id: clienteId,
    total: total,
    metodo_pago: data.metodo_pago
  };

  const venta = await ventaRepository.crearVenta(datosVenta);

  // Insertar los detalles y descontar inventario
  for (const detalle of data.detalles) {
    const producto = await productosRepository.obtenerProductoPorId(detalle.producto_id);
    const precio_unitario = producto.rows[0].precio;
    const subtotal = detalle.cantidad * precio_unitario;
    await detalleVentaRepository.crearDetalleVenta({
      venta_id: venta.rows[0].id,
      producto_id: detalle.producto_id,
      cantidad: detalle.cantidad,
      precio_unitario: precio_unitario,
      sub_total: subtotal
    });

    // Descontar del inventario
    await inventarioRepository.descontarStock(detalle.producto_id, detalle.cantidad);
  }

  console.log("ingresando los detalles y descontando inventario")

  //esta funcion le suma punto al clientes por el total de la compra (no se a definido la cantidad)
  if (clienteId) {
    const puntosGanados = Math.max(1, Math.floor(total / 100));
    await clientesRepository.sumarPuntosCliente(clienteId, puntosGanados);
    console.log(`Cliente ${clienteId} recibió ${puntosGanados} puntos`);
  }

  return venta;
}