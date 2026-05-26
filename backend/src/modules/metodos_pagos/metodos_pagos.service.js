import * as respository from './metodos_pagos.repository.js';

export const obtenerMetodosPagos = async () => {
    const result = await respository.obtenerMetodosPagos()
    return result.rows;
}

export const obtenerMetodoPagoPorId = async (id) => {
    const result = await respository.obtenerMetodoPagoPorId(id)
    return result.rows;
}

export const crearMetodoPago = async (datos) => {
    const result = await respository.crearMetodoPago(datos)
    return result.rows;
}

export const actualizarMetodoPago = async (id,datos) => {
    const result = await respository.actualizarMetodoPago(id,datos)
    return result.rows;
}

export const eliminarMetodoPago = async (id) => {
    const result = await respository.eliminarMetodoPago(id)
    return result.rows;
}