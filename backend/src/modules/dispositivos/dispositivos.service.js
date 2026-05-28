import * as repository from './dispositivos.repository.js';

export const obtenerDispositivos = async () => {
    const result = await repository.obtenerDispositivos();
    return result.rows;
}

export const obtenerDispositivoPorId = async (id) => {
    const result = await repository.obtenerDispositivoPorId(id);
    return result.rows;
}

export const crearDispositivo = async (datos) => {
    if (!datos.activo) {
        datos.activo = true
    }
    const result = await repository.crearDispositivo(datos);
    return result.rows;
}

export const actualizarDispositivo = async (id, datos) => {
    const result = await repository.actualizarDispositivo(id, datos);
    return result.rows;
}

export const eliminarDispositivo = async (id) => {
    const result = await repository.eliminarDispositivo(id);
    return result.rows;
}