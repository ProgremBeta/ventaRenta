import * as service from './detalles_ventas.service.js';

export const obtenerDetallesVentas = async (req, res, next) => {
    try {
        const result = await service.obtenerDetallesVentas();

        console.log("resultado de detalles de venta: ", result);

        if (!result || result.length === 0) {
            return res.status(404).json({ message: 'No se encontraron detalles de ventas' });
        }
        res.json(result);
    }catch (err) {
        next(err);
    }
};

export const obtenerDetalleVentaPorId = async (req, res, next) => {
    try {
        const { id } = req.params;

        const result = await service.obtenerDetalleVentaPorId(id);
        if (!result || result.length === 0) {
            return res.status(404).json({ message: 'Detalle de venta no encontrado' });
        
        }
        res.json(result);
    } catch (err) {
        next(err);
    }
};

export const crearDetalleVenta = async (req, res, next) => {
    try {
        const data = req.body;
        const result = await service.crearDetalleVenta(data);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
};

export const actualizarDetalleVenta = async (req, res, next) => {
    try {
        const { id } = req.params;
        const data = req.body;
        const result = await service.actualizarDetalleVenta(id, data);
        if (!result) {
            return res.status(404).json({ message: 'Detalle de venta no encontrado' });
        }
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
};

export const eliminarDetalleVenta = async (req, res, next) => {
    try {
        const { id } = req.params;
        const result = await service.eliminarDetalleVenta(id);
        if (!result || result.affectedRows === 0) {
            return res.status(404).json({ message: 'Detalle de venta no encontrado' });
        }
        res.status(200).json({ message: 'Detalle de venta eliminado correctamente' });
    } catch (err) {
        next(err);
    }
};