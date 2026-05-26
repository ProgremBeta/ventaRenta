import * as service from './roles.service.js';

export const obtenerRoles = async (req, res, next) => {
  try {
    const result = await service.obtenerRoles();
    if (result.length === 0) {
      console.log('No se encontraron roles en la base de datos');
      return res.status(400).json({ error: "no se encontraron roles" });
    }
    console.log("roles obtenidos:", result);
    res.status(200).json(result);

  } catch (err) {
    console.log("error al obtener controller roles ", err)
    next(err);
  }
};

export const obtenerRolPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerRolPorId(id);
    if (result.length === 0) {
      console.log(`no se encontró el rol con ID ${id}`);
      return res.status(400).json({ error: `no se encontró el rol con ID ${id}` });
    }
    console.log("Rol obtenido:", result);
    res.status(200).json(result);

  } catch (err) {
    console.log("error al obtener un rol controller por id ", err)
    next(err);
  }
};

export const crearRol = async (req, res, next) => {
  const datos = req.body;

  try {

    console.log("los datos recibidos son: ", datos)

    if (!datos) {
      console.log("no ingresastes datos para crear un rol")
      return res.status(400).json({mensaje:"no ingresastes datos para crear un rol"})
    }

    if (!datos.nombre) {
      console.log("se requiere el campo de nombre para crear un rol")
      return res.status(400).json({mensaje:"se requiere el campo de nombre para crear un rol"})
    }

    const result = await service.crearRol(datos);
    res.status(201).json(result);
  } catch (err) {
    console.log("error al crear un rol ", err)
    next(err);
  }
};

export const actualizarRol = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await service.actualizarRol(id, datos);
    if (result.length === 0) {
      console.log("no existen datos de este rol")
      return res.status(400).json({ error: "no existen datos de este rol" });
    }
    res.status(200).json(result);

  } catch (err) {
    console.log("error al actualizar un rol ", err)
    next(err);
  }
};

export const eliminarRol = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarRol(id);
    if (result.length === 0) {
      console.log("no existe datos o ya fue eliminado")
      return res.status(400).json({ mensaje: "no existe datos o ya fue eliminado" });
    }
    res.status(204).json(result);

  } catch (err) {
    console.log("error al eliminar rol ", err)
    next(err);
  }
};