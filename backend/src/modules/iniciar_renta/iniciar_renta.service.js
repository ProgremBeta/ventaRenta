import * as rentaService from './../../modules/rentas/rentas.service.js';
import * as detalleRentaService from './../../modules/detalles_rentas/detalles_rentas.service.js';
import * as clienteService from './../../modules/clientes/clientes.service.js';
import * as dispositivoService from './../../modules/dispositivos/dispositivos.service.js';

export const iniciarRentaDispositivos = async (datos) => {

  const cliente = await clienteService.obtenerClientePorId(datos.cliente_id);

  console.log("clientes en iniciar renta services: ", cliente)

  const dispositivo = await dispositivoService.obtenerDispositivoPorId(datos.dispositivo_id)

  if (!dispositivo[0]) {
    throw new Error(`dispostivo con id ${datos.dispositivo_id} no encontrado`);
  }
  
  const inicio = new Date();
  
  const milisegundos = datos.duracion * 60 * 60 * 1000;

  const fin = new Date(inicio.getTime() + milisegundos);

  console.log("dispositivo: ", dispositivo, " precio total: ", dispositivo[0].precio_hora)

  const precioTotal = dispositivo[0].precio_hora * datos.duracion;

  if (datos.duracion <= 0) {
    throw new Error("fecha_fin debe ser mayor que fecha_inicio");
  }

  const datosRenta = {
    cliente_id: datos.cliente_id,
    usuario_id: datos.usuario_id,
    fecha_inicio: inicio,
    fecha_fin: fin,
    tiempo_total: datos.duracion,
    metodo_pago: datos.metodo_pago,
    precio_total: precioTotal,
    estado: "renta"
  };

  const renta = await rentaService.crearRenta(datosRenta);
  
  await detalleRentaService.crearRenta({
    renta_id: renta[0].id,
    dispositivo_id:dispositivo[0].id,
    precio_hora:dispositivo[0].precio_hora,
    tiempo_total:renta[0].tiempo_total,
    sub_total:renta[0].precio_total
  });

  return renta;
}