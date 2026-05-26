import * as service from './rentas.service.js';

export const obtenerRentas = async (req, res, next) => {
  try {
    const result = await service.obtenerRentas();

    console.log("resultado de la rentas: ", result);

    if (!result || result.length === 0) {
      console.log("no se encontraron datos de rentas")
      return res.status(400).json({ message: "no se encontraron datos de rentas" });
    }
    
    res.status(200).json(result);
  } catch (err) {
    console.log("error al obtener rentas ", err)
    next(err);
  }
}

export const obtenerRentaPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerRentaPorId(id);

    if (!result || result.length === 0) {
      console.log(`no se encontro renta con el id ${id}`)
      return res.status(400).json({ message: `no se encontro renta con el id ${id}` });
    }
    
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const crearRenta = async (req, res, next) => {
  const datos = req.body;
  try {

    console.log("datos recibidos: ", datos)

    if (!datos) {
      console.log("no ingresastes ningun dato para crear renta")
      return res.status(400).json({mensaje: "no ingresastes ningun dato para crear renta"})
    }

    if (!datos.usuario_id) {
      console.log("se requiere el id del usuario para crear un renta")
      return res.status(400).json({mensaje: "se requieren el id del usuario para crear un renta"})
    }

    if (!datos.cliente_id) {
      console.log("se requiere el id del cliente crear un renta")
      return res.status(400).json({mensaje: "se requiere el id del cliente crear un renta"})
    }

    if (!datos.metodo_pago) {
      console.log("se requiere el metodo de pago para crear un renta")
      return res.status(400).json({mensaje: "se requiere el metodo de pago para crear un renta"})
    }

    const result = await service.crearRenta(datos);

    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const actualizarRenta = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarRenta(id, datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const eliminarRenta = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarRenta(id);

    if (!result || result.length === 0) {
      console.log("no existen los datos o ya fueron eliminados")
      return res.status(400).json({mensaje: "no existen los datos o ya fueron eliminados"})
    }

    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}