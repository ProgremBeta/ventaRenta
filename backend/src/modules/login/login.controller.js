import * as loginService from './login.service.js';

export const hacerLogin = async (req, res, next) => {
  const datos = req.body;
  try {
    const result = await loginService.hacerLogin(datos)
    if (result.permitirAcceso === true) {
      res.status(200).json({
        id: result.usuario.id,
        mensaje: "login",
        token: result.token.token,
        rol_id: result.usuario.rol_id,
        nombre: result.usuario.nombre
      })
    } else {
      res.status(401).json({ mensaje: "no login" })
    }
  } catch (err) {
    next(err);
  }
}