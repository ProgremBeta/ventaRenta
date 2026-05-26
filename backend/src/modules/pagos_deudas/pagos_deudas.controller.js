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

export const obtenerPagoDeudaPorId = async (req, res, next) => {
    const { id } = req.params;
    try {
        const result = await service.obtenerPagoDeudaPorId(id);

        if (!result || result.length === 0) {
            console.log(`no se encontraron pagos de deudas con el id ${id}`);
            return res.status(400).json({mensaje:`no se encontraron pagos de deudas con el id ${id}`})
        }

        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const crearPagoDeuda = async (req, res, next) => {
    const datos = req.body;
    try {
        if (!datos) {
            console.log("no ingresastes datos para crear un pago de deuda")
            return res.status(400).json({mensaje:"no ingresastes datos para crear un pago de deuda"})
        }

        if (!datos.deuda_id) {
            console.log("se requiere el id de una deuda")
            return res.status(400).json({mensaje:"se requiere el id de una deuda"})
        }

        if (!datos.monto) {
            console.log("se requiere un monto")
            return res.status(400).json({mensaje:"se requiere un monto"})
        }

        if (!datos.metodo_pago) {
            console.log("se requiere un metodo de pago")
            return res.status(400).json({mensaje:"se requiere un metodo de pago"})
        }

        const result = await service.crearPagoDeuda(datos);
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
        res.status(200).json(result)
    } catch (err) {
        next(err);
    }
}

export const eliminarPagoDeuda = async (req, res, next) => {
    const id = req.params.id;
    try {
        const result = await service.eliminarPagoDeuda(id);

        console.log(result)

        if (!result || result.length === 0) {
            console.log("no existen los dato o ya fue eliminado ")
            return res.status(400).json({mensaje:"no existen los dato o ya fue eliminado "})
        }

        res.status(200).json(result)
    } catch (err) {
        next(err);
    }
}