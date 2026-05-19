import * as respository from './metodos_pagos.repository.js';

export const obtenerMetodosPagos = async () => {
    const result = await respository.obtenerMetodosPago()

    console.log("metodos de pagos en services son:", result.rows);
    return result.rows;
}