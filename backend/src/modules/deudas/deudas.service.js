import * as repository from './deudas.repository.js';

export const obtenerDeudas = async () => {
    const result = await repository.obtenerDeudas();
    console.log("en services deudas: ", result.rows);

    console.log(result);

    return result[0];
}

export const obtenerDeudasPorId = async (id) => {
    const result = await repository.obtenerDeudasPorId(id);
    return result[0];
}

export const crearDeuda = async (data) => {
    const result = await repository.crearDeuda(data);
    return result;
}

export const actualizarDeudas = async (id, data) => {
    const result = await repository.actualizarDeuda(id,data);
    return result;
}

export const eliminarDeuda = async (id ) => {
    const result = await repository.eliminarDeuda(id);
    return result
}
