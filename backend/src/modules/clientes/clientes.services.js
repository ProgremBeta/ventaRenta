import * as repository from './clientes.repositorys.js';

export const obtenerClientes = async () => {
  const result = await repository.obtenerClientes();
  console.log("clientes obtenidos: " + result)

  return result.rows
}

export const obtenerClientePorId = async (id) => {
  const result = await repository.obtenerClientePorId(id);
  console.log("cliente obtenido: " + result);

  return result.rows
}

export const crearCliente = async (datos) => {
  const result = await repository.crearCliente(datos);
  console.log("cliente creado : " + result)

  return result.rows
}

export const actualizarCliente = async (id, datos) => {
  const result = await repository.actualizarCliente(id, datos)
  console.log("cliente actualizado: " + result)

  return result.rows
}

export const eliminarCliente = async (id) => {
  const result = await repository.eliminarCliente(id)
  console.log("cliente eliminado: " + result);

  return result.rows
}