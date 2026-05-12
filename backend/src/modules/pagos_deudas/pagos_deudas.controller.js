import * as service from './pagos_deudas.service.js';

export const obtenerPagosDeudas = async (req, res, next) => {
    try {
        const result = await service.obtenerPagosDeudas();
        
        if (!result || result.length === 0) {
            res.status(200).json({ message: "No se encontraron pagos de deudas" });
        }

        res.status(200).json(result);
    }catch (err) {
        next(err);
    }
}

export const obtenerPagosDeudasPorId = async (req, res, next) => {
    const id = req.params.id;
    try {
        const result = await service.obtenerPagosDeudasPorId(id);
        console.log("el resultado es:", result);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const crearPagoDeuda = async (req, res, next) => {
    const data = req.body;
    try {
        const result = await service.crearPagoDeuda(data);
        console.log("el resultado es:", result);
        res.status(200).json(result)
    } catch (err) {
        next(err);
    }
}

export const actualizarPagoDeuda = async (req, res, next) => {
    const id = req.params.id;
    const data = req.body;
    try {
        const result = await service.actualizarPagoDeuda(id, data);
        console.log("el resultado es:", result);
        res.status(200).json(result)
    } catch (err) {
        next(err);
    }
}

export const eliminarPagoDeuda = async (req, res, next) => {
    const id = req.params.id;
    try {
        const result = await service.eliminarPagoDeuda(id);
        console.log("el resultado es:", result);
        res.status(200).json(result)
    } catch (err) {
        next(err);
    }
}