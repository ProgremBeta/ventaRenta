import * as repository from './deudas.repository.js';

export const obtenerDeudas = async () => {
    const result = await repository.obtenerDeudas();
    return result.rows;
}

export const obtenerDeudaPorId = async (id) => {
    const result = await repository.obtenerDeudaPorId(id);
    return result.rows;
}

export const crearDeuda = async (datos) => {
    const result = await repository.crearDeuda(datos);
    return result.rows;
}

export const actualizarDeuda = async (id, datos) => {
    const result = await repository.actualizarDeuda(id,datos);
    return result.rows;
}

export const eliminarDeuda = async (id ) => {
    const result = await repository.eliminarDeuda(id);
    return result.rows
}
