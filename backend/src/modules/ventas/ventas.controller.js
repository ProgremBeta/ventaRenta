import * as service from './ventas.service.js';

export const obtenerVentas = async (req, res, next) => {
  try {
    const result = await service.obtenerVentas();
    
    if (!result || result.length === 0) {
      console.log("no existen datos de ventas")
      return res.status(400).json({mensaje:"no existen datos de ventas"})
    }

    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const obtenerVentaPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerresultPorId(id);
    
    if (!result || result.length === 0) {
      console.log(`no existen datos de esta venta con id ${id}`)
      return res.status(400).json({mensaje:`no existen datos de esta venta con id ${id}`})
    }

    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const crearVenta = async (req, res, next) => {
  const datos = req.body;
  try {
    if (!datos) {
      console.log("no ingresastes ningun dato para crear la venta")
      return res.status(400).json({mensaje:"no ingresastes ningun dato para crear la venta"})
    }

    if (!datos.total) {
      console.log("se requiere el total para crear la venta")
      return res.status(400).json({mensaje:"se requiere el total para crear la venta"})
    }

    if (!datos.usuario_id) {
      console.log("se requiere el usuario para crear la venta")
      return res.status(400).json({mensaje:"se requiere el usuario para crear la venta"})
    }

    if (!datos.cliente_id) {
      console.log("se requiere el cliente para crear la venta")
      return res.status(400).json({mensaje:"se requiere el cliente para crear la venta"})
    }

    if (!datos.total) {
      console.log("se requiere el total para crear la venta")
      return res.status(400).json({mensaje:"se requiere el total para crear la venta"})
    }

    const result = await service.crearVenta(datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const actualizarVenta = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarVenta(id, datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const eliminarVenta = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarVenta(id);

    if (!result || result.length === 0) {
      console.log("no existen datos o ya fue eliminado")
      return res.status(400).json({mensaje:"no existen datos o ya fue eliminado"})
    }
    
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}