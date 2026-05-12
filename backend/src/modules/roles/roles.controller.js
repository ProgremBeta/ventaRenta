import * as service from './roles.service.js';

export const obtenerRoles = async (req, res, next) => {
  try {
    const result = await service.obtenerRoles();
    if (result.rows.length === 0) {
      console.warn('No se encontraron roles en la base de datos');
      return res.status(404).json({ error: "no se encontraron roles" });
    }
    console.log("roles obtenidos:", result.rows);
    res.status(200).json(result.rows);

  } catch (err) {
    next(err);
  }
};

export const obtenerRolPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerRolPorId(id);
    if (result.rows.length === 0) {
      console.warn(`No se encontró el rol con ID ${id}`);
      return res.status(404).json({ error: "Rol no encontrado" });
    }
    console.log("Rol obtenido:", result.rows[0]);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const crearRol = async (req, res, next) => {
  const datos = req.body;
  try {
    const result = await service.crearRol(datos);
    console.log("Rol creado:", result.rows[0]);
    res.status(201).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const actualizarRol = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarRol(id, datos);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Rol no encontrado" });
    }
    console.log("Rol actualizado:", result.rows[0]);
    res.status(200).json(result.rows[0]);

  } catch (err) {
    next(err);
  }
};

export const eliminarRol = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarRol(id);
    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Rol no encontrado" });
    }
    console.log("Rol eliminado:", result.rows[0]);
    res.status(204).json({ message: "Rol eliminado exitosamente" });

  } catch (err) {
    next(err);
  }
};