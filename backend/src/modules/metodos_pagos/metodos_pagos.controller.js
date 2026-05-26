import * as service from './metodos_pagos.service.js';

export const obtenerMetodosPagos = async (req,res,next) => {
    try {
        const result = await service.obtenerMetodosPagos();

        if(!result || result.length === 0)
        {
            res.status(404).json({mensaje: "no existen metodos de pagos"});
        }
        res.status(200).json(result);
        
    } catch (err) {
        console.log("error al obtener metodos de pagos ", err);
        next()
    }
}

export const obtenerMetodoPagoPorId = async (req,res,next) => {
    const { id } = req.params;
    try{
        const result = await service.obtenerMetodoPagoPorId(id)

        if (!result || result.length === 0) {
            console.log(`no existen datos de metodos de pagos con el id ${id}`)
            return res.status(400).json({mensaje:`no existen datos de metodos de pagos con el id ${id}`})
        }

        return res.status(200).json(result)
    }catch(err){
        console.log("error al obtener metodos de pagos con el id ", err)
        next(err)
    }
}

export const crearMetodoPago = async (req,res,next) => {
    const datos = req.body;

    try{
        if (!datos) {
            console.log("no ingresastes datos para crear un metodo de pago")
            return res.status(400).json({mensaje:"no ingresastes datos para crear un metodo de pago"})
        }

        if (!datos.nombre) {
            console.log("se requiere un nombre para crear un metodo de pago")
            return res.status(400).json({mensaje:"se requiere un nombre para crear un metodo de pago"})
        }

        if (!datos.descripcion) {
            console.log("se requiere un descripcion para crear un metodo de pago")
            return res.status(400).json({mensaje:"se requiere un descripcion para crear un metodo de pago"})
        }

        const result = await service.crearMetodoPago(datos) 

        res.status(201).json(result)
    }catch(err){
        console.log("error al crear metodos de pagos ", err)
        next(err)
    }
}

export const actualizarMetodoPago = async (req,res,next) => {
    const { id } = req.params;
    const datos = req.body;

    try{
        const result = await service.actualizarMetodoPago(id,datos)

        res.status(200).json(result)
    }catch(err){
        console.log("error al actualizar metodo de pago ", err)
        next(err);
    }
    
}

export const eliminarMetodoPago = async (req,res,next) => {
    const { id } = req.params;

    try{
        console.log("ID: ", id)

        const result = await service.eliminarMetodoPago(id)

        if (!result || result.length === 0) {
            console.log("no existen datos o ya fue eliminado")
            return res.status(400).json({mensaje: "no existen datos o ya fue eliminado"})
        }

        return res.status(200).json(result)

    }catch(err){
        console.log("error al eliminar metodo de pago controller ", err)
        next(err)
    }
}