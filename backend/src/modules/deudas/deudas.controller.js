import * as service from './deudas.service.js';

export const obtenerDeudas = async (req, res, next) => {
    try {
        const result = await service.obtenerDeudas()

        if (!result || result.length == 0) {
            console.log("no existen datos de deudas")
            return res.status(200).json({ message: "no existen datos de deudas" });
        }
        
        return res.status(200).json(result);
    } catch (err) {
        console.log("error al obtener deudas controller: ", err)
        next(err);
    }
}

export const obtenerDeudaPorId = async (req, res, next) => {
    const { id } = req.params

    try {
        const result = await service.obtenerDeudaPorId(id)

        if (!result || result.length == 0) {
            console.log(`no se encontro deudas con el id: ${id}`)
            return res.status(200).json({ message: `no se encontro deudas con el id: ${id}` });
        }
        
        return res.status(200).json(result);
    } catch (err) {
        console.log("error al obtener deudas por id controller: ", err)
        next(err);
    }
}

export const crearDeuda = async (req, res, next) => {
    const datos = req.body

    try {
        if (!datos) {
            console.log("no ingresastes ningun datos")
            return res.status(400).json({mensaje:"no ingresastes ningun datos"})
        }
        const result = await service.crearDeuda(datos)
        
        return res.status(200).json(result);
    } catch (err) {
        console.log("error al crear deudas controller: ", err)
        next(err);
    }
}

export const actualizarDeuda = async (req, res, next) => {
    const { id } = req.params
    const datos = req.body

    try {
        const result = await service.actualizarDeuda(id,datos)
        
        return res.status(200).json(result);
    } catch (err) {
        console.log("error al actualizar deudas controller: ", err)
        next(err);
    }
}

export const eliminarDeuda = async (req, res, next) => {
    const { id } = req.params

    try {
        console.log("el id para eliminar es: ", id)
        const result = await service.eliminarDeuda(id)

        if (!result || result.length === 0) {
            console.log("no existe datos o ya fue eliminado")
            return res.status(200).json({mensaje:"no existe datos o ya fue eliminado"})
        }
        
        return res.status(200).json(result);
    } catch (err) {
        console.log("error al eliminar deudas controller: ", err)
        next(err);
    }
}