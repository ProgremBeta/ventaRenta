import * as deudaRepository from './../../modules/deudas/deudas.repository.js';
import * as clienteRepository from './../../modules/clientes/clientes.repository.js';
import * as ventasRepository from './../../modules/ventas/ventas.repository.js';
import * as rentaRepository from './../../modules/rentas/rentas.repository.js';

export const crearDeuda = async (datos) => {
  //declaro la variables que recibe la peticion
  const clienteId = datos.cliente_id;
  const origenTipo = datos.origen_tipo;
  const origenId = datos.origen_id;

  //declaro los casos para que funcione correctamente 
  if (!clienteId) {
    throw new Error('El ID del cliente es requerido para crear la deuda.');
  }

  if (!origenTipo) {
    throw new Error("El tipo de origen es requerido (debe ser 'venta' o 'renta').");
  }

  if (!origenId) {
    throw new Error(`El ID del origen es requerido para el tipo ${origenTipo}.`);
  }

  //hacemos una peticion para saber que el cliente existe en la base de datos
  const cliente = await clienteRepository.obtenerClientePorId(clienteId);

  //declaro mas casos de usos y mando sus respectivos mensajes de errores de ingreso de datos
  if (!cliente.rows[0]) {
    throw new Error(`El cliente con ID ${clienteId} no fue encontrado en el sistema.`);
  }

  //declaramos que el origenTipo solo pueda ser VENTA o RENTA
  if (!['venta', 'renta'].includes(origenTipo)) {
    throw new Error("El tipo de origen debe ser 'venta' o 'renta'.");
  }

  //declaro un variable para sumar los montos
  let montoTotal = 0;

  //hago una condicional para tomar el montoTotal de si es VENTA o RENTA
  //en caso de que no exista la venta manda el mensaje de no existe
  if (origenTipo === 'venta') {
    const venta = await ventasRepository.obtenerVentaPorId(origenId);
    if (!venta.rows[0]) {
      throw new Error(`Venta con id ${origenId} no encontrada`);
    }
    montoTotal = parseFloat(venta.rows[0].total);
  } else if (origenTipo === 'renta') {
    const renta = await rentaRepository.obtenerRentaPorId(origenId);
    if (!renta.rows[0]) {
      throw new Error(`Renta con id ${origenId} no encontrada`);
    }
    montoTotal = parseFloat(renta.rows[0].precio_total);
  }

  if (montoTotal <= 0) {
    throw new Error('El monto total de la deuda debe ser mayor a cero.');
  }

  //transfiero los datos a nuevas variables y usarlas para dejar datos por defecto
  const saldo = montoTotal;
  const estado = 'pendiente';

  //uso esta peticion con los datos de la deuda para crear los datos en la DB
  const deuda = await deudaRepository.crearDeuda({
    cliente_id: clienteId,
    origen_tipo: origenTipo,
    origen_id: origenId,
    monto_total: montoTotal,
    monto_pagado: 0,
    saldo,
    estado
  });

  //lo retorno para usarlo en el controller
  console.log(`Deuda creada para cliente ${clienteId} de ${origenTipo} id ${origenId}`);
  return deuda.rows[0];
};