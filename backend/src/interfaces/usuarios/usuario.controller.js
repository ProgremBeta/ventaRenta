import * as service from './../../core/usuarios/usuarios.service.js';

export const obtenerUsuarios = async (req, res, next) => {
  try {
    const usuarios = await service.obtenerUsuarios();
    res.status(200).json(usuarios);
  } catch (err) {
    next(err);
  }
}

export const obtenerUsuarioPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerUsuarioPorId(id);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
}

export const crearUsuario = async (req, res, next) => {
  const datos = req.body;
  try {
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