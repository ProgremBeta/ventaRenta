import * as service from './dispositivos.service.js';

export const obtenerDispositivos = async (req,res,next) =>{
    try {
        const result = await service.obtenerDispositivos()

        if (!result || result.length === 0) {
            console.log("no existen datos de dispositivos")
            return res.status(400).json({mensaje:"no existen datos de dispositivos"})
        }

        res.status(200).json(result)
    } catch (err) {
        console.log("error al obtener los dispositivos desde controller: ", err)
        next(err)
    }
}

export const obtenerDispositivoPorId = async (req,res,next) =>{
    const { id } = req.params;

    try {
        const result = await service.obtenerDispositivoPorId(id)

        if (!result || result.length === 0) {
            console.log(`no existen datos de dispositivos con el id = ${id}`)
            return res.status(400).json({mensaje:`no existen datos de dispositivos con el id = ${id}`})
        }

        res.status(200).json(result)
    } catch (err) {
        console.log("error al obtener los dispositivos pordesde controller: ", err)
        next(err)
    }
}

export const crearDispositivo = async (req,res,next) =>{
    const datos = req.body

    try {

        if (!datos) {
            console.log("no ingresastes ningun dato para crear un nuevo dispositivo")
            return res.status(400).json({mensaje:"no ingresastes ningun dato para crear un nuevo dispositivo"})
        }
        if (!datos.nombre) {
            console.log("se requiere un nombre para crear un nuevo dispositivo")
            return res.status(400).json({mensaje:"se requiere un nombre para crear un nuevo dispositivo"})
        }
        if (!datos.categoria_id) {
            console.log("se requiere un categoria id para crear un nuevo dispositivo")
            return res.status(400).json({mensaje:"se requiere un categoria id para crear un nuevo dispositivo"})
        }
        const result = await service.crearDispositivo(datos)
        res.status(200).json(result)
    } catch (err) {
        console.log("error al crear un dispositivo desde controller: ", err)
        next(err)
    }
}

export const actualizarDispositivo = async (req,res,next) =>{
    const { id } = req.params;
    const datos = req.body

    try {
        if (!datos) {
            console.log("no ingresastes ningun valor para actualizar dispositivos")
            return res.status(400).json({mensaje:"no ingresastes ningun valor para actualizar dispositivos"})
        }
        const result = await service.actualizarDispositivo(id,datos)

        res.status(200).json(result)
    } catch (err) {
        console.log("error al actulizar un dispositivos desde controller: ", err)
        next(err)
    }
}

export const eliminarDispositivo = async (req,res,next) =>{
    const { id } = req.params;

    try {
        const result = await service.eliminarDispositivo(id)
        res.status(200).json(result)
    } catch (err) {
        console.log("error al eliminar los dispositivos desde controller: ", err)
        next(err)
    }
}
