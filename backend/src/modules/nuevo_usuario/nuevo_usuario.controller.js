import * as service from './nuevo_usuario.service.js';

export const crearNuevoUsuario = async (req, res, next) => {
  const datos = req.body;

  let rolUsuario

  if(req.usuarioLogeado == null){
    rolUsuario = 2
  }
  else{
    rolUsuario = req.usuarioLogeado?.rol_id;
  }
    
  try {
    let result;

    if (rolUsuario == null){
      result = await service.crearNuevoUsuario(datos);
    }else{
      result = await service.crearNuevoUsuario(datos, rolUsuario);
    }

    if (!datos.nombre) {
      console.log("se require el nombre para crear el usuario")
      return res.status(400).json({mensaje:"se require el nombre para crear el usuario"})
    }
    if (!datos.identificacion) {
        console.log("se requiere el numero de identificacion para crear al usuario")
      return res.status(400).json({mensaje:"se requiere el numero de identificacion para crear al usuario"})
    }
    if (!datos.email) {
        console.log("se requiere el email para crear el usuario")
      return res.status(400).json({mensaje:"se requiere el email para crear el usuario"})
    }
    if (!datos.telefono) {
        console.log("se requiere el telefono para crear el usuario")
      return res.status(400).json({mensaje:"se requiere el telefono para crear el usuario"})
    }
    if (!datos.contrasena_hash) {
        console.log("se requirere la contraseña para crear el usuario")
      return res.status(400).json({mensaje:"se requirere la contraseña para crear el usuario"})
    }

    res.status(200).json(result)

  } catch (err) {
    console.error("Error al crear nuevo usuario:", err);
    next(err);
  }
}