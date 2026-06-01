import * as repository from './clientes.repository.js';

export const obtenerClientes = async () => {
    const result = await repository.obtenerClientes();
    return result.rows;
}

export const obtenerClientePorId = async (id) => {
    const result = await repository.obtenerClientePorId(id);
    return result.rows;
}

export const sumarPuntosCliente = async (id, puntos) => {
    const result = await repository.sumarPuntosCliente(id, puntos);
    return result.rows;
}

export const crearCliente = async (datos) => {
    const result = await repository.crearCliente(datos);
    return result.rows;
}

export const actualizarCliente = async (id, datos) => {
    const result = await repository.actualizarCliente(id, datos);

    return result.rows;
}

export const eliminarCliente = async (id) => {
    const result = await repository.eliminarCliente(id);
    return result.rows;
}