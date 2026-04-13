const roles = {
  administrador: 1,
  operador: 2,
  cliente: 3
}

export const verificarAdmin = (req, res, next) => {
  const usuarioRol = req.usuarioLogeado.rol_id;

  if (usuarioRol === roles.administrador) {
    next();
  } else {
    res.status(403).json({ message: 'Acceso denegado: Solo los administradores pueden acceder a esta ruta.' });
  }
}

export const verificarOperador = (req, res, next) => {
  const usuarioRol = req.usuarioLogeado.rol_id;

  if (usuarioRol === roles.operador || usuarioRol === roles.administrador) {
    next();
  } else {
    res.status(403).json({ message: 'Acceso denegado: Solo los operadores y administradores pueden acceder a esta ruta.' });
  }
}