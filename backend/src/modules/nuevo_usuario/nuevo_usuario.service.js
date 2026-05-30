import bcrypt from 'bcrypt';
import * as repository from '../usuarios/usuarios.repository.js';

export const crearNuevoUsuario = async (rolUsuario,datos) => {
  const formatoEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!formatoEmail.test(datos.email)) {
    throw new Error('Formato de email inválido');
  }

  const nivelSeguridad = 5;
  const contrasena = datos.contrasena_hash;

  const contrasenaEncriptada = await bcrypt.hash(contrasena, nivelSeguridad)

  const datosUsuario = {
    identificacion: datos.identificacion,
    nombre: datos.nombre,
    email: datos.email,
    telefono: datos.telefono,
    contrasena_hash: contrasenaEncriptada,
    rol_id: rolUsuario,
    activo: true
  };

  const usuario = await repository.crearUsuario(datosUsuario);

  return usuario.rows;
}