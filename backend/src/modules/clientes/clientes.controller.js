import * as service from './clientes.service.js';

export const obtenerClientes = async (req, res, next) => {
    try {
        const result = await service.obtenerClientes();
        
        if (!result || result.length === 0) {
            res.status(200).json({ message: "No se encontraron clientes" });
        }

        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const obtenerClientePorId = async (req, res, next) => {
    try {
        const id = req.params.id;
        const result = await service.obtenerClientePorId(id);
        if (!result) {
            res.status(404).json({ message: "Cliente no encontrado" });
        } else {
            res.status(200).json(result);
        }
    } catch (err) {
        next(err);
    }
}

export const sumarPuntosCliente = async (req, res, next) => {
    try {
        const id = req.params.id;
        const puntos = req.body.puntos;
        const result = await service.sumarPuntosCliente(id, puntos);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const crearCliente = async (req, res, next) => {
    try {
        const cliente = req.body;
        const result = await service.crearCliente(cliente);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
}

export const actualizarCliente = async (req, res, next) => {
    try {        const id = req.params.id;
        const cliente = req.body;
        const result = await service.actualizarCliente(id, cliente);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const eliminarCliente = async (req, res, next) => {
    try {
        const id = req.params.id;
        const result = await service.eliminarCliente(id);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}