import * as service from './detalles_ventas.service.js';

export const obtenerDetallesVentas = async (req, res, next) => {
    try {
        const result = await service.obtenerDetallesVentas();

        if (!result || result.length === 0) {
            return res.status(404).json({ message: 'No se encontraron detalles de ventas' });
        }
        res.json(result);
    }catch (err) {
        next(err);
    }
};

export const obtenerDetalleVentaPorId = async (req, res, next) => {
    const { id } = req.params;

    try {
        const result = await service.obtenerDetalleVentaPorId(id);

        if (!result || result.length === 0) {
            console.log(`Detalle de venta del id: ${id} no existe`)
            return res.status(404).json({ message: `Detalle de venta del id: ${id} no existe` });
        }

        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
};

export const crearDetalleVenta = async (req, res, next) => {
    const datos = req.body;

    try {
        if (!datos) {
            console.log("no ingresastes datos para crear usuario")
            return res.status(400).json({mensaje: "no ingresastes datos para crear usuario"})
        }

        if (!datos.cantidad) {
            console.log("se requiere la cantidad para crear el detalle de venta")
            return res.status(400).json({mensaje: "se requiere la cantidad para crear el detalle de venta"})
        }

        if (!datos.precio_unitario) {
            console.log("se requiere el precio unitario para crear el detalle de venta")
            return res.status(400).json({mensaje: "se requiere el precio unitario para crear el detalle de venta"})
        }

        if (!datos.sub_total) {
            console.log("se requiere el sub total para crear el detalle de venta")
            return res.status(400).json({mensaje: "se requiere el sub total para crear el detalle de venta"})
        }

        const result = await service.crearDetalleVenta(datos);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
};

export const actualizarDetalleVenta = async (req, res, next) => {
    const { id } = req.params;
    const datos = req.body;

    try {
        const result = await service.actualizarDetalleVenta(id, datos);
        if (!result) {
            return res.status(404).json({ message: 'Detalle de venta no encontrado' });
        }
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
};

export const eliminarDetalleVenta = async (req, res, next) => {
    const { id } = req.params;

    try {
        const result = await service.eliminarDetalleVenta(id);
        if (!result || result.length === 0) {
            console.log(`no existen datos de este detalle de venta o ya fue eliminado`)
            return res.status(404).json({ message:`no existen datos de este detalle de venta o ya fue eliminado`});
        }
        
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
};