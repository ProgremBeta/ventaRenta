import * as services from './metodos_pagos.service.js';

export const obtenerMetodosPagos = async (req,res,next) => {
    try {
        const result = await services.obtenerMetodosPagos();

        console.log("los metodos de pagos en controller son: ", result)

        if(!result || result.length === 0)
        {
            res.status(404).json({mensaje: "no existen metodos de pagos"});
        }
        res.status(200).json(result);
        
    } catch (err) {
        console.log("el error es: ", err);
        next()
    }
}