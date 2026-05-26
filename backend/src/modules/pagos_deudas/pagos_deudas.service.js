import * as respository from './pagos_deudas.repository.js';

export const obtenerPagosDeudas = async () => {
    const result = await respository.obtenerPagosDeudas();
    return result.rows;
}

export const obtenerPagoDeudaPorId = async (id) => {
    const result = await respository.obtenerPagoDeudaPorId(id);
    return result.rows;
}

export const crearPagoDeuda = async (datos) => {
    const result = await respository.crearPagoDeuda(datos);
    return result.rows;
}

export const actualizarPagoDeuda = async (id, datos) => {
    const result = await respository.actualizarPagoDeuda(id,datos);
    return result.rows;
}

export const eliminarPagoDeuda = async (id ) => {
    const result = await respository.eliminarPagoDeuda(id);
    return result.rows;
}