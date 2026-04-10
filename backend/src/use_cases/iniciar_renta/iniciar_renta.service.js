import * as rentaRepository from '../../modules/renta/renta.repository.js';
import * as detalleRentaRepository from '../../modules/detalles_renta/detalles_renta.repository.js';
import * as clienteRepository from '../../modules/clientes/clientes.repositorys.js';
import * as dispositivoRepository from '../../modules/dispositivos/dispositivos.repository.js';

export const iniciarRentaDispositivos = async (data) => {
  const clienteId = data.cliente_id;
  const usuarioId = data.usuario_id;
  const fechaInicio = data.fecha_inicio;
  const fechaFin = data.fecha_fin;
  const metodoPago = data.metodo_pago;
  const dispositivos = data.dispositivos;

  // Validaciones básicas
  if (!clienteId) {
    throw new Error("no se ingresó cliente_id");
  }

  if (!usuarioId) {
    throw new Error("no se ingresó usuario_id");
  }

  if (!fechaInicio || !fechaFin) {
    throw new Error("no se ingresaron fecha_inicio y fecha_fin");
  }

  if (!metodoPago) {
    throw new Error("no se ingresó metodo_pago");
  }

  //valida que si existan dispositivos para inciar la renta
  if (!dispositivos || dispositivos.length === 0) {
    throw new Error("no se ingresaron dispositivos");
  }

  // Validar que el cliente existe
  const cliente = await clienteRepository.obtenerClientePorId(clienteId);
  if (!cliente.rows[0]) {
    throw new Error(`Cliente con id ${clienteId} no encontrado`);
  }

  // Validar que todos los dispositivos existen y calcular precio total
  let precioTotal = 0;
  const dispositivosConDatos = []; // Guardar datos completos de dispositivos
  const inicio = new Date(fechaInicio);
  const fin = new Date(fechaFin);
  const horasRenta = (fin - inicio) / (1000 * 60 * 60); // Calcular horas

  // se asegura que la que las fechas estan ingresadas correctamente
  if (horasRenta <= 0) {
    throw new Error("fecha_fin debe ser mayor que fecha_inicio");
  }

  //consulta que exista el dispositivo y agrega los dispositivos a la lista
  for (const dispositivo of dispositivos) {
    const dispoExistente = await dispositivoRepository.obtenerDispositivoPorId(dispositivo.dispositivo_id);
    if (!dispoExistente.rows[0]) {
      throw new Error(`Dispositivo con id ${dispositivo.dispositivo_id} no encontrado`);
    }
    //agrega los dispositivos a la lista
    dispositivosConDatos.push(dispoExistente.rows[0]);
    precioTotal += dispositivo.precio_hora * horasRenta;
  }

  // Crear la renta
  const datosRenta = {
    cliente_id: clienteId,
    usuario_id: usuarioId,
    fecha_inicio: fechaInicio,
    fecha_fin: fechaFin,
    tiempo_total: `${Math.round(horasRenta)} horas`,
    metodo_pago: metodoPago,
    estado: 'activa',
    precio_total: precioTotal
  };

  const renta = await rentaRepository.crearRenta(datosRenta);
  const rentaId = renta.rows[0].id;

  // Crear detalles de renta_dispositivos y actualizar estado
  for (let i = 0; i < dispositivos.length; i++) {
    const dispositivoId = dispositivos[i].dispositivo_id;
    const datoDispositivo = dispositivosConDatos[i];

    await detalleRentaRepository.crearRentaDispositivo({
      renta_id: rentaId,
      dispositivo_id: dispositivoId
    });

    // Actualizar estado del dispositivo a "en renta"
    await dispositivoRepository.actualizarDispositivo(dispositivoId, {
      nombre: datoDispositivo.nombre,
      categoria_id: datoDispositivo.categoria_id,
      estado: 'en renta'
    });
  }

  console.log(`Renta ${rentaId} creada exitosamente con ${dispositivos.length} dispositivos`);
  return renta;
}