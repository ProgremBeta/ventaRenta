import * as repository from './../../modules/usuarios/usuarios.repository.js';

export const obtenerUsuarios = async () => {
  const result = await repository.obtenerUsuarios();
  return result.rows;
}

export const obtenerUsuarioPorIdentificacion = async (id) => {
  const result = await repository.obtenerUsuarioPorIdentificacion(id);
  return result.rows;
}

export const crearUsuario = async (datos) => {
  const result = await repository.crearUsuario(datos);
  return result.rows;
}

export const actualizarUsuario = async (id, datos) => {
  const camposPermitidos = ['nombre', 'email', 'telefono', 'activo', 'rol_id']

  console.log("Datos recibidos para actualizar usuario:", datos);

  const camposActualizar = Object.fromEntries(
    Object.entries(datos).filter(([campo]) => camposPermitidos.includes(campo))
  )

  if (Object.keys(camposActualizar).length === 0) {
    throw new Error('No hay campos para actualizar')
  }

  const result = await repository.actualizarUsuario(id, camposActualizar)
  return result.rows;
}

export const eliminarUsuario = async (id) => {
  const result = await repository.eliminarUsuario(id);
  return result.rows;
}