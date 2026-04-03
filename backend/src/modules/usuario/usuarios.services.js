import * as repository from './usuarios.repository.js';

console.log("Cargando servicios de usuarios...");

export const obtenerUsuarios = async () => {
  const result = await repository.obtenerUsuarios();
  console.log("Usuarios obtenidos:", result.rows);

  return result.rows;
};

export const obtenerUsuarioPorId = async (id) => {
  const result = await repository.obtenerUsuarioPorId(id);
  console.log("Usuario obtenido por ID:", result.rows);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró el usuario" });
  }

  return result.rows;
};

export const crearUsuario = async (datos) => {
  if (!datos.nombre) {
    throw new Error({ message: "Falta el nombre de usuario" });
  }

  if (!datos.email) {
    throw new Error({ message: "Falta el email del usuario" });
  }

  if (!datos.contrasena) {
    throw new Error({ message: "Falta la contraseña del usuario" });
  }

  const result = await repository.crearUsuario(datos);
  return result.rows;
};

export const actualizarUsuario = async (id, datos) => {
  const result = await repository.actualizarUsuario(id, datos);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró el usuario para actualizar" });
  }

  return result.rows;
};

export const eliminarUsuario = async (id) => {
  const result = await repository.eliminarUsuario(id);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró el usuario para eliminar" });
  }

  return result.rows;
};