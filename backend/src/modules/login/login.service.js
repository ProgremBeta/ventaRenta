import bcrypt from 'bcrypt';

import * as usuarioRepository from './../../modules/usuarios/usuarios.repository.js';
import * as autenticacionService from './../autenticacion/autenticacion.service.js';

export const hacerLogin = async (datos) => {

  const identificacion = datos.identificacion;
  const contrasenaIngresada = datos.contrasena_hash;

  console.log("identificacion", identificacion);
  console.log("contrasenaIngresada", contrasenaIngresada);

  if (!identificacion || identificacion.length === 0) {
    console.log("identificacion no proporcionada");
    throw new Error("tiene que ingresar el ID del usuario ")
  }

  const result = await usuarioRepository.obtenerUsuarioPorIdentificacion(identificacion);

  if (!result || result.rows.length === 0) {
    throw new Error("Usuario no existe");
  }

  const usuario = result.rows[0];
  const contrasenaUsuario = usuario.contrasena_hash;

  const permitirAcceso = await bcrypt.compare(contrasenaIngresada, contrasenaUsuario);

  const token = await autenticacionService.autenticarUsuario(usuario);

  return {
    usuario,
    permitirAcceso,
    token
  }
}