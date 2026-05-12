import * as respository from './pagos_deudas.repository.js';

export const obtenerPagosDeudas = async () => {
    const result = await respository.obtenerPagosDeudas();
    return result[0];
}

export const obtenerPagosDeudasPorId = async (id) => {
    const result = await respository.obtenerPagosDeudasPorId(id);
    return result[0];
}

export const crearPagoDeuda = async (data) => {
    const result = await respository.crearPagoDeuda(data);
    return result[0];
}

export const actualizarPagoDeuda = async (id, data) => {
    const result = await respository.actualizarPagoDeuda(id,data);
    return result[0];
}

export const eliminarPagoDeuda = async (id ) => {
    const result = await respository.eliminarPagoDeuda(id);
    return result[0]
}