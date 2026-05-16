import * as repository from './clientes.repository.js';

export const obtenerClientes = async (req, res) => {
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

export const crearCliente = async (cliente) => {
    const result = await repository.crearCliente(cliente);
    return result.rows;
}

export const actualizarCliente = async (id, cliente) => {
    const result = await repository.actualizarCliente(id, cliente);
    return result.rows;
}

export const eliminarCliente = async (id) => {
    const result = await repository.eliminarCliente(id);
    return result.rows;
}