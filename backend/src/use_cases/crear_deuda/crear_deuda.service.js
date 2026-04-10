import * as deudaRepository from './../../modules/deudas/deudas.repository.js';
import * as clienteRepository from './../../modules/clientes/clientes.repositorys.js';
import * as ventasRepository from './../../modules/ventas/ventas.repository.js';
import * as rentaRepository from './../../modules/renta/renta.repository.js';

export const crearDeuda = async (datos) => {
  //declaro la variables que recibe la peticion
  const clienteId = datos.cliente_id;
  const origenTipo = datos.origen_tipo;
  const origenId = datos.origen_id;

  //declaro los casos para que funcione correctamente 
  if (!clienteId) {
    throw new Error('no se ingreso cliente');
  }

  //hacemos una peticion para saber que el cliente existe en la base de datos
  const cliente = await clienteRepository.obtenerClientePorId(clienteId);

  //declaro mas casos de usos y mando sus respectivos mensajes de errores de ingreso de datos
  if (!cliente.rows[0]) {
    throw new Error("Cliente no encontrado ");
  }

  if (!origenTipo) {
    throw new Error("no se ingreso el origen");
  }

  //declaramos que el origenTipo solo pueda ser VENTA o RENTA
  if (!['venta', 'renta'].includes(origenTipo)) {
    throw new Error("el origen debe ser venta o renta");
  }

  if (!origenId) {
    throw new Error(`no se ingreso el ID de ${origenTipo}`);
  }

  //declaro un variable para sumar los montos
  let montoTotal = 0;

  //hago una condicional para tomar el montoTotal si es de VENTA o RENTA
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