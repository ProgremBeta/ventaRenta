import * as service from './crear_usuario.service.js';

export const crearNuevoUsuario = async (req, res) => {
  const data = req.body;
  try {
    const result = await service.crearNuevoUsuario(data)
    res.status(200).json(result)
  } catch (err) {
    console.error("error al crear usuario: ", err)
    res.status(500).json({ mensaje: "error al crear usuario" })
  }
}