import * as service from './crear_usuario.service.js';

export const crearNuevoUsuario = async (req, res, next) => {

  let rolUsuario

  if(req.usuarioLogeado == null){
    rolUsuario = 0
  }
  else{
    rolUsuario = req.usuarioLogeado?.rol_id; // Obtener el rol_id del usuario que intenta crear un nuevo usuario
  }
  console.log("Usuario que intenta crear nuevo usuario:", req.usuarioLogeado);
    
  const datos = req.body;
  console.log("Datos recibidos para crear nuevo usuario:", datos);

  try {
    
    let result;
    console.log("rol del usuario: ", rolUsuario)

    if (rolUsuario == null){
      result = await service.crearNuevoUsuario(datos);
    }else{
      result = await service.crearNuevoUsuario(datos, rolUsuario);
    }

    console.log("usuario creado: ", result)
    res.status(200).json(result)

  } catch (err) {
    console.error("Error al crear nuevo usuario:", err);
    next(err);
  }
}