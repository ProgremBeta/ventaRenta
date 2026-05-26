import * as service from './usuarios.service.js';

export const obtenerUsuarios = async (req, res, next) => {
  try {
    const result = await service.obtenerUsuarios();

    if (!result || result.length === 0 ) {
      console.log("no existen datos de usuarios")
      return res.status(400).json({mensaje:"no existen datos de usuarios"})
    }
    res.status(200).json(result);
  } catch (err) {
    console.log("error al obtener usuario controller ", err)
    next(err);
  }
}

export const obtenerUsuarioPorIdentificacion = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerUsuarioPorIdentificacion(id);

    if (!result || result.length === 0) {
      console.log(`no hay datos con el usuario con identificado ${id}`)
      return res.status(400).json({mensaje: `no hay datos con el usuario con identificado ${id}`})
    }
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const crearUsuario = async (req, res, next) => {
  const datos = req.body;
  try {
    if (!datos) {
      console.log("no ingresastes ningun dato para crear usuario")
      return res.status(400).json({mensaje:"no ingresastes ningun dato para crear usuario"})
    }

    if (!datos.identificacion) {
      console.log("se require el dato de identificacion para crear un usuario")
      return res.status(400).json({mensaje:"se require el dato de identificacion para crear un usuario"})
    }

    if (!datos.nombre) {
      console.log("se require el dato de nombre para crear un usuario")
      return res.status(400).json({mensaje:"se require el dato de nombre para crear un usuario"})
    }

    if (!datos.email) {
      console.log("se require el dato de email para crear un usuario")
      return res.status(400).json({mensaje:"se require el dato de email para crear un usuario"})
    }

    if (!datos.contrasena_hash) {
      console.log("se require el dato de contraseña para crear un usuario")
      return res.status(400).json({mensaje:"se require el dato de contraseña para crear un usuario"})
    }

    if (!datos.rol_id) {
      console.log("se require el dato de rol para crear un usuario")
      return res.status(400).json({mensaje:"se require el dato de rol para crear un usuario"})
    }



    const result = await service.crearUsuario(datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const actualizarUsuario = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarUsuario(id, datos);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const eliminarUsuario = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarUsuario(id);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}