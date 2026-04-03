import * as services from './roles.services.js';

export const obtenerRoles = async (req, res) => {
  try {
    const result = await services.obtenerRoles();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener los roles' });
  }
}

export const obtenerRolPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerRolPorId(id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener el rol por ID' });
  }
}

export const crearRol = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearRol(datos);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Error al crear el rol' });
  }
}

export const actualizarRol = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarRol(id, datos);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar el rol' });
  }
}

export const eliminarRol = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarRol(id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar el rol' });
  }
}