import * as service from './clientes.service.js';

export const obtenerClientes = async (req, res, next) => {
    try {
        const result = await service.obtenerClientes();
        
        if (!result || result.length === 0) {
            console.log("No se encontraron clientes")
            res.status(404).json({ message: "No se encontraron clientes" });
        }

        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const obtenerClientePorId = async (req, res, next) => {
    const { id } = req.params;

    try {
        const result = await service.obtenerClientePorId(id);

        if (!result) {
            console.log(`el cliente con el id: ${id}`)
            res.status(404).json({ message: `el cliente con el id: ${id}`});
        }

        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const sumarPuntosCliente = async (req, res, next) => {
    const { id } = req.params;
    const datos = req.body;

    try {
        if (!datos.puntos) {
            console.log("no se ingresaron puntos")
            res.status(400).json({messaje: "no se ingresaron puntos"});
        }

        const result = await service.sumarPuntosCliente(id, datos.puntos);
        res.status(200).json(result);

    } catch (err) {
        console.log(`error al sumar puntos del cliente con id: ${id} `, err)
        next(err);
    }
}

export const crearCliente = async (req, res, next) => {
    const datos = req.body;

    try {
        if (!datos) {
            console.log("no se ingresaron datos para crear el cliente")
            return res.status(404).json({mensaje: "no se ingresaron datos para crear el cliente"})
        }

        if (!datos.nombre){
            console.log("no ingresaste el nombre de usuario")
            return res.status(400).json({mensaje:"no ingresaste el nombre de usuario"})
        }

        const result = await service.crearCliente(datos);
        res.status(201).json(result);
    } catch (err) {
        console.log("error al crear un cliente: ", err)
        next(err);
    }
}

export const actualizarCliente = async (req, res, next) => {
    const { id } = req.params.id;
    const datos = req.body;

    try {
        if (!datos.nombre){
            console.log("se requiere un nombre para actualizar cliente")
            res.status(400).json({mensaje: "se requiere un nombre para actualizar cliente"})
        }

        if (!datos.email){
            console.log("se requiere el email para actualizar cliente")
            res.status(400).json({mensaje: "se requiere el email para actualizar cliente"})
        }
        if (!datos.telefono){
            console.log("se requiere el telefoo para actualizar el cliente")
            res.status(400).json({mensaje: "se requiere el telefoo para actualizar el cliente"})
        }

        const result = await service.actualizarCliente(id, datos);

        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

export const eliminarCliente = async (req, res, next) => {
    const { id } = req.params.id;

    try {
        if (!id) {
            console.log("El cliente no existe o ya fue eliminado")
            return res.status(404).json({mensaje:"El cliente no existe o ya fue eliminado"})
        }

        const result = await service.eliminarCliente(id);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}