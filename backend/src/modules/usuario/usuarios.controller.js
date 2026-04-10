import * as service from './usuarios.service.js';

export const obtenerUsuarios = async (req, res) => {
  try {
    const result = await service.obtenerUsuarios();
    return res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener usuarios:", err);
    return res.status(400).json({ message: "Error al obtener usuarios" });
  }
};

export const obtenerUsuarioPorId = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await service.obtenerUsuarioPorId(id);
    return res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener usuario por ID:", err);
    return res.status(400).json({ message: "Error al obtener usuario por ID" });
  }
};

export const crearUsuario = async (req, res) => {
  try {
    const datos = req.body;
    const result = await service.crearUsuario(datos);
    return res.status(201).json({ message: "Usuario creado exitosamente", usuario: result });
  } catch (err) {
    console.error("Error al crear usuario:", err);
    return res.status(400).json({ message: "Error al crear usuario" });
  }
};

export const actualizarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    const result = await service.actualizarUsuario(id, datos);
    return res.status(200).json({ message: "Usuario actualizado exitosamente", usuario: result });
  } catch (err) {
    console.error("Error al actualizar usuario:", err);
    return res.status(400).json({ message: "Error al actualizar usuario" });
  }
};

export const eliminarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await service.eliminarUsuario(id);
    return res.status(200).json({ message: "Usuario eliminado exitosamente", usuario: result });
  } catch (err) {
    console.error("Error al eliminar usuario:", err);
    return res.status(400).json({ message: "Error al eliminar usuario" });
  }
};
