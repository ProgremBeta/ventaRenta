import * as services from './roles.service.js';

export const obtenerRoles = async (req, res) => {
  try {
    const result = await services.obtenerRoles();
    res.status(200).json(result);
  } catch (err) {
    console.error("error al obtener los roles: ", err)
    res.status(400).json({ mensaje: 'Error al obtener los roles' });
  }
}

export const obtenerRolPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerRolPorId(id);
    res.status(200).json(result);
  } catch (err) {
    console.error("error al obtener los roles por id: ", err)
    res.status(400).json({ mensaje: 'Error al obtener el rol por ID' });
  }
}

export const crearRol = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearRol(datos);
    res.status(201).json(result);
  } catch (err) {
    console.error("error al crear los roles: ", err)
    res.status(400).json({ mensaje: 'Error al crear el rol' });
  }
}

export const actualizarRol = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarRol(id, datos);
    res.status(200).json(result);
  } catch (err) {
    console.error("error al actualizar los roles: ", err)
    res.status(400).json({ mensaje: 'Error al actualizar el rol' });
  }
}

export const eliminarRol = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarRol(id);
    res.status(200).json(result);
  } catch (err) {
    console.error("error al eliminar los roles: ", err)
    res.status(400).json({ mensaje: 'Error al eliminar el rol' });
  }
}