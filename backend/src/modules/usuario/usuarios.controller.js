import * as service from './usuarios.services.js';

console.log("Cargando controlador de usuarios...");

export const obtenerUsuarios = async (req, res) => {
  try {
    const usuarios = await service.obtenerUsuarios();
    return res.status(200).json(usuarios);
  } catch (error) {
    console.error("Error al obtener usuarios:", error);
    return res.status(500).json({ message: "Error al obtener usuarios" });
  }
};

export const obtenerUsuarioPorId = async (req, res) => {
  try {
    const { id } = req.params;
    const usuario = await service.obtenerUsuarioPorId(id);
    return res.status(200).json(usuario);
  } catch (error) {
    console.error("Error al obtener usuario por ID:", error);
    return res.status(500).json({ message: "Error al obtener usuario por ID" });
  }
};

export const crearUsuario = async (req, res) => {
  try {
    const datos = req.body;
    const nuevoUsuario = await service.crearUsuario(datos);
    return res.status(201).json({ message: "Usuario creado exitosamente", usuario: nuevoUsuario });
  } catch (error) {
    console.error("Error al crear usuario:", error);
    return res.status(500).json({ message: "Error al crear usuario" });
  }
};

export const actualizarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    const usuarioActualizado = await service.actualizarUsuario(id, datos);
    return res.status(200).json({ message: "Usuario actualizado exitosamente", usuario: usuarioActualizado });
  } catch (error) {
    console.error("Error al actualizar usuario:", error);
    return res.status(500).json({ message: "Error al actualizar usuario" });
  }
};

export const eliminarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const usuarioEliminado = await service.eliminarUsuario(id);
    return res.status(200).json({ message: "Usuario eliminado exitosamente", usuario: usuarioEliminado });
  } catch (error) {
    console.error("Error al eliminar usuario:", error);
    return res.status(500).json({ message: "Error al eliminar usuario" });
  }
};
