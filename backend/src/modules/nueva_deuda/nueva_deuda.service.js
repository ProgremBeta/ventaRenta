import * as deudaRepository from '../deudas/deudas.repository.js';
import * as clienteService from '../clientes/clientes.service.js';
import * as ventasService from '../ventas/ventas.service.js';
import * as rentaService from '../rentas/rentas.service.js';

export const crearDeuda = async (datos) => {

  console.log(`los datos recibidos son ${datos.cliente_id},  ${datos.origen_tipo} , ${ datos.origen_id}`)

  const cliente = await clienteService.obtenerClientePorId(datos.cliente_id);

  console.log("los clientes son: ", cliente)

  if (!cliente) {
    throw new Error(`datos clientes`);
  }

  let montoTotal = 0;

  if (datos.origen_tipo === 1) {
    const venta = await ventasService.obtenerVentaPorId(datos.origen_id);

    console.log("resultado de ventas en origen_tipo", venta)
    if (!venta) {
      throw new Error(`Venta con id ${datos.origen_id} no encontrada`);
    }
    
    montoTotal = parseFloat(venta[0].total);

  } else if (datos.origen_tipo === 2) {
    const renta = await rentaService.obtenerRentaPorId(datos.origen_id);
    
    console.log("resultado de renta en origen_tipo", renta)

    if (!renta || renta.length === 0) {
      throw new Error(`Renta con id ${datos.origen_id} no encontrada`);
    }

    montoTotal = parseFloat(renta[0].precio_total);
  }

  if (montoTotal <= 0) {
    throw new Error('El monto total de la deuda debe ser mayor a cero.');
  }

  const saldo = montoTotal;
  let pago = datos?.monto_pagado || 0;
  const estado = datos?.estado || "en deuda";

  const deuda = await deudaRepository.crearDeuda({
    cliente_id: cliente[0].id,
    monto_total: saldo,
    monto_pagado: pago,
    saldo: saldo,
    estado: estado
  });

  //lo retorno para usarlo en el controller
  console.log(`Deuda creada para cliente ${cliente[0].id} de ${datos.origen_tipo} id ${datos.origen_id}`);
  return deuda.rows;
};